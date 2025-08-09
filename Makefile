.PHONY: help install install-git

help:
	@echo "Available targets:"
	@echo "  make install      # Install all aliases"
	@echo "  make install-git  # Install only Git workflow aliases"
	@echo ""
	@echo "Git aliases usage:"
	@echo "  ship feat ENG-1234 \"add feature\"   # First commit to new branch"
	@echo "  commit \"fix bug\"                   # Subsequent commits"

install:
	@./install.sh

install-git:
	@echo "Installing Git workflow aliases only..."
	@./install.sh


