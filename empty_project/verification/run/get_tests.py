#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os
import sys
import re


def get_tests(test_directory):
    """
    Build test library
    """
    black_list = ['basetest', 'lib', 'pkg']

    test_list = dict()
    for directory, subdirectory, files in os.walk(test_directory):
        tests = []
        for test in files:
            if test.endswith('_test.sv'):
                test_wo_ext = os.path.splitext(test)[0]
                k = re.sub('_', '', test)
                if not any(s in k for s in black_list):
                    tests.append([test_wo_ext, get_test_description(directory+'/'+test)])
        test_list.update({os.path.basename(directory): tests})
    return test_list


def get_test_description(file_name):
    """
    Extract test description from source code
    """
    for l in open(file_name, 'r'):
        result = re.findall(r'^// Description:+', l)
        if result:
            return l.strip("\n").split(":")[1]

    return " Empty description"


def print_tests(test_list):
    """
    Print test library in a pretty way
    """
    if len(test_list) == 0:
        print('There is no test in your library')

    print('---------------AVAILABLE TESTS---------------')
    for grp, tests in iter(test_list.items()):
        if len(tests):
            print('\nGroup Name: ' + grp)
            for test, desc in tests:
                print('\t%25s -%s' %(test, desc))
        print('---------------------------------------------')


def main():
    """
    Entry point
    """
    if len(sys.argv) != 2:
        print('You should pass tests directory')
        print('Usage: get_tests.py <test directory>')
        sys.exit(1)

    if not os.path.isdir(sys.argv[1]):
        print('There is no such directory: {}'.format(sys.argv[1]))
        sys.exit(1)

    print_tests(get_tests(sys.argv[1]))


if __name__ == '__main__':
    main()
