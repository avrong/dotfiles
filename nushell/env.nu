# Nushell Environment Config File

def create_left_prompt [] {
    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"

    "\n" + ($path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)")
}

def create_right_prompt [] {
    ""
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "\n> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

# WezTerm Workaround
$env.config.shell_integration.osc133 = false

# Aliases

alias cat = bat -p
alias vim = nvim
alias grep = rg
alias find = fd

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

# TODO: Add aliases for frequently used dirs

$env.EDITOR = "hx"

# Coreutils (generated)
# print('\n'.join(list(map(lambda x: f'alias {x.strip()} = coreutils {x.strip()}', s.split(',')))))

alias arch = coreutils arch
alias b2sum = coreutils b2sum
alias b3sum = coreutils b3sum
alias base32 = coreutils base32
alias base64 = coreutils base64
alias basename = coreutils basename
alias basenc = coreutils basenc
alias cat = coreutils cat
alias cksum = coreutils cksum
alias comm = coreutils comm
alias cp = coreutils cp
alias csplit = coreutils csplit
alias cut = coreutils cut
alias date = coreutils date
alias dd = coreutils dd
alias df = coreutils df
alias dir = coreutils dir
alias dircolors = coreutils dircolors
alias dirname = coreutils dirname
alias du = coreutils du
alias echo = coreutils echo
alias env = coreutils env
alias expand = coreutils expand
alias expr = coreutils expr
alias factor = coreutils factor
# alias false = coreutils false
alias fmt = coreutils fmt
alias fold = coreutils fold
alias hashsum = coreutils hashsum
alias head = coreutils head
alias hostname = coreutils hostname
alias join = coreutils join
alias link = coreutils link
alias ln = coreutils ln
alias ls = coreutils ls --color
alias md5sum = coreutils md5sum
alias mkdir = coreutils mkdir
alias mktemp = coreutils mktemp
alias more = coreutils more
alias mv = coreutils mv
alias nl = coreutils nl
alias nproc = coreutils nproc
alias numfmt = coreutils numfmt
alias od = coreutils od
alias paste = coreutils paste
alias pr = coreutils pr
alias printenv = coreutils printenv
alias printf = coreutils printf
alias ptx = coreutils ptx
alias pwd = coreutils pwd
alias readlink = coreutils readlink
alias realpath = coreutils realpath
alias rm = coreutils rm
alias rmdir = coreutils rmdir
alias seq = coreutils seq
alias sha1sum = coreutils sha1sum
alias sha224sum = coreutils sha224sum
alias sha256sum = coreutils sha256sum
alias sha3-224sum = coreutils sha3-224sum
alias sha3-256sum = coreutils sha3-256sum
alias sha3-384sum = coreutils sha3-384sum
alias sha3-512sum = coreutils sha3-512sum
alias sha384sum = coreutils sha384sum
alias sha3sum = coreutils sha3sum
alias sha512sum = coreutils sha512sum
alias shake128sum = coreutils shake128sum
alias shake256sum = coreutils shake256sum
alias shred = coreutils shred
alias shuf = coreutils shuf
alias sleep = coreutils sleep
alias sort = coreutils sort
alias split = coreutils split
alias sum = coreutils sum
alias sync = coreutils sync
alias tac = coreutils tac
alias tail = coreutils tail
alias tee = coreutils tee
alias test = coreutils test
alias touch = coreutils touch
alias tr = coreutils tr
# alias true = coreutils true
alias truncate = coreutils truncate
alias tsort = coreutils tsort
alias uname = coreutils uname
alias unexpand = coreutils unexpand
alias uniq = coreutils uniq
alias unlink = coreutils unlink
alias vdir = coreutils vdir
alias wc = coreutils wc
alias whoami = coreutils whoami
alias yes = coreutils yes
