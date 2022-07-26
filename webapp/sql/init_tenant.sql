USE `isuports`;

DROP TABLE IF EXISTS `competition`;
DROP TABLE IF EXISTS `player`;
DROP TABLE IF EXISTS `player_score`;

CREATE TABLE `competition` (
  id VARCHAR(255) NOT NULL,
  tenant_id BIGINT NOT NULL,
  title TEXT NOT NULL,
  finished_at BIGINT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL,
  PRIMARY KEY (`id`, `tenant_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE INDEX tenant_id_idx_1 on competition(tenant_id);

CREATE TABLE `player` (
  id VARCHAR(255) NOT NULL,
  tenant_id BIGINT NOT NULL,
  display_name TEXT NOT NULL,
  is_disqualified BOOLEAN NOT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL,
  PRIMARY KEY (`id`, `tenant_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE INDEX `tenant_id_idx_2` on player(tenant_id);

CREATE TABLE `player_score` (
  id VARCHAR(255) NOT NULL,
  tenant_id BIGINT NOT NULL,
  player_id VARCHAR(255) NOT NULL,
  competition_id VARCHAR(255) NOT NULL,
  score BIGINT NOT NULL,
  `rank` BIGINT NOT NULL,
  row_num BIGINT NOT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL,
  PRIMARY KEY (`id`, `tenant_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE INDEX `tenant_id_idx_3` on player_score (`tenant_id`);
CREATE INDEX `tenant_id_competition_id_idx` on player_score (`tenant_id`, `competition_id`);

INSERT INTO competition SELECT * FROM competition_orig;
INSERT INTO player SELECT * FROM player_orig;

INSERT INTO player_score
SELECT
    id, tenant_id, player_id, competition_id, score,
    ROW_NUMBER() OVER (PARTITION BY tenant_id, competition_id  ORDER BY score DESC, row_num ASC) as `rank`, 
    row_num, created_at, updated_at
FROM player_score_orig;
