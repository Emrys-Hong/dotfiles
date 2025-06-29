lua << EOF
require("avante").setup({
  ------------------------------------------------------------------
  -- Pick the default model you want Avante to talk to first:
  ------------------------------------------------------------------
  provider = "openai",          -- "claude", "gemini", "copilot", …

  ------------------------------------------------------------------
  -- One table per provider.  Only the one you select is contacted
  -- at start-up, but you can hot-swap later with :AvanteSwitchProvider.
  ------------------------------------------------------------------
  providers = {

    -- OpenAI / compatible services (Groq, Perplexity, Deepseek …)
    openai = {
      endpoint = "https://api.openai.com/v1",
      model    = "gpt-4o-mini",          -- fast but high-quality
      timeout  = 30_000,                 -- ms
      extra_request_body = {
        -- deterministic code edits & refactors
        temperature           = 0.2,
        max_completion_tokens = 4096,
      },
    },

    -- Anthropic Claude
    claude = {
      endpoint = "https://api.anthropic.com",
      model    = "claude-3-sonnet-20250515",
      api_key_name = "ANTHROPIC_API_KEY",
      extra_request_body = {
        -- creative suggestions / planning
        temperature = 0.7,
        max_tokens  = 4096,
      },
    },

    -- Google Gemini 1.5 (Vertex or consumer API)
    gemini = {
      endpoint = "https://generativelanguage.googleapis.com/v1beta",
      model    = "gemini-1.5-flash-latest",
      api_key_name = "GEMINI_API_KEY",
      timeout  = 30_000,
      extra_request_body = {
        -- answers feel chatty at 0.4 without hallucinating
        temperature      = 0.4,
        candidate_count  = 1,
      },
    },

    -- GitHub Copilot (official backend)
    copilot = {
      -- Avante discovers the right endpoint; you mainly choose model
      model = "copilot-fugaku",          -- fastest
      extra_request_body = { temperature = 0.2 },
    },

    -- Example local model via Ollama
    ollama = {
      endpoint = "http://127.0.0.1:11434",
      model    = "codellama:34b-chat",
      timeout  = 60_000,
      extra_request_body = {
        options = {
          temperature = 0.1,             -- local models get noisy fast
          num_ctx     = 8192,
        },
      },
    },
  },

  ------------------------------------------------------------------
  -- (optional) behaviour tweaks
  ------------------------------------------------------------------
  behaviour = {
    auto_suggestions = true,            -- turn on when latency is low
  },
})
EOF
