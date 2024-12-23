import os
import pathlib
import typing as t
from hatch_buildext import Macro


def _get_libicu_dir() -> pathlib.Path:
    return pathlib.Path(os.environ["_LIBICU_DIR"])


def _quote(value: str) -> str:
    return f'"{value}"'


def get_sources(root: str, /) -> t.Sequence[str]:
    pyicu = pathlib.Path(root).joinpath("pyicu").absolute()
    return list(map(str, pyicu.glob("**/*.cpp")))


def get_include_dirs(root: str, /) -> t.Sequence[str]:
    path = _get_libicu_dir().joinpath("include").absolute()

    if not path.exists():
        raise FileNotFoundError(f"{path} does not exist")

    return [str(path)]


def get_library_dirs(root: str, /) -> t.Sequence[str]:
    path = _get_libicu_dir().joinpath("lib").absolute()

    if not path.exists():
        raise FileNotFoundError(f"{path} does not exist")

    return [str(path)]


def get_libraries(root: str, /) -> t.Sequence[str]:
    # NOTE: manylinux
    return [
        "icudata",
        "icui18n",
        "icuuc",
    ]
    # TODO: fix for other platforms?
    return [
        "libicudata",
        "libicui18n",
        "libicuuc",
    ]


def get_extra_compile_args(root: str, /) -> t.Sequence[str]:
    # NOTE: required by pyicu
    return ["-std=c++17"]


def get_macros(root: str, /) -> t.Sequence[Macro]:
    return [
        Macro(
            name="PYICU_VER",
            value=_quote(os.environ["PYICU_VERSION"]),
        ),
        Macro(
            name="PYICU_ICU_MAX_VER",
            value=_quote(os.environ["LIBICU_VERSION"]),
        ),
    ]
