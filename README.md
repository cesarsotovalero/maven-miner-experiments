# Maven Dependency graph analysis
This repository contains a set of Cypher and R scripts performing and plotting some common graph analysis metrics on top of (Maven Dependency Graph)[https://github.com/diverse-project/maven-miner]

## User guide

### General Prerequisites
- RStudio
- Neo4j
- bash
### Acquiring Maven Dependency graph data

In order to download data, we kindly invite you to visit the (Maven-miner)[https://github.com/diverse-project/maven-miner]  project and follow the instructions.

### Querying analysis data

This step assumes that you already installed Neo4j and played a litte bit the Maven Dependency Graph.

In order to reproduce the analysis data, a bash script and a set of Cypher queries are made at your disposal. Note, the script exports data to a CSV format. These files will later be fed to the R project for pre-processing and display.

```
Usage: ./run-queries.sh
--path            The path to store resulting CSV files"
--neo4j-home      The absolute path to Neo4j"
```

:warning: The file *queries.cypher* contains some variable patterns in the queries. If you're interested in running the queries separately, please consider replacing *%PATH%* by the actual path where you intend to export the CSV files

:warning: The script *./run-queries* assumes that the Neo4j authentication is disabled. If not, please consider adding the appropriate neo4j authentication parameters to the script as follows

```
sed -e "s#%PATH%#$PATH_CSV#g" $CURR/test.cypher | bin/cypher-shell --format -u ${username} -p ${password}
```

:fire: The script may take up 24h to finish!
### Plotting analysis data
@César Could you please add some instructions on how to use the R project you provided when you have time?!
