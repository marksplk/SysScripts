#!/bin/bash
cd /Users/ithangasamy/src/current/test/tests/package
grep "system" *.py |cut -d\[ -f2|cut -d\' -f2 | sort -u
