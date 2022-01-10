ifneq ($(strip $(unstow)),)
target := unstow
else ifneq ($(strip $(restow)),)
target := restow
else
target := stow
endif

.DEFAULT_GOAL := $(target)

.PHONY: stow
stow:
	stow -t ~ ${stow}

.PHONY: unstow
unstow:
	stow -t ~ -D ${unstow}

.PHONY: restow
restow:
	stow -t ~ -R ${restow}
