#color codes for printf
RED='\033[0;31m'
NC='\033[0m' # No Color

################ Output redirection
# Redirect all output to the specified file
function redirectOutput() {
    exec >"${1}" 2>&1
}

# Tee all output to the specified file
function teeOutput() {
    exec &> >(tee -a "${1}")
}


################ Output formatting
function section() {
    echo "#################:  ${1} ${2} ${3} ${4}"
}

function info() {
    echo "STARTING:  ${1} ${2} ${3} ${4}"
}

function errorPrint() {
    printf "${RED}ERROR: ${1} ${2} ${3} ${4}${NC}\n"
}

function errorExit() {
    errorPrint "${1} ${2} ${3} ${4}"
    printf "${RED}Exiting${NC}\n"
    exit 1
}

################ Executing commands
function checkStatus() {
    if [[ ${1} -ne 0 ]]
    then
        errorExit "Process exited with a non-zero status (${1})"
    fi
}

function execute() {
    date
    echo "#### Executing ${@}"
    ${@}
    checkStatus ${?}
}

################ Directories and files
function makeDirIfAbsent() {
	if [[ -z "${1}" ]]
	then
		errorExit "makeDirIfAbsent: No directory specified"
	fi 
	if [[ ! -d "${1}" ]]
	then
		mkdir -p "${1}"
		if [[ ! -d "${1}" ]]
		then
			errorExit "makeDirIfAbsent: Could not create '${1}'"
		fi 
	fi 

}