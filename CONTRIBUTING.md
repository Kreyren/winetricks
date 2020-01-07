# CONTRIBUTING

This is set of standards to be used in contribution

### Indentation one TAB (Not effective yet)
Since winetricks is using indentation of four spaces which is conflicting with preference of others we decided to use tabs that can be resized in text editors to user preference

### Code Style (Not effective yet)
Winetricks is using allman style for shell script which is horrible thus we are using the 'K&R variant: 1TBS' (https://en.wikipedia.org/wiki/Indentation_style#Variant:_1TBS_(OTBS))

Example:

```sh
# Wrong
func()
{
	something
}
# Correct
func(){
	something
}
```

### Usage of Change Directory 'cd'
If possible use absolute path instead of changing directory

Reasoning being sanitization so that verbs woudn't depend on current working directory

### Usage of 'echo'
`echo` is banned by kreytricks, use `printf '%s\n' 'message'` instead

reasoning: https://unix.stackexchange.com/a/65819

### Usage of 'else' in if statements
'else' syntax in if statement is allowed to be used only for `w_die 255 "hint/to/unexpected"`

Reasoning being sanitization to capture unexpected results in case used if statement is not sufficient for it's usage

```sh
# Not allowed
if [ ! -e "file" ]; then
	  touch file
else
	  w_debug "file exists"
fi

# Expected
if [ ! -e "file" ]; then
	  w_debug "Function example expected file 'file' is not present, creating it"
	  w_try touch file
elif [ -e "file" ]; then
	  w_debug "Function example expected file 'file' is already present, skipping.."
else
	  w_die 255 "example - logic"
fi
```
