.PHONY: setup
setup:
	cd $(PWD)/backend && pnpm install && pnpm run gen
	ln -s $(PWD)/backend/openapi.yaml $(PWD)/ios/MyPackages/Sources/Domains/Repositories/openapi.yaml || true
	$(MAKE) open

.PHONY: open
open:
	open $(PWD)/ios/hono-swift-openapi.xcworkspace

