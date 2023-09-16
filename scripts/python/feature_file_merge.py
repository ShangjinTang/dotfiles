#!/usr/bin/env python3

import argparse
import logging
import os
import sys

__author__ = "Shangjin Tang"
__email__ = "shangjin.tang@gmail.com"
__copyright__ = "Copyright 2022 Shangjin Tang"
__license__ = "GPL"
__version__ = "1.0.0"

LOG_FORMAT = "%(asctime)s    %(levelname)s    %(filename)s:%(lineno)s\n\t%(message)s"
logging.basicConfig(level=logging.DEBUG, format=LOG_FORMAT)


class FeatureFileMerger:
    def __init__(self, input_files, output_file, priority, file_utils):
        self.features = {}
        self.input_files = input_files
        self.output_file = output_file
        self.priority = priority
        self.file_utils = file_utils

    def generate(self):
        if self.priority == "descending":
            self.input_files.reverse()
        for file in self.input_files:
            file_features = self.file_utils.load_features_from_file(file)
            logging.debug(f"Features read from input file {file}: {file_features}")
            self.features.update(file_features)
        logging.debug(
            "Features write to output file {self.output_file}: {self.features}"
        )
        self.file_utils.save_features_to_file(self.features, self.output_file)


class FileUtils:
    def __init__(self, comment_symbol, separate_symbol):
        self.comment_symbol = comment_symbol
        self.separate_symbol = separate_symbol

    def load_features_from_file(self, file):
        features = {}
        if os.path.exists(file):
            with open(file, "r", encoding="utf-8") as f:
                line_number = 0
                for line in f.readlines():
                    line_number += 1
                    line = line.strip()
                    if line and not line.startswith(self.comment_symbol):
                        line_split = line.split(self.separate_symbol)
                        if len(line_split) != 2:
                            logging.warning(
                                "file: {} line {}: '{}' is not valid, ignore it".format(
                                    file, line_number, line
                                )
                            )
                            continue
                        key, value = line_split[0].strip(), line_split[1].strip()
                        features[key] = value
        return features

    def save_features_to_file(self, features, file):
        logging.debug(os.getcwd())
        logging.debug(file)
        with open(file, "w", encoding="utf-8") as f:
            for k, v in features.items():
                line = " ".join([k, self.separate_symbol, v]) + "\n"
                f.writelines(line)


def main(args):
    try:
        file_utils = FileUtils(args.comment_symbol, args.separate_symbol)
        feature_file_merger = FeatureFileMerger(
            args.input, args.output, args.priority, file_utils
        )
        feature_file_merger.generate()

    except KeyboardInterrupt:
        print("Keyboard Interrupt")
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument(
        "-i", "--input", required=True, nargs="+", help="Path of input file(s)"
    )
    parser.add_argument("-o", "--output", required=True, help="Path of output file")
    parser.add_argument(
        "--priority",
        default="ascending",
        choices=["ascending", "descending"],
        help="Priority ascending/descending in input files",
    )
    parser.add_argument(
        "--comment_symbol", default="#", help="Comment symbol (default #)"
    )
    parser.add_argument(
        "--separate_symbol", default="=", help="Separate symbol (default =)"
    )
    # parser.add_argument('--ignore-case',
    #                     default=False,
    #                     action='store_true',
    #                     help="Ignore case inside (default: True)")
    logging.debug(parser.parse_args())
    main(parser.parse_args())
