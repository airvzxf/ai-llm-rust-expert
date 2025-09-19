# Rust Expert | AI LLM

## Base model selection.

### Base model with or without programming.

**Short answer:** It is extremely inefficient and much more expensive to start with a model that doesn't know how to code. The final result will, almost certainly, be a much lower-quality model.

#### The analogy: Teaching a programmer vs. teaching a poet.

Imagine you want to hire someone to become your world-class expert in Rust. You have two candidates:

* **Candidate A (Base Model with Programming):** A senior programmer with 20 years of experience in C++ and Python. He doesn't know Rust, but he perfectly understands what variables, loops, pointers, memory management, data structures, compilers, etc., are.
* **Candidate B (Base Model without Programming):** An award-winning poet. He is a master of language, structure, syntax, and rhythm in human language, but has never written a single line of code in his life. He doesn't know what a variable or an `if/else` is.

Fine-Tuning (SFT/DPO) is your "intensive Rust course."

* For **Candidate A**, you only need to teach him the syntax and philosophy of Rust (ownership, borrowing, etc.). He will transfer all his prior programming knowledge and become an expert in Rust quickly.
* For **Candidate B**, you would first have to teach him the fundamental concepts of programming from scratch. This process would be incredibly long and arduous. He would likely never learn to "think" like a programmer and would only superficially imitate the syntax you show him, without understanding the underlying logic.

#### General rule and practical recommendation.

The golden rule of fine-tuning is: **Always choose a base model whose pre-training is as close as possible to your final domain.**

For your Rust project: You should use a model that is already a "generalist programmer."

* **Excellent Options:** Code Llama, StarCoder2, DeepSeek Coder. These models were pre-trained on trillions of tokens of code from dozens of languages, including a large amount of Rust. They are already "Candidate A."
* **Acceptable Options:** High-quality generalist models like Mistral or Llama 3. Although they are not code-specific, their massive training included so much code that they are also good generalist programmers.
* **Models you MUST AVOID:** A model that was exclusively fine-tuned to be an expert in medical or legal texts. Starting from there to teach Rust would be the equivalent of hiring a lawyer to be your five-star chef.

By choosing a code-centric base model, you are standing on the shoulders of giants and ensuring that your effort (and money) is invested in the final specialization phase, which is where the value is truly created.

### Base model reasoner or not reasoner.

By applying SFT and DPO, you aren't creating a skill from scratch; you are **amplifying and directing the innate strengths of the base model**.

* **If you fine-tune NextCoder:** You'll get an **elite "Rust Copilot"**. It will be incredibly fast and accurate at generating idiomatic code, refactoring snippets, and using `crates` correctly. Its excellence will lie in **pure code generation**.
* **If you fine-tune Phi-4-reasoning:** You'll get a **"Rust Architect/Tutor"**. It will be exceptionally good at tasks like:
  * **Designing a complex algorithm** in Rust from scratch, explaining the plan to you.
  * **Debugging a subtle logic error**, detailing its chain of reasoning.
  * **Explaining why** the *borrow checker* is complaining and giving you three different ways to fix it, with their pros and cons.

RAG will work with both, but they will use it differently. NextCoder will use the RAG context to get precise data and generate code. Phi-4 will use the context to **reason about the information** and then generate a solution and an explanation.

| Attribute | `NextCoder-7B` (Specialist) | `Phi-4-reasoning-plus` (Reasoner) |
| :--- | :--- | :--- |
| **Main Goal** | Code generation and completion. | Multi-step problem-solving. |
| **Key Strength** | Syntactic fluency and API knowledge. | Logic, planning, and explanation. |
| **Result post-SFT/DPO**| An ultra-fast and accurate Rust code generator. | An assistant that can design, debug, and teach Rust. |
| **Best for...** | Refactoring, boilerplate tasks, library usage. | Algorithm design, conceptual debugging, tutoring tasks. |

#### Verdict and Recommendation

For your goal of creating an "expert model," my recommendation would lean slightly towards the **reasoning model like `Phi-4-reasoning-plus`**.

Why? Because a true "expert" not only writes code but **understands and explains the underlying principles**. Fine-tuning a model that already has a solid foundation in logical reasoning will allow you to create a much more unique and powerful tool. It won't just be an assistant that writes code for you, but one that helps you **think better in Rust**.

### Technical criteria for selecting models.

#### Experimentation.

These models will be used for local testing and a quick review of their efficiency, whether they achieve the results in a timely manner, and also for experimentation. If they are suitable, they can be tested on cloud servers, so they won't be as costly and time-consuming.

* **Size:** I'm looking for models with a file size of less than approximately 5 GB for local testing.
* **Last update date:** If they are recent models, they are theoretically much better, as model training techniques have improved, making them faster and more accurate.
* **Rust:** Check if the model was trained with the Rust dataset. These tests would be manual and empirical, running Rust prompts to assess their level of knowledge.
* **Reasoner:** For now, you should experiment with general reasoning models and non-reasoning code models.

#### Production testing.

[Pending].

* **Reasoner:** Ideally, I'd train both to create a Mixture of Experts (MoE) model.

### Base models options.

This list was created and updaded on 14 Sep 2025 (2025-09-14). The information was takken from [Hugging Face](https://huggingface.co). The information of the model is in the next format: company/model-name | parameters | tensor type | total size of the file | last commit updated | reference in human time.

*Note:* The update time shown refers to the most recent commit to the Hugging Face repository. This doesn't necessarily mean the model itself was updated, as the change could have been to any file in the repository.

#### Code-focused models.

* [Meta Llama](https://huggingface.co/meta-llama).
  * [meta-llama/CodeLlama-7b-hf](https://huggingface.co/meta-llama/CodeLlama-7b-hf) | 6.74B | BF16 | 13.48 GB | 13 Mar 2024 | over 1 year ago.
  * [meta-llama/CodeLlama-7b-Instruct-hf](https://huggingface.co/meta-llama/CodeLlama-7b-Instruct-hf) | 6.74B | BF16 | 13.48 GB | 13 Mar 2024 | over 1 year ago.
  * [meta-llama/CodeLlama-13b-hf](https://huggingface.co/meta-llama/CodeLlama-13b-hf) | 13B | BF16 | 26.03 GB | 13 Mar 2024 | over 1 year ago.
  * [meta-llama/CodeLlama-13b-Instruct-hf](https://huggingface.co/meta-llama/CodeLlama-13b-Instruct-hf) | 13B | BF16 | 26.03 GB | 13 Mar 2024 | over 1 year ago.
  * [meta-llama/CodeLlama-34b-hf](https://huggingface.co/meta-llama/CodeLlama-34b-hf) | 33.7B | BF16 | 67.49 GB | 14 Mar 2024 | over 1 year ago.
  * [meta-llama/CodeLlama-34b-Instruct-hf](https://huggingface.co/meta-llama/CodeLlama-34b-Instruct-hf) | 33.7B | BF16 | 67.49 GB | 14 Mar 2024 | over 1 year ago.
  * [meta-llama/CodeLlama-70b-hf](https://huggingface.co/meta-llama/CodeLlama-70b-hf) | 69B | BF16 | 137.91 GB | 13 Mar 2024 | over 1 year ago.
  * [meta-llama/CodeLlama-70b-Instruct-hf](https://huggingface.co/meta-llama/CodeLlama-70b-Instruct-hf) | 69B | BF16 | 137.91 GB | 14 Mar 2024 | over 1 year ago.
* [Code Llama](https://huggingface.co/codellama).
  * [codellama/CodeLlama-7b-hf](https://huggingface.co/codellama/CodeLlama-7b-hf) | 6.74B | BF16 | 13.48 GB | 25 Aug 2023 | about 2 years ago.
  * [codellama/CodeLlama-7b-Instruct-hf](https://huggingface.co/codellama/CodeLlama-7b-Instruct-hf) | 6.74B | BF16 | 13.48 GB | 25 Aug 2023 | about 2 years ago.
  * [codellama/CodeLlama-13b-hf](https://huggingface.co/codellama/CodeLlama-13b-hf) | 13B | BF16 | 26.03 GB | 25 Aug 2023 | about 2 years ago.
  * [codellama/CodeLlama-13b-Instruct-hf](https://huggingface.co/codellama/CodeLlama-13b-Instruct-hf) | 13B | BF16 | 26.03 GB | 25 Aug 2023 | about 2 years ago.
  * [codellama/CodeLlama-34b-hf](https://huggingface.co/codellama/CodeLlama-34b-hf) | 33.7B | BF16 | 67.49 GB | 25 Aug 2023 | about 2 years ago.
  * [codellama/CodeLlama-34b-Instruct-hf](https://huggingface.co/codellama/CodeLlama-34b-Instruct-hf) | 33.7B | BF16 | 67.49 GB | 25 Aug 2023 | about 2 years ago.
  * [codellama/CodeLlama-70b-hf](https://huggingface.co/codellama/CodeLlama-70b-hf) | 69B | BF16 | 137.91 GB | 29 Jan 2024 | over 1 year ago.
  * [codellama/CodeLlama-70b-Instruct-hf](https://huggingface.co/codellama/CodeLlama-70b-Instruct-hf) | 69B | BF16 | 137.91 GB | 29 Jan 2024 | over 1 year ago.
* [Google](https://huggingface.co/google).
  * [google/codegemma-2b](https://huggingface.co/google/codegemma-2b) | 2.51B | BF16 | 5.02 GB | 09 Apr 2024 | over 1 year ago.
  * [google/codegemma-1.1-2b](https://huggingface.co/google/codegemma-1.1-2b) | 2.51B | BF16 | 5.02 GB | 30 Apr 2024 | over 1 year ago.
  * [google/codegemma-7b](https://huggingface.co/google/codegemma-7b) | 8.54B | BF16 | 17.07 GB | 09 Apr 2024 | over 1 year ago.
  * [google/codegemma-7b-it](https://huggingface.co/google/codegemma-7b-it) | 8.54B | BF16 | 17.07 GB | 09 Apr 2024 | over 1 year ago.
  * [google/codegemma-1.1-7b-it](https://huggingface.co/google/codegemma-1.1-7b-it) | 8.54B | BF16 | 17.07 GB | 30 Apr 2024 | over 1 year ago.
* [Qwen](https://huggingface.co/Qwen).
  * [Qwen/Qwen3-Coder-30B-A3B-Instruct](https://huggingface.co/Qwen/Qwen3-Coder-30B-A3B-Instruct) | 30.5B | BF16 | 61.08 GB | 31 Jul 2025 | about 2 months ago.
  * [Qwen/Qwen3-Coder-480B-A35B-Instruct](https://huggingface.co/Qwen/Qwen3-Coder-480B-A35B-Instruct) | 480B | BF16 | 962.5 GB | 22 Jul 2025 | about 2 months ago.
  * [Qwen/Qwen2.5-Coder-0.5B](https://huggingface.co/Qwen/Qwen2.5-Coder-0.5B) | 494M | BF16 | 988 MB | 08 Nov 2024 | 10 months ago.
  * [Qwen/Qwen2.5-Coder-0.5B-Instruct](https://huggingface.co/Qwen/Qwen2.5-Coder-0.5B-Instruct) | 494M | BF16 | 988 MB | 06 Nov 2024 | 10 months ago.
  * [Qwen/Qwen2.5-Coder-1.5B](https://huggingface.co/Qwen/Qwen2.5-Coder-1.5B) | 1.54B | BF16 | 3.09 GB | 18 Sep 2024 | 12 months ago.
  * [Qwen/Qwen2.5-Coder-1.5B-Instruct](https://huggingface.co/Qwen/Qwen2.5-Coder-1.5B-Instruct) | 1.54B | BF16 | 3.09 GB | 18 Sep 2024 | 12 months ago.
  * [Qwen/Qwen2.5-Coder-3B](https://huggingface.co/Qwen/Qwen2.5-Coder-3B) | 3.09B | BF16 | 4.96 GB | 08 Nov 2024 | 10 months ago.
  * [Qwen/Qwen2.5-Coder-3B-Instruct](https://huggingface.co/Qwen/Qwen2.5-Coder-3B-Instruct) | 3.09B | BF16 | 4.96 GB | 06 Nov 2024 | 10 months ago.
  * [Qwen/Qwen2.5-Coder-7B](https://huggingface.co/Qwen/Qwen2.5-Coder-7B) | 7.62B | BF16 | 15.23 GB | 16 Sep 2024 | 12 months ago.
  * [Qwen/Qwen2.5-Coder-7B-Instruct](https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct) | 7.62B | BF16 | 15.23 GB | 17 Sep 2024 | 12 months ago.
  * [Qwen/Qwen2.5-Coder-14B](https://huggingface.co/Qwen/Qwen2.5-Coder-14B) | 14.8B | BF16 | 29.48 GB | 08 Nov 2024 | 10 months ago.
  * [Qwen/Qwen2.5-Coder-14B-Instruct](https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct) | 14.8B | BF16 | 29.48 GB | 06 Nov 2024 | 10 months ago.
  * [Qwen/Qwen2.5-Coder-32B](https://huggingface.co/Qwen/Qwen2.5-Coder-32B) | 32.8B | BF16 | 65.56 GB | 08 Nov 2024 | 10 months ago.
  * [Qwen/Qwen2.5-Coder-32B-Instruct](https://huggingface.co/Qwen/Qwen2.5-Coder-32B-Instruct) | 32.8B | BF16 | 65.56 GB | 10 Nov 2024 | 10 months ago.
* [DeepSeek](https://huggingface.co/deepseek-ai).
  * [deepseek-ai/deepseek-coder-1.3b-base](https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-base) | 1.35B | BF16 | 2.69 GB | 28 Oct 2023 | almost 2 years ago.
  * [deepseek-ai/deepseek-coder-1.3b-instruct](https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-instruct) | 1.35B | BF16 | 2.69 GB | 07 Mar 2024 | over 1 year ago.
  * [deepseek-ai/deepseek-coder-6.7b-base](https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-base) | 6.74B | BF16 | 13.48 GB | 19 Mar 2024 | over 1 year ago.
  * [deepseek-ai/deepseek-coder-6.7b-instruct](https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-instruct) | 6.74B | BF16 | 13.48 GB | 03 Dec 2023 | almost 2 years ago.
  * [deepseek-ai/deepseek-coder-7b-base-v1.5](https://huggingface.co/deepseek-ai/deepseek-coder-7b-base-v1.5) | 6.91B | BF16 | 13.82 GB | 25 Jan 2024 | over 1 year ago.
  * [deepseek-ai/deepseek-coder-7b-instruct-v1.5](https://huggingface.co/deepseek-ai/deepseek-coder-7b-instruct-v1.5) | 6.91B | BF16 | 13.82 GB | 25 Jan 2024 | over 1 year ago.
  * [deepseek-ai/deepseek-coder-33b-base](https://huggingface.co/deepseek-ai/deepseek-coder-33b-base) | 33.3B | BF16 | 66.67 GB | 07 Mar 2024 | over 1 year ago.
  * [deepseek-ai/deepseek-coder-33b-instruct](https://huggingface.co/deepseek-ai/deepseek-coder-33b-instruct) | 33.3B | BF16 | 66.67 GB | 07 Mar 2024 | over 1 year ago.
  * [deepseek-ai/DeepSeek-Coder-V2-Lite-Base](https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Lite-Base) | 15.7B | BF16 | 31.41 GB | 14 Jun 2024 | over 1 year ago.
  * [deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct](https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct) | 15.7B | BF16 | 31.41 GB | 14 Jun 2024 | over 1 year ago.
  * [deepseek-ai/DeepSeek-Coder-V2-Base](https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Base) | 236B | BF16 | 471.29 GB | 14 Jun 2024 | over 1 year ago.
  * [deepseek-ai/DeepSeek-Coder-V2-Instruct](https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Instruct) | 236B | BF16 | 471.29 GB | 14 Jun 2024 | over 1 year ago.
  * [deepseek-ai/DeepSeek-Coder-V2-Instruct-0724](https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Instruct-0724) | 236B | BF16 | 471.29 GB | 05 Sep 2024 | about 1 year ago.
* [BigCode](https://huggingface.co/bigcode).
  * [bigcode/starcoder2-3b](https://huggingface.co/bigcode/starcoder2-3b) | 3.03B | F32 | 12.1 GB | 23 Feb 2024 | over 1 year ago.
  * [bigcode/starcoder2-7b](https://huggingface.co/bigcode/starcoder2-7b) | 7.17B | BF16 | 14.35 GB | 27 Feb 2024 | over 1 year ago.
  * [bigcode/starcoder2-15b](https://huggingface.co/bigcode/starcoder2-15b) | 16B | F32 | 63.88 GB | 27 Feb 2024 | over 1 year ago.
* [Z.ai](https://huggingface.co/zai-org).
  * [zai-org/codegeex4-all-9b](https://huggingface.co/zai-org/codegeex4-all-9b) | 9.4B | BF16 | 18.81 GB | 05 Jul 2024 | about 1 year ago.
* [Microsoft](https://huggingface.co/microsoft).
  * [microsoft/NextCoder-7B](https://huggingface.co/microsoft/NextCoder-7B) | 7.62B | F32 | 30.46 GB | 03 May 2025 | 4 months ago.
  * [microsoft/NextCoder-14B](https://huggingface.co/microsoft/NextCoder-14B) | 14.8B | F32 | 59.08 GB | 03 May 2025 | 4 months ago.
  * [microsoft/NextCoder-32B](https://huggingface.co/microsoft/NextCoder-32B) | 32.8B | F32 | 129.68 GB | 03 May 2025 | 4 months ago.
* [Intellligent Software Engineering (iSE)](https://huggingface.co/ise-uiuc).
  * [ise-uiuc/Magicoder-DS-6.7B](https://huggingface.co/ise-uiuc/Magicoder-DS-6.7B) | 6.74B | F32 | 26.97 GB | 03 Dec 2023 | almost 2 years ago.
  * [ise-uiuc/Magicoder-S-CL-7B](https://huggingface.co/ise-uiuc/Magicoder-S-CL-7B) | 6.74B | F32 | 26.96 GB | 03 Dec 2023 | almost 2 years ago.
  * [ise-uiuc/Magicoder-S-DS-6.7B](https://huggingface.co/ise-uiuc/Magicoder-S-DS-6.7B) | 6.74B | F32 | 26.97 GB | 03 Dec 2023 | almost 2 years ago.
  * [ise-uiuc/Magicoder-CL-7B](https://huggingface.co/ise-uiuc/Magicoder-CL-7B) | 6.74B | F32 | 26.96 GB | 03 Dec 2023 | almost 2 years ago.
* [Mistral AI_](https://huggingface.co/mistralai).
  * [mistralai/Mamba-Codestral-7B-v0.1](https://huggingface.co/mistralai/Mamba-Codestral-7B-v0.1) | 7.29B | BF16 | 14.57 GB | 22 Aug 2024 | about 1 year ago.
  * [mistralai/Codestral-22B-v0.1](https://huggingface.co/mistralai/Codestral-22B-v0.1) | 22.2B | BF16 | 44.48 GB | 01 Jun 2024 | over 1 year ago.
* [Stability AI](https://huggingface.co/stabilityai).
  * [stabilityai/stable-code-instruct-3b](https://huggingface.co/stabilityai/stable-code-instruct-3b) | 2.8B | BF16 | 5.59 GB | 19 Mar 2024 | over 1 year ago.
  * [stabilityai/stable-code-3b](https://huggingface.co/stabilityai/stable-code-3b) | 2.8B | BF16 | 5.59 GB | 09 Jan 2024 | over 1 year ago.
  * [stabilityai/stablecode-instruct-alpha-3b](https://huggingface.co/stabilityai/stablecode-instruct-alpha-3b) | 3.31B | F16 BOOL | 6.08 GB | 08 Aug 2023 | about 2 years ago.
  * [stabilityai/stablecode-completion-alpha-3b](https://huggingface.co/stabilityai/stablecode-completion-alpha-3b) | 3.31B | BF16 | 14.1 GB | 07 Aug 2023 | about 2 years ago.
  * [stabilityai/stablecode-completion-alpha-3b-4k](https://huggingface.co/stabilityai/stablecode-completion-alpha-3b-4k) | 3.31B | F16 BOOL | 6.08 GB | 08 Aug 2023 | about 2 years ago.

#### General Purpose Models with reasoning capabilities.

* [Meta Llama](https://huggingface.co/meta-llama).
  * [meta-llama/Llama-3.2-1B](https://huggingface.co/meta-llama/Llama-3.2-1B) | 1.24B | BF16 | 2.47 GB | 18 Sep 2024 | 12 months ago.
  * [meta-llama/Llama-3.2-1B-Instruct](https://huggingface.co/meta-llama/Llama-3.2-1B-Instruct) | 1.24B | BF16 | 2.47 GB | 18 Sep 2024 | 12 months ago.
  * [meta-llama/Llama-3.2-3B](https://huggingface.co/meta-llama/Llama-3.2-3B) | 3.21B | BF16 | 6.43 GB | 18 Sep 2024 | 12 months ago.
  * [meta-llama/Llama-3.2-3B-Instruct](https://huggingface.co/meta-llama/Llama-3.2-3B-Instruct) | 3.21B | BF16 | 6.43 GB | 18 Sep 2024 | 12 months ago.
  * [meta-llama/Llama-3.1-8B](https://huggingface.co/meta-llama/Llama-3.1-8B) | 8.03B | BF16 | 16.07 GB | 14 Jul 2024 | about 1 year ago.
  * [meta-llama/Llama-3.1-8B-Instruct](https://huggingface.co/meta-llama/Llama-3.1-8B-Instruct) | 8.03B | BF16 | 16.07 GB | 18 Jul 2024 | about 1 year ago.
  * [meta-llama/Llama-3.1-70B](https://huggingface.co/meta-llama/Llama-3.1-70B) | 70.6B | BF16 | 139.85 GB | 16 Jul 2024 | about 1 year ago.
  * [meta-llama/Llama-3.3-70B-Instruct]() | 70.6B | BF16 | 139.85 GB | 26 Nov 2024 | 10 months ago.
* [Google](https://huggingface.co/google).
  * [google/gemma-3-270m](https://huggingface.co/google/gemma-3-270m) | 268M | BF16 | 536 MB | 05 Aug 2025 | about 1 month ago.
  * [google/gemma-3-270m-it](https://huggingface.co/google/gemma-3-270m-it) | 268M | BF16 | 536 MB | 04 Aug 2025 | about 1 month ago.
  * [google/gemma-3-1b-pt](https://huggingface.co/google/gemma-3-1b-pt) | 1B | BF16 | 2 GB | 12 Mar 2025 | 6 months ago.
  * [google/gemma-3-1b-it](https://huggingface.co/google/gemma-3-1b-it) | 1B | BF16 | 2 GB | 12 Mar 2025 | 6 months ago.
  * [google/gemma-3-4b-pt](https://huggingface.co/google/gemma-3-4b-pt) | 4.3B | BF16 | 8.60 GB | 12 Mar 2025 | 6 months ago.
  * [google/gemma-3-4b-it](https://huggingface.co/google/gemma-3-4b-it) | 4.3B | BF16 | 8.60 GB | 12 Mar 2025 | 6 months ago.
  * [google/gemma-3-12b-pt](https://huggingface.co/google/gemma-3-12b-pt) | 12.2B | BF16 | 24.37 GB | 12 Mar 2025 | 6 months ago.
  * [google/gemma-3-12b-it](https://huggingface.co/google/gemma-3-12b-it) | 12.2B | BF16 | 24.37 GB | 12 Mar 2025 | 6 months ago.
  * [google/gemma-3-27b-pt](https://huggingface.co/google/gemma-3-27b-pt) | 27.4B | BF16 | 54.81 GB | 12 Mar 2025 | 6 months ago.
  * [google/gemma-3-27b-it](https://huggingface.co/google/gemma-3-27b-it) | 27.4B | BF16 | 54.81 GB | 12 Mar 2025 | 6 months ago.
* [Qwen](https://huggingface.co/Qwen).
  * [Qwen/Qwen3-Next-80B-A3B-Instruct](https://huggingface.co/Qwen/Qwen3-Next-80B-A3B-Instruct) | 81.3B | BF16 | 162.67 GB | 09 Sep 2025 | 7 days ago.
  * [Qwen/Qwen3-Next-80B-A3B-Thinking](https://huggingface.co/Qwen/Qwen3-Next-80B-A3B-Thinking) | 81.3B | BF16 | 162.67 GB | 09 Sep 2025 | 7 days ago.
  * [Qwen/Qwen3-0.6B](https://huggingface.co/Qwen/Qwen3-0.6B) | 752M | BF16 | 1.5 GB | 28 Apr 2025 | 5 months ago.
  * [Qwen/Qwen3-1.7B](https://huggingface.co/Qwen/Qwen3-1.7B) | 2.03B | BF16 | 4.06 GB | 28 Apr 2025 | 5 months ago.
  * [Qwen/Qwen3-4B](https://huggingface.co/Qwen/Qwen3-4B) | 4.02B | BF16 | 8.05 GB | 28 Apr 2025 | 5 months ago.
  * [Qwen/Qwen3-4B-Instruct-2507](https://huggingface.co/Qwen/Qwen3-4B-Instruct-2507) | 4.02B | BF16 | 8.05 GB | 05 Aug 2025 | about 1 month ago.
  * [Qwen/Qwen3-4B-Thinking-2507](https://huggingface.co/Qwen/Qwen3-4B-Thinking-2507) | 4.02B | BF16 | 8.05 GB | 05 Aug 2025 | about 1 month ago.
  * [Qwen/Qwen3-8B](https://huggingface.co/Qwen/Qwen3-8B) | 8.19B | BF16 | 16.38 GB | 28 Apr 2025 | 5 months ago.
  * [Qwen/Qwen3-14B](https://huggingface.co/Qwen/Qwen3-14B) | 14.8B | BF16 | 29.51 GB | 28 Apr 2025 | 5 months ago.
  * [Qwen/Qwen3-30B-A3B](https://huggingface.co/Qwen/Qwen3-30B-A3B) | 30.5B | BF16 | 61.08 GB | 28 Apr 2025 | 5 months ago.
  * [Qwen/Qwen3-30B-A3B-Instruct-2507](https://huggingface.co/Qwen/Qwen3-30B-A3B-Instruct-2507) | 30.5B | BF16 | 61.08 GB | 28 Jul 2025 | about 2 months ago.
  * [Qwen/Qwen3-30B-A3B-Thinking-2507](https://huggingface.co/Qwen/Qwen3-30B-A3B-Thinking-2507) | 30.5B | BF16 | 61.08 GB | 29 Jul 2025 | about 2 months ago.
  * [Qwen/Qwen3-32B](https://huggingface.co/Qwen/Qwen3-32B) | 32.8B | BF16 | 65.52 GB | 28 Apr 2025 | 5 months ago.
  * [Qwen/Qwen3-235B-A22B](https://huggingface.co/Qwen/Qwen3-235B-A22B) | 235B | BF16 | 469.94 GB | 28 Apr 2025 | 5 months ago.
  * [Qwen/Qwen3-235B-A22B-Instruct-2507](https://huggingface.co/Qwen/Qwen3-235B-A22B-Instruct-2507) | 235B | BF16 | 469.94 GB | 21 Jul 2025 | about 2 months ago.
  * [Qwen/Qwen3-235B-A22B-Thinking-2507](https://huggingface.co/Qwen/Qwen3-235B-A22B-Thinking-2507) | 235B | BF16 | 469.94 GB | 25 Jul 2025 | about 2 months ago.
* [DeepSeek](https://huggingface.co/deepseek-ai).
  * [deepseek-ai/DeepSeek-V3.1](https://huggingface.co/deepseek-ai/DeepSeek-V3.1) | 685B  BF16 · F8_E4M3 · F32 | 654.58 GB | 21 Aug 2025 | 27 days ago.
  * [deepseek-ai/DeepSeek-V3.1-Base](https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Base) | 685B | BF16 · F8_E4M3 · F32 | 654.58 GB | 19 Aug 2025 | 28 days ago.
  * [deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B) | 1.78B | BF16 | 3.55 GB | 20 Jan 2025 | 8 months ago.
  * [deepseek-ai/DeepSeek-R1-Distill-Qwen-7B](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-7B) | 7.62B | BF16 | 15.23 GB | 20 Jan 2025 | 8 months ago.
  * [deepseek-ai/DeepSeek-R1-Distill-Llama-8B](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-8B) | 8.03B | BF16 | 16.06 GB | 20 Jan 2025 | 8 months ago.
  * [deepseek-ai/DeepSeek-R1-Distill-Qwen-14B](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-14B) | 14.8B | BF16 | 29.54 GB | 20 Jan 2025 | 8 months ago.
  * [deepseek-ai/DeepSeek-R1-Distill-Qwen-32B](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B) | 32.8B | BF16 | 65.54 GB | 20 Jan 2025 | 8 months ago.
  * [deepseek-ai/DeepSeek-R1-Distill-Llama-70B](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-70B) | 70.6B | BF16 | 141.07 GB | 20 Jan 2025 | 8 months ago.
  * [deepseek-ai/DeepSeek-R1](https://huggingface.co/deepseek-ai/DeepSeek-R1) | 685B | BF16 · F8_E4M3 · F32 | 654.58 GB | 20 Jan 2025 | 8 months ago.
  * [deepseek-ai/DeepSeek-R1-Zero](https://huggingface.co/deepseek-ai/DeepSeek-R1-Zero) | 685B | BF16 · F8_E4M3 · F32 | 654.58 GB | 20 Jan 2025 | 8 months ago.
  * [deepseek-ai/DeepSeek-R1-0528](https://huggingface.co/deepseek-ai/DeepSeek-R1-0528) | 685B | BF16 · F8_E4M3 · F32 | 654.58 GB | 28 May 2025 | 4 months ago.
* [Microsoft](https://huggingface.co/microsoft).
  * [microsoft/Phi-4-mini-instruct](https://huggingface.co/microsoft/Phi-4-mini-instruct) | 3.84B | BF16 | 7.67 GB | 19 Feb 2025 | 7 months ago.
  * [microsoft/Phi-4-mini-reasoning](https://huggingface.co/microsoft/Phi-4-mini-reasoning) | 3.84B | BF16 | 7.67 GB | 29 Apr 2025 | 5 months ago.
  * [microsoft/Phi-4-mini-flash-reasoning](https://huggingface.co/microsoft/Phi-4-mini-flash-reasoning) | 3.85B | F32 · BF16 | 7.70 GB | 22 Jun 2025 | 3 months ago.
  * [microsoft/Phi-4-multimodal-instruct](https://huggingface.co/microsoft/Phi-4-multimodal-instruct) | 5.57B | BF16 | 11.15 GB | 24 Feb 2025 | 7 months ago.
  * [microsoft/phi-4](https://huggingface.co/microsoft/phi-4) | 14.7B | BF16 | 29.31 GB | 11 Dec 2024 | 9 months ago.
  * [microsoft/Phi-4-reasoning](https://huggingface.co/microsoft/Phi-4-reasoning) | 14.7B | BF16 | 29.31 GB | 15 Apr 2025 | 5 months ago.
  * [microsoft/Phi-4-reasoning-plus](https://huggingface.co/microsoft/Phi-4-reasoning-plus) | 14.7B | BF16 | 29.31 GB | 18 Apr 2025 | 5 months ago.

### Base models for experiments.

You will use your computer for data preparation and coding, and **Google Colab Pro will be your "gym" for training** (fine-tuning) the models. With techniques like QLoRA, you will be able to train models of up to ~15B parameters on a Colab GPU.

For your MoE architecture, you indeed need to select **a pair of models for each experiment**: one that will be the "Worker" (code specialist) and another that will be the "Architect" (reasoning specialist).

Based on your excellent list and your project requirements, I have created 3 sets of options. Each set represents a different strategy for you to experiment with and compare. All selected models are **"Instruct"** versions (or equivalent), as they are the correct foundation for your fine-tuning.

#### Set 1: The Safe and Proven Bet 🏆

This set uses models that are considered the industry standard. They are an excellent base for building your prototype, as they are well-documented and have solid, predictable performance.

* **Worker (Code):** `meta-llama/CodeLlama-7b-Instruct-hf`
    * **Why:** It is the quintessential benchmark for code models. It has fantastic performance, a huge community, and tons of available examples. It is the safest and most reliable option to ensure your training pipeline works correctly.
* **Architect (Reasoning):** `meta-llama/Llama-3.1-8B-Instruct`
    * **Why:** Llama 3 is universally recognized for its impressive reasoning and instruction-following capabilities in its category. It is the perfect complement to Code Llama. This combination gives you a very high-quality starting point and is probably the one you should start with.

#### Set 2: The Compact and Powerful Duo ⚡

This set focuses on models known for their high efficiency: they offer exceptional performance for their size. They are ideal for experimenting quickly and with lower resource consumption.

* **Worker (Code):** `deepseek-ai/deepseek-coder-6.7b-instruct`
    * **Why:** DeepSeek Coder consistently outperforms other models of its size in programming benchmarks. It is an incredibly powerful alternative to Code Llama, often praised for generating more complete and accurate code. It will allow you to see if a different architecture yields better results.
* **Architect (Reasoning):** `microsoft/Phi-4-mini-instruct` (or the `-reasoning` variant)
    * **Why:** Microsoft's Phi family is the queen of "small models that think big." Despite having only ~4B parameters, its reasoning quality competes with much larger models. It is very fast and cheap to train, making it perfect for the experimentation phase and for testing whether you need the power of a larger model.

#### Set 3: The Cutting-Edge Combination ✨

This set uses some of the latest and most powerful models from your list that are still manageable in Colab. The goal here is to experiment with the latest architectures to seek the maximum possible performance.

* **Worker (Code):** `google/codegemma-1.1-7b-it`
    * **Why:** It's the evolution of Google's code models. It uses a modern architecture and has been trained on a very recent dataset. Experimenting with CodeGemma will give you an idea of the performance of Google's architecture compared to those of Meta or DeepSeek.
* **Architect (Reasoning):** `google/gemma-3-12b-it`
    * **Why:** With 12B parameters, this is the largest and most recent model from your list that you can still feasibly train in Colab Pro. It represents a leap in reasoning capability over the 7B/8B models. This set is ideal for when you already have your pipeline running and want to push the limits to get the best possible quality.

My recommendation is to **start with Set 1** to build and debug your entire SFT, DPO, and MoE process. Once everything is working, you can use **Sets 2 and 3** to compare performance and decide which combination gives you the best balance of quality, speed, and cost.

### Base models for production.

When moving from experimentation to a final product, priorities change. We are no longer looking for the fastest and cheapest iteration, but the best balance between **response quality, inference cost per user, and latency**.

For production, we move out of Google Colab and into a more robust cloud environment like **Google Cloud Vertex AI** or **Amazon SageMaker**, where you can deploy models on dedicated endpoints with powerful GPUs (L4, A10G, A100). This allows us to consider larger and more powerful models that were unfeasible in the previous phase.

Here are 3 sets of models optimized for a production environment, selected from your list.

#### Set 1: The Professional Standard 💼

This set represents a significant quality leap from the experimental phase. It is a robust, powerful, and widely used combination in the industry, offering excellent performance without requiring the most expensive infrastructure.

* **Worker (Code):** `meta-llama/CodeLlama-13b-Instruct-hf`
    * **Why:** It's the bigger brother of the 7B. The jump from 7B to 13B in code models often brings a very noticeable improvement in the ability to handle more complex logic and generate more complete code. It is a reliable "workhorse" that runs efficiently on a single mid-to-high-range GPU (like an A10G).
* **Architect (Reasoning):** `meta-llama/Llama-3.1-8B-Instruct`
    * **Why:** We are intentionally keeping the 8B here. The architect needs to be fast and logical for routing and planning. A high-quality 8B model like Llama 3 has very low latency. This asymmetry (13B Worker, 8B Architect) creates a very efficient system: power where it's needed (code generation) and speed for orchestration.

#### Set 2: The Sweet Spot (Maximum Performance for Cost) 🎯

This set seeks the "sweet spot": the maximum possible performance before hardware costs and latency skyrocket. This is likely the combination I would choose for a new, serious product.

* **Worker (Code):** `deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct`
    * **Why:** At 16B parameters, this is one of the most efficient and powerful code models in existence. In many benchmarks, it competes with models twice its size. Its modern architecture makes it incredibly good at generating high-quality code with a relatively low resource footprint. It is a cutting-edge and very smart choice.
* **Architect (Reasoning):** `microsoft/Phi-4-reasoning-plus`
    * **Why:** At 14.7B parameters, this is the most powerful reasoning model in the Phi family. It is known for its top-tier logical capabilities, which are crucial for the architect role. Pairing a ~15B reasoner with a ~16B code generator creates a very symmetrical and extremely capable MoE system.

#### Set 3: Maximum Power (Uncompromised Quality) 🚀

This is the set for when response quality is the top priority and the budget allows for it. It requires more powerful infrastructure (likely multiple GPUs per model), but the result will be world-class.

* **Worker (Code):** `meta-llama/CodeLlama-34b-Instruct-hf`
    * **Why:** This is the gold standard for open-source code models. Its ability to understand and generate complex software systems is far superior to that of smaller models. It is the engine you need if your assistant must write entire modules or handle complex codebases.
* **Architect (Reasoning):** `google/gemma-3-27b-it` or `Qwen/Qwen3-30B-A3B-Instruct-2507`
    * **Why:** To direct a 34B worker, you need an equally powerful architect. A model in the 27B-30B range can handle extremely ambiguous user prompts, perform very detailed and complex planning, and maintain a coherent context during long interactions. This is the brain you need for a truly "expert" AI assistant.

#### Final Considerations for Production

1.  **Quantization:** In production, models are rarely used at their full size (BF16/F32). You will use **quantization** techniques (like AWQ, GPTQ, or FP8) to reduce memory usage and increase inference speed with minimal quality loss.
2.  **Inference Servers:** You will not run the models with a simple `transformers` script. You will use optimized inference servers like **vLLM**, Hugging Face's **Text Generation Inference (TGI)**, or **NVIDIA Triton** to manage requests efficiently, handle batching, and achieve the lowest possible latency.
3.  **Benchmarking:** The final decision should be based on your own tests. Deploy Set 1 and Set 2, measure their performance on your specific tasks, calculate the cost per response, and decide which option offers the best experience for your users within your budget.
