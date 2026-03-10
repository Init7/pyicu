"""Cross-platform file copy utility for hatch scripts."""

import pathlib
import shutil
import sys


def main() -> None:
    src = pathlib.Path(sys.argv[1])
    dst = pathlib.Path(sys.argv[2])

    shutil.copytree(src=src, dst=dst, dirs_exist_ok=True)


if __name__ == "__main__":
    main()
