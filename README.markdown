## Problem

It seems that JRuby has a file descriptor leak and it is related to the Net::HTTP methods.

## How to reproduce 

    bundle install
    kirk -c Kirkfile
    ab -n 100 -c 10 http://127.0.0.1:9090/test
    # check number of pipes using:
    # lsof -p KIRK_PID | grep pipe | wc -l
    
    # redeploy kirk:
    touch REVISION
    # run ab once again, and check number of pipes
    # after a few redeploys there should be plenty of opened pipes
    ab -n 100 -c 10 http://127.0.0.1:9090/test

Trinidad has the same problem, so it's probably some general JRuby bug.  On a big, heavaily used, long running Rails app number of pipes grow even without redeploying - it's the most problematic part of the bug. 
