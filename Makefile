check-var = $(if $(strip $($1)),,$(error var for "$1" is empty))
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[\/a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36mGrafana \033[0m%-16s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

check-var = $(if $(strip $($1)),,$(error var for "$1" is empty))
stack_lower := $(shell echo $(stack) | tr A-Z a-z)

require_stack:
	$(call check-var,stack)

upgrade/tiller: ## Upgrade tiller to the latest version.
	@helm init --tiller-namespace testns --upgrade

upgrade/stack: require_stack ## Deploy stack into kubernetes. vars: stack
	@helm upgrade grafana-$(stack_lower) --values=values-$(stack_lower).yaml .

install/stack: require_stack ## Deploy stack into kubernetes. vars: stack
	@helm install --name grafana-$(stack_lower) --values=values-$(stack_lower).yaml .

open/ui: require_stack ## Open stack in browser. vars: stack
	@open http://grafana-$(stack_lower).platform.cloud.domain.net

install/debug: require_stack ## View all variables and configs generated before deployment. vars: stack
		@helm install --name grafana-$(stack_lower) --values=values-$(stack_lower).yaml . --dry-run --debug

delete/stack: ## delete stack from reference
	@helm delete  --purge grafana-$(stack_lower)
