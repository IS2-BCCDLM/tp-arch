# Makefile to compile informe.org into a PDF using Emacs

# Target file (output PDF)
TARGET = informe.pdf

# HTML target
HTML_TARGET = informe.html

# Source file (input Org file)
SOURCE = informe.org

# Emacs command to export Org to PDF
EMACS = emacs
EMACSFLAGS = --batch -Q --script scripts/export-to-pdf.el $(SOURCE)

# Emacs command to export Org to HTML
HTMLFLAGS = --batch -Q --script scripts/export-to-html.el $(SOURCE)

# Default target
all: $(TARGET)

# Rule to generate PDF
$(TARGET): $(SOURCE)
	@echo "Executing code blocks to generate images..."
	@$(MAKE) execute-code-blocks
	@echo "Compiling $< to PDF..."
	@$(EMACS) $(EMACSFLAGS) || (echo "Compilation failed"; exit 1)

# Rule to generate HTML
$(HTML_TARGET): $(SOURCE)
	@echo "Executing code blocks to generate images..."
	@$(MAKE) execute-code-blocks
	@echo "Compiling $< to HTML..."
	@$(EMACS) $(HTMLFLAGS) || (echo "Compilation failed"; exit 1)

# Rule to prepare GitHub Pages
github-pages: $(HTML_TARGET)
	@echo "Preparing docs/ for GitHub Pages..."
	@mkdir -p docs
	@cp $(HTML_TARGET) docs/index.html
	@cp -r assets docs/
	@echo "GitHub Pages files prepared in docs/"

# New target to execute all Org Babel blocks (e.g. generate images)
execute-code-blocks:
	$(EMACS) --batch -l scripts/process-org.el

# Clean up generated files
clean:
	rm -f $(TARGET) $(HTML_TARGET)

# Phony targets
.PHONY: all clean execute-code-blocks html github-pages
