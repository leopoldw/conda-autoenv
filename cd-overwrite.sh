# Overwrite cd
function cd() {
    builtin cd "$@" || return

    local env_changed=0
    local previous_env="$CONDA_DEFAULT_ENV"

    # Check for .python-env in the new directory
    if [[ -f ".python-env" ]]; then
        local env_name
        env_name="$(< ".python-env")"
        if [[ "$CONDA_DEFAULT_ENV" != "$env_name" ]]; then
            echo -e "\033[34mActivating environment: $previous_env -> $env_name\033[0m"
            conda activate "$env_name"
            env_changed=1
        fi
    else
        # Deactivate to base environment if not already in it
        if [[ "$CONDA_DEFAULT_ENV" != "base" ]]; then
            echo -e "\033[34mDeactivating environment: $CONDA_DEFAULT_ENV -> base\033[0m"
            conda deactivate
        fi
    fi
}