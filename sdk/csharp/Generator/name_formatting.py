import re

CAMEL_CASE_PATTERN = re.compile(r'(?<!^)(?=[A-Z])')

SNAKE_CASE_PATTERN = re.compile(r'_([a-z])')


def _to_upper(matchobj):
	return matchobj.group(1).upper()


def lang_field_name(name):
	return SNAKE_CASE_PATTERN.sub(_to_upper, name)

def underline_name(name):
	return CAMEL_CASE_PATTERN.sub('_', name).lower()

def pascal_name(name):
	return name[:1].upper() + name[1:]

def fix_size_name(name):
	return name

def fix_name(name):
	return name

def camel_case_name(name):
  words = name.split('_')
  return words[0].lower() + ''.join(word.capitalize() for word in words[1:])