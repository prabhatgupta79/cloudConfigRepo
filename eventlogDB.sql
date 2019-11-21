USE EventLogsDB;

CREATE TABLE EventLogsDB.AuditLogs (
	id BIGINT NOT NULL AUTO_INCREMENT,
	`date` DATE NULL,
	eventType varchar(100) NOT NULL,
	submittedSBLC varchar(100) NULL,
	timeZone varchar(100) NULL,
	ip varchar(100) NOT NULL,
	corpKey varchar(100) NOT NULL,
	event_description VARCHAR(9000) NOT NULL,
	originAppName varchar(200) NOT NULL,
	`time` TIME NULL,
	EventTime TIMESTAMP NOT NULL,
	get_Criteria varchar(100) NULL,
	CONSTRAINT AuditLogs_PK PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;