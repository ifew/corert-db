CREATE TABLE `member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `member` (`id`, `firstname`, `lastname`)
VALUES
	(1,'Chitpong','Wuttanan'),
	(2,'Jim','Carrey'),
	(3,'Bruce','Banner');