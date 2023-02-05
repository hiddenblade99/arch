#!/bin/sh
sensors | grep -A 0 'edge' | cut -c16-25
