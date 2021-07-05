-- Database: `cloud_user`

-- Table structure for table `cloud_user`

CREATE TABLE IF NOT EXISTS `cloud_user` (  
    `user_id` bigint NOT NULL AUTO_INCREMENT,   
    `user_name` varchar(45) DEFAULT NULL,   
    `user_email` varchar(45) DEFAULT NULL,   
    `user_bio` varchar(255) DEFAULT NULL,   
    PRIMARY KEY (`user_id`) 
    ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ;

-- Dumping data for table `cloud_user`

INSERT INTO `cloud_user` (
    `user_id`,`user_name`,`user_email`, `user_bio`) 
    values  
    (1,'kc chang','cloudacode@gmail.com', 'mento');

