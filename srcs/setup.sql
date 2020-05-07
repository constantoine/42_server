USE mysql;
CREATE DATABASE wpdb;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'mussolini';
GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'ravioli';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
