if [ -f "$XDG_CONFIG_HOME/zsh/company.env" ]; then
  source "$XDG_CONFIG_HOME/zsh/company.env"

  export GITHUB_PACKAGES_TOKEN="$DR_DROPIN_REG_TOKEN"
  # export GOOGLE_API_KEY="$GOOGLE_API_KEY"
  # export GOOGLE_GENAI_USE_VERTEXAI=true
fi

