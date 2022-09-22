#!/usr/bin/env python3
import re
import glob
import os

global_path = './GraphQL/API/*.swift'

def ignorePath(path):
  return ("Types.graphql.swift" in path)
  
def replaceFile(file):
  with open(file, 'r') as f:
      print(file)
      text = f.read()
      text = text.replace(": GraphQLQuery", ": CustomQuery")

  with open(file, 'w') as f:
    f.write(text)

def startFormatter():
  for path in set(glob.iglob(global_path, recursive = True)):
    if ignorePath(path) == False and os.path.isfile(path):
        replaceFile(path)
            
    
startFormatter()