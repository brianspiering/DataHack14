#!/usr/bin/env Rscript

# File description -------------------------------------------------------------
# 
#

# Setup packages ---------------------------------------------------------------
# List of packages for session
.packages = c("devtools", "stringr", "dplyr", "ggplot2", "knitr", "markdown") 

# Install required CRAN packages (if not already installed)
.inst <- .packages %in% installed.packages()
if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])

# Load packages into session 
lapply(.packages, require, character.only=TRUE)

# General setup ----------------------------------------------------------------
cat("\014")    # Clear console
rm(list=ls())  # Delete all variables
graphics.off() # Close all open plots


# Code Block -------------------------------------------------------------------
# TODO: Add code

# Tidy things up ---------------------------------------------------------------
cat("\014")  # Clear console

# Scratchpad -------------------------------------------------------------------
# print( "Hello, world!")
