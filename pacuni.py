#!/usr/bin/env python3

"""
A configuration python script to unify installation (depends on 'dotbot').

How to use:

    1. Add the configuration in file, e.g. `~/.pacuni_conf.yaml`:

    Ubuntu 24.04:
        ```yaml
        - apt-get:
            - jq
        - npm:
            - pnpm
        - pipx:
            - pytest
        - cargo:
        ```

    Arch Linux:
        ```yaml
        - pacman
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

    Note: you can place all the configurations in one file, and run specific config(s) with '--only' or '--except' flag, e.g.:

        ```bash
        ~/.dotfiles/dotbot/install/dotbot -p pacuni.py -c ~/.pacuni_conf.yaml --except apt-get
        ~/.dotfiles/dotbot/install/dotbot -p pacuni.py -c ~/.pacuni_conf.yaml --except pacman apt-get
        ```

        ```bash
        ~/.dotfiles/dotbot/install/dotbot -p pacuni.py -c ~/.pacuni_conf.yaml --only apt-get
        ~/.dotfiles/dotbot/install/dotbot -p pacuni.py -c ~/.pacuni_conf.yaml --only npm pipx
        ```
"""

__author__ = "Shangjin Tang"
__email__ = "shangjin.tang@gmail.com"
__copyright__ = "Copyright 2024 Shangjin Tang"
__license__ = "GPL"
__version__ = "0.1.0"

import subprocess
from enum import Enum
from typing import List

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
                "msg_fail": "'apt-get' not available, not Ubuntu distro",
            },
            "check_installed": "dpkg -l | grep '^ii ' | cut -d ' ' -f 3 | cut -d ':' -f 1",
            "try_install": "sudo apt-get install -y",
        },
        "pacman": {
            "depends": {
                "cmd": "[[ -f '/etc/os-release' ]] && [[ $(cat /etc/os-release) =~ 'ID=arch' ]]",
                "msg_fail": "'pacman' not available, not ArchLinux distro",
            },
            "check_installed": "pacman -Qi",
            "try_install": "sudo pacman --noconfirm -S",
        },
        "cargo": {
            "depends": {
                "cmd": "command -v cargo &> /dev/null",
                "msg_fail": "'cargo' not available. To install it, see: https://rustup.rs/",
            },
            "check_installed": "cargo install --list",
            "try_install": "cargo install",
        },
        "npm": {
            "depends": {
                "cmd": "command -v npm &> /dev/null",
                "msg_fail": "'npm' not available. To install it, see: https://nodejs.org/en/download/package-manager",
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
        "pip": {
            "depends": {
                "cmd": "command -v python &> /dev/null",
                "msg_fail": "'pip' cannot be used as 'python' not found",
            },
            "check_installed": "python -m pip list",
            "try_install": "python -m pip install",
        },
    }

    def __init__(self, context: str) -> None:
        super(PacUni, self).__init__(self)
        self._context = context

    def can_handle(self, directive: str) -> bool:
        return directive in self._installers_config.keys()

    def handle(self, directive: str, data: List[str]) -> bool:
        if not self.can_handle(directive):
            raise RuntimeError(f"PacUni cannot handle directive {directive}")
        if not data:
            return True
        non_installed_pkgs = [pkg for pkg in data if not self._is_installed(directive, pkg)]
        self._log.info(f"Packages to install: {non_installed_pkgs}")
        return self._process_packages(directive, data)

    def _check_depends(self, directive: str) -> bool:
        if "depends" in self._installers_config[directive]:
            depends = self._installers_config[directive]["depends"]
            if depends and "cmd" in depends:
                result = subprocess.call(
                    f"bash -c '{depends["cmd"]}' > /dev/null", shell=True
                )
                if result != 0:
                    if "msg_fail" in depends:
                        self._log.error(f"Error: {depends['msg_fail']}")
                    else:
                        self._log.error(f"Error: failed to process '{directive}'")
                    return False
        return True

    def _is_installed(self, directive: str, pkg: str) -> bool:
        check_installed_cmd = self._installers_config[directive]["check_installed"]
        return (
            subprocess.call(
                f"{check_installed_cmd} | grep -qw {pkg}", shell=True
            )
            == 0
        )

    def _install_package(self, directive: str, pkg: str) -> None:
        try_install_cmd = self._installers_config[directive]["try_install"]
        cmd_to_run = f"{try_install_cmd} {pkg}".strip()
        self._log.lowinfo(f" {cmd_to_run}")
        result = subprocess.call(f"{cmd_to_run} > /dev/null", shell=True)
        if result != 0:
            self._log.error(f" {cmd_to_run}")
        else:
            self._log.info(f" {cmd_to_run}")

    def _process_packages(self, directive: str, packages: List[str]) -> bool:
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
