CREATE TABLE `users` (
 	 `id` int(11) NOT NULL AUTO_INCREMENT,
 	 `name` varchar(100) NOT NULL,
 	 `phone` varchar(50) NULL,
     `email` varchar(200) NULL,
     `password` varchar(100) NOT NULL,
     `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON  UPDATE CURRENT_TIMESTAMP,
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `clients` (
 	 `id` int(11) NOT NULL AUTO_INCREMENT,
 	 `name` varchar(200) NOT NULL,
 	 `country` varchar(50) NULL,
 	 `city` varchar(150) NULL,
 	 `address` varchar(550) NULL,
 	 `billing_address` varchar(550) NULL,
 	 `telephone` varchar(50) NULL,
     `email` varchar(100) NULL,
     `acquisition_type` varchar(100) NULL,
     `client_type` varchar(100) NULL,
     `industry_type` varchar(100) NULL,
     `description` varchar(500) NULL,
     `created` date NOT NULL,
     `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON  UPDATE CURRENT_TIMESTAMP,
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `contact` (
 	 `id` int(11) NOT NULL AUTO_INCREMENT,
 	 `client_id` int(11) NOT NULL,
 	 `name` varchar(200) NOT NULL,
 	 `position` varchar(200) NULL,
 	 `address` varchar(550) NULL,
 	 `telephone` varchar(50) NULL,
     `email` varchar(100) NULL,
     `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON  UPDATE CURRENT_TIMESTAMP,
     FOREIGN KEY (client_id) REFERENCES clients(id),
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
