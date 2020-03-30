#!/bin/bash

#install dependencies
npm install

# if you already have firefox built once before
./mach build faster

# if you have  never built firefox, can take hours
#./mach build

echo 'Creating directory test_results if it does not exist for test results'
mkdir -p test_results

# test if the inspector works still
echo 'Running Inspector tests...'
./mach mochitest devtools/server/tests/chrome/test_inspector-changeattrs.html > 'test_results/test_inspector_01.txt'
./mach mochitest devtools/server/tests/chrome/test_inspector-changevalue.html > 'test_results/test_inspector_02.txt'
echo 'Running FrontEnd tests...'
./mach mochitest devtools/client/inspector/changes/test/browser_changes_copy_all_changes.js > 'test_results/test_frontend_01.txt'
./mach mochitest devtools/client/inspector/changes/test/browser_changes_copy_rule.js > 'test_results/test_frontend_02.txt'

if grep -Fxq "Unexpected results: 0" "test_results/test_inspector_01.txt"
then
	echo 'inspector_01 test passed!'
else
	echo 'inspector_01 test failed!'
fi

if grep -Fxq "Unexpected results: 0" "test_results/test_inspector_02.txt"
then
	echo 'inspector_02 test passed!'
else
	echo 'inspector_02 test failed!'
fi

if grep -Fxq "Unexpected results: 0" "test_results/test_frontend_01.txt"
then
        echo 'frontend_01 test passed!'
else
        echo 'frontend_01 test failed!'
fi

if grep -Fxq "Unexpected results: 0" "test_results/test_frontend_02.txt"
then
        echo 'frontend_02 test passed!'
else
        echo 'frontend_02 test failed!'
fi

