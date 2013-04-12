#!/usr/bin/env Rscript

m = 8
n = 8
p = 8

cat('{\n "nodes":[\n')
for(i in 1:m)
  for(j in 1:n){
    cat(
      paste('  {"name":"',
            paste('a',i,j,sep='_'),
            '","group":',1,'}',
            sep='')
      )
    cat(',\n')
  }

for(j in 1:n)
  for(k in 1:p){
    cat(
      paste('  {"name":"',
            paste('b',j,k,sep='_'),
            '","group":',2,'}',
            sep='')
      )
    cat(',\n')
  }

for(i in 1:m)
  for(k in 1:p){
    cat(
      paste('  {"name":"',
            paste('c',i,k,sep='_'),
            '","group":',3,'}',
            sep='')
      )
    if(i * k < m * p)
      cat(',')
    cat('\n')
  }

cat(' ],\n')
cat(' "links":[\n')

# number elements as follows, starting from 0:
# row-major from a
# row-major from b
# row-major from c
for(i in 1:m)
  for(k in 1:p){
# each element of the product depends on
# n elements from the rhs and
# n elements from the lhs.
# element (i,k) depends on
# (i,1:n) from lhs, and
# (1:n,k) from rhs
    for(j in 1:n){
      cat(
        paste('  {"source":',
# source from a
              (i-1) * n + j - 1,
              ',"target":',
# this node
              m*n + n*p + (i-1) * p + k - 1,
              ',"value":',1,
              '},\n',
              sep='')
        )
      cat(
        paste('  {"source":',
# source from b
              m*n + (j-1) * p + k - 1,
              ',"target":',
# this node
              m*n + n*p + (i-1) * p + k - 1,
              ',"value":',1,
              '}',
              sep='')
        )
      if(i * j * k < n * m * p)
        cat(',')
      cat('\n')
    }
  }

cat(' ]\n')
cat('}\n')
