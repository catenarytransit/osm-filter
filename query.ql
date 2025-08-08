[out:xml][timeout:3600];
// Gather all nodes, ways, and relations that are administrative boundaries
nwr["boundary"="administrative"];
// Recurse down to collect all constituent nodes for ways/relations
(._;>;);
// Output the complete geometry
out meta;
