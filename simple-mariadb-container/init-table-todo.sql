-- Database: `todo`

-- Table structure for table `todo`

CREATE TABLE todo (
        id INTEGER NOT NULL AUTO_INCREMENT,
        content VARCHAR(255) NOT NULL,
        date_created DATETIME,
        PRIMARY KEY (id)
) ;

-- Dumping data for table `todo`

INSERT INTO `todo` (
    `content`,`date_created`) 
    values  
    ('cloudacode','2021-08-01 05:50:25');
