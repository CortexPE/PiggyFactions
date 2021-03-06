-- #! mysql
-- #{ piggyfactions

-- # { factions

-- # { init
CREATE TABLE IF NOT EXISTS factions
(
    id            VARCHAR(36) PRIMARY KEY,
    name          TEXT,
    creation_time BIGINT,
    description   TEXT,
    motd          TEXT,
    members       JSON,
    permissions   JSON,
    flags         JSON,
    home          JSON,
    relations     JSON,
    banned        JSON
);
-- # }

-- # { load
SELECT *
FROM factions;
-- # }

-- # { create
-- #    :id string
-- #    :name string
-- #    :members string
-- #    :permissions string
-- #    :flags string
INSERT INTO factions (id, name, creation_time, members, permissions, flags)
VALUES (:id, :name, UNIX_TIMESTAMP(), :members, :permissions, :flags);
-- # }

-- # { delete
-- #    :id string
DELETE
FROM factions
WHERE id = :id;
-- # }

-- # { update
-- #    :id string
-- #    :name string
-- #    :description ?string
-- #    :motd ?string
-- #    :members string
-- #    :permissions string
-- #    :flags string
-- #    :home ?string
-- #    :relations string
-- #    :banned string
UPDATE factions
SET name=:name,
    description=:description,
    motd=:motd,
    members=:members,
    permissions=:permissions,
    flags=:flags,
    home=:home,
    relations=:relations,
    banned=:banned
WHERE id = :id;
-- # }

-- # }

-- # { players

-- # { init
CREATE TABLE IF NOT EXISTS players
(
    uuid     VARCHAR(36) PRIMARY KEY,
    username VARCHAR(16),
    faction  INTEGER,
    role     TEXT,
    power    FLOAT
);
-- # }

-- # { load
SELECT *
FROM players;
-- # }

-- # { create
-- #    :uuid string
-- #    :username string
-- #    :faction ?string
-- #    :role ?string
-- #    :power float
INSERT INTO players (uuid, username, faction, role, power)
VALUES (:uuid, :username, :faction, :role, :power);
-- # }

-- # { update
-- #    :uuid string
-- #    :username string
-- #    :faction ?string
-- #    :role ?string
-- #    :power float
UPDATE players
SET username=:username,
    faction=:faction,
    role=:role,
    power=:power
WHERE uuid = :uuid;
-- # }

-- # }

-- # { claims

-- # { init
CREATE TABLE IF NOT EXISTS claims
(
    id      INTEGER PRIMARY KEY AUTO_INCREMENT,
    chunkX  INTEGER,
    chunkZ  INTEGER,
    level   TEXT,
    faction INTEGER
);
-- # }

-- # { load
SELECT *
FROM claims;
-- # }

-- # { create
-- #    :chunkX int
-- #    :chunkZ int
-- #    :level string
-- #    :faction string
INSERT INTO claims (chunkX, chunkZ, level, faction)
VALUES (:chunkX, :chunkZ, :level, :faction);
-- # }

-- # { update
-- #    :chunkX int
-- #    :chunkZ int
-- #    :level string
-- #    :faction string
UPDATE claims
SET faction=:faction
WHERE chunkX = :chunkX
  AND chunkZ = :chunkZ
  AND level = :level;
-- # }

-- # { delete
-- #    :chunkX int
-- #    :chunkZ int
-- #    :level string
DELETE
FROM claims
WHERE chunkX = :chunkX
  AND chunkZ = :chunkZ
  AND level = :level;
-- # }

-- # }

-- # }