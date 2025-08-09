.PHONY: help install

help:
	@echo "Available targets:"
	@echo "  make install   # Install 'ship' and 'commit' Git workflow aliases"
	@echo ""
	@echo "Usage after installation:"
	@echo "  ship feat ENG-1234 \"add feature\"   # First commit to new branch"
	@echo "  commit \"fix bug\"                   # Subsequent commits"

install:
	@./install.sh


