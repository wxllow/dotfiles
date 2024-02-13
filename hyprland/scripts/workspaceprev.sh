#!/bin/bash
hyprctl dispatch split-workspace $(($(hyprctl activeworkspace | awk 'NR==1 { print $3 }') - 1))

