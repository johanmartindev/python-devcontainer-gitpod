.PHONEY: typehint
typehint:
	mypy --ignore-missing-imports /src
.PHONEY: test
test:
	pytest tests/
.PHONEY: lint
lint:
	pylint /src
.PHONEY: checklist
	checklist: lint typehint test
.PHONEY: black
	black:
		black -l 79 *.py
.PHONEY: clean
clean:
	find . -type f -name "*.pyc" | xargs rm -fr
	find . -type d -name __pycache__ | xargs rm -fr
