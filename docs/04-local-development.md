# Rust Expert | AI LLM

## Local Development Environment Setup

This document outlines the steps to set up and run the local development environment for this project. The environment is based on Python and uses a Jupyter Notebook for experimentation.

### 1. Prerequisites

Ensure you have Python 3 installed on your system.

### 2. Environment Setup

The project includes a script to automate the setup process. This script will create a Python virtual environment and install all the necessary dependencies.

1.  **Navigate to the setup directory:**
    ```bash
    cd src/local-dev/
    ```

2.  **Run the setup script:**
    ```bash
    ./setup_env.bash
    ```
    This command creates a directory named `.venv` which contains the Python interpreter and the required libraries. The dependencies are listed in `src/local-dev/requirements.txt`.

### 3. Activate the Virtual Environment

Before running the notebook, you must activate the virtual environment in your terminal session.

```bash
source .venv/bin/activate
```
Your terminal prompt should now indicate that you are in the `.venv` environment.

### 4. Hugging Face Authentication

The base model used in this project (`mistralai/Mistral-7B-v0.1`) is a "gated model". You must have a Hugging Face account and authenticate your environment to download it.

1.  **Grant Access Online:** Visit the [model's page](https://huggingface.co/mistralai/Mistral-7B-v0.1), read, and accept the terms of use.
2.  **Login via CLI:** In your activated terminal, run the following command and enter a valid Hugging Face access token when prompted.
    ```bash
    huggingface-cli login
    ```

### 5. Running the Jupyter Notebook

The starter notebook `01-load-base-model.ipynb` allows you to load the base model and run a test prompt.

1.  **Launch Jupyter Lab:**
    ```bash
    jupyter lab 01-load-base-model.ipynb
    ```
2.  **Run the cells:** Once the notebook is open in your browser, you can execute the cells sequentially to load the model and generate a response.

### 6. Hardware and Performance Notes

#### CPU Execution

The notebook is currently configured to **run on the CPU by default**. This is the most compatible option and ensures that the code runs on most machines without requiring a specific GPU setup.

**Be aware that running a 7-billion parameter model on a CPU is very slow.** Generating a response to the test prompt can take several minutes.

#### GPU Execution (Advanced)

The environment was tested on a GPU, but ran into two common issues:

1.  **CUDA Out of Memory:** A 7B model requires a significant amount of GPU VRAM (typically >14 GB). The notebook includes an implementation for loading the model in 4-bit precision (`load_in_4bit=True`) to reduce this requirement to ~5-6 GB.
2.  **GPU Architecture Incompatibility:** Modern data science libraries (like PyTorch and `bitsandbytes`) are often compiled for newer GPU architectures. Older GPUs (like the NVIDIA Pascal series, e.g., GTX 1080) may not be supported by the pre-compiled binaries, leading to a `no kernel image is available` error.

If you have a modern, supported GPU with sufficient VRAM, you can modify the notebook to enable GPU execution. This involves changing the `device` variable to `"cuda"` and using the `load_in_4bit=True` and `device_map="auto"` parameters in the `from_pretrained` call.