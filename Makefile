# Makefile

# Run `$ make` to see docummentation
.DEFAULT_GOAL := help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

###########################################################################################################################################
SCRIPTS_DIR = ./Scripts

graphQL_formatter: ## Bump minor
	python3 $(SCRIPTS_DIR)/graphQLFormatter.py