#!/usr/bin/env bash

# Function to check if conda is available
__conda_autoenv_check_conda() {
    if ! command -v conda &> /dev/null; then
        echo "Error: conda is not installed or not in PATH"
        return 1
    fi
    return 0
}

# Function to activate conda environment
__conda_autoenv_activate() {
    local env_name="$1"
    if ! conda env list | grep -q "^${env_name} "; then
        echo "Conda environment '$env_name' does not exist. Creating..."
        if conda create -n "$env_name" python -y; then
            echo "Created conda environment: $env_name"
        else
            echo "Failed to create conda environment: $env_name"
            return 1
        fi
    fi
    if conda activate "$env_name" 2>/dev/null; then
        echo "Activated conda environment: $env_name"
    else
        echo "Failed to activate conda environment: $env_name"
        return 1
    fi
}

# Function to deactivate conda environment
__conda_autoenv_deactivate() {
    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        local current_env="$CONDA_DEFAULT_ENV"
        if conda deactivate 2>/dev/null; then
            echo "Deactivated conda environment: $current_env"
        else
            echo "Failed to deactivate conda environment: $current_env"
        fi
    fi
}

# Function to handle .condaenv file
__conda_autoenv_handle() {
    local dir="$1"
    local condaenv_file="$dir/.condaenv"

    if [[ -f "$condaenv_file" ]]; then
        local env_name=$(cat "$condaenv_file" | tr -d '[:space:]')
        if [[ -n "$env_name" ]]; then
            if [[ "$CONDA_DEFAULT_ENV" != "$env_name" ]]; then
                __conda_autoenv_deactivate
                __conda_autoenv_activate "$env_name"
            fi
        fi
    else
        __conda_autoenv_deactivate
    fi
}

# Overwrite cd command
cd() {
    builtin cd "$@"
    __conda_autoenv_handle "$PWD"
}

# Overwrite python command
python() {
    if __conda_autoenv_check_conda; then
        __conda_autoenv_handle "$PWD"
        command python "$@"
    else
        command python "$@"
    fi
}

# Initial check for conda
__conda_autoenv_check_conda

# Handle current directory on shell startup
__conda_autoenv_handle "$PWD"
