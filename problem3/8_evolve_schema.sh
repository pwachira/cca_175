#!/bin/bash
beeline -u jdbc:hive2:// hive cloudera -f 8_evolve_schema.sql
