#!/bin/bash
msehrVersion=8.0.6
cd $msehrVersion
buildah build -f Dockerfile -t marsante/msehrtest:$msehrVersion -t marsante/msehrtest:latest
buildah push marsante/msehrtest:$msehrVersion docker://marsante/msehrtest:$msehrVersion
buildah push marsante/msehrtest:latest docker://marsante/msehrtest:latest