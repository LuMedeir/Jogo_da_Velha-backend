# Color codes for terminal output
PURPLE = \033[1;35m
CYAN= \033[0;36m
RESET = \033[0m

up: compose
	echo "$(CYAN)Server is running on http://localhost:3000 \033[0m"
	rails server

test: compose
	echo "$(CYAN)Tests are running...$(RESET)"
	rails db:test:prepare
	rails test

compose:
	@if [ -z "$$(docker ps --filter name=backend-db-1 --format '{{.Names}}')" ]; then \
	  echo "Containers are not running. Starting Docker Compose..."; \
	  docker compose up --build -d; \
	else \
	  echo "$(PURPLE)Containers are already running.$(RESET)"; \
	fi

down:
	@rails server --stop
	@docker compose down

kill:
	@kill $(shell lsof -t -i :3000)