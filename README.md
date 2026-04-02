# Self-hosted AI

Run large language models (LLMs) locally via Docker Compose per
_Implementing Opensource LLMs in Research Computing_ at PEARC'25:

- [slides and video](https://bit.ly/csim-pearc25)

- [supporting materials](https://dartgo.org/pearc25-llm)

Alternatives include [Ollama](https://ollama.com/),
[vMLX](https://vmlx.net/), [Jan.ai](https://jan.ai/),
[LLMStack](https://llmstack.ai/), and [LocalAI](https://localai.io/).

> [!CAUTION]
>
> Attackers have exploited
> [heap overflow vulnerabilities in GGML](https://www.databricks.com/blog/ggml-gguf-file-format-vulnerabilities)
> via malicious models published on Hugging Face.  Only download
> models from reputable developers and trustworthy hosting services.

## Quick Start

1. Copy `compose.override.yaml.example` to `compose.override.yaml`.

2. Change the passwords and secret keys in `compose.override.yaml`.
   Customize the list of models and their corresponding settings in
   the `litellm` configuration.

3. Start the `ollama` service and install the desired models.

```sh
docker compose up ollama -d
docker compose exec ollama ollama pull llama3.2:1b
docker compose exec ollama ollama pull bge-m3:567m
docker compose exec ollama ollama pull qwen2.5-coder:latest
```

4. Start the remaining services.

```sh
docker compose up -d
```

6. Open [http://localhost:8080/](http://localhost:8080/) in a web
   browser to interact with the installed models.

## Limitations

Good model performance requires access to a graphics processor (GPU).
Accessing the GPU from a container requires additional configuration.
This may be as simple as adding `gpu` to the `ollama` service's list
of capabilities.  For more information, refer to
[Run Docker Compose services with GPU access](https://docs.docker.com/compose/how-tos/gpu-support/).

[Virtualization.framework](https://developer.apple.com/documentation/virtualization)
on Apple Silicon Macs does not support hardware GPU pass-through.
Some virtual machine monitors provide a Vulkan GPU API within virtual
machines,
cf. [GPU-Accelerated Containers for M1/M2/M3/M4... Macs](https://medium.com/@andreask_75652/gpu-accelerated-containers-for-m1-m2-m3-macs-237556e5fe0b).
Alternatively, run Ollama on the host.  This requires connecting the
LiteLLM Proxy Server to the Ollama API endpoint via a container
runtime-specific hostname or IP address such as `host.docker.internal`
or `172.17.0.1`,
cf. [Docker Container Host Access](https://eastondev.com/blog/en/posts/dev/20251217-docker-host-access/),
[OpenAI-Compatible Endpoints](https://docs.litellm.ai/docs/providers/openai_compatible).

[Metal](https://developer.apple.com/metal/) limits the amount of
[unified memory](https://www.xda-developers.com/apple-silicon-unified-memory/)
available to an Apple Silicon Mac's GPU, around three quarters of the
total by default.  Change this limit via the kernel state variable
`iogpu.wired_limit_mb`, specified in
[mebibytes (MIB)](https://en.wikipedia.org/wiki/Mebibyte), e.g., a
value of `122880` would limit the GPU to 120 GiB of unified memory.
(On macOS Ventura and earlier, change `debug.iogpu.wired_limit`,
specified in bytes, instead.)

> [!IMPORTANT]
>
> When changing `iogpu.wired_limit_mb` (or `debug.iogpu.wired_limit`),
> reserve some memory for the operating system as otherwise the
> computer may crash.  Only set the kernel state variable temporarily
> via the `sysctl` command.  Track memory pressure via
> [Activity Monitor](https://support.apple.com/guide/activity-monitor/).
> Reboot to restore the original limit if the system becomes
> unresponsive.

> [!CAUTION]
>
> Changing kernel state variables permanently via `/etc/sysctl.conf`
> is **NOT RECOMMENDED** because that requires disabling
> [System Integrity Protection](https://support.apple.com/en-us/102149),
> an important security feature of macOS.

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
