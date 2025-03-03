@echo off
rd public /s/q
rd resources /s/q
REM hugo server --buildDrafts --buildFuture
hugo server
pause