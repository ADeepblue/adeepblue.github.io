@echo off
setlocal

rem 从 %date% 按位置提取年月日（假设格式固定为 YYYY/MM/DD）
set "year=%date:~0,4%"
set "month=%date:~5,2%"
set "day=%date:~8,2%"
set "formatted_date=%year%-%month%-%day%"


git add -f public
git commit -m "Publish site %formatted_date%"
git subtree push --prefix public origin gh-pages
REM pause