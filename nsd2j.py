import os
import sys
import json
import argparse
try:
    from Foundation import NSDictionary
except ModuleNotFoundError:
    print("Please install Foundation with 'pip3 install Foundation'")
    exit(1)



def show_help() -> None:
    import subprocess

    lines = [
        "NSD2J(1)",
        "",
        "NAME",
        "   nsd2j - Convert a NSDictionary object to a JSON object",
        "SYNOPSIS",
        "   nsd2j [-h]",
        "",
        "DESCRIPTION",
        "    The nsd2j utility converts an Objective-C NSDictionary object to JSON string. Input can be passed as a command-line argument or from standard-in",
        "",
        "   The following options are supported",
        ""
        "    -h, --help            Show this help message",
        "",
        "PROJECT",
        "    This script is from the mac-utils repo on GitHub.",
        "    mac-utils is a collection of useful (mostly macOS specific) shell and python scripts.",
        "",
        "    GitHub: https://github.com/Soliez/mac-utils"
    ]
    message = "\n".join(lines)
    
    message_echo = subprocess.run(
    ['echo', message], 
    stdout=subprocess.PIPE, 
    text=True
    )

    subprocess.run(
    ['less'], 
    input=message_echo.stdout, 
    text=True
    )


def nsd2j(obj: NSDictionary) -> str:
    '''
    Convert a NSDictionary object to a JSON string.
    '''
    d = dict(obj)
    return json.dumps(obj=d, indent=4)


def main():
    parser = argparse.ArgumentParser(description="Convert a NSDictionary object to a JSON object")
    parser.add_argument('object', help="The NSDictionary object to convert")
    
    args = parser.parse_args()

    if args.object:
        nsd = args.object
    else:
        if sys.stdin.isatty():
            inp = sys.stdin.read()
            # This is based on the estimation that a valid NSDictionary object has to be at leat 5 characters long. Example of a minimum qualifier: {a=1}
            if len(inp) >= 5 and inp.startswith("{") and inp.endswith("}"):
                nsd = inp
            else:
                show_help()
        else:
            show_help()

    j = nsd2j(NSDictionary(nsd))
    print(j)

if __name__ == "__main__":
    main()