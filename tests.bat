echo TESTS BEGIN
echo
for %%F in (D:\drfermor\dev\ruby\grad_assignment\test\*.rb) do (
    ruby %%~dpnxF
)
