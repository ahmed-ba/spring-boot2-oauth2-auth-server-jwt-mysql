CREATE TABLE OAUTH_CLIENT_DETAILS (
                                      CLIENT_ID VARCHAR(255) NOT NULL PRIMARY KEY,
                                      CLIENT_SECRET VARCHAR(255) NOT NULL,
                                      RESOURCE_IDS VARCHAR(255) DEFAULT NULL,
                                      SCOPE VARCHAR(255) DEFAULT NULL,
                                      AUTHORIZED_GRANT_TYPES VARCHAR(255) DEFAULT NULL,
                                      WEB_SERVER_REDIRECT_URI VARCHAR(255) DEFAULT NULL,
                                      AUTHORITIES VARCHAR(255) DEFAULT NULL,
                                      ACCESS_TOKEN_VALIDITY INT(11) DEFAULT NULL,
                                      REFRESH_TOKEN_VALIDITY INT(11) DEFAULT NULL,
                                      ADDITIONAL_INFORMATION VARCHAR(4096) DEFAULT NULL,
                                      AUTOAPPROVE VARCHAR(255) DEFAULT NULL);

INSERT INTO OAUTH_CLIENT_DETAILS (
    CLIENT_ID,CLIENT_SECRET,
    RESOURCE_IDS,
    SCOPE,
    AUTHORIZED_GRANT_TYPES,
    WEB_SERVER_REDIRECT_URI,AUTHORITIES,
    ACCESS_TOKEN_VALIDITY,REFRESH_TOKEN_VALIDITY,
    ADDITIONAL_INFORMATION,AUTOAPPROVE)
VALUES(
          'USER_CLIENT_APP','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi',
          'USER_CLIENT_RESOURCE,USER_ADMIN_RESOURCE',
          'role_admin,role_user',
          'authorization_code,password,refresh_token,implicit',
          NULL,NULL,
          900,3600,
          '{}',NULL);



CREATE TABLE PERMISSION (
                            ID INT PRIMARY KEY AUTO_INCREMENT,
                            NAME VARCHAR(60) UNIQUE KEY);

INSERT INTO PERMISSION (NAME) VALUES
('can_create_user'),
('can_update_user'),
('can_read_user'),
('can_delete_user');



CREATE TABLE ROLE
(ID INT PRIMARY KEY AUTO_INCREMENT,
 NAME VARCHAR(60) UNIQUE KEY);


INSERT INTO ROLE (NAME) VALUES
('role_admin'),('role_user');




CREATE TABLE PERMISSION_ROLE(
                                PERMISSION_ID INT,
                                FOREIGN KEY(PERMISSION_ID) REFERENCES PERMISSION(ID),
                                ROLE_ID INT,
                                FOREIGN KEY(ROLE_ID) REFERENCES ROLE(ID));

INSERT INTO PERMISSION_ROLE (PERMISSION_ID, ROLE_ID) VALUES
(1,1), /* can_create_user assigned to role_admin */
(2,1), /* can_update_user assigned to role_admin */
(3,1), /* can_read_user assigned to role_admin */
(4,1), /* can_delete_user assigned to role_admin */

(3,2);  /* can_read_user assigned to role_user */





CREATE TABLE USER (
                      ID INT PRIMARY KEY AUTO_INCREMENT,
                      USERNAME VARCHAR(24) UNIQUE KEY NOT NULL,
                      PASSWORD VARCHAR(255) NOT NULL,
                      EMAIL VARCHAR(255) NOT NULL,
                      ENABLED BIT(1) NOT NULL,
                      ACCOUNT_EXPIRED BIT(1) NOT NULL,
                      CREDENTIALS_EXPIRED BIT(1) NOT NULL,
                      ACCOUNT_LOCKED BIT(1) NOT NULL);





INSERT INTO USER (
    USERNAME,PASSWORD,
    EMAIL,ENABLED,ACCOUNT_EXPIRED,CREDENTIALS_EXPIRED,ACCOUNT_LOCKED) VALUES (
                                                                                 'admin','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi',
                                                                                 'ahmed@gmail.com',1,0,0,0),
                                                                             ('user','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi',
                                                                              'bahrini@gmail.com',1,0,0,0);



CREATE TABLE ROLE_USER (ROLE_ID INT,FOREIGN KEY(ROLE_ID) REFERENCES ROLE(ID),
                        USER_ID INT, FOREIGN KEY(USER_ID) REFERENCES USER(ID));


INSERT INTO ROLE_USER (ROLE_ID, USER_ID)
VALUES
(1, 1) /* role_admin assigned to admin user */,
(2, 2) /* role_user assigned to user user */ ;

