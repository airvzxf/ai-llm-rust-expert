# Rust Expert | AI LLM

## Project Roadmap: Creation of a Rust Expert LLM

### **Phase 0: Planning and Environment Setup (Week 1)**

- **Step 0.1: Refined Definition of the “Rust Expert”**

  - **Action:** Write the specific objectives in a document. Should the model be good at generating code from scratch, explaining compiler errors, refactoring code to be more idiomatic, or all of the above?

  - *Note: Being specific here is crucial. A clear objective like “Create an assistant that refactors `for` loops into functional iterators” is better than “Make a Rust expert.” Start with a niche.*

- **Step 0.2: Base Model Selection**

  - **Action:** Research Hugging Face and choose a pre-trained code model.

  - **Options:** `codellama/CodeLlama-7b-hf`, `mistralai/Mistral-7B-v0.1`, `bigcode/starcoder2-3b`.

  - *Note: Start with a small model (3B or 7B parameters). They are faster and cheaper for experimenting. Only scale up to a larger one if the results are not sufficient.*

- **Step 0.3: Computing Strategy and Budget**

  - **Action:** Allocate your budget. Define a spending limit on Google Cloud.

  - **Strategy:**

    1. **Prototyping and Debugging:** `Google Colab Pro` (approx. $10 USD/month).
    2. **Final Trainings:** `Google Cloud AI Platform` with an L4 or T4 GPU (these are more cost-effective than V100/A100 for this scale).

  - *Note: Always do a 5-minute training test on a small fraction of the data to estimate costs and time before launching the full job.*

- **Step 0.4: Local Development Environment Setup**

  - **Action:** On your machine, create a Python virtual environment.

  - **Commands:** `python -m venv rust_llm_env`, `source rust_llm_env/bin/activate`.

  - **Key Installations:** `pip install transformers datasets accelerate bitsandbytes peft trl jupyterlab`

  - *Note: `bitsandbytes` is for quantization (QLoRA), which allows you to train larger models on smaller GPUs. `trl` is the Hugging Face library that contains the trainers for SFT and DPO.*

- **Step 0.5: Support Account Configuration**

  - **Action:** Make sure you have accounts for:

    1. **Hugging Face:** To download models and upload your own. Configure your access token.
    2. **Weights & Biases (optional, but recommended):** To monitor your trainings in real time (loss, metrics, etc.). It is free for personal projects.

-----

### **Phase 1: Supervised Fine-Tuning (SFT). Creating the Base Model v1 (Weeks 2-4)**

- **Step 1.1: SFT Dataset Collection and Curation**

  - **Action:** Gather high-quality `(instruction, response)` pairs about Rust.

  - **Sources:**

    - **GitHub:** Clone popular repositories (“awesome-rust”) and extract functions and their docstrings.
    - **Stack Overflow:** Use a scraper to get questions with the [rust] tag and their accepted answers.
    - **The Rust Programming Language Book:** Extract code examples and their explanations.

  - *Note: The quality of the dataset is the most important factor in the project. 1,000 high-quality examples are better than 10,000 low-quality ones.*

- **Step 1.2: Dataset Cleaning and Formatting**

  - **Action:** Convert all your data to a consistent JSONL format. Apply a standard prompt format.

  - **Example Format:**

    ```json
    {"text": "<s>[INST] How do you write a function that sums two integers in Rust? [/INST] fn sum(a: i32, b: i32) -> i32 { a + b } </s>"}
    ```

  - *Note: The prompt format (with tokens like `[INST]`) must match the one used to train the base model. Check the “model card” on Hugging Face.*

- **Step 1.3: SFT Training Script**

  - **Action:** Write a Python script using the `SFTTrainer` class from the `trl` library.

  - **Key Configurations (QLoRA):** Load the model in 4-bit, define the modules you will apply LoRA to (generally `q_proj`, `v_proj`), and configure the hyperparameters.

  - *Note: Look for an example fine-tuning script for Llama 2/3 with QLoRA on the Hugging Face blogs. You don't have to reinvent the wheel.*

- **Step 1.4: SFT Training Execution**

  - **Action:** Launch the training, first on a 1% sample of your data to ensure the code doesn't fail. Then, launch the full training on Colab Pro or Google Cloud.

  - *Note: Save model checkpoints every certain number of steps. If the training is interrupted, you can resume it without losing all progress.*

- **Step 1.5: Qualitative Evaluation and Model v1 Publication**

  - **Action:** Load the fine-tuned model and interact with it. Ask it questions. Are the answers coherent? Does the code compile?

  - **Publication:** Upload your fine-tuned model to your Hugging Face profile.

  - *Note: This v1 model is your baseline. It won't be perfect, but it is the foundation for the next phase.*

-----

### **Phase 2: Creation of the Preference Dataset (Your Expertise in Action) (Weeks 5-6)**

- **Step 2.1: Design of Challenging Evaluation Prompts**

 - **Action:** Create a spreadsheet with 100-200 prompts that test the model. Include common use cases, subtle errors, and questions about “the idiomatic way to do X in Rust.”

  - *Note: Think about the problems a junior Rust developer would face. These are the perfect prompts.*

- **Step 2.2: Generation of Multiple Responses**

  - **Action:** Write a script that feeds each prompt from your spreadsheet to the Model v1 and generates 2 or 3 different responses for each one (by playing with parameters like `temperature` and `top_p`).

  - *Note: Save these responses in a format that is easy to review, such as a CSV or JSON file.*

- **Step 2.3: Manual Annotation of Preferences**

  - **Action:** Review each set of generated responses. For each prompt, choose the response you consider “winning” and one that is “losing.”

  - *Note: This is the most manual-intensive step, but it is where you inject your value as an expert. Be rigorous and consistent in your evaluation criteria.*

- **Step 2.4: DPO Dataset Formatting**

  - **Action:** Convert your annotations to the format required by DPO.

  - **Example Format:**

    ```json
    {
    "prompt": "How are errors handled idiomatically in Rust?",
    "chosen": "The response that uses Result and the `?` operator...",
    "rejected": "The response that uses `unwrap()` indiscriminately..."
    }
    ```

  - *Note: Make sure there are no formatting errors. Validate your JSONL file before proceeding.*

-----

### **Phase 3: Direct Preference Optimization (DPO). Creating the Expert Model v2 (Week 7)**

- **Step 3.1: DPO Training Script**

  - **Action:** Adapt your previous script to use the `DPOTrainer` class from the `trl` library.

  - *Note: The `DPOTrainer` is very similar to the `SFTTrainer`, but it receives the dataset with the `(prompt, chosen, rejected)` format. The key hyperparameter to adjust is `beta`.*

- **Step 3.2: DPO Training Execution**

  - **Action:** Launch the DPO training. This process takes your Model v1 and “pushes” it in the direction of your preferences, learning to generate responses like the ones you marked as “chosen.”

  - *Note: DPO training is usually much shorter than SFT.*

- **Step 3.3: Saving and Publishing the v2 Model**

  - **Action:** Save the final model and upload it to Hugging Face with a clear name, such as `rust-expert-codellama-v2-dpo`.

-----

### **Phase 4: Retrieval-Augmented Generation (RAG) Integration (Week 7)**

- **Step 4.1: Vector Database and Retriever Setup**
  - **Action:** Choose and set up a vector database (e.g., ChromaDB, FAISS). Implement a retrieval mechanism that takes a user query and finds the most relevant text chunks.
  - *Note: The efficiency of the retriever is key. Start with a simple keyword-based search or a pre-trained sentence-transformer model to create embeddings.*

- **Step 4.2: Knowledge Base Ingestion**
  - **Action:** Write scripts to process and load the knowledge sources into the vector database.
  - **Sources:** The Rust Programming Language Book, Rustonomicon, Tokio tutorial, and documentation of the top 20 most popular crates.
  - *Note: Chunking is important. Documents must be split into small, coherent pieces to be useful for the retriever.*

- **Step 4.3: Pipeline Integration**
  - **Action:** Modify the inference pipeline so that prompts are first sent to the retriever. The retrieved context is then prepended to the original prompt before being passed to the Expert Model v2 (from DPO).
  - *Note: This combines the expert reasoning of the DPO model with the factual, up-to-date knowledge from the RAG system.*

-----

### **Phase 5: Final Evaluation and Closing (Week 8)**

- **Step 5.1: “Face-to-Face” Comparative Evaluation**

  - **Action:** Create an evaluation script where you give the same prompt to Model v1, Model v2 (DPO), and Model v2 with RAG. Show their responses side-by-side.

  - *Note: Use a set of test prompts that the model has not seen during training to get an honest evaluation of its performance. The comparison should highlight the improvements from SFT, DPO, and RAG.*

- **Step 5.2: Final Project Documentation**

  - **Action:** Update the `README.md` of your GitHub repository. Describe the complete process, the challenges you faced, the decisions you made, and the results obtained. Include examples of the improvements between v1, v2, and v2+RAG.

  - *Note: A well-documented project is a top-level portfolio piece that demonstrates not only technical skill but also methodological rigor.*

- **Step 5.3: (Optional) Creation of an Interactive Demo**

  - **Action:** Use libraries like `Gradio` or `Streamlit` to build a simple web interface where others can interact with your model. You can host it for free on Hugging Face Spaces.

  - *Note: This makes your work tangible and easy to share with others, which is incredibly valuable.*
