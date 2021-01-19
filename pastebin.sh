#!/bin/bash

set -e

#
# Print key/value
#

print_key_value() {
  key="${1% = *}"
  value="${1#* = }"
  echo -ne "\033[1;37m${key}\033[0;0m: ${value}"
}

#
# Print in columns
#

print_columns() {
  column_width="${1}"; shift
  [[ -n "${COLUMNS}" ]] && terminal_width="${COLUMNS}" || terminal_width=$(tput cols)
  ((column_count = terminal_width / column_width))
  [[ "${column_count}" -le 0 ]] && column_count=0
  format_string="%-$((column_width - 1))s "

  i=0
  while [[ -n "${1}" ]]; do
    # shellcheck disable=SC2059
    line="$(printf "${format_string}" "${1}")"
    print_key_value "${line}"
    ((++i % column_count == 0)) && echo
    shift
  done
  ((i++ % column_count != 0)) && echo
}

#
# Help
#

do_help() {
  case "${2}" in
    f|fo|for|form|forma|format|formats)
      formats=('4cs = 4CS'
              '6502acme = 6502 ACME Cross Assembler'
              '6502kickass = 6502 Kick Assembler'
              '6502tasm = 6502 TASM/64TASS'
              'abap = ABAP'
              'actionscript = ActionScript'
              'actionscript3 = ActionScript 3'
              'ada = Ada'
              'aimms = AIMMS'
              'algol68 = ALGOL 68'
              'apache = Apache Log'
              'applescript = AppleScript'
              'apt_sources = APT Sources'
              'arduino = Arduino'
              'arm = ARM'
              'asm = ASM (NASM)'
              'asp = ASP'
              'asymptote = Asymptote'
              'autoconf = autoconf'
              'autohotkey = Autohotkey'
              'autoit = AutoIt'
              'avisynth = Avisynth'
              'awk = Awk'
              'bascomavr = BASCOM AVR'
              'bash = Bash'
              'basic4gl = Basic4GL'
              'dos = Batch'
              'bibtex = BibTeX'
              'b3d = Blitz3D'
              'blitzbasic = Blitz Basic'
              'bmx = BlitzMax'
              'bnf = BNF'
              'boo = BOO'
              'bf = BrainFuck'
              'c = C'
              'csharp = C#'
              'c_winapi = C (WinAPI)'
              'cpp = C++'
              'cpp-winapi = C++ (WinAPI)'
              'cpp-qt = C++ (Qt)'
              'c_loadrunner = C: Loadrunner'
              'caddcl = CAD DCL'
              'cadlisp = CAD Lisp'
              'ceylon = Ceylon'
              'cfdg = CFDG'
              'c_mac = C for Macs'
              'chaiscript = ChaiScript'
              'chapel = Chapel'
              'cil = C Intermediate Language'
              'clojure = Clojure'
              'klonec = Clone C'
              'klonecpp = Clone C++'
              'cmake = CMake'
              'cobol = COBOL'
              'coffeescript = CoffeeScript'
              'cfm = ColdFusion'
              'css = CSS'
              'cuesheet = Cuesheet'
              'd = D'
              'dart = Dart'
              'dcl = DCL'
              'dcpu16 = DCPU-16'
              'dcs = DCS'
              'delphi = Delphi'
              'oxygene = Delphi Prism (Oxygene)'
              'diff = Diff'
              'div = DIV'
              'dot = DOT'
              'e = E'
              'ezt = Easytrieve'
              'ecmascript = ECMAScript'
              'eiffel = Eiffel'
              'email = Email'
              'epc = EPC'
              'erlang = Erlang'
              'euphoria = Euphoria'
              'fsharp = F#'
              'falcon = Falcon'
              'filemaker = Filemaker'
              'fo = FO Language'
              'f1 = Formula One'
              'fortran = Fortran'
              'freebasic = FreeBasic'
              'freeswitch = FreeSWITCH'
              'gambas = GAMBAS'
              'gml = Game Maker'
              'gdb = GDB'
              'gdscript = GDScript'
              'genero = Genero'
              'genie = Genie'
              'gettext = GetText'
              'go = Go'
              'godot-glsl = Godot GLSL'
              'groovy = Groovy'
              'gwbasic = GwBasic'
              'haskell = Haskell'
              'haxe = Haxe'
              'hicest = HicEst'
              'hq9plus = HQ9 Plus'
              'html4strict = HTML'
              'html5 = HTML 5'
              'icon = Icon'
              'idl = IDL'
              'ini = INI file'
              'inno = Inno Script'
              'intercal = INTERCAL'
              'io = IO'
              'ispfpanel = ISPF Panel Definition'
              'j = J'
              'java = Java'
              'java5 = Java 5'
              'javascript = JavaScript'
              'jcl = JCL'
              'jquery = jQuery'
              'json = JSON'
              'julia = Julia'
              'kixtart = KiXtart'
              'kotlin = Kotlin'
              'ksp = KSP (Kontakt Script)'
              'latex = Latex'
              'ldif = LDIF'
              'lb = Liberty BASIC'
              'lsl2 = Linden Scripting'
              'lisp = Lisp'
              'llvm = LLVM'
              'locobasic = Loco Basic'
              'logtalk = Logtalk'
              'lolcode = LOL Code'
              'lotusformulas = Lotus Formulas'
              'lotusscript = Lotus Script'
              'lscript = LScript'
              'lua = Lua'
              'm68k = M68000 Assembler'
              'magiksf = MagikSF'
              'make = Make'
              'mapbasic = MapBasic'
              'markdown = Markdown'
              'matlab = MatLab'
              'mercury = Mercury'
              'metapost = MetaPost'
              'mirc = mIRC'
              'mmix = MIX Assembler'
              'mk-61 = MK-61/52'
              'modula2 = Modula 2'
              'modula3 = Modula 3'
              '68000devpac = Motorola 68000 HiSoft Dev'
              'mpasm = MPASM'
              'mxml = MXML'
              'mysql = MySQL'
              'nagios = Nagios'
              'netrexx = NetRexx'
              'newlisp = newLISP'
              'nginx = Nginx'
              'nim = Nim'
              'nsis = NullSoft Installer'
              'oberon2 = Oberon 2'
              'objeck = Objeck Programming Language'
              'objc = Objective C'
              'ocaml = OCaml'
              'ocaml-brief = OCaml Brief'
              'octave = Octave'
              'pf = OpenBSD PACKET FILTER'
              'glsl = OpenGL Shading'
              'oorexx = Open Object Rexx'
              'oobas = Openoffice BASIC'
              'oracle8 = Oracle 8'
              'oracle11 = Oracle 11'
              'oz = Oz'
              'parasail = ParaSail'
              'parigp = PARI/GP'
              'pascal = Pascal'
              'pawn = Pawn'
              'pcre = PCRE'
              'per = Per'
              'perl = Perl'
              'perl6 = Perl 6'
              'phix = Phix'
              'php = PHP'
              'php-brief = PHP Brief'
              'pic16 = Pic 16'
              'pike = Pike'
              'pixelbender = Pixel Bender'
              'pli = PL/I'
              'plsql = PL/SQL'
              'postgresql = PostgreSQL'
              'postscript = PostScript'
              'povray = POV-Ray'
              'powerbuilder = PowerBuilder'
              'powershell = PowerShell'
              'proftpd = ProFTPd'
              'progress = Progress'
              'prolog = Prolog'
              'properties = Properties'
              'providex = ProvideX'
              'puppet = Puppet'
              'purebasic = PureBasic'
              'pycon = PyCon'
              'python = Python'
              'pys60 = Python for S60'
              'q = q/kdb+'
              'qbasic = QBasic'
              'qml = QML'
              'rsplus = R'
              'racket = Racket'
              'rails = Rails'
              'rbs = RBScript'
              'rebol = REBOL'
              'reg = REG'
              'rexx = Rexx'
              'robots = Robots'
              'roff = Roff Manpage'
              'rpmspec = RPM Spec'
              'ruby = Ruby'
              'gnuplot = Ruby Gnuplot'
              'rust = Rust'
              'sas = SAS'
              'scala = Scala'
              'scheme = Scheme'
              'scilab = Scilab'
              'scl = SCL'
              'sdlbasic = SdlBasic'
              'smalltalk = Smalltalk'
              'smarty = Smarty'
              'spark = SPARK'
              'sparql = SPARQL'
              'sqf = SQF'
              'sql = SQL'
              'sshconfig = SSH Config'
              'standardml = StandardML'
              'stonescript = StoneScript'
              'sclang = SuperCollider'
              'swift = Swift'
              'systemverilog = SystemVerilog'
              'tsql = T-SQL'
              'tcl = TCL'
              'teraterm = Tera Term'
              'texgraph = TeXgraph'
              'thinbasic = thinBasic'
              'typescript = TypeScript'
              'typoscript = TypoScript'
              'unicon = Unicon'
              'uscript = UnrealScript'
              'upc = UPC'
              'urbi = Urbi'
              'vala = Vala'
              'vbnet = VB.NET'
              'vbscript = VBScript'
              'vedit = Vedit'
              'verilog = VeriLog'
              'vhdl = VHDL'
              'vim = VIM'
              'vb = VisualBasic'
              'visualfoxpro = VisualFoxPro'
              'visualprolog = Visual Pro Log'
              'whitespace = WhiteSpace'
              'whois = WHOIS'
              'winbatch = Winbatch'
              'xbasic = XBasic'
              'xml = XML'
              'xojo = Xojo'
              'xorg_conf = Xorg Config'
              'xpp = XPP'
              'yaml = YAML'
              'yara = YARA'
              'z80 = Z80 Assembler'
              'zxbasic = ZXBasic')
      print_columns 42 "${formats[@]}"
      ;;
    e|ex|exp|expi|expir|expire)
      # N / B / 10M / 1H / 1D / 1W / 2W / 1M / 6M / 1Y
      expires=('N = Never expire'
               'B = Burn after read'
               '10M = 10 minutes'
               '1H = 1 hour'
               '1D = 1 day'
               '1W = 1 week'
               '2W = 2 weeks'
               '1M = 1 month'
               '6M = 6 months'
               '1Y = 1 year')
      for expire in "${expires[@]}"; do
        print_key_value "${expire}"
        echo
      done
      ;;
    *)
      echo 'Usage:'
      echo "  ${0} [options] [command] [args]"
      echo
      echo 'Commands:'
      echo '  login <username> <password>   User login'
      echo '  paste [filename]              Create a paste (default)'
      echo
      echo 'Options:'
      echo '  -h [TOPIC], --help=TOPIC      Show help'
      echo '  -d KEY, --dev-key=KEY         Override developer key'
      echo '  -u KEY, --user-key=KEY        Override user key'
      echo '  -a, --anonymous               Force anonymous post'
      echo '  -l L1[:L2], --line=L1[:L2]    Extract only specific line(s)'
      echo '  -n NAME, --name=NAME          Set post name'
      echo '  -p, --private                 Set post visibility to PRIVATE'
      echo '  -f FORMAT, --format=FORMAT    Set post format (see --help=formats)'
      echo '  -e EXPIRE, --expire=EXPIRE    Set post expiration (see --help=expire)'
      ;;

  esac

  exit "${1}"
}

#
# Login
#

do_login() {
  # Arguments check
  if [[ -z "${2}" ]]; then
    echo "${0} login: wrong number of arguments (given ${#}, expected >= 2)" >&2
    echo >&2
    do_help 1 >&2
  fi

  # Do login
  response=$(curl \
    --silent \
    --request 'POST' \
    --data-urlencode "api_dev_key=${API_DEV_KEY}" \
    --data-urlencode "api_user_name=${1}" \
    --data-urlencode "api_user_password=${2}" \
    'https://pastebin.com/api/api_login.php')

  # Error check
  if [[ "${response}" = *\ * ]];  then
    echo "ERROR: ${response}" >&2
    exit 1
  fi

  # Store in config
  mkdir -p "${HOME}/.config/pastebin.sh"
  echo "API_USER_KEY='${response}'" > "${HOME}/.config/pastebin.sh/config"
  echo "Logged in successfully. User key '${response}' stored in ${HOME}/.config/pastebin.sh/config"
}

#
# Paste
#

do_paste() {
  # Read input
  if [[ -z "${1}" || "${1}" = '-' ]]; then
    PASTE_CODE="$(</dev/stdin)"
  else
    [[ -z "${PASTE_NAME}" ]] && PASTE_NAME="${1}"
    PASTE_CODE="$(<"${1}")"
  fi

  # Extract lines
  if [[ -n "${PASTE_LINE}" ]]; then
    if [[ "${PASTE_LINE}" = *:* ]]; then
      PASTE_CODE="$(echo "${PASTE_CODE}" | awk "NR==${PASTE_LINE%:*}, NR==${PASTE_LINE#*:}")"
    else
      PASTE_CODE="$(echo "${PASTE_CODE}" | awk "NR==${PASTE_LINE}")"
    fi
  fi

  # Uppercase expiration
  PASTE_EXPIRE="$(echo "${PASTE_EXPIRE}" | tr '[:lower:]' '[:upper:]')"

  # Do post
  response=$(curl \
    --silent \
    --request 'POST' \
    --data-urlencode 'api_option=paste' \
    --data-urlencode "api_dev_key=${API_DEV_KEY}" \
    --data-urlencode "api_user_key=${API_USER_KEY}" \
    --data-urlencode "api_paste_name=${PASTE_NAME}" \
    --data-urlencode "api_paste_code=${PASTE_CODE}" \
    --data-urlencode "api_paste_private=${PASTE_PRIVATE}" \
    --data-urlencode "api_paste_format=${PASTE_FORMAT}" \
    --data-urlencode "api_paste_expire_date=${PASTE_EXPIRE}" \
    'https://pastebin.com/api/api_post.php')

  # Error check
  if [[ "${response}" = *\ * ]]; then
    echo "ERROR: ${response}" >&2
    exit 1
  fi

  # Great success
  echo "${response}"
}

#
# Defaults
#

API_DEV_KEY='-O72PYs3oEq_T8ZS_vPBRiMMVTA3eyAW'
API_USER_KEY=''

PASTE_CODE=''
PASTE_LINE=''
PASTE_NAME=''
PASTE_PRIVATE='0'
PASTE_FORMAT=''
PASTE_EXPIRE='N'

#
# User config
#

if [[ -f "${HOME}/.config/pastebin.sh/config" ]]; then
  # shellcheck disable=SC1090
  source "${HOME}/.config/pastebin.sh/config"
fi

#
# Parse command line
#

PARSE='true'
ARGS=()
while [[ -n "${1}" ]]; do
  if ${PARSE}; then
    case "${1}" in
      -h|--help) do_help 0 "${2}";;
      --help=*)  do_help 0 "${1:7}";;
      -h*)       do_help 0 "${1:2}";;

      -d|--dev-key) API_DEV_KEY="${2}"; shift;;
      --dev-key=*)  API_DEV_KEY="${1:10}";;
      -d*)          API_DEV_KEY="${1:2}";;

      -u|--user-key) API_USER_KEY="${2}"; shift;;
      --user-key=*)  API_USER_KEY="${1:11}";;
      -u*)           API_USER_KEY="${1:2}";;

      -a|--anonymous) API_USER_KEY='';;

      -l|--line) PASTE_LINE="${2}"; shift;;
      --line=*)  PASTE_LINE="${1:7}";;
      -l*)       PASTE_LINE="${1:2}";;

      -n|--name) PASTE_NAME="${2}"; shift;;
      --name=*)  PASTE_NAME="${1:7}";;
      -n*)       PASTE_NAME="${1:2}";;

      -p|--private) PASTE_PRIVATE='1';;

      -f|--format) PASTE_FORMAT="${2}"; shift;;
      --format=*)  PASTE_FORMAT="${1:9}";;
      -f*)         PASTE_FORMAT="${1:2}";;

      -e|--expire) PASTE_EXPIRE="${2}"; shift;;
      --expire=*)  PASTE_EXPIRE="${1:9}";;
      -e*)         PASTE_EXPIRE="${1:2}";;

      --) PARSE='false';;
      -*) echo "${0}: invalid option: ${1}" >&2; echo >&2; usage 1 >&2;;
      *)  ARGS+=("${1}");;
    esac
  else
    ARGS+=("${1}")
  fi

  shift
done

#
# Execute command
#

case "${ARGS[0]}" in
  login) do_login "${ARGS[@]:1}";;
  paste) do_paste "${ARGS[@]:1}";;
  *)     do_paste "${ARGS[@]}";;
esac
