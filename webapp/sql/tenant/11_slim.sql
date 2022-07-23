CREATE TABLE player_score_new (
  id VARCHAR(255) NOT NULL PRIMARY KEY,
  tenant_id BIGINT NOT NULL,
  player_id VARCHAR(255) NOT NULL,
  competition_id VARCHAR(255) NOT NULL,
  score BIGINT NOT NULL,
  row_num BIGINT NOT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL
);


INSERT INTO player_score_new 
SELECT
    a.id, a.tenant_id, a.player_id, a.competition_id, a.score, a.row_num, a.created_at, a.updated_at
FROM
    player_score as a
    INNER JOIN (SELECT
                    b.tenant_id, b.player_id, b.competition_id,
                    MAX(b.row_num) AS row_num
                FROM
                    player_score as b
                GROUP BY
                    b.tenant_id, b.player_id, b.competition_id) AS t
    ON a.tenant_id = t.tenant_id AND a.player_id = t.player_id AND a.competition_id = t.competition_id
       AND a.row_num = t.row_num;

DROP TABLE player_score;
ALTER TABLE player_score_new RENAME TO player_score;
