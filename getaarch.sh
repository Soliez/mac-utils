#!/bin/bash


show_usage(){
    echo "Usage: $0 <EXECUTABLE> <AARCH> <OUTPATH>"
}


show_help(){
    lines=(
        "GETAARCH(1)"
        ""
        "NAME"
        "    getaarch - Universal Binary Extraction Utility"
        ""
        "SYNOPSIS"
        "    getaarch [EXECUTABLE] [ARCHITECTURE] [OUTPATH]"
        ""
        "DESCRIPTION"
        "    The getaarch utility is used for extracting single architecture executables from universal binaries"
        ""
        "    The following options are supported"
        ""
        "    ┌── -arm, --arm64e   Extract a thin arm64e executable from the input file"
        "    ├── -x86, --x86_64   Extract a thin x86_64 executable from the input file"
        "    └── -h,   --help     Show this help message"
        ""
        "PROJECT"
        "    This script is from the mac-utils repo on GitHub."
        "    mac-utils is a collection of useful (mostly macOS specific) shell and python scripts."
        ""
        "    GitHub: https://github.com/Soliez/mac-utils"
    )
    printf "%s\n" "${lines[@]}" | less
}


main(){
    if [ $# -lt 3 ]; then
        show_usage
        exit 1
    else
        exe="$1"
        aarch="$2"
        outpath="$3"
    fi
    
    case "$aarch" in
        -arm|-arm64e)
            lipo -thin arm64e "$exe" -output "$outpath"
            ;;
        -x86|--x86-64)
            lipo -thin x86_64 "$exe" -output "$outpath"
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            show_usage
            exit 1
            ;;
    esac

}

main "$@"