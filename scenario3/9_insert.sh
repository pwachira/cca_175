#!/bin/bash
beeline -u jdbc:hive2:// hive cloudera -f 9_insert.sql
