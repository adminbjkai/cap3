.PHONY: up down logs reset-db smoke

# Canonical docker compose project name.
# Override: `make PROJECT=cap3-staging up`
PROJECT ?= cap3-dev

up:
	docker compose -p $(PROJECT) up -d --build

down:
	docker compose -p $(PROJECT) down

logs:
	docker compose -p $(PROJECT) logs -f --tail=200

reset-db:
	for f in $$(docker compose -p $(PROJECT) exec -T postgres sh -lc 'ls /migrations/*.sql | sort'); do \
		docker compose -p $(PROJECT) exec -T postgres psql -U $${POSTGRES_USER:-app} -d $${POSTGRES_DB:-cap3} -f $$f; \
	done

smoke:
	curl -sS -X POST http://localhost:3000/debug/smoke
