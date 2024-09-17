function python() {
    local args=("$@")
    local script_path=""
    local script_dir=""
    local env_changed=0
    local previous_env="$CONDA_DEFAULT_ENV"

    # Determine the script path and directory
    if [[ -f "$1" ]]; then
        script_path="$1"
        script_dir="$(dirname "$script_path")"
    else
        script_dir="$PWD"
    fi

    # Check for .python-env in the script directory
    if [[ -f "$script_dir/.python-env" ]]; then
        local env_name
        env_name="$(< "$script_dir/.python-env")"
        if [[ "$CONDA_DEFAULT_ENV" != "$env_name" ]]; then
            echo -e "\033[34mActivating environment: $previous_env -> $env_name\033[0m"
            conda activate "$env_name"
            env_changed=1
        fi
    fi

    # Execute the original python command
    command python "$@"

    # Deactivate the environment if it was changed
    if [[ $env_changed -eq 1 ]]; then
        if [[ -n "$previous_env" && "$previous_env" != "$CONDA_DEFAULT_ENV" ]]; then
            echo -e "\033[34mReverting to previous environment: $CONDA_DEFAULT_ENV -> $previous_env\033[0m"
            conda activate "$previous_env"
        fi
    fi
}