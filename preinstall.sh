#!/bin/bash

if ! command -v conda &> /dev/null; then
    echo "Error: conda is not installed - please install conda first"
    return 1
fi

eval "$(conda shell.bash hook)" && conda activate base

return 0