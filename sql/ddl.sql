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

CREATE TABLE `contacts` (
 	 `id` int(11) NOT NULL AUTO_INCREMENT,
 	 `client_id` int(11) NOT NULL,
 	 `name` varchar(200) NOT NULL,
 	 `position` varchar(200) NULL,
 	 `address` varchar(550) NULL,
 	 `telephone` varchar(50) NULL,
     `email` varchar(100) NULL,
     `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON  UPDATE CURRENT_TIMESTAMP,
     CONSTRAINT `fk_contact_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `products` (
 	 `id` int(11) NOT NULL AUTO_INCREMENT,
 	 `name` varchar(200) NOT NULL,
 	 `product_idph` varchar(20) NOT NULL,
 	 `product_type` varchar(100) NOT NULL,
 	 `structure_path` varchar(200) NULL,
 	 `in_stock` varchar(10) NULL,
 	 `price` varchar(50) NULL,
     `production_year` varchar(10) NULL,
     `cas` varchar(100) NULL,
 	 `description` varchar(500) NULL,
     `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON  UPDATE CURRENT_TIMESTAMP,
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `case_studies` (
 	 `id` int(11) NOT NULL AUTO_INCREMENT,
 	 `product_id` int(11) NOT NULL,
 	 `name` varchar(200) NOT NULL,
 	 `file_path` varchar(500) NULL,
 	 `link` varchar(500) NULL,
 	 `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON  UPDATE CURRENT_TIMESTAMP,
     CONSTRAINT `fk_case_studies_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `applications` (
 	 `id` int(11) NOT NULL AUTO_INCREMENT,
 	 `product_id` int(11) NOT NULL,
 	 `name` varchar(100) NOT NULL,
 	 `category` varchar(200) NOT NULL,
 	 `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON  UPDATE CURRENT_TIMESTAMP,
     CONSTRAINT `fk_applications_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
