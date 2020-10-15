CREATE TABLE customers (
  `id` mediumint(8) unsigned NOT NULL auto_increment, 
  `name` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `phone` varchar(100) default NULL,
  `street_address` varchar(255) default NULL,
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1; 
 
INSERT INTO `customers` (`id`,`name`,`email`,`phone`,`street_address`) 
    VALUES ('1','Thomas Pacheco','Duis@aliquetlobortisnisi.com','','558-2198 Facilisis, Rd.');
INSERT INTO `customers` (`id`,`name`,`email`,`phone`,`street_address`) 
    VALUES ('2','Nissim Hardy','in.dolor.Fusce@sollicitudinadipiscing.edu','','P.O. Box 937, 6498 Amet, St.');
INSERT INTO `customers` (`id`,`name`,`email`,`phone`,`street_address`) 
    VALUES ('3','Baxter Williamson','mi.Duis.risus@felisullamcorper.org','','Ap #984-7814 In St.');