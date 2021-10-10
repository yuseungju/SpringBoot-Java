drop database `gnbang`;
CREATE SCHEMA `gnbang` DEFAULT CHARACTER SET utf8 ;
USE `gnbang`;

-- user
CREATE TABLE `user` (
	`no`          INT(11)      NOT NULL, -- no
	`level`       INT(11)      NULL,     -- level
	`type`        INT(11)      NULL,     -- type
	`password`    VARCHAR(100) NULL,     -- password
	`name`        VARCHAR(20)  NULL,     -- name
	`email`       VARCHAR(50)  NULL,     -- email
	`phone`       VARCHAR(20)  NULL,     -- phone
	`date`        TIMESTAMP    NULL     DEFAULT 	CURRENT_TIMESTAMP, -- date
	`agreement`   BOOL         NULL,     -- agreement
	`leave_date`  TIMESTAMP    NULL,      -- 새 컬럼2
    `photo_url`     VARCHAR(500) NULL
);

-- user
ALTER TABLE `user`
	ADD CONSTRAINT `PK_user` -- user 기본키
		PRIMARY KEY (
			`no` -- no
		);

ALTER TABLE `user`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- user_agent
CREATE TABLE `user_agent` (
	`no`                            INT(11)      NOT NULL, -- no
	`name`                          VARCHAR(20)  NULL,     -- name
	`corporate_registration_number` VARCHAR(20)  NULL     COMMENT '사업자번호', -- corporate_registration_number
	`representative`                VARCHAR(20)  NULL     COMMENT '대표자', -- representative
	`address`                       VARCHAR(200) NULL,     -- address
	`phone`                         VARCHAR(20)  NULL,     -- phone
	`user_no`                       INT(11)      NULL,     -- user_no
	`level`                         INT(11)      NULL     COMMENT '0 대표/ 1 소속 /3 중개보조원 ', -- 새 컬럼
	`mac_address` 					VARCHAR(20) NULL    -- agreement
);

-- user_agent
ALTER TABLE `user_agent`
	ADD CONSTRAINT `PK_user_agent` -- user_agent 기본키
		PRIMARY KEY (
			`no` -- no
		);

ALTER TABLE `user_agent`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- specific_room_item_prev
CREATE TABLE `specific_room_item_prev` (
	`no`                      INT(11)     NOT NULL, -- no
	`user_no`                 INT(11)     NULL,     -- no2
	`item_no`                 INT(11)     NULL,     -- 새 컬럼2
	`close`                   TINYINT(1)  NULL     DEFAULT 0, -- 새 컬럼3
	`close_reason`            VARCHAR(50) NULL,     -- 새 컬럼4
	`recommend`               TINYINT(4)  NULL,     -- recommend
	`urgent_sale`             TINYINT(1)  NULL,     -- urgent_sale
	`apartment`               TINYINT(1)  NULL,     -- apartment
	`officetel`               TINYINT(1)  NULL,     -- officetel
	`house`                   TINYINT(1)  NULL,     -- house
	`normal_room`             TINYINT(1)  NULL,     -- normal_room
	`full_option_room`        TINYINT(1)  NULL,     -- full_option_room
	`shop`                    TINYINT(1)  NULL,     -- shop
	`office`                  TINYINT(1)  NULL,     -- office
	`building`                TINYINT(1)  NULL,     -- buliding
	`redevelopment`           TINYINT(1)  NULL,     -- redevelopment
	`land`                    TINYINT(1)  NULL,     -- land
	`event`                   TINYINT(1)  NULL,     -- event
	`all_floor`               INT         NULL,     -- all_floor
	`floor_no`                INT         NULL,     -- floor_no
	`semi_basement`           TINYINT(1)  NULL,     -- semi_basement
	`rooftop`                 TINYINT(1)  NULL,     -- rooftop
	`built`                   INT         NULL,     -- built
	`room_count`              INT         NULL,     -- room_count
	`room_count_onepointfive` TINYINT(1)  NULL,     -- room_count_onepointfive
	`bathroom_count`          INT(11)     NULL,     -- bathroom_count
	`room_type`               TINYINT(4)  NULL     COMMENT '1오픈형/2분리형/3복층형/4사무용/5주거용/6일부층사용/7전층사용/8원룸원거실/9세미분리', -- room_type
	`empty`                   TINYINT(1)  NULL,     -- empty
	`type`                    TINYINT(4)  NULL     COMMENT '매매|전세|월세|단기임대', -- type
	`leased_area`             FLOAT       NULL,     -- leased_area
	`exclusive_area`          FLOAT       NULL,     -- exclusive_area
	`move_now`                TINYINT(1)  NULL,     -- move_now
	`move_modify`             TINYINT(1)  NULL,     -- move_modify
	`move_day`                VARCHAR(20) NULL,     -- move_day
	`brokerage`               INT(11)     NULL,     -- 새 컬럼5
	`sale_price`              INT(11)     NULL,     -- 새 컬럼6
	`standard_deposit`        INT(11)     NULL,     -- standard_deposit
	`charter_deposit`         INT(11)     NULL,     -- charter_deopsit
	`deposit`                 INT(11)     NULL,     -- deposit
	`monthly_rent`            INT(11)     NULL,     -- monthly_rent
	`maintenance_cost`        INT(11)     NULL,     -- maintenance_cost
	`deposit_modify`          TINYINT(1)  NULL,     -- deposit_modify
	`in_electronic_bill`      TINYINT(1)  NULL,     -- in_electronic_bill
	`in_gas_bill`             TINYINT(1)  NULL,     -- in_gas_bill
	`in_water_bill`           TINYINT(1)  NULL,     -- in_water_bill
	`in_internet_bill`        TINYINT(1)  NULL,     -- in_internet_bill
	`in_tv_bill`              TINYINT(1)  NULL,     -- in_tv_bill
	`in_clean_fee`            TINYINT(1)  NULL,     -- in_clean_fee
	`airconditioner`          TINYINT(1)  NULL,     -- airconditioner
	`refrigerator`            TINYINT(1)  NULL,     -- regrigerator
	`washer`                  TINYINT(1)  NULL,     -- washer
	`tv`                      TINYINT(1)  NULL,     -- tv
	`microwave`               TINYINT(1)  NULL,     -- microwave
	`induction`               TINYINT(1)  NULL,     -- induction
	`gasrange`                TINYINT(1)  NULL,     -- gasrange
	`bed`                     TINYINT(1)  NULL,     -- bed
	`built_in_closet`         TINYINT(1)  NULL,     -- built_in_closet
	`closet`                  TINYINT(1)  NULL,     -- closet
	`dressing_table`          TINYINT(1)  NULL,     -- dressing_table
	`veranda`                 TINYINT(1)  NULL,     -- veranda
	`security`                TINYINT(1)  NULL,     -- security
	`digital_doorlock`        TINYINT(1)  NULL,     -- digital_doorlock
	`other_option`            TEXT        NULL,     -- other_option
	`elevator`                TINYINT(1)  NULL,     -- elevator
	`animal`                  TINYINT(1)  NULL,     -- animal
	`parking`                 TINYINT(1)  NULL,     -- parking
	`parking_free`            TINYINT(1)  NULL,     -- parking_free
	`parking_count`           TINYINT(4)  NULL,     -- parking_count
	`parking_option`          VARCHAR(50) NULL,     -- parking_option
	`heating_type`            TINYINT(4)  NULL     COMMENT '0:중앙, 1:개별, 2:지역', -- heating_type
	`detail`                  TEXT        NULL,     -- detail
	`requirement`             TEXT        NULL,     -- requirement
	`movie_url`               VARCHAR(50) NULL,     -- movie_url
	`z_explain`               TEXT        NULL,     -- z_explain
	`contact_who_1`           VARCHAR(20) NULL,     -- contact_who_1
	`contact_phone_1`         VARCHAR(20) NULL,     -- contact_phone_1
	`contact_who_2`           VARCHAR(20) NULL,     -- contact_who_2
	`contact_phone_2`         VARCHAR(20) NULL,     -- contact_phone_2
	`contact_who_3`           VARCHAR(20) NULL,     -- contact_who_3
	`contact_phone_3`         VARCHAR(20) NULL,     -- contact_phone_3
	`contact_who_4`           VARCHAR(20) NULL,     -- contact_who_4
	`contact_phone_4`         VARCHAR(20) NULL,     -- contact_phone_4
	`confirm_date`            TIMESTAMP   NULL,     -- confirm_date
	`date`                    TIMESTAMP   NOT NULL DEFAULT 	CURRENT_TIMESTAMP, -- date
	`read_cnt`                INT(11)     NULL,     -- read_cnt
	`photo_open`              TINYINT(1)  NULL,     -- photo_open
	`snum`                    INT         NULL      -- 새 컬럼
);

-- specific_room_item_prev
ALTER TABLE `specific_room_item_prev`
	ADD CONSTRAINT `PK_specific_room_item_prev` -- specific_room_item_prev 기본키
		PRIMARY KEY (
			`no` -- no
		);

ALTER TABLE `specific_room_item_prev`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- section
CREATE TABLE `section` (
	`no`    INT         NOT NULL, -- no
	`gu`    VARCHAR(10) NULL,     -- 새 컬럼
	`name`  VARCHAR(20) NULL,     -- name
	`shape` TEXT        NULL      -- shape
);

-- section
ALTER TABLE `section`
	ADD CONSTRAINT `PK_section` -- section 기본키
		PRIMARY KEY (
			`no` -- no
		);

ALTER TABLE `section`
	MODIFY COLUMN `no` INT NOT NULL AUTO_INCREMENT;

-- note
CREATE TABLE `note` (
	`no`           INT(11)   NOT NULL, -- 새 컬럼
	`user_no`      INT(11)   NULL,     -- no
	`room_item_no` INT(11)   NULL,     -- 새 컬럼4
	`text`         TEXT      NULL,     -- 새 컬럼2
	`date`         TIMESTAMP NULL     DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼3
);

-- note
ALTER TABLE `note`
	ADD CONSTRAINT `PK_note` -- note 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `note`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- room_photo
CREATE TABLE `room_photo` (
	`no`           INT(11)      NOT NULL, -- 새 컬럼
	`user_no`      INT(11)      NULL,     -- no
	`room_item_no` INT(11)      NULL,     -- 새 컬럼7
	`comment`      TEXT         NULL,     -- 새 컬럼2
	`original_url` VARCHAR(500) NULL,     -- 새 컬럼3
	`fake_url`     VARCHAR(500) NULL,     -- 새 컬럼6
	`date`         TIMESTAMP    NULL     DEFAULT 	CURRENT_TIMESTAMP, -- 새 컬럼4
	`order`        INT(11)      NULL,     -- 새 컬럼8
	`is_use`       TINYINT(1)   NULL     DEFAULT 1 -- 새 컬럼5
);

-- room_photo
ALTER TABLE `room_photo`
	ADD CONSTRAINT `PK_room_photo` -- room_photo 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `room_photo`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- room_fake_report
CREATE TABLE `room_fake_report` (
	`no`           INT(11)   NOT NULL, -- no
	`user_no`      INT(11)   NULL,     -- no3
	`room_item_no` INT(11)   NULL,     -- 새 컬럼2
	`date`         TIMESTAMP NULL     DEFAULT 	CURRENT_TIMESTAMP, -- 새 컬럼
	`text`         TEXT      NULL      -- 새 컬럼3
);

-- room_fake_report
ALTER TABLE `room_fake_report`
	ADD CONSTRAINT `PK_room_fake_report` -- room_fake_report 기본키
		PRIMARY KEY (
			`no` -- no
		);

ALTER TABLE `room_fake_report`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- room_item
CREATE TABLE `room_item` (
	`no`               INT(11)     NOT NULL, -- 새 컬럼
	`local_code`       INT(11)     NULL,     -- 새 컬럼2
	`local_code2`      INT(11)     NULL,     -- 새 컬럼15
	`local_code3`      INT(11)     NULL,     -- 새 컬럼16
	`main_address`     INT(11)     NULL,     -- 새 컬럼3
	`sub_address`      INT(11)     NULL,     -- 새 컬럼4
	`last_address`     VARCHAR(50) NULL,     -- 새 컬럼5
	`new_address`      VARCHAR(50) NULL,     -- 새 컬럼6
	`building_address` VARCHAR(50) NULL,     -- 새 컬럼7
	`lat`              FLOAT       NULL,     -- 새 컬럼8
	`lng`              FLOAT       NULL,     -- 새 컬럼9
	`metro1`           INT(11)     NULL,     -- 새 컬럼10
	`metro2`           INT(11)     NULL,     -- 새 컬럼11
	`metro3`           INT(11)     NULL,     -- 새 컬럼12
	`metro4`           INT(11)     NULL,     -- 새 컬럼13
	`metro5`           INT(11)     NULL,     -- 새 컬럼14
	`section_no`       INT         NULL,     -- no
	`photo`            TINYINT(1)  NOT NULL DEFAULT 0 -- 새 컬럼17
);

-- room_item
ALTER TABLE `room_item`
	ADD CONSTRAINT `PK_room_item` -- room_item 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `room_item`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- admin_information_modify
CREATE TABLE `admin_information_modify` (
	`no`      INT(11)    NOT NULL, -- 새 컬럼
	`user_no` INT(11)    NULL,     -- no
	`room_no` INT(11)    NULL,     -- 새 컬럼5
	`date`    TIMESTAMP  NULL     DEFAULT 	CURRENT_TIMESTAMP, -- 새 컬럼2
	`check`   TINYINT(1) NULL,     -- 새 컬럼3
	`text`    TEXT       NULL      -- 새 컬럼4
);

-- admin_information_modify
ALTER TABLE `admin_information_modify`
	ADD CONSTRAINT `PK_admin_information_modify` -- admin_information_modify 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `admin_information_modify`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- room_item_cart_list
CREATE TABLE `room_item_cart_list` (
	`no`        INT(11)     NOT NULL, -- 새 컬럼
	`user_no`   INT(11)     NOT NULL, -- no
	`client_no` INT(11)     NULL,     -- no2
	`name`      VARCHAR(50) NULL,     -- 새 컬럼2
	`phone`     VARCHAR(50) NULL,     -- 새 컬럼5
	`explain`   TEXT        NULL,     -- 새 컬럼4
	`date`      TIMESTAMP   NOT NULL DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼3
);

-- room_item_cart_list
ALTER TABLE `room_item_cart_list`
	ADD CONSTRAINT `PK_room_item_cart_list` -- room_item_cart_list 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `room_item_cart_list`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- room_item_cart
CREATE TABLE `room_item_cart` (
	`no`                     INT(11) NOT NULL, -- 새 컬럼2
	`room_item_cart_list_no` INT(11) NULL,     -- 새 컬럼
	`room_item_no`           INT(11) NULL      -- 새 컬럼3
);

-- room_item_cart
ALTER TABLE `room_item_cart`
	ADD CONSTRAINT `PK_room_item_cart` -- room_item_cart 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼2
		);

ALTER TABLE `room_item_cart`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- consult
CREATE TABLE `consult` (
	`no`               INT(11)     NOT NULL, -- 새 컬럼
	`type`             TINYINT(4)  NULL     COMMENT '매매|전세|전월세|월세|단기임대', -- type
	`room_item_no`     INT(11)     NULL,     -- 새 컬럼2
	`deposit_min`      INT(11)     NULL,     -- 새 컬럼3
	`deposit_max`      INT(11)     NULL,     -- 새 컬럼4
	`monthly_rent_min` INT(11)     NULL,     -- 새 컬럼5
	`monthly_rent_max` INT(11)     NULL,     -- 새 컬럼6
	`phone`            VARCHAR(20) NULL,     -- 새 컬럼7
	`user_no`          INT(11)     NULL,     -- no
	`comment`          TEXT        NULL,     -- 새 컬럼9
	`agent_no`         INT(11)     NULL,     -- no2
	`date`             TIMESTAMP   NULL     DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼8
);

-- consult
ALTER TABLE `consult`
	ADD CONSTRAINT `PK_consult` -- consult 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `consult`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- zzim
CREATE TABLE `zzim` (
	`no`           INT(11)   NOT NULL, -- 새 컬럼3
	`user_no`      INT(11)   NULL,     -- no
	`room_item_no` INT(11)   NULL,     -- 새 컬럼2
	`date`         TIMESTAMP NULL     DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼
);

-- zzim
ALTER TABLE `zzim`
	ADD CONSTRAINT `PK_zzim` -- zzim 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼3
		);

ALTER TABLE `zzim`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- recently
CREATE TABLE `recently` (
	`no`           INT(11)   NOT NULL, -- 새 컬럼3
	`user_no`      INT(11)   NULL,     -- no
	`room_item_no` INT(11)   NULL,     -- 새 컬럼
	`date`         TIMESTAMP NULL     DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼2
);

-- recently
ALTER TABLE `recently`
	ADD CONSTRAINT `PK_recently` -- recently 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼3
		);

ALTER TABLE `recently`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- address_code
CREATE TABLE `address_code` (
	`code`  INT(11)     NOT NULL, -- 새 컬럼4
	`si`    VARCHAR(10) NULL,     -- 새 컬럼
	`gungu` VARCHAR(10) NULL,     -- 새 컬럼2
	`dong`  VARCHAR(10) NULL      -- 새 컬럼3
);

-- address_code
ALTER TABLE `address_code`
	ADD CONSTRAINT `PK_address_code` -- address_code 기본키
		PRIMARY KEY (
			`code` -- 새 컬럼4
		);

ALTER TABLE `address_code`
	MODIFY COLUMN `code` INT(11) NOT NULL AUTO_INCREMENT;

-- specific_room_item
CREATE TABLE `specific_room_item` (
	`no`                      INT(11)     NOT NULL, -- no
	`user_no`                 INT(11)     NULL,     -- no3
	`item_no`                 INT(11)     NULL,     -- 새 컬럼3
	`close`                   TINYINT(1)  NULL     DEFAULT 0, -- 새 컬럼2
	`close_reason`            VARCHAR(50) NULL,     -- 새 컬럼4
	`recommend`               TINYINT(4)  NULL,     -- recommend
	`urgent_sale`             TINYINT(1)  NULL,     -- urgent_sale
	`apartment`               TINYINT(1)  NULL,     -- apartment
	`officetel`               TINYINT(1)  NULL,     -- officetel
	`house`                   TINYINT(1)  NULL,     -- house
	`normal_room`             TINYINT(1)  NULL,     -- normal_room
	`full_option_room`        TINYINT(1)  NULL,     -- full_option_room
	`shop`                    TINYINT(1)  NULL,     -- shop
	`office`                  TINYINT(1)  NULL,     -- office
	`building`                TINYINT(1)  NULL,     -- buliding
	`redevelopment`           TINYINT(1)  NULL,     -- redevelopment
	`land`                    TINYINT(1)  NULL,     -- land
	`event`                   TINYINT(1)  NULL,     -- event
	`all_floor`               INT         NULL,     -- all_floor
	`floor_no`                INT         NULL,     -- floor_no
	`semi_basement`           TINYINT(1)  NULL,     -- semi_basement
	`rooftop`                 TINYINT(1)  NULL,     -- rooftop
	`built`                   INT         NULL,     -- built
	`room_count`              INT         NULL,     -- room_count
	`room_count_onepointfive` TINYINT(1)  NULL,     -- room_count_onepointfive
	`bathroom_count`          INT(11)     NULL,     -- bathroom_count
	`room_type`               TINYINT(4)  NULL     COMMENT '1오픈형/2분리형/3복층형/4사무용/5주거용/6일부층사용/7전층사용/8원룸원거실/9세미분리', -- room_type
	`empty`                   TINYINT(1)  NULL,     -- empty
	`type`                    TINYINT(4)  NULL     COMMENT '매매|전세|월세|단기임대', -- type
	`leased_area`             FLOAT       NULL,     -- leased_area
	`exclusive_area`          FLOAT       NULL,     -- exclusive_area
	`move_now`                TINYINT(1)  NULL,     -- move_now
	`move_modify`             TINYINT(1)  NULL,     -- move_modify
	`move_day`                VARCHAR(20) NULL,     -- move_day
	`brokerage`               INT(11)     NULL,     -- 새 컬럼5
	`sale_price`              INT(11)     NULL,     -- 새 컬럼6
	`standard_deposit`        INT(11)     NULL,     -- standard_deposit
	`charter_deposit`         INT(11)     NULL,     -- charter_deopsit
	`deposit`                 INT(11)     NULL,     -- deposit
	`monthly_rent`            INT(11)     NULL,     -- monthly_rent
	`maintenance_cost`        INT(11)     NULL,     -- maintenance_cost
	`deposit_modify`          TINYINT(1)  NULL,     -- deposit_modify
	`in_electronic_bill`      TINYINT(1)  NULL,     -- in_electronic_bill
	`in_gas_bill`             TINYINT(1)  NULL,     -- in_gas_bill
	`in_water_bill`           TINYINT(1)  NULL,     -- in_water_bill
	`in_internet_bill`        TINYINT(1)  NULL,     -- in_internet_bill
	`in_tv_bill`              TINYINT(1)  NULL,     -- in_tv_bill
	`in_clean_fee`            TINYINT(1)  NULL,     -- in_clean_fee
	`airconditioner`          TINYINT(1)  NULL,     -- airconditioner
	`refrigerator`            TINYINT(1)  NULL,     -- regrigerator
	`washer`                  TINYINT(1)  NULL,     -- washer
	`tv`                      TINYINT(1)  NULL,     -- tv
	`microwave`               TINYINT(1)  NULL,     -- microwave
	`induction`               TINYINT(1)  NULL,     -- induction
	`gasrange`                TINYINT(1)  NULL,     -- gasrange
	`bed`                     TINYINT(1)  NULL,     -- bed
	`built_in_closet`         TINYINT(1)  NULL,     -- built_in_closet
	`closet`                  TINYINT(1)  NULL,     -- closet
	`dressing_table`          TINYINT(1)  NULL,     -- dressing_table
	`veranda`                 TINYINT(1)  NULL,     -- veranda
	`security`                TINYINT(1)  NULL,     -- security
	`digital_doorlock`        TINYINT(1)  NULL,     -- digital_doorlock
	`other_option`            TEXT        NULL,     -- other_option
	`elevator`                TINYINT(1)  NULL,     -- elevator
	`animal`                  TINYINT(1)  NULL,     -- animal
	`parking`                 TINYINT(1)  NULL,     -- parking
	`parking_free`            TINYINT(1)  NULL,     -- parking_free
	`parking_count`           TINYINT(4)  NULL,     -- parking_count
	`parking_option`          VARCHAR(50) NULL,     -- parking_option
	`heating_type`            TINYINT(4)  NULL     COMMENT '0:중앙, 1:개별, 2:지역', -- heating_type
	`detail`                  TEXT        NULL,     -- detail
	`requirement`             TEXT        NULL,     -- requirement
	`movie_url`               VARCHAR(50) NULL,     -- movie_url
	`z_explain`               TEXT        NULL,     -- z_explain
	`contact_who_1`           VARCHAR(20) NULL,     -- contact_who_1
	`contact_phone_1`         VARCHAR(20) NULL,     -- contact_phone_1
	`contact_who_2`           VARCHAR(20) NULL,     -- contact_who_2
	`contact_phone_2`         VARCHAR(20) NULL,     -- contact_phone_2
	`contact_who_3`           VARCHAR(20) NULL,     -- contact_who_3
	`contact_phone_3`         VARCHAR(20) NULL,     -- contact_phone_3
	`contact_who_4`           VARCHAR(20) NULL,     -- contact_who_4
	`contact_phone_4`         VARCHAR(20) NULL,     -- contact_phone_4
	`confirm_date`            TIMESTAMP   NULL,     -- confirm_date
	`date`                    TIMESTAMP   NOT NULL DEFAULT 	CURRENT_TIMESTAMP, -- date
	`read_cnt`                INT(11)     NULL,     -- read_cnt
	`photo_open`              TINYINT(1)  NULL,     -- photo_open
	`snum`                    INT         NULL      -- 새 컬럼
);

-- specific_room_item
ALTER TABLE `specific_room_item`
	ADD CONSTRAINT `PK_specific_room_item` -- specific_room_item 기본키
		PRIMARY KEY (
			`no` -- no
		);

ALTER TABLE `specific_room_item`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- metro
CREATE TABLE `metro` (
	`no`   INT         NOT NULL, -- 새 컬럼
	`name` VARCHAR(10) NULL      -- 새 컬럼2
);

-- metro
ALTER TABLE `metro`
	ADD CONSTRAINT `PK_metro` -- metro 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `metro`
	MODIFY COLUMN `no` INT NOT NULL AUTO_INCREMENT;

-- role
CREATE TABLE `role` (
	`no`           INT(11) NOT NULL, -- 새 컬럼
	`user_no`      INT(11) NULL,     -- no
	`role_list_no` INT(11) NULL      -- 새 컬럼2
);

-- role
ALTER TABLE `role`
	ADD CONSTRAINT `PK_role` -- role 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `role`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- role_list
CREATE TABLE `role_list` (
	`no`   INT(11)     NOT NULL, -- 새 컬럼
	`role` VARCHAR(20) NULL      -- 새 컬럼2
);

-- role_list
ALTER TABLE `role_list`
	ADD CONSTRAINT `PK_role_list` -- role_list 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `role_list`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- lessor_phone_history
CREATE TABLE `lessor_phone_history` (
	`no`           INT(11)   NOT NULL, -- 새 컬럼
	`user_no`      INT(11)   NULL,     -- no
	`cart_list_no` INT(11)   NULL,     -- 새 컬럼2
	`room_item_no` INT(11)   NULL,     -- 새 컬럼4
	`date`         TIMESTAMP NOT NULL DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼3
);

-- lessor_phone_history
ALTER TABLE `lessor_phone_history`
	ADD CONSTRAINT `PK_lessor_phone_history` -- lessor_phone_history 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `lessor_phone_history`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- contract_complete
CREATE TABLE `contract_complete` (
	`no`           INT(11)    NOT NULL, -- 새 컬럼
	`user_no`      INT(11)    NULL,     -- no
	`room_item_no` INT(11)    NULL,     -- 새 컬럼2
	`check`        TINYINT(1) NULL,     -- 새 컬럼4
	`date`         TIMESTAMP  NOT NULL DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼3
);

-- contract_complete
ALTER TABLE `contract_complete`
	ADD CONSTRAINT `PK_contract_complete` -- contract_complete 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `contract_complete`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;

-- ask_room
CREATE TABLE `ask_room` (
	`no`            INT(11)     NOT NULL, -- 새 컬럼
	`user_no`       INT(11)     NULL,     -- no
	`room_item_no`  INT(11)     NULL,     -- 새 컬럼2
	`phone`         VARCHAR(50) NULL,     -- 새 컬럼3
	`possible_time` VARCHAR(50) NULL,     -- 새 컬럼4
	`date`          TIMESTAMP   NULL     DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼5
);

-- ask_room
ALTER TABLE `ask_room`
	ADD CONSTRAINT `PK_ask_room` -- ask_room 기본키
		PRIMARY KEY (
			`no` -- 새 컬럼
		);

ALTER TABLE `ask_room`
	MODIFY COLUMN `no` INT(11) NOT NULL AUTO_INCREMENT;