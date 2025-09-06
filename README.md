# Self-hosted AI

This runs large language models (LLMs) locally via Docker Compose per
_Implementing Opensource LLMs in Research Computing_ at PEARC'25:

- [slides and video](https://bit.ly/csim-pearc25)

- [supporting materials](https://dartgo.org/pearc25-llm)

Alternatives include [Jan.ai](https://jan.ai/),
[LLMStack](https://llmstack.ai/), and [LocalAI](https://localai.io/).

> [!CAUTION]
>
> Attackers have exploited
> [heap overflow vulnerabilities in GGML](https://www.databricks.com/blog/ggml-gguf-file-format-vulnerabilities)
> via malicious models published on Hugging Face.  Only download
> models from reputable developers and trustworthy hosting services.

## Quick Start

1. Copy `compose.override.yaml.example` to `compose.override.yaml` and
   `litellm-config.yml.example` to `litellm-config.yml`.

```sh
for f in compose.override.yaml litellm-config.yml; do
    cp $f.example $f
done
```

2. Change the passwords and secret keys in `compose.override.yaml`.

3. Start the `ollama` service and install the desired models.

```sh
docker compose up ollama -d
docker compose exec ollama ollama pull llama3.2:1b
docker compose exec ollama ollama pull bge-m3:567m
docker compose exec ollama ollama pull qwen2.5-coder:latest
```

4. Customize the list of installed models and corresponding
   configuration parameters in `litellm-config.yml`.

5. Start the remaining services.

```sh
docker compose up -d
```

6. Open [http://localhost:8080/](http://localhost:8080/) in a web
   browser to interact with the installed models.

## Limitations

Good model performance requires access to a graphics processor (GPU).
Accessing the GPU from a container requires additional configuration:

- At a minimum, add `gpu` to the `ollama` service's list of
  capabilities.  For more information, refer to
  [Run Docker Compose services with GPU access](https://docs.docker.com/compose/how-tos/gpu-support/).

- [Virtualization.framework](https://developer.apple.com/documentation/virtualization)
  on Apple Silicon Macs does not support hardware GPU pass-through.
  However, some virtual machine monitors provide a Vulkan GPU API
  within virtual machines.  For more information, refer to
  [GPU-Accelerated Containers for M1/M2/M3/M4... Macs](https://medium.com/@andreask_75652/gpu-accelerated-containers-for-m1-m2-m3-macs-237556e5fe0b).

## Additional Resources

The video
[Deep Dive into LLMs like ChatGPT](https://www.youtube.com/watch?v=7xTGNNLPyMI)
covers how models are developed, how to think about their
"psychology", and how to use them in practical applications.

The blog post series
[LLM from scratch](https://www.gilesthomas.com/llm-from-scratch)
references
[_Build a Large Language Model (From Scratch)_](https://www.manning.com/books/build-a-large-language-model-from-scratch),
which teaches you how to:

- plan and code all the parts of an LLM,

- prepare a dataset suitable for LLM training,

- fine-tune LLMs for text classification and with your own data,

- use human feedback to ensure your LLM follows instructions, and

- load pretrained weights into an LLM.
