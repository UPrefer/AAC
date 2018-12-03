// Creation des Noeuds

CREATE (warehouse1:Resource{name:"warehouse1", uri:"/v1/warehouses/1", type:"warehouse", uuid:1})
CREATE (warehouse2:Resource{name:"warehouse2", uri:"/v1/warehouses/2", type:"warehouse", uuid:2})
CREATE (warehouse3:Resource{name:"warehouse3", uri:"/v1/warehouses/3", type:"warehouse", uuid:3})
CREATE (warehouse4:Resource{name:"warehouse4", uri:"/v1/warehouses/4", type:"warehouse", uuid:4})
CREATE (warehouse5:Resource{name:"warehouse5", uri:"/v1/warehouses/5", type:"warehouse", uuid:5})


CREATE (project11:Resource{name:"project11", uri:"/v1/warehouses/1/Projects/11", type:"project", uuid:11})
CREATE (project21:Resource{name:"project21", uri:"/v1/warehouses/2/Projects/21", type:"project", uuid:21})
CREATE (project31:Resource{name:"project31", uri:"/v1/warehouses/3/Projects/31", type:"project", uuid:31})
CREATE (project41:Resource{name:"project41", uri:"/v1/warehouses/4/Projects/41", type:"project", uuid:41})
CREATE (project51:Resource{name:"project51", uri:"/v1/warehouses/5/Projects/51", type:"project", uuid:51})

CREATE (artifact111:Resource{name:"artifact111", uri:"/v1/warehouses/1/Projects/11/artifacts/111", type:"artifact", uuid:111})
CREATE (artifact221:Resource{name:"artifact221", uri:"/v1/warehouses/1/Projects/11/artifacts/221", type:"artifact", uuid:221})
CREATE (artifact331:Resource{name:"artifact331", uri:"/v1/warehouses/1/Projects/11/artifacts/331", type:"artifact", uuid:331})
CREATE (artifact441:Resource{name:"artifact441", uri:"/v1/warehouses/2/Projects/21/artifacts/441", type:"artifact", uuid:441})
CREATE (artifact551:Resource{name:"artifact551", uri:"/v1/warehouses/5/Projects/51/artifacts/551", type:"artifact", uuid:551})

CREATE (Arnaud:User{sub:"06bd6895-f76d-4650-b967-e67138d010d8"})
CREATE (Charly:User{sub:"f59f31e3-5393-4ccc-b68d-5355182e0acf"})

// Users are linked to warehouse AND project with full rights
CREATE (project11) - [:IsChildOf] -> (warehouse1)
CREATE (warehouse1) - [:IsParentOf] -> (project11)
CREATE (artifact111) - [:IsChildOf] -> (project11)
CREATE (project11) - [:IsParentOf] ->(artifact111)
CREATE (artifact221) - [:IsChildOf] -> (project11)
CREATE (project11) - [:IsParentOf] ->(artifact221)
CREATE (artifact331) - [:IsChildOf] -> (project11)
CREATE (project11) - [:IsParentOf] ->(artifact331)

CREATE (Arnaud) - [:Can{GET:true, POST: true, DELETE: true, UPDATE:true}] ->(warehouse1)
CREATE (Charly) - [:Can{GET:true, POST: true, DELETE: true, UPDATE:true}] ->(warehouse1)
CREATE (Arnaud) - [:Can{GET:true, POST: true, DELETE: true, UPDATE:true}] ->(project11)
CREATE (Charly) - [:Can{GET:true, POST: true, DELETE: true, UPDATE:true}] ->(project11)

// Users are linked to warehouse only with GET rights
CREATE (project21) - [:IsChildOf] -> (warehouse2)
CREATE (warehouse2) - [:IsParentOf] -> (project21)
CREATE (artifact441) - [:IsChildOf] -> (project21)
CREATE (project21) - [:IsParentOf] ->(artifact441)
CREATE (Arnaud) - [:Can{GET:true, POST: false, DELETE: false, UPDATE:false}] ->(warehouse2)
CREATE (Charly) - [:Can{GET:true, POST: false, DELETE: false, UPDATE:false}] ->(warehouse2)

// Users are linked to project only with GET rights
CREATE (project31) - [:IsChildOf] -> (warehouse3)
CREATE (warehouse3) - [:IsParentOf] -> (project31)
CREATE (Arnaud) - [:Can{GET:true, POST: false, DELETE: false, UPDATE:false}] ->(project31)
CREATE (Charly) - [:Can{GET:true, POST: false, DELETE: false, UPDATE:false}] ->(project31)

// Users are not linked to resources
CREATE (project41) - [:IsChildOf] -> (warehouse4)
CREATE (warehouse4) - [:IsParentOf] -> (project41)

CREATE (project51) - [:IsChildOf] -> (warehouse5)
CREATE (warehouse5) - [:IsParentOf] -> (project51)

MATCH (n)
Return n

MATCH (user:User)-[*]->(res:Resource)-[:IsChildOf*]-(Parent:Resource)
WHERE (user.sub = "06bd6895-f76d-4650-b967-e67138d010d8" OR user.sub="public")
return user, res, Parent


Match(n)
DETACH DELETE n
return n