#!/usr/bin/env python3

"""
Step:

    1. add the configuration in file, e.g. `~/.pacuni_conf.yaml`:

        ```yaml
        - pacman:
            - jq
        - npm:
            - pnpm
        - pipx:
            - pytest
        - cargo:
        ```

    2. run: `${DOTBOT_BIN} -p {CURRENT_SCRIPT} -c {CONFIG}`, e.g.:

        ```bash
        ~/.dotfiles/dotbot/install/dotbot -p pacuni.py -c ~/.pacuni_conf.yaml
        ```
"""

__author__ = "Shangjin Tang"
__email__ = "shangjin.tang@gmail.com"
__copyright__ = "Copyright 2024 Shangjin Tang"
__license__ = "GPL"
__version__ = "0.1.0"

import subprocess
from enum import Enum

import dotbot


class PkgStatus(Enum):
    ALREADY_INSTALLED = "Already Installed"
    FAILED_TO_INSTALL = "Failed to Install"
    SUCCEEDED_TO_INSTALL = "Succeeded to Install"


class PacUni(dotbot.Plugin):

    _installers_config = {
        "apt-get": {
            "depends": {
                "cmd": "[[ -f '/etc/os-release' ]] && [[ $(cat /etc/os-release) =~ 'ID=ubuntu' ]]",
                "msg_fail": "'apt-get' can not be used, not Ubuntu distro",
            },
            "check_installed": "dpkg -l",
            "try_install": "sudo apt-get install -y",
        },
        "apt-get-24.04": {
            "depends": {
                "cmd": "[[ -f '/etc/os-release' ]] && [[ $(cat /etc/os-release) =~ 'ID=ubuntu' ]] && [[ $(lsb_release -rs) == '24.04' ]]",
                "msg_fail": "'apt-get-24.04' can not be used, not Ubuntu 24.04 distro",
            },
            "check_installed": "dpkg -l",
            "try_install": "sudo apt-get install -y",
        },
        "pacman": {
            "depends": {
                "cmd": "[[ -f '/etc/os-release' ]] && [[ $(cat /etc/os-release) =~ 'ID=arch' ]]",
                "msg_fail": "'pacman' not found, not ArchLinux distro",
            },
            "check_installed": "pacman -Qi",
            "try_install": "sudo pacman --noconfirm -S",
        },
        "cargo": {
            "depends": {
                "cmd": "command -v cargo &> /dev/null",
                "msg_fail": "'cargo' not found. To install it, see: https://rustup.rs/",
            },
            "check_installed": "cargo install --list",
            "try_install": "cargo install",
        },
        "npm": {
            "depends": {
                "cmd": "command -v npm &> /dev/null",
                "msg_fail": "'npm' not found. To install it, see: https://nodejs.org/en/download/package-manager",
            },
            "check_installed": "npm list -g",
            "try_install": "npm install -g",
        },
        "pipx": {
            "depends": {
                "cmd": "command -v pipx &> /dev/null",
                "msg_fail": "'pipx' not found",
            },
            "check_installed": "pipx list",
            "try_install": "pipx install",
        },
    }

    def __init__(self, context):
        super(PacUni, self).__init__(self)
        self._context = context

    def can_handle(self, directive):
        return directive in self._installers_config.keys()

    def handle(self, directive, data):
        if not self.can_handle(directive):
            raise RuntimeError(f"PacUni cannot handle directive {directive}")
        if not data:
            return True
        return self._process_packages(directive, data)

    def _check_depends(self, directive):
        if "depends" in self._installers_config[directive]:
            depends = self._installers_config[directive]["depends"]
            if depends and "cmd" in depends:
                result = subprocess.call(
                    f"bash -c '{depends["cmd"]}' > /dev/null", shell=True
                )
                if result != 0:
                    if "msg_fail" in depends:
                        self._log.warning(f"Warning: {depends['msg_fail']}")
                    return False
        return True

    def _is_installed(self, directive, pkg):
        check_installed_cmd = self._installers_config[directive]["check_installed"]
        return (
            subprocess.call(
                f"{check_installed_cmd} | grep {pkg} > /dev/null", shell=True
            )
            == 0
        )

    def _install_package(self, directive, pkg):
        try_install_cmd = self._installers_config[directive]["try_install"]
        cmd_to_run = f"{try_install_cmd} {pkg}".strip()
        self._log.lowinfo(f" {cmd_to_run}")
        result = subprocess.call(f"{cmd_to_run} > /dev/null", shell=True)
        if result != 0:
            self._log.error(f" {cmd_to_run}")
        else:
            self._log.info(f" {cmd_to_run}")

    def _process_packages(self, directive, packages):
        if not self._check_depends(directive):
            return False
        results = {
            PkgStatus.ALREADY_INSTALLED: [],
            PkgStatus.SUCCEEDED_TO_INSTALL: [],
            PkgStatus.FAILED_TO_INSTALL: [],
        }
        successful = [PkgStatus.ALREADY_INSTALLED, PkgStatus.SUCCEEDED_TO_INSTALL]

        for pkg in packages:
            if self._is_installed(directive, pkg):
                results[PkgStatus.ALREADY_INSTALLED].append(pkg)
            else:
                self._install_package(directive, pkg)
                if not self._is_installed(directive, pkg):
                    results[PkgStatus.FAILED_TO_INSTALL].append(pkg)
                else:
                    results[PkgStatus.SUCCEEDED_TO_INSTALL].append(pkg)

        results_stripped = {k: v for k, v in results.items() if v}

        if all(result in successful for result in results_stripped.keys()):
            self._log.info(f"All {directive} packages installed successfully")
            success = True
        else:
            success = False

        for status, pkgs in results_stripped.items():
            log_func = self._log.lowinfo
            if status == PkgStatus.SUCCEEDED_TO_INSTALL:
                log_func = self._log.info
            elif status == PkgStatus.FAILED_TO_INSTALL:
                log_func = self._log.error
            log_func(f"{directive}:\t{status.value}:\t{pkgs}")

        self._log.lowinfo("-" * 70)
        return success
