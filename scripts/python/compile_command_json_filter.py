#!/usr/bin/env python3

import argparse
import json
import logging
import os
import sys

__author__ = "Shangjin Tang"
__email__ = "shangjin.tang@gmail.com"
__copyright__ = "Copyright 2023 Shangjin Tang"
__license__ = "GPL"
__version__ = "1.1.0"

LOG_FORMAT = "%(asctime)s    %(levelname)s    %(filename)s:%(lineno)s\n\t%(message)s"
logging.basicConfig(level=logging.DEBUG, format=LOG_FORMAT)


def main(args):
    output_targets = []
    with open(args.input_file, "r", encoding="utf-8") as input_json:
        input_targets = json.load(input_json)
        for compile_target in input_targets:
            for pattern in args.filter_pattern:
                if pattern in compile_target["file"]:
                    output_targets.append(compile_target)
    with open(args.output_file, "w", encoding="utf-8") as output_json:
        json.dump(output_targets, output_json)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter, description=""
    )
    parser.add_argument("filter_pattern", nargs="+", type=str, action="extend")
    parser.add_argument("-i", "--input_file", default="./compile_commands.json")
    parser.add_argument("-o", "--output_file", default="./compile_commands_output.json")
    try:
        main(parser.parse_args())
    except KeyboardInterrupt:
        print("Interrupted")
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
