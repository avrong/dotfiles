from __future__ import annotations

import sys
import re
import signal
import subprocess
from typing import List

class Package:
    def __init__(self, name: str, version: str, bucket: str=None):
        self.name = name
        self.version = version
        self.bucket = bucket
    
    def install(self):
        print("Installing {}@{} from {}:".format(self.name, self.version, self.bucket or 'main'))
        try:
            print(subprocess.check_output(['scoop', 'install', '{}@{}'.format(self.name, self.version)], shell=True).decode())
        except Exception as e:
            print("Seems is already fine")
        print()

    @staticmethod
    def from_package_line(line: str) -> Package:
        match = re.match(r'^\s*(?P<name>[\w-]+)\s(?P<version>[\w\d\.-]+)(?:\s\[(?P<bucket>\w+)\])?$', line)

        if match is not None:
            group = match.groupdict()
            return Package(group.get('name'), group.get('version'), group.get('bucket'))
        
        return None


def parse_packages_text(text: str) -> List[Package]:
    package_list = []
    
    for line in text.splitlines():
        package = Package.from_package_line(line)

        if package is not None:
            package_list.append(package)

    return package_list


def signal_handler(sig, frame):
    print('Roger that, leaving the area!')
    sys.exit(0)


if __name__ == '__main__':
    signal.signal(signal.SIGINT, signal_handler)

    if len(sys.argv) < 2:
        print('Usage: {} <file>'.format(sys.argv[0]))
        exit(1)
    
    try:
        packages = None
        with open(sys.argv[1]) as file:
            packages = parse_packages_text(file.read())
    except FileNotFoundError as e:
        print(e)
        exit(1)
    
    for package in packages:
        package.install()
    
    print('Alles goed!')
