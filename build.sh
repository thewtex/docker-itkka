#!/bin/sh

sundials_tarball=sundials-2.5.0.tar.gz
if [ ! -e ./$sundials_tarball ]; then
  echo "Please download $sundials_tarball from"
  echo "  http://computation.llnl.gov/casc/sundials/download/download.html"
  echo "and move it to this directory."
  exit 1
fi

itkka_tarball=SourceCode3_itkka-src-140930.tgz
if [ ! -e ./$itkka_tarball ]; then
  echo "Please download $itkka_tarball from:"
  echo "  http://hdl.handle.net/10380/3469"
  echo "and move it to this directory."
  exit 1
fi

docker build -t itkka .
