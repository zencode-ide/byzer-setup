@echo off
set "hadooppath=%cd%"
wmic ENVIRONMENT create name="HADOOP_HOME",username="<system>",VariableValue="%hadooppath%"
