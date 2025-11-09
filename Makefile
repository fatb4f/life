.PHONY: ci-openai
ci-openai:
gh workflow run openai-check.yml --ref main
gh run watch
gh run view --log
