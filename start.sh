#!/usr/bin/env bash
# """TODO
# """

# shellcheck disable=SC2034
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
SCRIPTNAME="$(basename "$0")"

init_logger(){
  local log_file="${HOME}/.cache/snippets/_log.sh"
  local status
  status=$(curl -o /dev/null -s -w "%{http_code}\n" http://framagit.org)
  mkdir -p "$(dirname "${log_file}")"

  if ping -q -c 1 framagit.org &> /dev/null \
    && [[ ${status} -ge 200 ]] \
    && [[ ${status} -lt 400 ]]
  then
    # shellcheck disable=SC1090
    source <(curl -s https://framagit.org/-/snippets/7183/raw/main/_get_log.sh)
  elif [[ -f "${log_file}" ]]
  then
    # shellcheck disable=SC1090
    source <(cat "${log_file}")
  else
    echo -e "\e[1;31m[ERROR]\e[0m\e[31m $0: Not able to ping \e[1;31mframagit.org\e[0m"
    echo -e "\e[1;31m[ERROR]\e[0m\e[31m $0: And log file ${log_file} does not exists.\e[0m"
    echo -e "\e[1;31m[ERROR]\e[0m\e[31m $0: Logger not available, script will now exit\e[0m"
    exit 1
  fi
}

check_dir(){
  local dir="$1"
  if ! [[ -d "${dir}" ]]
  then
    _log "INFO" "Create directory ${dir}"
    mkdir -p "${dir}"
  fi
}

main(){
  # TODO Change below substitution if need
  local DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  local answer=1
  local idx=0
  local vm_configs
  local all_configs
  cd "${SCRIPTPATH}/vms/nixos-shell/" || exit 1
  all_configs=$(nix flake show ./ --json)

  for iConf in $(echo "${all_configs}" | jq -r '.nixosConfigurations | keys[]')
  do
    vm_configs+="\n  - **${idx}**: ${iConf}"
    idx=$((idx + 1))
  done

  init_logger
  check_dir "/tmp/nixos-shell"

  if [[ $# -lt 1 ]]
  then
    msg="Which flavor to use ? [Default: **0**]${vm_configs}"
    _log "INFO" "${msg}"
    read -r answer
    answer=${answer:-0}
  else
    answer=$1
    shift
  fi
  config=$(echo "${all_configs}" | jq -r ".nixosConfigurations | keys[${answer}]")

  _log "INFO" "Starting VM with flavor **${config}**"
  # nix run ".#${config}" --show-trace "$@"
  nixos-shell --flake ".#${config}" --show-trace "$@"
}

main "$@"

# vim: ft=sh
