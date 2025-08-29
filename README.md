# minimal

Modified minimal theme for zsh forked from [zimfw's minimal](https://github.com/zimfw/minimal) which is based on [subnixr's minimal](https://github.com/subnixr/minimal).

## Warning

May be less minimal than the minimal theme it was forked from.

## Instructions

This theme can be used with the [zimfw](https://zimfw.sh/) ZSH framework.

```shell
# Reference the module in your .zimrc
echo 'zmodule https://github.com/julian-computes/minimal' >> ~/.zimrc
```

## Changes

- Working directory appears on the left of the prompt
- Git information appears on the lambda prompt
- Enhanced git information (ahead/behind, stash, file status)

## Requirements

Requires Zim's [prompt-pwd] module to show the current working directory, and
[git-info] to show git information.

[subnixr's minimal]: https://github.com/subnixr/minimal
[magic-enter]: https://github.com/zimfw/magic-enter
[prompt-pwd module settings]: https://github.com/zimfw/prompt-pwd/blob/master/README.md#settings
[prompt-pwd]: https://github.com/zimfw/prompt-pwd
[git-info]: https://github.com/zimfw/git-info
