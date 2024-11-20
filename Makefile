# Conditionally include .env file if not running in CI/CD environment
ifndef GITHUB_ACTIONS
  -include .env
endif

# default env values
APTOS_NETWORK ?= custom
ARTIFACTS_LEVEL ?= all
DEFAULT_FUND_AMOUNT ?= 100000000
DEFAULT_FUNDER_PRIVATE_KEY ?= 0x0
DEV_ACCOUNT ?= 380cc51342dc20d61af1a05abbd3a4ba718e555ef8c01f1337698180d5ecff31
STABLE_SWAP_ADDRESS ?= 0x0

# ============================= CLEAN ============================= #
clean:
	rm -rf build

# ===================== PACKAGE PROFILE ===================== #

compile:
	aptos move compile \
	--skip-fetch-latest-git-deps \
	--included-artifacts $(ARTIFACTS_LEVEL) \
	--save-metadata \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)"

test:
	aptos move test \
	--skip-fetch-latest-git-deps \
	--ignore-compile-warnings \
	--skip-attribute-checks \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)"
	--coverage

publish:
	aptos move deploy-object \
	--skip-fetch-latest-git-deps \
	--included-artifacts none \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)" \
	--address-name razor_stable_swap

upgrade:
	aptos move upgrade-object \
	--skip-fetch-latest-git-deps \
	--address-name razor_stable_swap \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)" \
	--object-address $(STABLE_SWAP_ADDRESS)

doc:
	aptos move document \
	--skip-fetch-latest-git-deps \
	--skip-attribute-checks \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)"

# ===================== PACKAGE SMART ROUTER ===================== #