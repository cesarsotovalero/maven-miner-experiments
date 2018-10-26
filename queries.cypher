
CALL apoc.export.csv.query("MATCH (n:Artifact) RETURN n.coordinates as artifact, n.release_date as release", "%PATH%/release_all.csv", {});

CALL apoc.export.csv.query("MATCH (n:Artifact)-[:DEPENDS_ON]->(m:Artifact) RETURN n.coordinates AS x, m.coordinates AS y", "%PATH%/links_all.csv", {});

CALL apoc.export.csv.query("MATCH (n) RETURN n.coordinates AS artifact, size((n)<-[:DEPENDS_ON]-()) as direct_usages ORDER BY direct_usages DESC","%PATH%/direct_usages.csv", {});

CALL apoc.export.csv.query("MATCH (n) RETURN n.coordinates AS artifact, size((n)-[:DEPENDS_ON]->()) as direct_dependencies ORDER BY direct_dependencies DESC","%PATH%/direct_dependencies.csv", {});

//CALL apoc.export.csv.query("MATCH (n:Artifact)<-[:DEPENDS_ON*]-(m:Artifact) RETURN n.coordinates AS artifact, count(m) as transitive_usages ORDER BY transitive_usages DESC","%PATH%/trans_usages.csv", {});

// Common graph algorithms
CALL apoc.export.csv.query("CALL algo.pageRank.stream('Artifact', 'DEPENDS_ON', {iterations:10, dampingFactor:0.85}) YIELD nodeId, score MATCH (node) WHERE id(node) = nodeId RETURN node.coordinates AS artifact, score AS page_rank ORDER BY score DESC", "%PATH%/pagerank_all.csv", {});

CALL apoc.export.csv.query("CALL algo.betweenness.stream('Artifact','DEPENDS_ON',{direction:'out'}) YIELD nodeId, centrality MATCH (user:Artifact) WHERE id(user) = nodeId RETURN user.coordinates AS artifact, centrality AS betweenness_centrality ORDER BY centrality DESC","%PATH%/betweenness_centrality_all.csv", {});

CALL apoc.export.csv.query("CALL algo.closeness.harmonic.stream('Artifact', 'DEPENDS_ON') YIELD nodeId, centrality MATCH (node) WHERE id(node) = nodeId RETURN node.coordinates as artifact, centrality AS harmonic_centrality ORDER BY centrality DESC","%PATH%/harmonic_centrality_all.csv", {});

CALL apoc.export.csv.query("CALL algo.labelPropagation.stream('Artifact', 'DEPENDS_ON', {direction: 'OUTGOING', iterations: 10}) YIELD nodeId, label MATCH (node) WHERE id(node) = nodeId RETURN node.coordinates as artifact, label","%PATH%/label_propagation.csv", {});

CALL apoc.export.csv.query("CALL algo.unionFind.stream('Artifact', 'DEPENDS_ON', {}) YIELD nodeId, setId MATCH (artifact:Artifact) WHERE id(artifact) = nodeId RETURN artifact.coordinates AS artifact, setId AS union_find","%PATH%/union_find.csv", {});

CALL apoc.export.csv.query("CALL algo.louvain.stream('Artifact', 'DEPENDS_ON', {}) YIELD nodeId, community MATCH (node) WHERE id(node) = nodeId RETURN node.coordinates AS artifact, community", "%PATH%/louvain_all.csv", {});
