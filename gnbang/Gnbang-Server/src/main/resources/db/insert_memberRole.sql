DELETE FROM ROLE_LIST WHERE  NO = 7 OR NO = 8;
DELETE FROM user WHERE  NO = 1 OR NO = 2;
DELETE FROM role WHERE  NO = 1 OR NO = 2;
 
insert into  user(no,email,password) 
values (1,'users@email','1');
insert into  user(no,email,password) 
values (2,'supers@email','2');
insert into  role(user_no , no , role_list_no) 
values (1,1,7);
insert into  role(user_no , no , role_list_no) 
values (2,2,8);
insert into  role_list(no , role) 
values (7, 'ROLE_USER');
insert into  role_list(no , role) 
values (8, 'ROLE_SUPER');