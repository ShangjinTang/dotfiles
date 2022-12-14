#!/usr/bin/env python3

import sys
import argparse
import os
import re
import json
import logging

__author__ = "Shangjin Tang"
__email__ = "shangjin.tang@gmail.com"
__copyright__ = "Copyright 2022 Shangjin Tang"
__license__ = "GPL"
__version__ = "1.0.0"

ARGS = None  # Get argument: ARGS.arg
LOG_FORMAT = "%(asctime)s    %(levelname)s    %(filename)s:%(lineno)s\n\t%(message)s"
logging.basicConfig(level=logging.DEBUG, format=LOG_FORMAT)


def main():
    output_targets = []
    with open(ARGS.input_file, 'r') as input_json:
        input_targets = json.load(input_json)
        for compile_target in input_targets:
            for pattern in ARGS.filter_pattern:
                if pattern in compile_target["file"]:
                    output_targets.append(compile_target)
    with open(ARGS.output_file, 'w') as output_json:
        json.dump(output_targets, output_json)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter, description="")
    parser.add_argument('filter_pattern', nargs='+', type=str, action='extend')
    parser.add_argument('-i',
                        '--input_file',
                        default="./compile_commands.json")
    parser.add_argument('-o',
                        '--output_file',
                        default="./compile_commands_output.json")
    ARGS = parser.parse_args()
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
