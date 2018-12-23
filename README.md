# Cleopatra

_Micro virtual environment for [YeAST](https://github.com/yvan-sraka/YeAST)_

## What's that?

Cleopatra let you work on a shell where YeAST alias the commons tools you defined.

This is needed when you want to use YeAST inside a complex runtime structure like, typically, a web framework!

YeAST will be called in place of your standard interpreter without the shebang on top of your files.

Interpreters should always take input as first positional argument and write the output on standard output.

e.g. You can aliases python like that:

```shell
cleopatra add python
```

It will create inside `.cleopatra` subfolder (think it would be nice to add to your repository version source control), a `python` file which look like (it could diverge on your machine):

```shell
YEAST_CONTEXT=/anaconda3/bin/python yeast $@
```

Aliases are just shell script and hackable by design, you can add pre and post steps on them to customize your micro-virtual environment.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Get YeAST binary from source:

```shell
git clone git@github.com:yvan-sraka/YeAST.git
cd YeAST
./configure
make
sudo make install
```

### Build

You need an [Haskell build environment](https://www.haskell.org/downloads) on your computer, then just:

```shell
ghc cleopatra.hs -o cleopatra
```

### Usage

```shell
cleopatra glue
# That's all!
```

## Contributing

Please read [CONTRIBUTING.md](https://github.com/yvan-sraka/cleopatra/blob/master/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* [Yvan Sraka](https://github.com/yvan-sraka)

See also the list of [contributors](https://github.com/yvan-sraka/cleopatra/graphs/contributors) who participated in this project.

## License

This project is licensed under the 3rd version of GPL License - see the [LICENSE](https://github.com/yvan-sraka/cleopatra/blob/master/LICENSE) file for details.


