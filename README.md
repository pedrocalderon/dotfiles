##VIM
Finish adding development environment plugins.

Set spell check in english and portuguese (french spanish optional)

Make spell check only in comments inside programs. 

Automatically start english spell check when editing code.

Add for portability:
if has("compile_option")
    "all commands inside"
endif
Repeat aproach for every similar types of commands that depend on a compile
option.
