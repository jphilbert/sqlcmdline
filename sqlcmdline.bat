@echo off
@rem Because EMACS applies EXECUTABLE-FIND on SQLI-PROGRAM it is not possible to
@rem set it to "python sqlcmdline.py". This batch file passes the parameters and
@rem encapsulates calling python.
python %HOME%\apps\sqlcmdline\sqlcmdline.py %*
echo on