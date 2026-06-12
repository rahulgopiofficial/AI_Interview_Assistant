# 🤖 Domain-Specific AI Interview Assistant (Telecom/IMS Edition)

An intelligent, context-aware AI technical interviewer and automated assessment portal. This project leverages a locally deployed, fine-tuned Large Language Model (LLM) to conduct realistic, multi-turn technical interviews for senior telecom roles, tailors its technical depth using a candidate’s resume, and automates final evaluation report generation via cloud LLM APIs.

The system is fine-tuned specifically for the **IP Multimedia Subsystem (IMS)** domain, dynamically probing candidates on core architecture concepts like **SIP, VoLTE, VoNR, VoWIFI, and LTE/NR network log analysis**.

---

## 🚀 Key Features

* **RAG-Driven Interview Context:** Leverages a Retrieval-Augmented Generation (RAG) pipeline to ingest candidate resumes (PDFs) into a vector database, allowing the AI to generate personalized, tailored questions.
* **Highly Optimized Local Inference:** Powered by a locally fine-tuned model accelerated using **Unsloth (FastLanguageModel)**, delivering fast, memory-efficient inference in 16-bit or 4-bit precision.
* **Guardrails & Conversational Pacing:** Implements natural conversational pacing (strict one-question rule, length boundaries, and tone consistency) alongside robust input sanitization to block prompt-injection attacks.
* **Automated Multi-Model Evaluation:** Offloads the scoring task to a decoupled cloud API (via Groq / Llama 3.3) at the end of the session to dynamically analyze the full transcript and generate an unbiased verdict report without putting load on local GPU VRAM.
* **Intuitive Gradio Web UI:** Provides an end-to-end user interface complete with interactive tabs for resume uploading, live interview chatting, session countdown timers, and an evaluation report accordion display.

---

## 🛠️ Tech Stack

| Component | Technology |
| :--- | :--- |
| **Local LLM Engine** | Unsloth, Hugging Face `transformers`, PyTorch |
| **RAG Pipeline** | LangChain, FAISS (Vector DB), SentenceTransformers (`all-MiniLM-L6-v2`) |
| **Evaluation Layer** | OpenAI-compatible SDK (Groq API / Llama 3.3 70B) |
| **User Interface** | Gradio (Tabs, Chatbot, Accordions, Component State) |

---

## 🧩 Architectural Workflow

```mermaid
graph TD
    A[Candidate PDF Resume] --> B(LangChain PyPDF Loader)
    B --> C(Recursive Text Splitter)
    C --> D(FAISS Vector Store)
    
    E[Candidate Input] --> F{RAG Context Match}
    D -.-> F
    F --> G[Fine-Tuned Local LLM Interviewer]
    G --> H(Gradio Chatbot Interface)
    
    H --> I[Stop & Evaluate Session]
    I --> J(Decoupled Cloud API: Groq/OpenRouter)
    J --> K[Final Assessment Report: Score & Verdict]

```text
SCORE: 8/10
VERDICT: Pass
JUSTIFICATION: The candidate demonstrated a strong architectural understanding...
