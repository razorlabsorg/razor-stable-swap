# Conditionally include .env file if not running in CI/CD environment
ifndef GITHUB_ACTIONS
  -include .env
endif

# default env values
APTOS_NETWORK ?= custom
ARTIFACTS_LEVEL ?= none
DEFAULT_FUND_AMOUNT ?= 100000000
DEFAULT_FUNDER_PRIVATE_KEY ?= 0x0
DEV_ACCOUNT ?= 0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839
STABLE_SWAP_ADDRESS ?= 0x9f3f0bd6c81c56670796e13a532f47931a54e9a89e40944e04d690367b2e5531

# ============================= CLEAN ============================= #
clean:
	rm -rf build

# ===================== PACKAGE PROFILE ===================== #

compile:
	aptos move compile \
	--skip-fetch-latest-git-deps \
	--included-artifacts none \
	--move-2 \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)"

test:
	aptos move test \
	--move-2 \
	--skip-fetch-latest-git-deps \
	--ignore-compile-warnings \
	--skip-attribute-checks \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)"
	--coverage

publish:
	aptos move deploy-object \
	--move-2 \
	--skip-fetch-latest-git-deps \
	--override-size-check \
	--included-artifacts none \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)" \
	--address-name razor_stable_swap

upgrade:
	aptos move upgrade-object \
	--move-2 \
	--skip-fetch-latest-git-deps \
	--address-name razor_stable_swap \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)" \
	--object-address $(STABLE_SWAP_ADDRESS)

docs:
	aptos move document \
	--move-2 \
	--skip-fetch-latest-git-deps \
	--skip-attribute-checks \
	--named-addresses "razor_stable_swap=$(DEV_ACCOUNT)"

# ===================== PACKAGE SMART ROUTER ===================== #