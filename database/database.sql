--------------------------------------------------------
--  文件已创建 - 星期六-九月-09-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence APPEAL_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##LJX"."APPEAL_ID_SEQ"  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 8 NOCACHE  ORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence APPEAL_IMG_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##LJX"."APPEAL_IMG_SEQ"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 8 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence COMMENT_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##LJX"."COMMENT_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence COMMODITY_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##LJX"."COMMODITY_ID_SEQ"  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 201 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence IND_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##LJX"."IND_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 81 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence NTC_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##LJX"."NTC_ID_SEQ"  MINVALUE 0 MAXVALUE 9999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence TMP_IMAGE_KEY_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##LJX"."TMP_IMAGE_KEY_SEQ"  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 441 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence USERIDSEQUENCE
--------------------------------------------------------

   CREATE SEQUENCE  "C##LJX"."USERIDSEQUENCE"  MINVALUE 1000000 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1000060 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence USER_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##LJX"."USER_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 3 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Table ADMINISTRATOR
--------------------------------------------------------

  CREATE TABLE "C##LJX"."ADMINISTRATOR" 
   (	"ADMIN_ID" NUMBER(10,0), 
	"ADMIN_ACCNUMBER" VARCHAR2(20 BYTE), 
	"ADMIN_PASSWORD" VARCHAR2(20 BYTE), 
	"ADMIN_STATE" VARCHAR2(1 BYTE)
   ) ;

   COMMENT ON COLUMN "C##LJX"."ADMINISTRATOR"."ADMIN_ID" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."ADMINISTRATOR"."ADMIN_PASSWORD" IS 'The table stores the MD5 value of the actual password';
   COMMENT ON COLUMN "C##LJX"."ADMINISTRATOR"."ADMIN_STATE" IS '0: Not logged in/1: Logged in';
--------------------------------------------------------
--  DDL for Table APPEAL
--------------------------------------------------------

  CREATE TABLE "C##LJX"."APPEAL" 
   (	"APP_ID" NUMBER(10,0), 
	"APP_MATTERS" NUMBER(1,0), 
	"APP_CONTENT" VARCHAR2(2000 BYTE), 
	"USER_ID" NUMBER(10,0), 
	"COM_ID" NUMBER(10,0), 
	"CMT_ID" NUMBER(10,0), 
	"APP_USERID" NUMBER(10,0), 
	"APP_TIME" DATE
   ) ;

   COMMENT ON COLUMN "C##LJX"."APPEAL"."APP_ID" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."APPEAL"."APP_MATTERS" IS '1:Inaccurate product information/2: food safety issues/3:Incomplete merchant qualifications/4:Malicious comments/5:Multiple refund swipes/6:multiple malicious comments';
   COMMENT ON COLUMN "C##LJX"."APPEAL"."USER_ID" IS 'FK, nullable, referenced from the user table';
   COMMENT ON COLUMN "C##LJX"."APPEAL"."COM_ID" IS 'FK, nullable, referenced from the community table';
   COMMENT ON COLUMN "C##LJX"."APPEAL"."CMT_ID" IS 'FK, nullable, referenced from comment table';
   COMMENT ON COLUMN "C##LJX"."APPEAL"."APP_USERID" IS 'FK, referenced from the user table';
--------------------------------------------------------
--  DDL for Table BROWSE
--------------------------------------------------------

  CREATE TABLE "C##LJX"."BROWSE" 
   (	"BRO_TIME_START" TIMESTAMP (6), 
	"BRO_TIME_END" TIMESTAMP (6), 
	"COM_ID" NUMBER(38,0), 
	"BROWSER_ID" NUMBER(10,0), 
	"WHETHER_BUY" NUMBER(1,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."BROWSE"."BRO_TIME_START" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."BROWSE"."COM_ID" IS 'PK,FK,"Referencing the com_ID attribute in the commodity table';
   COMMENT ON COLUMN "C##LJX"."BROWSE"."BROWSER_ID" IS 'PK,FK,Referencing the cus_ID attribute in the customer table';
   COMMENT ON COLUMN "C##LJX"."BROWSE"."WHETHER_BUY" IS '0:havn''t purchase/1:purchase';
--------------------------------------------------------
--  DDL for Table CHAT
--------------------------------------------------------

  CREATE TABLE "C##LJX"."CHAT" 
   (	"CHAT_TIME" TIMESTAMP (6), 
	"CUS_ID" NUMBER(10,0), 
	"STORE_ID" NUMBER(10,0), 
	"CHAT_CONTENT" VARCHAR2(2000 BYTE), 
	"CHAT_SENDER" NUMBER(1,0), 
	"CHAT_TYPE" NUMBER(10,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."CHAT"."CHAT_TIME" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."CHAT"."CUS_ID" IS 'PK,FK,Referencing the cus_ID attribute in the customer table';
   COMMENT ON COLUMN "C##LJX"."CHAT"."STORE_ID" IS 'PK,FK,Referencing the store_ID attribute in the store table';
   COMMENT ON COLUMN "C##LJX"."CHAT"."CHAT_SENDER" IS '0:customer/1:store';
   COMMENT ON COLUMN "C##LJX"."CHAT"."CHAT_TYPE" IS '0:text/1:image';
--------------------------------------------------------
--  DDL for Table COMMODITIES_CATEGORIES
--------------------------------------------------------

  CREATE TABLE "C##LJX"."COMMODITIES_CATEGORIES" 
   (	"COM_CATEGORY" VARCHAR2(20 BYTE)
   ) ;

   COMMENT ON COLUMN "C##LJX"."COMMODITIES_CATEGORIES"."COM_CATEGORY" IS 'The category of a commodity being available in value 	PK';
--------------------------------------------------------
--  DDL for Table COMMODITY
--------------------------------------------------------

  CREATE TABLE "C##LJX"."COMMODITY" 
   (	"COM_ID" NUMBER(38,0), 
	"COM_NAME" VARCHAR2(200 BYTE), 
	"COM_INTRODUCTION" VARCHAR2(2000 BYTE), 
	"COM_EXPIRATIONDATE" DATE, 
	"COM_UPLOADDATE" DATE, 
	"COM_LEFT" NUMBER(*,0), 
	"COM_RATING" NUMBER(5,3), 
	"STO_ID" NUMBER(10,0), 
	"COM_ORIPRICE" NUMBER(10,2), 
	"COM_STATUS" NUMBER(2,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."COMMODITY"."COM_ID" IS 'commodity ID,PK';
   COMMENT ON COLUMN "C##LJX"."COMMODITY"."COM_NAME" IS 'Commodity name administrator can be modified, the administrator remarks content fusion here';
   COMMENT ON COLUMN "C##LJX"."COMMODITY"."COM_INTRODUCTION" IS 'Merchants, administrators can be modified';
   COMMENT ON COLUMN "C##LJX"."COMMODITY"."COM_EXPIRATIONDATE" IS 'due date';
   COMMENT ON COLUMN "C##LJX"."COMMODITY"."COM_UPLOADDATE" IS 'On the shelf time';
   COMMENT ON COLUMN "C##LJX"."COMMODITY"."COM_LEFT" IS 'Commodity allowance';
   COMMENT ON COLUMN "C##LJX"."COMMODITY"."COM_RATING" IS 'Product score';
   COMMENT ON COLUMN "C##LJX"."COMMODITY"."STO_ID" IS 'Merchant ID, FK, quoted from the store table';
   COMMENT ON COLUMN "C##LJX"."COMMODITY"."COM_STATUS" IS '-1 for bad,0 for empty,1 for on sale';
--------------------------------------------------------
--  DDL for Table COMMODITY_CATEGORIES
--------------------------------------------------------

  CREATE TABLE "C##LJX"."COMMODITY_CATEGORIES" 
   (	"COM_ID" NUMBER(38,0), 
	"COM_CATEGORY" VARCHAR2(20 BYTE)
   ) ;

   COMMENT ON COLUMN "C##LJX"."COMMODITY_CATEGORIES"."COM_ID" IS 'PK, FK, referenced from store table
';
   COMMENT ON COLUMN "C##LJX"."COMMODITY_CATEGORIES"."COM_CATEGORY" IS 'FK, referenced from commodities_categories table

';
--------------------------------------------------------
--  DDL for Table COMMODITY_COMMENT
--------------------------------------------------------

  CREATE TABLE "C##LJX"."COMMODITY_COMMENT" 
   (	"CMT_ID" NUMBER(10,0), 
	"CMT_FATHER" NUMBER(10,0), 
	"CMT_CONTENT" VARCHAR2(2000 BYTE), 
	"CMT_TIME" DATE, 
	"COM_ID" NUMBER(38,0), 
	"USER_ID" NUMBER(10,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."COMMODITY_COMMENT"."CMT_ID" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."COMMODITY_COMMENT"."CMT_FATHER" IS '0: no parent comment/non-zero: parent comment ID*';
   COMMENT ON COLUMN "C##LJX"."COMMODITY_COMMENT"."COM_ID" IS 'FK, referenced from commodity table';
   COMMENT ON COLUMN "C##LJX"."COMMODITY_COMMENT"."USER_ID" IS 'FK, referenced from the user table';
--------------------------------------------------------
--  DDL for Table COMMODITY_IMAGE
--------------------------------------------------------

  CREATE TABLE "C##LJX"."COMMODITY_IMAGE" 
   (	"COM_ID" NUMBER(38,0), 
	"COM_IMAGE" VARCHAR2(100 BYTE)
   ) ;

   COMMENT ON COLUMN "C##LJX"."COMMODITY_IMAGE"."COM_ID" IS 'Commodity ID,PK';
   COMMENT ON COLUMN "C##LJX"."COMMODITY_IMAGE"."COM_IMAGE" IS 'Commodity Image, PK,store using relative path';
--------------------------------------------------------
--  DDL for Table COMMODITY_PRICE_CURVE
--------------------------------------------------------

  CREATE TABLE "C##LJX"."COMMODITY_PRICE_CURVE" 
   (	"COM_PC_TIME" DATE, 
	"COM_PC_PRICE" NUMBER(10,2), 
	"COM_ID" NUMBER(38,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."COMMODITY_PRICE_CURVE"."COM_PC_TIME" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."COMMODITY_PRICE_CURVE"."COM_ID" IS 'PK,FK, foreign keys depend on the com_ID of the commidity';
--------------------------------------------------------
--  DDL for Table CUSTOMER
--------------------------------------------------------

  CREATE TABLE "C##LJX"."CUSTOMER" 
   (	"CUS_ID" NUMBER(10,0), 
	"CUS_NICKNAME" VARCHAR2(20 BYTE), 
	"CUS_NOTES" VARCHAR2(2000 BYTE), 
	"CUS_PAYPASSWORD" VARCHAR2(20 BYTE), 
	"CUS_STATE" NUMBER(1,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."CUSTOMER"."CUS_ID" IS 'Customer ID / PK, FK, the same as the corresponding user_ID';
   COMMENT ON COLUMN "C##LJX"."CUSTOMER"."CUS_NICKNAME" IS 'nickname';
   COMMENT ON COLUMN "C##LJX"."CUSTOMER"."CUS_NOTES" IS 'Personal notes can be set up personally or modified by the administrator';
   COMMENT ON COLUMN "C##LJX"."CUSTOMER"."CUS_PAYPASSWORD" IS 'Storage in the payment password table is the md 5 value of the actual password';
   COMMENT ON COLUMN "C##LJX"."CUSTOMER"."CUS_STATE" IS 'Account status 0: closed / 1: normal';
--------------------------------------------------------
--  DDL for Table CUSTOMER_LOVE
--------------------------------------------------------

  CREATE TABLE "C##LJX"."CUSTOMER_LOVE" 
   (	"CUS_ID" NUMBER(10,0), 
	"COM_CATEGORY" VARCHAR2(20 BYTE), 
	"CUS_LOVE_WEIGHT" NUMBER(15,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."CUSTOMER_LOVE"."CUS_ID" IS 'Customer ID,PK, FK, is the same as the cus_ID in customer';
   COMMENT ON COLUMN "C##LJX"."CUSTOMER_LOVE"."COM_CATEGORY" IS 'Commodity category, PK, FK, is the same as com_category in the commodities_categories table';
   COMMENT ON COLUMN "C##LJX"."CUSTOMER_LOVE"."CUS_LOVE_WEIGHT" IS 'Favor label weight, recommendation algorithm to determine';
--------------------------------------------------------
--  DDL for Table FAVORITE
--------------------------------------------------------

  CREATE TABLE "C##LJX"."FAVORITE" 
   (	"COM_ID" NUMBER(38,0), 
	"CUS_ID" NUMBER(10,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."FAVORITE"."COM_ID" IS 'PK,FK,Referencing the com_ID attribute in the commodity table';
   COMMENT ON COLUMN "C##LJX"."FAVORITE"."CUS_ID" IS 'PK,FK,Referencing the cus_ID attribute in the customer table';
--------------------------------------------------------
--  DDL for Table INDENT
--------------------------------------------------------

  CREATE TABLE "C##LJX"."INDENT" 
   (	"IND_ID" NUMBER(10,0), 
	"IND_QUANTITY" NUMBER(*,0), 
	"IND_CREATIONTIME" DATE, 
	"IND_VERIFICATIONCODE" VARCHAR2(50 BYTE), 
	"IND_NOTES" VARCHAR2(2000 BYTE), 
	"IND_STATE" NUMBER(1,0), 
	"CUS_ID" NUMBER(10,0), 
	"COM_ID" NUMBER(38,0), 
	"IND_RTIME" DATE, 
	"IND_RNOTES" VARCHAR2(2000 BYTE), 
	"IND_MONEY" NUMBER(15,2), 
	"IND_RMONEY" NUMBER(15,2), 
	"IND_RATING" NUMBER(15,1)
   ) ;

   COMMENT ON COLUMN "C##LJX"."INDENT"."IND_ID" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."INDENT"."IND_STATE" IS '0: To be verified/1: Completed/2: Refunded';
   COMMENT ON COLUMN "C##LJX"."INDENT"."CUS_ID" IS 'FK, referenced from customer table';
   COMMENT ON COLUMN "C##LJX"."INDENT"."COM_ID" IS 'FK, referenced from the community table';
--------------------------------------------------------
--  DDL for Table NOTICE
--------------------------------------------------------

  CREATE TABLE "C##LJX"."NOTICE" 
   (	"NTC_ID" NUMBER(10,0), 
	"NTC_TIME" DATE, 
	"NTC_CONTENT" VARCHAR2(2000 BYTE), 
	"NTC_STATE" NUMBER(1,0), 
	"STO_ID" NUMBER(10,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."NOTICE"."NTC_ID" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."NOTICE"."NTC_STATE" IS '0: Not displayed/1: Displayed';
   COMMENT ON COLUMN "C##LJX"."NOTICE"."STO_ID" IS 'FK, referenced from store table';
--------------------------------------------------------
--  DDL for Table SCREENSHOT
--------------------------------------------------------

  CREATE TABLE "C##LJX"."SCREENSHOT" 
   (	"APP_ID" NUMBER(10,0), 
	"SCT_IMAGE" VARCHAR2(100 BYTE)
   ) ;

   COMMENT ON COLUMN "C##LJX"."SCREENSHOT"."APP_ID" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."SCREENSHOT"."SCT_IMAGE" IS 'PK,store using relative path';
--------------------------------------------------------
--  DDL for Table STORE
--------------------------------------------------------

  CREATE TABLE "C##LJX"."STORE" 
   (	"STO_ID" NUMBER(10,0), 
	"STO_NAME" VARCHAR2(20 BYTE), 
	"STO_INTRODUCTION" VARCHAR2(2000 BYTE), 
	"STO_LICENSEIMG" VARCHAR2(200 BYTE), 
	"STO_STATE" NUMBER(1,0)
   ) ;

   COMMENT ON COLUMN "C##LJX"."STORE"."STO_ID" IS 'Merchant ID, PK, FK, is the same as the corresponding user_ID';
   COMMENT ON COLUMN "C##LJX"."STORE"."STO_NAME" IS 'Merchant name';
   COMMENT ON COLUMN "C##LJX"."STORE"."STO_INTRODUCTION" IS 'Business profile, can be set by the businesses themselves, can also be modified by the administrator';
   COMMENT ON COLUMN "C##LJX"."STORE"."STO_LICENSEIMG" IS 'Business executive, according to the image table stored in the image relative path';
   COMMENT ON COLUMN "C##LJX"."STORE"."STO_STATE" IS '0: Closed / 1: Normal / 2: to be reviewed';
--------------------------------------------------------
--  DDL for Table STOREIMAGE
--------------------------------------------------------

  CREATE TABLE "C##LJX"."STOREIMAGE" 
   (	"STO_ID" NUMBER(10,0), 
	"STO_IMAGE" VARCHAR2(100 BYTE)
   ) ;

   COMMENT ON COLUMN "C##LJX"."STOREIMAGE"."STO_ID" IS 'PK';
   COMMENT ON COLUMN "C##LJX"."STOREIMAGE"."STO_IMAGE" IS 'PK, stored as a relative path';
--------------------------------------------------------
--  DDL for Table STORE_CATEGORIES
--------------------------------------------------------

  CREATE TABLE "C##LJX"."STORE_CATEGORIES" 
   (	"STORE_ID" NUMBER(10,0), 
	"COM_CATEGORY" VARCHAR2(20 BYTE)
   ) ;

   COMMENT ON COLUMN "C##LJX"."STORE_CATEGORIES"."STORE_ID" IS 'Merchant IDPK, FK, quoted from the store table';
   COMMENT ON COLUMN "C##LJX"."STORE_CATEGORIES"."COM_CATEGORY" IS 'Product category FK, quoted from table commodities_categories';
--------------------------------------------------------
--  DDL for Table USERS
--------------------------------------------------------

  CREATE TABLE "C##LJX"."USERS" 
   (	"USER_PHONE" VARCHAR2(20 BYTE), 
	"USER_PASSWORD" VARCHAR2(20 BYTE), 
	"USER_ADDRESS" VARCHAR2(100 BYTE), 
	"USER_STATE" NUMBER(1,0), 
	"USER_REGTIME" DATE, 
	"USER_TYPE" NUMBER(1,0), 
	"USER_ID" NUMBER(10,0), 
	"USER_BALANCE" NUMBER(15,2)
   ) ;

   COMMENT ON COLUMN "C##LJX"."USERS"."USER_PHONE" IS 'Phone number, not repeatable, unique';
   COMMENT ON COLUMN "C##LJX"."USERS"."USER_PASSWORD" IS 'Login password, the table stores the md 5 value of the actual password';
   COMMENT ON COLUMN "C##LJX"."USERS"."USER_ADDRESS" IS 'Geographic location, separating strings of geographic information by semicolons, and processing with functions for queries and operation';
   COMMENT ON COLUMN "C##LJX"."USERS"."USER_STATE" IS 'Login status, 0: Not login / 1: Login';
   COMMENT ON COLUMN "C##LJX"."USERS"."USER_REGTIME" IS 'registration time';
   COMMENT ON COLUMN "C##LJX"."USERS"."USER_TYPE" IS 'User type, 0: Customer / 1: merchant';
   COMMENT ON COLUMN "C##LJX"."USERS"."USER_ID" IS 'PK';
--------------------------------------------------------
--  DDL for View INDENT_VIEW
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##LJX"."INDENT_VIEW" ("IND_ID", "IND_QUANTITY", "IND_CREATIONTIME", "IND_VERIFICATIONCODE", "IND_NOTES", "IND_STATE", "CUS_ID", "COM_ID", "IND_RTIME", "IND_RNOTES", "IND_MONEY", "IND_RMONEY", "IND_RATING") AS 
  SELECT "IND_ID","IND_QUANTITY","IND_CREATIONTIME","IND_VERIFICATIONCODE","IND_NOTES","IND_STATE","CUS_ID","COM_ID","IND_RTIME","IND_RNOTES","IND_MONEY","IND_RMONEY","IND_RATING" FROM C##LJX.INDENT
;
REM INSERTING into C##LJX.ADMINISTRATOR
SET DEFINE OFF;
Insert into C##LJX.ADMINISTRATOR (ADMIN_ID,ADMIN_ACCNUMBER,ADMIN_PASSWORD,ADMIN_STATE) values (1,null,'123456','1');
REM INSERTING into C##LJX.APPEAL
SET DEFINE OFF;
Insert into C##LJX.APPEAL (APP_ID,APP_MATTERS,APP_CONTENT,USER_ID,COM_ID,CMT_ID,APP_USERID,APP_TIME) values (6,5,'恶意退款',1000017,null,null,1000004,to_date('07-9月 -23','DD-MON-RR'));
Insert into C##LJX.APPEAL (APP_ID,APP_MATTERS,APP_CONTENT,USER_ID,COM_ID,CMT_ID,APP_USERID,APP_TIME) values (7,4,'该用户似乎恶意评论',null,82,24,1000017,to_date('07-9月 -23','DD-MON-RR'));
Insert into C##LJX.APPEAL (APP_ID,APP_MATTERS,APP_CONTENT,USER_ID,COM_ID,CMT_ID,APP_USERID,APP_TIME) values (1,5,'恶意退款',1000017,null,null,1000004,to_date('04-9月 -23','DD-MON-RR'));
Insert into C##LJX.APPEAL (APP_ID,APP_MATTERS,APP_CONTENT,USER_ID,COM_ID,CMT_ID,APP_USERID,APP_TIME) values (2,2,'拉肚子了',null,10,null,1000018,to_date('05-9月 -23','DD-MON-RR'));
Insert into C##LJX.APPEAL (APP_ID,APP_MATTERS,APP_CONTENT,USER_ID,COM_ID,CMT_ID,APP_USERID,APP_TIME) values (3,2,'又拉肚子了',null,10,null,1000018,to_date('05-9月 -23','DD-MON-RR'));
Insert into C##LJX.APPEAL (APP_ID,APP_MATTERS,APP_CONTENT,USER_ID,COM_ID,CMT_ID,APP_USERID,APP_TIME) values (4,1,'又双拉肚子了',null,10,null,1000018,to_date('05-9月 -23','DD-MON-RR'));
Insert into C##LJX.APPEAL (APP_ID,APP_MATTERS,APP_CONTENT,USER_ID,COM_ID,CMT_ID,APP_USERID,APP_TIME) values (5,5,'临期退款，恶意至极',1000017,null,null,1000004,to_date('05-9月 -23','DD-MON-RR'));
REM INSERTING into C##LJX.BROWSE
SET DEFINE OFF;
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.50.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.56.17.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.57.22.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.57.33.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.57.47.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.57.49.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),144,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.57.51.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.57.52.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),144,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.57.54.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.58.00.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),83,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.58.19.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.58.22.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.58.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.58.28.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),145,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.55.42.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 06.00.08.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 06.05.50.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 06.05.54.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),108,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 06.06.04.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 06.06.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 06.09.35.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 06.09.38.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),142,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.13.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.17.36.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.17.51.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.17.53.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.35.10.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.35.45.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.37.59.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.39.05.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.39.13.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.39.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.39.18.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.39.19.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),5,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.39.20.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.39.28.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.39.29.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.39.30.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.39.31.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.39.38.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),148,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 07.56.16.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 07.56.17.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),148,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.04.44.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.04.52.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.05.06.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.05.09.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),143,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.05.23.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.05.32.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.05.34.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.05.48.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),143,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.06.42.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.06.51.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),108,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.36.25.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.36.30.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.36.39.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.36.42.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.36.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.36.47.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.36.48.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.36.51.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.37.06.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.38.07.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.46.44.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.46.46.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.48.50.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.48.55.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),98,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.54.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.54.31.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),38,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.54.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.55.05.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.55.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.56.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.56.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.56.21.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.56.25.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.56.31.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.56.38.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.57.02.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.57.05.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.57.31.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),144,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.57.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.58.04.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),144,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 08.58.18.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 08.58.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),144,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 02.37.46.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 02.37.56.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),148,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 03.15.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 03.15.27.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),108,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 03.15.44.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 03.15.48.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),169,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 03.15.56.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 03.16.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),169,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 03.16.07.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 03.16.10.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),169,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 03.16.13.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 03.16.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),105,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 03.16.28.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 03.16.32.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),105,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 03.16.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 03.16.42.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),61,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 03.27.55.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 03.28.59.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('09-9月 -23 04.09.46.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-9月 -23 04.09.49.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),154,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 07.53.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 07.53.44.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),52,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 07.53.58.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 07.54.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),4,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 07.54.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 07.54.34.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),49,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 07.55.57.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 07.56.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),49,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 07.57.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 07.57.49.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),8,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 08.00.06.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 08.00.09.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),8,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 10.19.39.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 10.19.48.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),7,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.30.43.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.30.46.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),9,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.31.03.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.31.10.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),9,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.31.14.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.31.17.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.32.21.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.32.23.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.32.30.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.32.32.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.32.34.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.32.36.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.33.02.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.33.04.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.33.07.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.33.11.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.33.12.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.33.19.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.33.26.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.33.29.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.33.32.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.33.35.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),36,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.33.40.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.33.41.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),36,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.33.43.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.33.44.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),19,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.34.17.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.34.19.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.34.09.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.34.30.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),19,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.35.00.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.35.01.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),10,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.35.19.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.35.21.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),30,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.35.24.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.37.48.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),30,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.37.51.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.38.28.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),30,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.40.18.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.40.19.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),82,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.40.28.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.40.29.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),19,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.42.13.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.42.18.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.42.16.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.42.22.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.47.27.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.47.43.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),10,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 02.00.53.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 02.00.55.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),19,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 02.00.57.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 02.00.58.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),19,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 02.01.38.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 02.01.39.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),19,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 02.01.46.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 02.01.47.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),94,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 04.24.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 04.25.08.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 04.25.41.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 04.25.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 04.25.50.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 04.25.59.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 04.27.13.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 04.28.06.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 04.28.12.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 04.28.13.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 05.41.28.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 05.41.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 06.33.58.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 06.34.21.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),94,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 06.36.35.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 06.36.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),94,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 06.37.08.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 06.39.31.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),94,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 07.22.50.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 07.24.36.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),94,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 07.25.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 07.25.17.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),6,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 07.40.49.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 07.40.56.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 07.44.19.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 07.53.32.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 07.53.53.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 07.54.47.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 07.55.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 08.00.54.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 08.01.47.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 08.01.50.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),6,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 08.01.51.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 08.01.52.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),5,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 08.05.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 08.05.45.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),26,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 08.06.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 08.06.09.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),26,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 08.09.09.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 08.09.16.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),26,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 08.10.39.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 08.10.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 08.11.04.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 08.11.35.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),25,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 08.11.52.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 08.56.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),25,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 09.19.12.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 09.19.17.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),144,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 09.27.52.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 09.28.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 09.28.08.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 10.08.35.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),41,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 10.11.22.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 10.11.23.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),144,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 10.14.12.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 10.14.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),6,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 10.14.18.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 10.15.42.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 10.15.51.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 10.16.06.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),101,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 10.16.34.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 10.16.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),36,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 10.16.42.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 10.16.44.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),26,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.08.46.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.08.49.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.09.28.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.09.30.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.13.37.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.13.40.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.13.49.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.13.50.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.14.20.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.14.22.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.16.03.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.16.06.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('07-9月 -23 01.16.42.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('07-9月 -23 01.16.45.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 10.39.36.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 10.39.40.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 10.39.56.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 10.40.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 10.40.57.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 10.40.59.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),25,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 10.44.33.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 10.48.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),25,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 10.49.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 10.49.09.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 10.50.50.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 10.51.38.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.16.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.18.12.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),4,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.24.07.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.24.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.24.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.24.46.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),11,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.24.47.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.24.47.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),11,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.24.51.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.24.53.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.24.55.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.24.55.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.24.57.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.25.00.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),12,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.25.08.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.25.11.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.28.13.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.28.42.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),23,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.46.59.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.47.23.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),25,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('04-9月 -23 11.49.47.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('04-9月 -23 11.49.56.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),25,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 12.10.42.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 12.10.50.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),9,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 12.10.54.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 12.11.21.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),5,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 12.11.30.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 12.11.41.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),25,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 12.11.52.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 12.12.11.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 12.40.16.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 12.40.21.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),23,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 12.46.52.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 12.47.10.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),10,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.06.20.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.06.43.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),7,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.06.46.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.07.45.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),8,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.07.52.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.07.59.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),6,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.08.00.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.08.01.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),6,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.08.07.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.08.10.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),5,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.09.26.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.09.31.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),4,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.11.24.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.11.35.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),63,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.11.43.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.11.58.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),43,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.17.37.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.17.42.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),6,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.20.05.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.20.28.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),50,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 01.25.59.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 01.26.00.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),50,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.17.21.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.17.24.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),52,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.17.39.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.18.03.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),43,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.24.38.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.24.55.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),14,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.33.08.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.33.19.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),40,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.39.31.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.39.35.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),42,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.49.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.49.30.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.50.44.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.50.47.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),63,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.50.51.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.51.07.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),63,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.51.11.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.51.16.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),38,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('05-9月 -23 11.57.55.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('05-9月 -23 11.58.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),6,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.00.59.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.01.01.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),6,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.01.18.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.01.21.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),38,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.06.36.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.06.45.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),12,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.24.48.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.24.59.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),92,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.26.00.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.26.05.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.27.08.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.27.12.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),19,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.27.40.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.33.12.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),19,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.33.33.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.33.35.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),19,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.51.16.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.51.27.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),9,1000019,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.56.20.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.56.25.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),41,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 12.56.27.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 12.56.32.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),5,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 11.22.08.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 11.22.15.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),86,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 02.23.13.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 02.23.14.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),75,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 02.23.25.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 02.23.27.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),22,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 02.23.45.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 02.23.48.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),41,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 02.23.49.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 02.23.50.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),41,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('06-9月 -23 02.29.20.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('06-9月 -23 02.29.25.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),82,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 01.50.04.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 01.50.06.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),144,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 02.19.58.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 02.20.02.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),59,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 02.30.52.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 02.30.56.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),144,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 03.16.42.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 03.16.57.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),43,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 03.37.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 03.37.18.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 03.37.23.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 03.37.29.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),5,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 03.37.31.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 03.37.32.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),5,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 03.37.33.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 03.37.38.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),108,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 03.37.42.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 03.37.46.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),143,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 03.59.07.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 03.59.11.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.11.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.11.46.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),15,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.11.54.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.12.02.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),151,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.12.20.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.13.39.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),108,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.14.21.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.14.30.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),154,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.26.41.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.26.48.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.26.51.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.26.55.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.26.57.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.26.58.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.27.39.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.27.44.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.57.29.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.57.35.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.57.43.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.57.46.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),9,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.57.49.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 04.57.56.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),142,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 04.58.41.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.02.50.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),150,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.03.17.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.03.28.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),10,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.06.18.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.07.15.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.07.16.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.07.17.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.10.44.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.10.49.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.10.53.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.10.55.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.11.58.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.12.09.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),154,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.12.55.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.13.04.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.13.19.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.13.22.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.13.35.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.13.52.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),142,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.13.45.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.21.28.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.21.37.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.21.39.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.22.45.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.22.46.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),46,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.22.56.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.23.01.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.25.22.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.25.44.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),5,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.29.49.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.31.27.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.35.10.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.35.16.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),143,1000008,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.35.55.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.35.58.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.44.18.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.44.21.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),152,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.47.02.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.47.04.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),65,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.47.06.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.47.09.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),35,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.47.11.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.48.09.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),62,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.48.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.48.30.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.48.39.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.48.58.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000017,0);
Insert into C##LJX.BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) values (to_timestamp('08-9月 -23 05.49.11.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-9月 -23 05.49.17.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),153,1000018,0);
REM INSERTING into C##LJX.CHAT
SET DEFINE OFF;
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 07.18.46.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000018,1000004,'所以说请问你们店里这款牛奶质量到底怎么样？',0,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 08.35.23.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000004,'这个东西真的好吃么？你确定么？',0,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('07-9月 -23 04.20.04.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000004,'hallo~',0,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('07-9月 -23 04.20.09.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000004,'你好~
',1,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('07-9月 -23 04.20.14.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000004,'chat_image\d75fce9a-086e-487a-8fb4-2e596744a72b.png',0,1);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('07-9月 -23 09.55.02.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'   ',0,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('04-9月 -23 10.42.22.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'这猕猴桃保熟吗？QAQ',0,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('04-9月 -23 10.42.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'chat_image\e7608ab8-10bb-4587-a0e1-cda99aeb989d.jpg',0,1);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('04-9月 -23 11.19.05.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'亲，我们这边都是临期的猕猴桃，当然是熟透的
',1,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('04-9月 -23 11.19.48.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'请问您想要中果，大果还是特大果呢',1,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('04-9月 -23 11.21.10.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'属于是罗老师快乐果了',0,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('06-9月 -23 12.42.58.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000005,'chat_image\3a717314-23df-49f0-8179-7838cbac4cd0.png',0,1);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('06-9月 -23 12.42.59.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000005,'chat_image\5447976c-c329-4a1d-a79f-5239125af8ac.png',0,1);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('06-9月 -23 12.44.42.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000005,'chat_image\9d3e28ff-e86b-4650-b6b6-f72440f6e6dd.png',0,1);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('06-9月 -23 12.45.16.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000005,'chat_image\4663205a-cf06-4940-be35-f6d8f499556e.png',0,1);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('06-9月 -23 12.45.31.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000005,'chat_image\d0ce8762-8b43-454f-9c9e-0f77cd496fc6.png',0,1);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 12.29.25.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000004,'hello
',1,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 12.29.43.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000004,'qwq
',1,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 12.29.54.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'你好~',1,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 12.30.00.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000004,'0.0',1,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 12.30.35.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊',1,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 12.30.47.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'亲，我们这边都是临期的猕猴桃，当然是熟透的',1,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 12.38.19.000000000 上午','DD-MON-RR HH.MI.SSXFF AM'),1000017,1000010,'你好呀~',0,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 04.27.24.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000018,1000004,'请问你们店里这款牛奶质量怎么样？',0,0);
Insert into C##LJX.CHAT (CHAT_TIME,CUS_ID,STORE_ID,CHAT_CONTENT,CHAT_SENDER,CHAT_TYPE) values (to_timestamp('08-9月 -23 05.45.35.000000000 下午','DD-MON-RR HH.MI.SSXFF AM'),1000018,1000004,'我想买回去给我孩子吃',0,0);
REM INSERTING into C##LJX.COMMODITIES_CATEGORIES
SET DEFINE OFF;
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('保健品');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('其他');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('果品');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('熟食');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('肉制品');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('蔬菜');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('蛋奶');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('调味品');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('零食');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('面点');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('预制菜');
Insert into C##LJX.COMMODITIES_CATEGORIES (COM_CATEGORY) values ('饮料');
REM INSERTING into C##LJX.COMMODITY
SET DEFINE OFF;
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (161,'乐事薯片','乐事薯片经典原切40g袋原味红烩番茄多口味可选膨化零食小吃办公室',to_date('11-9月 -23','DD-MON-RR'),to_date('08-9月 -23','DD-MON-RR'),19,0,1000004,4.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (162,'甘师傅一根葱','甘师傅一根葱零食小吃休闲食品90后童年怀旧小卖部膨化薯条大礼包10袋',to_date('13-9月 -23','DD-MON-RR'),to_date('08-9月 -23','DD-MON-RR'),7,0,1000004,9.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (163,'乐事奇多妙脆角','乐事奇多妙脆角40g*10袋尖角脆儿童怀旧小零食膨化休闲食品大礼包',to_date('12-9月 -23','DD-MON-RR'),to_date('08-9月 -23','DD-MON-RR'),55,0,1000004,13.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (164,'伊利原味豆奶','伊利植选高蛋白植物奶原味豆奶315ML10瓶整箱临期无蔗糖燕麦奶',to_date('30-9月 -23','DD-MON-RR'),to_date('08-9月 -23','DD-MON-RR'),23,0,1000004,29.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (165,'卫龙卤蛋78度溏心','卫龙卤蛋78度溏心糖心即食熟鸡蛋盐焗宿舍早餐夜宵休闲小吃零食品',to_date('18-9月 -23','DD-MON-RR'),to_date('08-9月 -23','DD-MON-RR'),1,0,1000004,2.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (166,'乳酸菌小口袋面包','乳酸菌小口袋面包整箱早餐健康零食水果夹心菠萝吐司紫米蛋糕食品',to_date('28-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),16,0,1000004,21.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (167,'芒果干奶糕','芒果控一定要试试哇！芒果干奶糕 软糯奶砖 健康小零食 南沫先生',to_date('14-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),1,0,1000004,8.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (168,'突尼斯软籽石榴','突尼斯软籽石榴2斤新鲜当季水果四川会理红宝石无籽石榴整箱包邮',to_date('14-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),17,0,1000004,6.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (169,'福建平和红心柚','福建平和红心柚子蜜柚10斤新鲜水果当季葡萄整箱包邮三红肉叶琯溪',to_date('15-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),4,0,1000004,11.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (170,'巧克力流心月饼','巧克力流心月饼广式奶黄流心中秋节礼盒装送礼蛋黄酥糕点零食',to_date('24-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),14,0,1000004,29.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (171,'唯甄豆奶','【开学季大促】豆本豆唯甄豆奶红枣原味250ml营养早餐奶饮品',to_date('24-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),68,0,1000004,4.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (172,'巨峰葡萄','浦东巨峰新鲜葡萄王鲜果盒装应当季水果现摘现发孕妇整箱大果包邮',to_date('13-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),1,0,1000004,0.01,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (173,'秋月梨','正宗秋月梨山东莱阳新鲜梨子10斤当季水果现摘现发雪蜜梨整箱包邮',to_date('14-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),9,0,1000004,48.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (174,'徐香猕猴桃','陕西眉县徐香猕猴桃5斤新鲜当季水果整箱包邮绿心中秋礼盒奇异果',to_date('13-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),57,0,1000004,36.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (175,'AD钙奶','好喝又营养
哇哈哈乳酸奶饮料',to_date('18-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),1,0,1000004,2.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (176,'麒麟果','海南山野燕窝果麒麟果应季新鲜水果非黄色皮火龙果热带顺丰包邮',to_date('12-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),1,0,1000004,15.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (177,'舒可曼白砂糖','舒可曼白砂糖400g袋盖设计碳化糖烘焙糖浆糖水细白糖冲饮调味',to_date('29-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),18,0,1000004,6.6,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (178,'中国香港出前一丁泡面','中国香港出前一丁多口味12袋方便面火腿好搭档 1件装',to_date('12-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),8,0,1000004,45,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (179,'正宗广西小米蕉香蕉','正宗广西小米蕉香蕉10斤新鲜水果整箱当季鲜苹果蕉自然熟粉蕉包邮',to_date('13-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),487,0,1000004,9.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (180,'薯愿薯片','好丽友薯愿薯片小包装非油炸蜂蜜牛奶黄瓜味散装零食小吃休闲食品',to_date('24-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),76,0,1000004,5.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (181,'苦菊','苦菊生菜新鲜蔬菜沙拉食材包邮苦苣狗牙菜西餐健身轻食苦细叶生菜',to_date('11-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),1,0,1000004,7.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (182,'乳酸菌饮品','乳酸菌饮品益生菌早餐酸奶100ml4瓶儿时怀旧美味乳酸菌饮料整箱',to_date('27-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),1,0,1000004,13.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (183,'新鲜薄皮辣椒','现摘现发新鲜薄皮辣椒小皱皮特辣超辣青椒时令蔬菜现摘现发农家3/5斤',to_date('14-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),6,0,1000004,4.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (184,'椒盐粉','椒盐粉撒料家用小包装烧烤烤肉油炸调料瓶装低轻脂卡西餐牛排香料',to_date('10-10月-23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),1,0,1000004,10.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (185,'梅菜扣肉加热即食','食得迷梅菜扣肉加热即食半成品家用预制菜料理包快手菜旗舰店',to_date('15-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),9,0,1000006,18.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (186,'水果胡萝卜','红萝卜水果胡萝卜新鲜红罗卜蔬菜2斤生吃水果型脆甜当季',to_date('11-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),1,0,1000006,7.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (187,'娃娃菜小白菜','云南新鲜现摘农家露天种植娃娃菜小白菜黄心蔬菜火锅食材当季蔬菜3斤',to_date('10-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),6,0,1000006,7.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (188,'爱媛38号果冻橙','爱媛38号果冻橙新鲜橙子水果当季整箱10斤四川应季甜橙子',to_date('20-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),45,0,1000006,32.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (189,'维他命水','农夫山泉力量帝维他命水500ml瓶整箱批发特价维生素VC功能饮料',to_date('27-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),153,0,1000009,6.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (190,'手撕碳烤鱿鱼条','手撕碳烤鱿鱼条鱿鱼丝海鲜即食零食网红爆款休闲小吃解馋鱿鱼干片',to_date('21-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),17,0,1000009,25.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (191,'进口日本森永岩盐太妃糖','进口日本森永岩盐太妃糖海盐焦糖糖果咖啡巧克力牛奶喜糖高端零食10颗
',to_date('25-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),18,0,1000009,16,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (192,'黑爵士焦糖花生夹心巧克力','黑爵士焦糖花生夹心巧克力500g俄罗斯进口食品KDV糖果休闲零食',to_date('26-9月 -23','DD-MON-RR'),to_date('09-9月 -23','DD-MON-RR'),19,0,1000009,21.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (6,'舒可曼白砂糖','舒可曼白砂糖400g袋盖设计碳化糖烘焙糖浆糖水细白糖冲饮调味',to_date('05-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),8,0,1000004,6.6,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (7,'出前一丁方便面','中国香港出前一丁多口味12袋方便面火腿好搭档 1件装',to_date('06-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),3,0,1000004,52,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (4,'三只松鼠芒果干','三只松鼠芒果干水果干60g果干蜜饯休闲零食网红小吃芒果蜜饯果脯',to_date('06-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),2,0,1000004,11,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (5,'巧克力流心月饼','巧克力流心月饼广式奶黄流心中秋节礼盒装送礼蛋黄酥糕点零食',to_date('09-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),16,0,1000004,8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (8,'双汇王中王火腿肠','吴京推荐双汇王中王火腿肠香肠肉类零食小吃泡面拍档即食270gx2袋',to_date('11-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),70,0,1000004,14.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (9,'菠萝啤','湛航 新日期0酒精菠萝啤320ml整箱12罐碳酸饮料果味汽水',to_date('10-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),0,0,1000005,26,0);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (10,'五香带鱼罐头','良时海 五香带鱼罐头110g/罐 *3罐 海鲜熟食 即食下饭下酒菜 罐头带鱼',to_date('07-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),5,2,1000005,21.6,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (11,'冰糖红西柚','康师傅冰糖红西柚330ml，清甜解渴，货真价实',to_date('04-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),21,0,1000005,2.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (12,'咖啡专用调制乳','光明咖啡专用调制乳1L 花式咖啡打奶泡奶茶西点甜品用牛奶',to_date('06-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),1,0,1000005,19.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (13,'锦绣黄桃 ','山东锦绣黄桃 新鲜水果 净重4.5斤 香甜可口 坏果包赔 西沛',to_date('05-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),1,0,1000005,0.01,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (14,'辣椒','新鲜辣椒韩国青阳瓜里美人椒小杭椒辣妹子农产品山东寿光蔬菜半斤',to_date('06-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),0,0,1000006,9.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (15,'红心柚子','红心柚子新鲜水果葡萄香柚三红柚琯管溪密柚红肉福建平和蜜柚',to_date('08-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),36,0,1000006,17.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (16,'红心柚','红心柚子新鲜水果葡萄香柚三红柚琯管溪密柚红肉福建平和蜜柚',to_date('04-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),1,0,1000006,17.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (17,'土豆','恩施小土豆10斤包邮新鲜士豆黄心批发富硒蔬菜迷你马铃薯湖北洋芋',to_date('06-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),3,0,1000006,11.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (18,'小番茄','顺丰山东千禧小番茄5斤超甜时令水果圣女果农家特产小西红柿蔬菜3斤',to_date('11-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),7,0,1000006,20.7,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (19,'比利时lotus焦糖饼干','比利时lotus和情缤咖时焦糖饼干休闲进口下午茶零食单独小包装',to_date('10-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),5,0,1000009,29.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (20,'提拉米苏蛋糕','提拉米苏蛋糕俄罗斯正宗风味迷你小包装早餐整箱奶油零食品3枚',to_date('05-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),57,0,1000009,7.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (21,'海牌海苔','海牌海苔韩国进口零食大礼包芥末味即食儿童寿司包饭烤紫菜片 8包装',to_date('04-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),9,0,1000009,8.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (22,'夹心巧克力','黑爵士焦糖花生夹心巧克力500g俄罗斯进口食品KDV糖果休闲零食',to_date('06-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),7,0,1000009,21.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (23,'手撕牛肉干','源口庄园美洲手撕牛肉干500g沙爹味内蒙古风味炭烤牛肉干休闲零食',to_date('05-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),0,0,1000009,33,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (24,'进口纯牛奶','laciate卢森牧场波兰进口全脂纯牛奶学生高钙500ml',to_date('08-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),68,0,1000009,5.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (25,'猕猴桃','陕西周至猕猴桃奇异果新鲜当季孕妇水果绿心弥猴桃非徐香整箱',to_date('04-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),3,2.5,1000010,7.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (26,'火锅丸子','潮汕火锅丸子套餐正宗手打牛肉丸牛筋丸墨鱼丸鱼皮饺烧烤火锅食材',to_date('07-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),7,0,1000010,14.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (27,'速冻饺子','大娘水饺速冻饺子猪肉素三鲜手工包白菜荠菜虾仁牛肉速食早餐蒸煎',to_date('04-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),7,0,1000010,44,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (28,'鸭腿','鸭腿开袋即食盐焗麻辣鸡腿夜宵充饥速食熟食小吃零食解馋',to_date('09-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),57,0,1000010,5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (29,'鹌鹑蛋','盐津铺子鹌鹑蛋小包装盐焗卤蛋熟食办公室休闲解馋小吃零食品批发30颗',to_date('08-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),31,0,1000010,12.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (30,'牛蛙','华靖牛蛙下酒菜下饭菜卤味熟食巨好吃的零食开袋即食网红小吃',to_date('08-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),14,0,1000010,5.01,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (31,'奥尔良鸡翅','三只松鼠奥尔良鸡翅中130g*1袋真空熟食鸡腿卤味即食休闲零食小吃 1件装',to_date('10-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),26,0,1000010,15.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (32,'山椒凤爪','良品铺子山椒凤爪50g卤味鸡爪熟食',to_date('11-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),168,0,1000010,2,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (33,'蜜谷果汁茶','香飘飘meco蜜谷果汁茶400ml网红果汁饮品密谷茶饮料',to_date('06-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),1,0,1000010,6.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (34,'冠生园蜂蜜','冠生园蜂蜜 蜂蜜便携尖嘴挤压瓶蜂蜜小包装瓶早餐官方旗舰店正品',to_date('07-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),4,0,1000010,17.6,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (35,'蓝莓果酱','0脂肪蓝莓果酱蔓越莓果酱大颗粒涂抹面包酱卡即食早餐夹吐司酱',to_date('08-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),7,0,1000010,12.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (36,'爆爆珠','广禧芒果爆爆珠2.5斤草莓马蹄爆爆蛋珍珠奶茶店专用冰粉小配料',to_date('07-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),1,0,1000010,18.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (37,'蒜蓉生蚝','蒜蓉生蚝官方旗舰店牡蛎罐装海鲜熟食即食海蛎子肉新鲜零食下饭菜',to_date('08-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),22,0,1000010,9.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (38,'海底捞自热米饭','海底捞自热米饭自热锅煲仔饭方便速食食品即食自热快餐免煮饭',to_date('05-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),1,0,1000010,8.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (39,'口袋面包','乳酸菌小口袋面包整箱早餐健康零食水果夹心菠萝吐司紫米蛋糕食品500g约20袋',to_date('06-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),4,0,1000004,22.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (40,'芋泥肉松三明治','芋泥肉松三明治彩虹香芋无边吐司早餐面包整箱网红小零食休闲食品',to_date('04-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),3,0,1000004,3.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (41,'来伊份蛋黄酥','来伊份蛋黄酥55零食蛋糕小吃面包充饥早餐食品传统中式糕点',to_date('07-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),1345,0,1000004,2.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (42,'紫薯玫瑰饼','滇二娃农科院鲜花饼云南特产玫瑰花早餐面包整箱零食小吃休闲食品10枚装',to_date('04-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),7,0,1000004,12.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (43,'AD钙奶','【娃哈哈官方】AD钙奶酸甜牛奶饮品220g瓶整箱装饮料哇哈哈',to_date('08-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),62,3,1000004,2.4,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (44,'茉莉清茶','康师傅茉莉清茶300ml整箱迷你小瓶装清茶饮料夏季解渴饮品',to_date('05-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),7,0,1000004,1.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (45,'益生菌','乳酸菌饮品益生菌早餐酸奶100ml瓶儿时怀旧美味乳酸菌饮料整箱',to_date('04-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),8,0,1000004,5.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (46,'红枣豆奶','【开学季大促】豆本豆唯甄豆奶红枣原味250ml营养早餐奶饮品',to_date('09-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),12,0,1000004,4.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (47,'椒盐粉','椒盐粉撒料家用小包装烧烤烤肉油炸调料瓶装低轻脂卡西餐牛排香料',to_date('06-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),3,0,1000004,9.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (48,'沙拉酱','丘比沙拉汁焙煎芝麻口味蔬菜水果沙拉汁寿司凉拌色拉酱油醋汁',to_date('05-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),8,0,1000004,12.1,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (49,'薯愿薯片','好丽友薯愿薯片小包装非油炸蜂蜜牛奶黄瓜味散装零食小吃休闲食品',to_date('07-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),75,0,1000004,3.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (50,'小黄瓜','新鲜现摘水果小黄瓜山东旱黄瓜生吃孕妇蔬菜脆嫩青瓜1斤整箱',to_date('04-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),8,0,1000006,7.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (51,'紫薯','紫薯新鲜板栗红薯番薯地瓜蜜薯糖心3斤山芋烟薯香薯蔬菜农家自种',to_date('07-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),6,0,1000006,9.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (52,'水果胡萝卜','红萝卜水果胡萝卜新鲜红罗卜蔬菜2斤生吃水果型脆甜当季',to_date('05-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),1,0,1000006,8.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (53,'果冻橙','爱媛38号果冻橙新鲜橙子水果当季整箱10斤四川应季甜橙子 ',to_date('09-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),1,0,1000006,13.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (54,'酸菜鱼半成品','【安井正品】冻品先生酸菜鱼半成品家常菜预制菜家用金汤黑鱼片',to_date('07-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),4,0,1000006,7.7,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (55,'烟熏烤香肠','网易严选脆皮猪肉肠火腿肠即食250g黑胡椒解馋玉米零食烟熏烤香肠',to_date('11-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),98,0,1000006,28.7,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (56,'酸菜小笋','酸菜小笋外婆菜湖南特产木桶饭预制菜半成品商用小炒菜下饭菜腌制',to_date('12-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),23,0,1000006,11.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (57,'咖喱浇头预制菜','开小灶咖喱番茄牛肉下饭浇头速食懒人夜宵免煮即食品预制菜料理包',to_date('09-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),34,0,1000006,10,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (58,'梅菜扣肉','食得迷梅菜扣肉加热即食半成品家用预制菜料理包快手菜旗舰店',to_date('07-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),6,0,1000006,18,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (59,'来伊份猪肉脯','来伊份居司令猪肉脯200g手撕肉脯高蛋白酥脆肉铺靖江猪肉脯熟食',to_date('12-9月 -23','DD-MON-RR'),to_date('04-9月 -23','DD-MON-RR'),17,0,1000006,22,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (141,'春江鸭爪','春江鸭爪泡椒鸭掌脱骨去骨即食解馋零食休闲食品充饥鸭脚散装',to_date('10-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),48,0,1000004,5.4,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (142,'芒果干奶糕','芒果控一定要试试哇！芒果干奶糕 软糯奶砖 健康小零食 南沫先生',to_date('09-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),19,0,1000004,19.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (143,'糕点礼盒','上海特产礼盒青团沈大成老字号糕点点心特色小吃伴手礼零食美食',to_date('08-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),6,0,1000004,39.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (144,'芋泥肉松三明治','芋泥肉松三明治彩虹香芋无边吐司早餐面包整箱网红小零食休闲食品',to_date('11-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),64,4,1000004,3.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (145,'茉莉鲜花饼','好一朵茉莉花南京特产茉莉鲜花饼中式糕点特色点心伴手礼宁饼礼盒',to_date('09-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),3,0,1000004,6.7,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (146,'中粮时怡纯坚果混合','中粮时怡纯坚果混合每日坚果健康零食独小包装孕妇原味桶罐装礼盒
',to_date('13-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),3,0,1000004,188,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (147,'蒙时代风干牛肉干','蒙时代风干牛肉干500g正宗内蒙古特产手撕小零食袋装熟食真空',to_date('20-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),1,0,1000004,119,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (148,'凤梨酥','【99抢购】微热山丘凤梨酥多颗礼盒装零食台湾糕点办公室伴手礼',to_date('09-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),7,0,1000004,85,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (149,'黄山烧饼','正宗安徽特产黄山烧饼梅干菜扣肉酥饼早餐糕点心饼干休闲零食小吃6枚',to_date('10-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),13,0,1000004,24.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (150,'喜旺冷切肠','喜旺冷切肠蒜香火腿肠香肠零食烤肠即食香辣香脆肉肠泡面搭档伴侣',to_date('14-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),1,0,1000004,7.7,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (151,'浓缩西梅汁','妈妈花园西梅汁官方旗舰店浓缩西梅膳食纤维饮料孕妇老人儿童可用500ml',to_date('17-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),1,0,1000004,88.88,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (152,'元气苏打水','元气苏打水无汽无糖孕妇备孕小瓶装饮料批发白桃味饮用水260ml',to_date('09-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),1,0,1000004,2.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (153,'甘蒂牧场果味牛奶','甘蒂牧场丹麦进口草莓香蕉巧克力3果味牛奶200ml送礼儿童调味乳',to_date('15-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),688,3.5,1000004,5.6,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (154,'好巧果粒果汁饮料','好巧葡萄草莓黄桃果肉果粒果汁饮料310ml*6罐葡萄汁夏日饮品包邮',to_date('16-9月 -23','DD-MON-RR'),to_date('07-9月 -23','DD-MON-RR'),34,0,1000004,26.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (61,'小米蕉香蕉','正宗广西小米蕉香蕉10斤新鲜水果整箱当季鲜苹果蕉自然熟粉蕉包邮',to_date('09-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),0,0,1000004,8.8,0);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (62,'黑布林','现摘黑布林1斤李子大果水果脆李黑金刚恐龙蛋孕妇应当季3整箱包邮',to_date('09-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),13,0,1000004,5.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (63,'牛油果','墨西哥进口牛油果2个新鲜水果当季整箱包邮大果辅食鳄梨熟透即食',to_date('05-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),1,0,1000004,9.6,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (64,'阳光葡萄','现货阳光玫瑰葡萄新鲜水果5斤礼盒晴王无籽香印青提当季整箱套袋',to_date('07-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),7,0,1000005,23.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (65,'芒果','现货广西百色田东桂七芒果整箱桂七礼盒当季新鲜热带孕妇水果包邮1斤',to_date('10-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),9,0,1000005,8.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (66,'山东月梨','正宗山东秋月梨10新鲜水果9斤梨子现摘现发当季整箱莱阳礼盒5斤',to_date('08-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),1,0,1000005,7.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (67,'简醇酸奶','君乐宝简醇酸奶无蔗糖酸牛奶网红非脱脂早餐健身0蔗糖酸奶整箱装',to_date('12-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),39,0,1000005,3.3,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (68,'真果粒草莓味','蒙牛mini小真果粒草莓味125ml学生成人营养早餐奶牛奶饮料',to_date('08-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),1345,0,1000005,2.2,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (69,'旺旺仔牛奶','旺旺旺仔牛奶125ml礼盒装学生早餐伴侣含乳饮料儿童节整箱批发',to_date('05-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),17,0,1000005,2.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (70,'果粒橙','美汁源果粒橙300m 橙汁/汁汁桃桃果汁橙子饮品饮料',to_date('06-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),79,0,1000005,2.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (71,'李子园甜牛奶','李子园甜牛奶原味225ml*20瓶整箱学生早餐奶儿童健康新鲜含乳饮料',to_date('07-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),9,0,1000005,2.7,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (72,'特仑苏纯牛奶','蒙牛特仑苏纯牛奶250mlx12/16原生高钙全脂早餐零蔗糖',to_date('08-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),13,0,1000005,3.4,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (73,'Lindt黑巧克力','瑞士莲进口软心牛奶黑巧克力散装婚庆喜糖网红休闲零食糖果',to_date('07-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),17,0,1000009,39.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (74,'鱿鱼丝','手撕碳烤鱿鱼条鱿鱼丝海鲜即食零食网红爆款休闲小吃解馋鱿鱼干片',to_date('09-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),7,0,1000009,12.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (75,'法丽兹巧克力夹心曲奇','法丽兹巧克力夹心曲奇饼干抹茶芝士酸奶115克办公室休闲零食小吃',to_date('10-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),56,0,1000009,6.6,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (76,'mix脆脆条','泰国进口VFOODS 30g香辣网红虾条mix脆脆条零食小吃薯条休闲食品',to_date('07-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),17,0,1000009,4.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (77,'pocky抹茶味饼干','日本进口宇治抹茶味饼干辻利巧克力棒夹心pocky百醇奇格力高',to_date('06-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),1,0,1000009,7.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (78,'鳕鱼肠','来伊份进口肠鳕鱼肠105g零食休闲食品小吃营养小零食宝宝佐餐',to_date('08-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),17,0,1000009,8.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (79,'莓日饮蓝莓汁','莓日饮100%蓝莓原汁非浓缩蓝莓原浆花青素饮料',to_date('05-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),13,0,1000009,6.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (80,'椰谷鲜椰汁','椰谷鲜椰汁生榨椰子汁网红饮料245g/瓶',to_date('07-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),26,0,1000009,3.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (81,'维他命','农夫山泉力量帝维他命水500ml瓶整箱批发特价维生素VC功能饮料',to_date('09-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),87,0,1000009,4.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (82,'农心辛拉面','农心辛拉面韩式辣白菜方便面农心拉面袋装韩国进口泡面速食旗舰店5包',to_date('11-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),34,0,1000009,25.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (83,'法式烤面包脆片','韩国进口SI蒜香黄油面包干休闲零食酥脆饼干蒜蓉味法式烤面包脆片',to_date('12-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),18,0,1000009,7.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (84,'森永岩盐太妃糖','进口日本森永岩盐太妃糖海盐焦糖糖果咖啡巧克力牛奶喜糖高端零食10颗',to_date('06-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),16,0,1000009,16.6,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (85,'解酒糖','韩国VEGTOMETO/维格美进口解酒糖芒果蜂蜜味应酬聚会快速解酒醒酒',to_date('11-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),65,0,1000009,9.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (86,'烤面包脆片','韩国进口SI蒜香黄油面包干休闲零食酥脆饼干蒜蓉味法式烤面包脆片',to_date('05-9月 -23','DD-MON-RR'),to_date('05-9月 -23','DD-MON-RR'),17,0,1000009,9.6,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (87,'卡曼橘果汁原浆','国进口卡曼橘原液NFC果汁原浆1L无糖精VC维C纯果汁100%饮料1961',to_date('06-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),2,0,1000005,28,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (88,'百草味虎皮凤爪','百草味虎皮凤爪160g鸡爪鸡肉休闲熟食即食好吃的卤味休闲零食',to_date('06-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),34,0,1000005,11.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (89,'牛海哥鸭肠','牛海哥鸭肠食麻辣卤味肉食夜宵充饥零食休闲食品小吃大礼包10包',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),1,0,1000005,7.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (90,'牛海哥鸭肠','牛海哥鸭肠10袋即食麻辣卤味肉食夜宵充饥零食休闲食品小吃大礼包',to_date('09-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),1,0,1000005,7.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (91,'狼牙土豆','好吃的狼牙土豆零食即食麻辣土豆各种休闲美食品大全网红爆款小吃
',to_date('08-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),53,0,1000005,13.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (92,'卤味脆藕片','卤味脆藕片解馋麻辣小零食网红休闲食品辣味小吃香辣土豆片下饭菜10包',to_date('11-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),34,0,1000005,6.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (93,'老厨鸭翅','老厨鸭翅膀老汤酱卤蜜汁香辣小包装解饿馋即食卤味熟食追剧肉零食
',to_date('10-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),8,0,1000005,4.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (94,'乡巴佬五香卤蛋','五香卤蛋正宗乡巴佬卤蛋盐焗鸡蛋泡椒蛋卤味制品熟食休闲零食小吃',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),0,0,1000005,2.3,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (95,'竹岛红烧牛肉罐头','竹岛红烧牛肉罐头即食牛腩拌面方便速食肉制品下饭菜应急户外食品',to_date('11-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),26,0,1000005,22.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (96,'盐焗鸡冠','盐焗鸡冠子客家特色小吃鸡冠香辣冷吃鸡肉零食下酒菜熟食即食零食',to_date('06-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),5,0,1000005,18.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (97,'牛肉丸','知心园牛肉丸鸡胸肉丸开袋即食鸡胸肉小吃熟食减解馋脂期零食300g',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),7,0,1000005,9.2,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (98,'猪耳朵','猪耳朵零食熟食开袋即食下酒菜小吃网上解饿肉解馋荤食香辣猪脆骨',to_date('12-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),985,0,1000005,1,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (99,'麒麟果','海南山野燕窝果麒麟果应季新鲜水果非黄色皮火龙果热带',to_date('10-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),17,0,1000004,10,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (100,'突尼斯软籽石榴','突尼斯软籽石榴5斤水果新鲜整箱当季孕妇会理红宝石无籽石榴包邮',to_date('11-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),15,0,1000004,15,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (101,'周至翠香猕猴桃','周至翠香猕猴桃新鲜水果当季整箱绿心奇异果孕妇礼盒15枚',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),7,0,1000004,15,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (102,'黄金油桃','黄金油桃黄肉应季黄金蜜桃孕妇时令甜黄油桃大果新鲜水果当季5斤',to_date('08-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),24,0,1000004,58,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (103,'猫山王榴莲','市舶士猫山王榴莲新鲜马来西亚进口D197液氮冷冻水果整果',to_date('09-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),1,0,1000004,160,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (104,'云南昭通丑苹果','云南昭通丑苹果冰糖心苹果水果新鲜脆甜10斤红富士当季整箱包邮',to_date('10-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),22,0,1000004,16.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (105,'浦江巨峰葡萄','浦江巨峰葡萄新鲜送礼水果整箱马陆当应季1斤',to_date('10-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),57,0,1000004,17,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (106,'正宗陕西大荔冬枣','正宗陕西大荔冬枣大果1斤枣子新鲜水果当季现摘脆甜现发整箱包邮',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),85,0,1000004,12.6,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (107,'冷冻水蜜桃','冷冻水蜜桃块1kg芝芝桃桃子果肉饮料调配速冻新鲜水果无核去皮2斤',to_date('08-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),33,0,1000004,24,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (108,'树葡萄','树葡萄嘉宝果大果现摘新鲜高端水果孕妇水果稀奇罕见1斤',to_date('13-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),5,5,1000004,88,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (109,'meito桃子糖','名糖meito日本进口零食白桃喜糖水果糖糖果硬糖网红桃子糖
',to_date('08-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),33,0,1000009,14.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (110,'meito五味碳酸糖','名糖meito日本进口零食白桃喜糖水果糖糖果硬糖网红桃子糖',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),17,0,1000009,39,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (111,'黄油鸡蛋卷','澳门特产手信进口高端零食香港手工黄油鸡蛋卷饼干伴手礼大礼包',to_date('09-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),1,0,1000009,53,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (112,'蜜兰达薄荷糖','蜜兰达新西兰进口麦卢卡蜂蜜润喉糖清新薄荷糖果护嗓子教师节礼物',to_date('11-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),6,0,1000009,88,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (113,'goahead酸奶夹心饼干','欧洲进口goahead网红酸奶夹心饼干高端级办公室好零食品休闲小吃',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),1,0,1000009,19.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (114,'初饮果粒果汁饮料','初饮果粒果汁饮料0脂肪500g大罐橙汁葡萄果味果肉饮品',to_date('12-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),178,0,1000009,5.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (115,'三只松鼠_蜀香牛肉','三只松鼠_蜀香牛肉_麻辣牛肉零食熟食休闲解馋灯影牛肉干即食牛筋',to_date('06-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),7,0,1000010,6.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (116,'良品铺子猪肉脯','良品铺子猪肉脯干靖江网红解馋即食熟食 追剧休闲茶几零食200g',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),42,0,1000010,22.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (117,'老乡法式鹅酱鹅肝','老乡法式鹅酱鹅肝香辣味卤味零食小吃独立小包装休闲熟食28g',to_date('09-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),1496,0,1000010,3.5,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (118,'网红香辣牛蹄筋','网红香辣牛蹄筋即食麻辣味营养小零食牛板筋小吃休闲食品健康熟食3袋',to_date('08-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),16,0,1000010,9.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (119,'八爪鱼大爆头即食','八爪鱼大爆头即食麻辣小海鲜熟食罐头扇贝生蚝香辣鱿鱼须下酒饭菜',to_date('11-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),1,0,1000010,16.9,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (120,'牛海哥嗨爽鸭胗','牛海哥嗨爽鸭胗香辣鸭肫卤味辣味鸭肉熟食即食零食小吃休闲食品10包',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),1,0,1000010,14.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (121,'比比赞即食鸡排','比比赞即食鸡排鸡胸肉解馋卤味熟食夜宵充饥零食小吃货休闲即食品',to_date('08-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),9,0,1000010,16,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (122,'四川香辣冷吃猪蹄','四川香辣冷吃猪蹄熟食即食猪手真空猪脚零食卤味猪爪下酒追剧特产',to_date('09-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),65,0,1000010,32,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (123,'小鸭腿','小鸭腿鸡腿卤味小腿开袋即食充饥夜宵鸭翅根肉类熟食休闲零食整箱',to_date('06-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),136,0,1000010,7.7,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (124,'苦菊生菜','苦菊生菜新鲜蔬菜沙拉食材包邮苦苣狗牙菜西餐健身轻食苦细叶生菜',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),5,0,1000006,14.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (125,'嫩南瓜','嫩南瓜新鲜现摘高山圆南瓜青小南瓜农家当季蔬菜5斤整箱包邮鲜嫩香甜汁水充盈自种蔬菜新鲜现摘',to_date('09-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),6,0,1000006,19.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (126,'花紫玉米','苏北农家自种带壳花紫玉米甜糯玉米新鲜玉米糯玉米棒蔬菜苞谷现摘1斤',to_date('11-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),68,0,1000006,6.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (127,'水果西红柿','山东普罗旺斯水果西红柿新鲜现摘沙瓤番茄农家自然熟孕妇生吃蔬菜1斤',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),3,0,1000006,7.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (128,'娃娃菜小白菜','云南新鲜现摘农家露天种植娃娃菜小白菜黄心蔬菜火锅食材当季蔬菜3斤',to_date('09-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),6,0,1000006,16.8,1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (129,'大蒜头','果王缘山东金乡大蒜头干蒜5斤装紫皮新鲜多瓣农家',to_date('08-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),17,0,1000006,6.5,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (130,'玉女黄瓜','玉女黄瓜1斤装应季水果孕妇新鲜蔬菜现摘拇指鲜嫩小黄瓜青瓜',to_date('07-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),39,0,1000006,5.9,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (131,'云南牛奶芋头','云南牛奶毛芋头新鲜1斤小香芋当季蔬菜粉糯芋艿农家',to_date('08-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),39,0,1000006,6.8,-1);
Insert into C##LJX.COMMODITY (COM_ID,COM_NAME,COM_INTRODUCTION,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,COM_ORIPRICE,COM_STATUS) values (132,'当季香莴苣','【四川新鲜莴笋2023】当季香莴苣农家绿心青笋凤尾新鲜蔬菜买菜',to_date('08-9月 -23','DD-MON-RR'),to_date('06-9月 -23','DD-MON-RR'),15,0,1000006,8.8,-1);
REM INSERTING into C##LJX.COMMODITY_CATEGORIES
SET DEFINE OFF;
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (4,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (4,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (5,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (5,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (6,'调味品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (7,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (8,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (9,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (10,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (10,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (11,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (12,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (13,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (14,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (15,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (16,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (17,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (18,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (19,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (19,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (20,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (21,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (22,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (23,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (24,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (25,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (26,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (26,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (27,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (28,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (28,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (29,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (29,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (30,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (30,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (30,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (31,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (31,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (31,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (32,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (32,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (32,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (33,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (34,'保健品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (35,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (35,'调味品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (36,'调味品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (36,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (37,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (37,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (38,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (39,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (40,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (40,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (41,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (41,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (42,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (42,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (43,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (43,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (44,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (45,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (45,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (46,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (46,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (47,'调味品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (48,'调味品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (49,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (50,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (51,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (52,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (53,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (54,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (54,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (55,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (55,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (55,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (56,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (57,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (58,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (58,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (59,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (59,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (59,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (61,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (62,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (63,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (64,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (65,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (66,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (67,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (68,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (68,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (69,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (69,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (70,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (70,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (71,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (71,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (72,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (73,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (74,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (74,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (74,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (75,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (75,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (76,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (76,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (77,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (77,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (78,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (78,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (78,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (79,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (79,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (80,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (80,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (81,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (82,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (82,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (82,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (83,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (83,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (84,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (84,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (85,'保健品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (85,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (86,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (86,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (87,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (87,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (88,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (88,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (88,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (89,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (89,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (89,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (90,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (90,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (90,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (91,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (91,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (91,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (92,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (92,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (92,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (93,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (93,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (94,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (94,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (94,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (95,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (95,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (95,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (96,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (96,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (96,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (97,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (97,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (97,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (98,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (98,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (98,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (99,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (100,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (101,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (102,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (103,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (104,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (105,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (106,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (107,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (108,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (109,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (110,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (111,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (111,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (112,'保健品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (112,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (113,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (113,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (114,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (114,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (115,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (115,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (115,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (116,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (116,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (116,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (117,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (117,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (117,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (117,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (118,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (118,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (118,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (119,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (119,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (119,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (120,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (120,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (120,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (121,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (121,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (121,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (122,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (122,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (122,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (123,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (123,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (123,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (123,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (124,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (125,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (126,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (126,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (127,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (127,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (128,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (128,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (129,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (130,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (131,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (132,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (141,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (141,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (141,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (142,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (142,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (142,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (143,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (143,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (143,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (144,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (144,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (144,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (145,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (145,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (146,'保健品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (146,'其他');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (147,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (147,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (147,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (148,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (148,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (148,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (149,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (149,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (150,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (150,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (150,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (150,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (151,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (151,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (152,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (152,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (153,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (153,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (154,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (154,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (161,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (161,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (162,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (162,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (163,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (164,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (165,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (165,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (165,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (166,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (167,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (168,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (169,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (170,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (170,'面点');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (171,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (172,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (173,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (174,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (175,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (175,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (176,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (177,'调味品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (178,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (178,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (179,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (180,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (181,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (182,'蛋奶');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (182,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (183,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (184,'调味品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (185,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (185,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (186,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (187,'蔬菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (188,'果品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (189,'饮料');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (190,'熟食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (190,'肉制品');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (190,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (190,'预制菜');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (191,'零食');
Insert into C##LJX.COMMODITY_CATEGORIES (COM_ID,COM_CATEGORY) values (192,'零食');
REM INSERTING into C##LJX.COMMODITY_COMMENT
SET DEFINE OFF;
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (48,0,'非常不错',to_date('08-9月 -23','DD-MON-RR'),108,1000008);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (49,23,'确实',to_date('08-9月 -23','DD-MON-RR'),82,1000009);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (50,23,'是这样的',to_date('08-9月 -23','DD-MON-RR'),82,1000009);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (51,0,'不错不错~',to_date('08-9月 -23','DD-MON-RR'),144,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (52,0,'不错不错~',to_date('08-9月 -23','DD-MON-RR'),144,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (53,51,'感谢您对**的支持
',to_date('08-9月 -23','DD-MON-RR'),144,1000004);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (54,52,'感谢您对**的支持',to_date('08-9月 -23','DD-MON-RR'),144,1000004);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (55,53,'不用谢~~',to_date('08-9月 -23','DD-MON-RR'),144,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (56,53,'不用谢~~',to_date('08-9月 -23','DD-MON-RR'),144,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (21,0,'好好好',to_date('07-9月 -23','DD-MON-RR'),82,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (22,0,'这款拉面味道不错，下次还会买！',to_date('07-9月 -23','DD-MON-RR'),82,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (23,0,'这个很好吃！',to_date('07-9月 -23','DD-MON-RR'),82,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (24,0,'一点也不好吃！！！',to_date('07-9月 -23','DD-MON-RR'),82,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (25,24,'好像还行呀',to_date('07-9月 -23','DD-MON-RR'),82,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (26,0,'这个猕猴桃不错',to_date('07-9月 -23','DD-MON-RR'),25,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (27,26,'谢谢夸奖！！',to_date('07-9月 -23','DD-MON-RR'),25,1000010);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (1,0,'好评捏~',to_date('04-9月 -23','DD-MON-RR'),43,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (2,1,'感谢您的支持~',to_date('04-9月 -23','DD-MON-RR'),43,1000004);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (3,0,'坏掉了，差评！！！AWA',to_date('04-9月 -23','DD-MON-RR'),25,1000018);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (4,0,'好评！！！',to_date('04-9月 -23','DD-MON-RR'),25,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (5,0,'中评~',to_date('05-9月 -23','DD-MON-RR'),43,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (6,0,'差评！！！',to_date('05-9月 -23','DD-MON-RR'),43,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (7,0,'好评~',to_date('05-9月 -23','DD-MON-RR'),10,1000018);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (8,0,'中评~',to_date('05-9月 -23','DD-MON-RR'),10,1000018);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (9,0,'好评捏~',to_date('05-9月 -23','DD-MON-RR'),82,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (41,1,'感谢您的支持~',to_date('08-9月 -23','DD-MON-RR'),43,1000004);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (42,0,'味道不好',to_date('08-9月 -23','DD-MON-RR'),10,1000018);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (43,0,'不好喝',to_date('08-9月 -23','DD-MON-RR'),153,1000017);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (44,0,'好喝~',to_date('08-9月 -23','DD-MON-RR'),153,1000018);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (45,43,'我觉得还行吧',to_date('08-9月 -23','DD-MON-RR'),153,1000018);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (46,6,'为什么',to_date('08-9月 -23','DD-MON-RR'),43,1000008);
Insert into C##LJX.COMMODITY_COMMENT (CMT_ID,CMT_FATHER,CMT_CONTENT,CMT_TIME,COM_ID,USER_ID) values (47,45,'****',to_date('08-9月 -23','DD-MON-RR'),153,1000017);
REM INSERTING into C##LJX.COMMODITY_IMAGE
SET DEFINE OFF;
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (4,'.\wwwroot\commodity_image\4\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (4,'.\wwwroot\commodity_image\4\com_image_1.jpg');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (5,'.\wwwroot\commodity_image\5\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (6,'.\wwwroot\commodity_image\6\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (7,'.\wwwroot\commodity_image\7\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (7,'.\wwwroot\commodity_image\7\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (8,'.\wwwroot\commodity_image\8\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (8,'.\wwwroot\commodity_image\8\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (9,'.\wwwroot\commodity_image\9\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (10,'.\wwwroot\commodity_image\10\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (11,'.\wwwroot\commodity_image\11\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (11,'.\wwwroot\commodity_image\11\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (12,'.\wwwroot\commodity_image\12\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (13,'.\wwwroot\commodity_image\13\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (14,'.\wwwroot\commodity_image\14\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (15,'.\wwwroot\commodity_image\15\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (15,'.\wwwroot\commodity_image\15\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (16,'.\wwwroot\commodity_image\16\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (17,'.\wwwroot\commodity_image\17\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (18,'.\wwwroot\commodity_image\18\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (19,'.\wwwroot\commodity_image\19\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (20,'.\wwwroot\commodity_image\20\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (20,'.\wwwroot\commodity_image\20\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (21,'.\wwwroot\commodity_image\21\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (22,'.\wwwroot\commodity_image\22\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (22,'.\wwwroot\commodity_image\22\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (22,'.\wwwroot\commodity_image\22\com_image_2.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (23,'.\wwwroot\commodity_image\23\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (24,'.\wwwroot\commodity_image\24\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (25,'.\wwwroot\commodity_image\25\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (26,'.\wwwroot\commodity_image\26\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (27,'.\wwwroot\commodity_image\27\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (28,'.\wwwroot\commodity_image\28\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (29,'.\wwwroot\commodity_image\29\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (29,'.\wwwroot\commodity_image\29\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (30,'.\wwwroot\commodity_image\30\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (31,'.\wwwroot\commodity_image\31\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (32,'.\wwwroot\commodity_image\32\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (33,'.\wwwroot\commodity_image\33\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (34,'.\wwwroot\commodity_image\34\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (35,'.\wwwroot\commodity_image\35\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (36,'.\wwwroot\commodity_image\36\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (37,'.\wwwroot\commodity_image\37\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (38,'.\wwwroot\commodity_image\38\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (39,'.\wwwroot\commodity_image\39\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (40,'.\wwwroot\commodity_image\40\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (41,'.\wwwroot\commodity_image\41\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (42,'.\wwwroot\commodity_image\42\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (43,'.\wwwroot\commodity_image\43\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (44,'.\wwwroot\commodity_image\44\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (45,'.\wwwroot\commodity_image\45\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (46,'.\wwwroot\commodity_image\46\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (46,'.\wwwroot\commodity_image\46\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (47,'.\wwwroot\commodity_image\47\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (48,'.\wwwroot\commodity_image\48\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (49,'.\wwwroot\commodity_image\49\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (50,'.\wwwroot\commodity_image\50\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (51,'.\wwwroot\commodity_image\51\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (52,'.\wwwroot\commodity_image\52\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (53,'.\wwwroot\commodity_image\53\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (54,'.\wwwroot\commodity_image\54\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (55,'.\wwwroot\commodity_image\55\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (56,'.\wwwroot\commodity_image\56\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (57,'.\wwwroot\commodity_image\57\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (58,'.\wwwroot\commodity_image\58\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (59,'.\wwwroot\commodity_image\59\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (61,'.\wwwroot\commodity_image\61\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (62,'.\wwwroot\commodity_image\62\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (63,'.\wwwroot\commodity_image\63\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (64,'.\wwwroot\commodity_image\64\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (65,'.\wwwroot\commodity_image\65\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (66,'.\wwwroot\commodity_image\66\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (67,'.\wwwroot\commodity_image\67\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (68,'.\wwwroot\commodity_image\68\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (69,'.\wwwroot\commodity_image\69\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (70,'.\wwwroot\commodity_image\70\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (71,'.\wwwroot\commodity_image\71\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (72,'.\wwwroot\commodity_image\72\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (73,'.\wwwroot\commodity_image\73\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (74,'.\wwwroot\commodity_image\74\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (75,'.\wwwroot\commodity_image\75\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (75,'.\wwwroot\commodity_image\75\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (76,'.\wwwroot\commodity_image\76\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (77,'.\wwwroot\commodity_image\77\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (78,'.\wwwroot\commodity_image\78\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (79,'.\wwwroot\commodity_image\79\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (80,'.\wwwroot\commodity_image\80\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (81,'.\wwwroot\commodity_image\81\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (82,'.\wwwroot\commodity_image\82\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (83,'.\wwwroot\commodity_image\83\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (84,'.\wwwroot\commodity_image\84\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (85,'.\wwwroot\commodity_image\85\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (86,'.\wwwroot\commodity_image\86\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (87,'.\wwwroot\commodity_image\87\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (88,'.\wwwroot\commodity_image\88\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (89,'.\wwwroot\commodity_image\89\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (90,'.\wwwroot\commodity_image\90\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (91,'.\wwwroot\commodity_image\91\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (92,'.\wwwroot\commodity_image\92\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (93,'.\wwwroot\commodity_image\93\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (94,'.\wwwroot\commodity_image\94\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (95,'.\wwwroot\commodity_image\95\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (96,'.\wwwroot\commodity_image\96\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (97,'.\wwwroot\commodity_image\97\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (98,'.\wwwroot\commodity_image\98\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (99,'.\wwwroot\commodity_image\99\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (100,'.\wwwroot\commodity_image\100\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (101,'.\wwwroot\commodity_image\101\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (102,'.\wwwroot\commodity_image\102\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (103,'.\wwwroot\commodity_image\103\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (104,'.\wwwroot\commodity_image\104\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (105,'.\wwwroot\commodity_image\105\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (106,'.\wwwroot\commodity_image\106\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (107,'.\wwwroot\commodity_image\107\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (108,'.\wwwroot\commodity_image\108\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (109,'.\wwwroot\commodity_image\109\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (110,'.\wwwroot\commodity_image\110\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (111,'.\wwwroot\commodity_image\111\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (112,'.\wwwroot\commodity_image\112\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (113,'.\wwwroot\commodity_image\113\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (114,'.\wwwroot\commodity_image\114\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (115,'.\wwwroot\commodity_image\115\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (116,'.\wwwroot\commodity_image\116\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (117,'.\wwwroot\commodity_image\117\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (118,'.\wwwroot\commodity_image\118\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (119,'.\wwwroot\commodity_image\119\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (120,'.\wwwroot\commodity_image\120\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (121,'.\wwwroot\commodity_image\121\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (122,'.\wwwroot\commodity_image\122\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (123,'.\wwwroot\commodity_image\123\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (124,'.\wwwroot\commodity_image\124\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (125,'.\wwwroot\commodity_image\125\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (126,'.\wwwroot\commodity_image\126\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (127,'.\wwwroot\commodity_image\127\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (128,'.\wwwroot\commodity_image\128\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (129,'.\wwwroot\commodity_image\129\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (130,'.\wwwroot\commodity_image\130\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (131,'.\wwwroot\commodity_image\131\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (132,'.\wwwroot\commodity_image\132\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (141,'.\wwwroot\commodity_image\141\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (142,'.\wwwroot\commodity_image\142\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (143,'.\wwwroot\commodity_image\143\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (144,'.\wwwroot\commodity_image\144\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (145,'.\wwwroot\commodity_image\145\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (146,'.\wwwroot\commodity_image\146\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (147,'.\wwwroot\commodity_image\147\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (148,'.\wwwroot\commodity_image\148\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (149,'.\wwwroot\commodity_image\149\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (150,'.\wwwroot\commodity_image\150\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (151,'.\wwwroot\commodity_image\151\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (152,'.\wwwroot\commodity_image\152\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (153,'.\wwwroot\commodity_image\153\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (154,'.\wwwroot\commodity_image\154\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (161,'.\wwwroot\commodity_image\161\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (162,'.\wwwroot\commodity_image\162\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (163,'.\wwwroot\commodity_image\163\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (164,'.\wwwroot\commodity_image\164\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (165,'.\wwwroot\commodity_image\165\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (166,'.\wwwroot\commodity_image\166\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (167,'.\wwwroot\commodity_image\167\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (168,'.\wwwroot\commodity_image\168\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (169,'.\wwwroot\commodity_image\169\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (170,'.\wwwroot\commodity_image\170\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (171,'.\wwwroot\commodity_image\171\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (171,'.\wwwroot\commodity_image\171\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (172,'.\wwwroot\commodity_image\172\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (173,'.\wwwroot\commodity_image\173\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (174,'.\wwwroot\commodity_image\174\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (174,'.\wwwroot\commodity_image\174\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (175,'.\wwwroot\commodity_image\175\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (176,'.\wwwroot\commodity_image\176\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (177,'.\wwwroot\commodity_image\177\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (178,'.\wwwroot\commodity_image\178\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (179,'.\wwwroot\commodity_image\179\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (180,'.\wwwroot\commodity_image\180\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (181,'.\wwwroot\commodity_image\181\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (182,'.\wwwroot\commodity_image\182\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (183,'.\wwwroot\commodity_image\183\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (184,'.\wwwroot\commodity_image\184\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (185,'.\wwwroot\commodity_image\185\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (186,'.\wwwroot\commodity_image\186\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (187,'.\wwwroot\commodity_image\187\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (188,'.\wwwroot\commodity_image\188\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (189,'.\wwwroot\commodity_image\189\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (190,'.\wwwroot\commodity_image\190\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (191,'.\wwwroot\commodity_image\191\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (192,'.\wwwroot\commodity_image\192\com_image_0.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (192,'.\wwwroot\commodity_image\192\com_image_1.png');
Insert into C##LJX.COMMODITY_IMAGE (COM_ID,COM_IMAGE) values (192,'.\wwwroot\commodity_image\192\com_image_2.png');
REM INSERTING into C##LJX.COMMODITY_PRICE_CURVE
SET DEFINE OFF;
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),3.96,161);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.25,161);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),1.8,161);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),1.35,161);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),6.53,162);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),3.27,162);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),2.18,162);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),1.09,162);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),12.42,163);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),11.04,163);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),9.66,163);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),8.28,163);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),6.9,163);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),26.82,164);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),23.84,164);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('16-9月 -23','DD-MON-RR'),20.86,164);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('20-9月 -23','DD-MON-RR'),17.88,164);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('24-9月 -23','DD-MON-RR'),14.9,164);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('28-9月 -23','DD-MON-RR'),7.45,164);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),1.9,165);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),1.37,165);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('16-9月 -23','DD-MON-RR'),0.73,165);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),4.8,5);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),4,5);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),5.6,5);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),3.2,5);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),2.7,46);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),2.48,46);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),2.03,46);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),1.58,46);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),1.13,46);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),14.17,166);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),11.77,166);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),10.46,166);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('15-9月 -23','DD-MON-RR'),8.72,166);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('20-9月 -23','DD-MON-RR'),7.19,166);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),4.4,167);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),5.1,168);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),3.4,168);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),1.7,168);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),9.09,169);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),7.79,169);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),5.19,169);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),25.33,170);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),20.86,170);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('15-9月 -23','DD-MON-RR'),16.39,170);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('22-9月 -23','DD-MON-RR'),11.92,170);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),3.6,171);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),3.15,171);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('14-9月 -23','DD-MON-RR'),2.7,171);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('17-9月 -23','DD-MON-RR'),2.25,171);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('23-9月 -23','DD-MON-RR'),1.13,171);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),0.01,172);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),0.01,172);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),0.01,172);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),0.01,172);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),42.94,173);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),32.21,173);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),26.84,173);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),23.73,174);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),20.08,174);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),2,175);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),1.5,175);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('15-9月 -23','DD-MON-RR'),1,175);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('18-9月 -23','DD-MON-RR'),0.5,175);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),10.9,176);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),9.32,176);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),7.74,176);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),5.94,177);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),5.28,177);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('14-9月 -23','DD-MON-RR'),4.95,177);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('15-9月 -23','DD-MON-RR'),4.62,177);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('19-9月 -23','DD-MON-RR'),3.3,177);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('24-9月 -23','DD-MON-RR'),1.65,177);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),24.75,178);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),7.35,179);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),6.76,179);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),3.23,179);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),5.66,180);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),5.31,180);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('15-9月 -23','DD-MON-RR'),4.72,180);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('18-9月 -23','DD-MON-RR'),4.13,180);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('21-9月 -23','DD-MON-RR'),2.95,180);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),4.95,181);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),3.3,181);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),13.37,182);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),11.88,182);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),10.4,182);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('16-9月 -23','DD-MON-RR'),7.97,182);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('19-9月 -23','DD-MON-RR'),6.75,182);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('22-9月 -23','DD-MON-RR'),6.08,182);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('26-9月 -23','DD-MON-RR'),5.4,182);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),3.72,183);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),5.4,184);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('30-9月 -23','DD-MON-RR'),2.7,184);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),16.54,185);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),10.34,185);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),8.27,185);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),5.18,186);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),4.35,186);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),5.46,187);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),25.33,188);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),21.71,188);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),18.1,188);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('14-9月 -23','DD-MON-RR'),14.81,188);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('19-9月 -23','DD-MON-RR'),8.23,188);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),5.72,189);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('14-9月 -23','DD-MON-RR'),4.36,189);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('19-9月 -23','DD-MON-RR'),2.21,189);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('26-9月 -23','DD-MON-RR'),0.98,189);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),22.96,190);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),20.38,190);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('15-9月 -23','DD-MON-RR'),17.8,190);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('20-9月 -23','DD-MON-RR'),12.9,190);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('14-9月 -23','DD-MON-RR'),14.24,191);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('18-9月 -23','DD-MON-RR'),12.16,191);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('21-9月 -23','DD-MON-RR'),8.48,191);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),19.35,192);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),18.28,192);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),17.2,192);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),16.13,192);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('16-9月 -23','DD-MON-RR'),10.75,192);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('21-9月 -23','DD-MON-RR'),7.1,192);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('25-9月 -23','DD-MON-RR'),2.37,192);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),8.8,4);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),4.4,4);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),3.3,6);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),1.65,6);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),36.4,7);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),20.8,7);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.2,7);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),7.45,8);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),6.71,8);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.96,8);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),4.47,8);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),2.98,8);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.24,8);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),1.49,8);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),10.4,9);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),7.8,9);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.2,9);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.6,9);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),10.8,10);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),4.32,10);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),0.5,11);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),6.57,12);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),4.38,12);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),0.01,13);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),0.01,13);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),6.93,14);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),3.96,14);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),11.75,15);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),8.01,15);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),2.15,16);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),7.43,17);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),5.66,17);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),3.66,17);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),19.67,18);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),18.63,18);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),17.6,18);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),16.56,18);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),12.42,18);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),8.28,18);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),4.14,18);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),2.07,18);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),21.78,23);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),14.52,23);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),4.68,20);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),3.9,20);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),2.9,21);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),10.75,22);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.38,22);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),14.95,19);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),5.98,19);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),2.2,24);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),1.65,24);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),1.1,24);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),0.55,24);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),2.92,141);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),11.92,26);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),9.69,26);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),7.45,26);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),10.32,29);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),13.2,27);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),3,28);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),2.75,28);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),2.5,28);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),2,28);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),1.5,28);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),0.5,28);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),13.41,26);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),9.93,29);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),9.42,29);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),9.03,29);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),5.16,29);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),2.51,30);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),2.25,30);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),12.72,31);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),11.93,31);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),11.13,31);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),10.34,31);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),9.54,31);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),8.75,31);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),7.95,31);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),1.5,32);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),1,32);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),3.25,33);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),1.63,33);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),10.56,34);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),5.28,34);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),6.4,35);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),3.2,35);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),15.04,36);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),11.28,36);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),7.52,36);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),5.94,37);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),4.95,37);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),2.97,37);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),5.72,38);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),3.96,38);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),11.4,39);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),1.16,40);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),1.85,41);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),1.54,41);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),0.92,41);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),9.03,42);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),1.68,43);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),1.56,43);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),1.44,43);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),0.99,44);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),2.61,45);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),5.45,47);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),3.27,47);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),5.81,48);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),4.72,48);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),3.08,49);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),2.7,49);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),1.75,49);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),1.3,49);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),3.23,50);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),7.55,51);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),6.86,51);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),6.37,51);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),4.9,51);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),5.98,52);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),4.05,52);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),13.21,53);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),11.4,53);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),9.87,53);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),8.06,53);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),6.26,53);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),5.56,53);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),4.62,54);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),2.31,54);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),17.22,55);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),11.48,55);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),8.61,55);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),6.96,56);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),5.66,56);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),4.96,56);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),9.5,57);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),9,57);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),5.5,57);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),9,58);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),15.4,59);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),13.2,59);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),11,59);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),5.5,59);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),3.73,141);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.43,141);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),1.89,141);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),15.02,142);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),10.73,142);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),6.44,142);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),17.56,143);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),1.72,144);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),1.37,144);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),1.02,144);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),0.7,144);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),4.56,145);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),3.62,145);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.88,145);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),94,146);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),90.24,146);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),84.6,146);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),78.96,146);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),75.2,146);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),37.6,146);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),89.25,147);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),71.4,147);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),59.5,147);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('18-9月 -23','DD-MON-RR'),29.75,147);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('20-9月 -23','DD-MON-RR'),11.9,147);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),80.75,148);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),38.25,148);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),19.17,149);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),17.43,149);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),15.69,149);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),12.45,149);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),3.85,150);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),3.08,150);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),2.31,150);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),1.54,150);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),71.1,151);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),66.66,151);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),57.77,151);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),44.44,151);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('14-9月 -23','DD-MON-RR'),31.11,151);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('16-9月 -23','DD-MON-RR'),17.78,151);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('17-9月 -23','DD-MON-RR'),8.89,151);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),2,152);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),1.5,152);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),5.04,153);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),4.48,153);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),3.92,153);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),2.8,153);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('15-9月 -23','DD-MON-RR'),1.4,153);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),22.87,154);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),20.18,154);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),13.45,154);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),8.07,154);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('16-9月 -23','DD-MON-RR'),2.69,154);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),6.16,61);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.28,61);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),4.4,61);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),4.64,62);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),4.35,62);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),4.06,62);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),3.48,62);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.9,62);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),5.28,63);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),15.47,64);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),12.38,64);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),9.52,64);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('04-9月 -23','DD-MON-RR'),3.12,25);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),6.16,65);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.28,65);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),4.4,65);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),3.52,65);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.64,65);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),2.2,65);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.25,66);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),4.65,66);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),4.13,66);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),3.14,67);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),2.84,67);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),2.54,67);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),2.28,67);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),1.65,67);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),1.16,67);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),0.99,68);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),0.77,68);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),1.5,69);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),2.16,70);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),1.23,70);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),1.81,71);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),1.87,72);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),0.75,72);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),25.94,73);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),11.01,74);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),7.94,74);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),5.12,74);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),5.87,75);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.02,75);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),3.3,75);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),1.65,75);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),3.47,76);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),2.48,76);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),1.49,76);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),3.51,77);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),3.12,77);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),6.72,78);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.53,78);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),1.7,78);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),1.93,79);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),2.65,80);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),2.15,80);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),2.7,81);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),2.25,81);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),1.8,81);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),1.35,81);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),17.8,82);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),13.93,82);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),10.84,82);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),5.68,82);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),3.43,83);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.57,83);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),0.78,83);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),7.47,84);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.81,84);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),6.73,85);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.25,85);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),4.16,85);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),3.07,85);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),1.49,85);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('05-9月 -23','DD-MON-RR'),4.8,86);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),12.32,87);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.47,88);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),6,89);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),5.3,90);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),4.45,90);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.73,90);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),9.52,91);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),5.38,91);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.98,92);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),5.24,92);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),4.49,92);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),3.4,92);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),1.7,92);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),3.47,93);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),2.93,93);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),1.53,93);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),1.08,94);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),10.8,95);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),9.45,95);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),6.53,95);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),6.96,96);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.15,97);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),3.96,97);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),0.56,98);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),0.32,98);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),0.25,98);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),7.5,99);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),5,99);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),2.5,99);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),13.35,100);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),12.75,100);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),12,100);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),7.5,100);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),4.95,101);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),37.7,102);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),30.74,102);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),17.4,102);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),80,103);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),48,103);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),11.59,104);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),9.41,104);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),8.74,104);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),16.66,105);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),12.75,105);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),8.33,105);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),4.25,105);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),8.57,106);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),5.8,106);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),16.08,107);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),10.8,107);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),7.92,107);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),60.72,108);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),56.32,108);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),52.8,108);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),48.4,108);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),44,108);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),39.6,108);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),30.8,108);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('13-9月 -23','DD-MON-RR'),17.6,108);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),7.4,109);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),25.35,110);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),14.04,110);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),36.57,111);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),29.15,111);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),25.97,111);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),19.08,111);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),61.6,112);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),52.8,112);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),39.6,112);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),3.58,113);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),3.8,114);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),2.37,114);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('12-9月 -23','DD-MON-RR'),0.99,114);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),2.48,115);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),12.77,116);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),9.58,116);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),1.96,117);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),1.61,117);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),1.26,117);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),0.91,117);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),6.44,118);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),13.01,119);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),9.3,119);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),7.44,119);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.81,120);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),10.08,121);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),7.68,121);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),5.12,121);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),22.08,122);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),11.84,122);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),9.28,122);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),4.31,123);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),10.21,124);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),17.62,125);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),13.66,125);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),9.7,125);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),6.46,126);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),6.12,126);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),5.78,126);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('09-9月 -23','DD-MON-RR'),5.44,126);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('10-9月 -23','DD-MON-RR'),5.1,126);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('11-9月 -23','DD-MON-RR'),3.4,126);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),4.58,127);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),11.59,128);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),9.74,128);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),7.73,128);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),4.29,129);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),2.15,129);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),4.07,130);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),3.54,130);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),5.24,131);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),3.74,131);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),2.24,131);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('06-9月 -23','DD-MON-RR'),6.6,132);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('07-9月 -23','DD-MON-RR'),5.98,132);
Insert into C##LJX.COMMODITY_PRICE_CURVE (COM_PC_TIME,COM_PC_PRICE,COM_ID) values (to_date('08-9月 -23','DD-MON-RR'),4.4,132);
REM INSERTING into C##LJX.CUSTOMER
SET DEFINE OFF;
Insert into C##LJX.CUSTOMER (CUS_ID,CUS_NICKNAME,CUS_NOTES,CUS_PAYPASSWORD,CUS_STATE) values (1000012,'11','11','123',0);
Insert into C##LJX.CUSTOMER (CUS_ID,CUS_NICKNAME,CUS_NOTES,CUS_PAYPASSWORD,CUS_STATE) values (1000017,'张书豪','在校大三蒟蒻一枚 QAQ','123456',1);
Insert into C##LJX.CUSTOMER (CUS_ID,CUS_NICKNAME,CUS_NOTES,CUS_PAYPASSWORD,CUS_STATE) values (1000008,'王诗腾','想买点零食','123456',1);
Insert into C##LJX.CUSTOMER (CUS_ID,CUS_NICKNAME,CUS_NOTES,CUS_PAYPASSWORD,CUS_STATE) values (1000018,'张翔','吃吃吃！！！','123456',1);
Insert into C##LJX.CUSTOMER (CUS_ID,CUS_NICKNAME,CUS_NOTES,CUS_PAYPASSWORD,CUS_STATE) values (1000019,'qwq','qwqqqq','123456',1);
REM INSERTING into C##LJX.CUSTOMER_LOVE
SET DEFINE OFF;
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000012,'其他',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000012,'熟食',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000008,'果品',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000008,'零食',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000012,'肉制品',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000012,'蛋奶',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000017,'蛋奶',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000017,'面点',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000017,'零食',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000018,'果品',1);
Insert into C##LJX.CUSTOMER_LOVE (CUS_ID,COM_CATEGORY,CUS_LOVE_WEIGHT) values (1000019,'果品',1);
REM INSERTING into C##LJX.FAVORITE
SET DEFINE OFF;
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (4,1000018);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (6,1000017);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (7,1000008);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (25,1000018);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (38,1000017);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (59,1000008);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (63,1000017);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (94,1000017);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (145,1000008);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (150,1000018);
Insert into C##LJX.FAVORITE (COM_ID,CUS_ID) values (154,1000018);
REM INSERTING into C##LJX.INDENT
SET DEFINE OFF;
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (67,1,to_date('08-9月 -23','DD-MON-RR'),'fec71b27-0f84-40ea-be05-a7868aa22341',' ',0,1000018,43,to_date('01-1月 -01','DD-MON-RR'),'0',1.44,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (68,3,to_date('08-9月 -23','DD-MON-RR'),'6b20132f-7b59-4d17-b06a-c994269b7017','尽快备货~',1,1000017,144,to_date('01-1月 -01','DD-MON-RR'),'0',4.11,-1,4);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (69,1,to_date('09-9月 -23','DD-MON-RR'),'a3a983a1-616b-4fea-baf3-dd76283df655','包好房门口',1,1000018,61,to_date('01-1月 -01','DD-MON-RR'),'0',4.4,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (70,2,to_date('09-9月 -23','DD-MON-RR'),'a3a983a1-616b-4fea-baf3-dd76283df655','包好房门口',1,1000018,105,to_date('01-1月 -01','DD-MON-RR'),'0',16.66,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (71,3,to_date('09-9月 -23','DD-MON-RR'),'a3a983a1-616b-4fea-baf3-dd76283df655','包好房门口',1,1000018,169,to_date('01-1月 -01','DD-MON-RR'),'0',27.27,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (1,1,to_date('04-9月 -23','DD-MON-RR'),'3d81b55e-4597-4bdc-9853-fa75498732e2','要新鲜的',0,1000008,52,to_date('01-1月 -01','DD-MON-RR'),'0',5.98,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (2,5,to_date('04-9月 -23','DD-MON-RR'),'0f6a3f32-2a7a-4754-8584-a1b09b63782c','放到门口我自己拿',0,1000008,4,to_date('01-1月 -01','DD-MON-RR'),'0',44,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (3,10,to_date('04-9月 -23','DD-MON-RR'),'0f6a3f32-2a7a-4754-8584-a1b09b63782c','放到门口我自己拿',0,1000008,8,to_date('01-1月 -01','DD-MON-RR'),'0',74.5,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (4,3,to_date('04-9月 -23','DD-MON-RR'),'0f6a3f32-2a7a-4754-8584-a1b09b63782c','放到门口我自己拿',0,1000008,49,to_date('01-1月 -01','DD-MON-RR'),'0',9.24,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (41,4,to_date('07-9月 -23','DD-MON-RR'),'14f8a6c2-bd24-4d1a-aa8c-f7a2df4a171f','将于9.12取核销订单',0,1000017,94,to_date('01-1月 -01','DD-MON-RR'),'0',4.32,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (42,1,to_date('07-9月 -23','DD-MON-RR'),'8d37e469-77e9-4d6c-8360-ca7ccc20b173',' ',2,1000017,26,to_date('07-9月 -23','DD-MON-RR'),'不想要了',7.45,7.45,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (43,1,to_date('07-9月 -23','DD-MON-RR'),'3ccae5fd-812c-41b0-9b0d-cc2d8d728028',' ',2,1000017,26,to_date('07-9月 -23','DD-MON-RR'),'多买了',7.45,7.45,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (44,1,to_date('07-9月 -23','DD-MON-RR'),'b60c63ad-7e3d-4198-b630-1a7b641e345b',' ',2,1000017,26,to_date('07-9月 -23','DD-MON-RR'),'买错了',7.45,7.45,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (45,1,to_date('07-9月 -23','DD-MON-RR'),'f985aef7-ea52-4144-a78e-1cd61854f847',' ',0,1000017,26,to_date('01-1月 -01','DD-MON-RR'),'0',7.45,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (46,5,to_date('07-9月 -23','DD-MON-RR'),'914a0270-878e-4cf5-9b3f-7e76a44e2275','不错不错',0,1000017,144,to_date('01-1月 -01','DD-MON-RR'),'0',8.6,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (47,3,to_date('07-9月 -23','DD-MON-RR'),'c44b9203-de7b-4fb7-b05a-72abd42f75de',' ',0,1000017,144,to_date('01-1月 -01','DD-MON-RR'),'0',5.16,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (5,10,to_date('04-9月 -23','DD-MON-RR'),'c1aa2a7a-ae83-490c-a222-9c9c8fe107d1','希望尽快发货',1,1000017,43,to_date('01-1月 -01','DD-MON-RR'),'0',16.8,-1,5);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (6,12,to_date('04-9月 -23','DD-MON-RR'),'bc503a78-df0c-4876-ab80-baf9660bbd9c','超爱芒果，快快发货~',0,1000018,4,to_date('01-1月 -01','DD-MON-RR'),'0',105.6,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (7,2,to_date('04-9月 -23','DD-MON-RR'),'85a905f5-844c-4b3e-8fd9-9c9f77f89666',' ',0,1000017,9,to_date('01-1月 -01','DD-MON-RR'),'0',20.8,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (8,4,to_date('04-9月 -23','DD-MON-RR'),'c292f352-6150-492c-9ef2-9e7be67de620',' ',2,1000017,46,to_date('04-9月 -23','DD-MON-RR'),'不想要了',10.8,10.8,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (9,2,to_date('04-9月 -23','DD-MON-RR'),'ef362203-3853-42bf-8dd4-f4a5fa725452',' ',2,1000017,12,to_date('06-9月 -23','DD-MON-RR'),'不想要了',13.14,8.76,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (10,3,to_date('04-9月 -23','DD-MON-RR'),'ef362203-3853-42bf-8dd4-f4a5fa725452',' ',0,1000017,11,to_date('01-1月 -01','DD-MON-RR'),'0',1.5,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (11,2,to_date('04-9月 -23','DD-MON-RR'),'ef362203-3853-42bf-8dd4-f4a5fa725452',' ',0,1000017,9,to_date('01-1月 -01','DD-MON-RR'),'0',20.8,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (12,5,to_date('04-9月 -23','DD-MON-RR'),'872abf97-b3cc-4581-a59b-0c2dfbc644d5','想吃~',0,1000017,23,to_date('01-1月 -01','DD-MON-RR'),'0',108.9,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (13,5,to_date('04-9月 -23','DD-MON-RR'),'09802f75-d544-47ab-bcb7-cbf802b9fd2b','期待捏~',1,1000018,25,to_date('01-1月 -01','DD-MON-RR'),'0',15.6,-1,1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (14,2,to_date('04-9月 -23','DD-MON-RR'),'9e27e506-90f3-4e56-a958-e4c63fb4b7fb','期待~',1,1000017,25,to_date('01-1月 -01','DD-MON-RR'),'0',6.24,-1,4);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (15,2,to_date('05-9月 -23','DD-MON-RR'),'9932ef1e-ba02-4707-8ae3-db2f37a14fdf',' ',1,1000017,43,to_date('01-1月 -01','DD-MON-RR'),'0',3.36,-1,1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (16,1,to_date('05-9月 -23','DD-MON-RR'),'5a687ec8-ac9f-40c1-a455-261cf1e314bb',' ',1,1000018,10,to_date('01-1月 -01','DD-MON-RR'),'0',10.8,-1,2);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (17,1,to_date('05-9月 -23','DD-MON-RR'),'f6b9595b-b7c8-427d-bb7f-eafd8bad66a2',' ',0,1000017,7,to_date('01-1月 -01','DD-MON-RR'),'0',36.4,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (18,3,to_date('05-9月 -23','DD-MON-RR'),'77bd1d13-8ece-4a65-89f3-13dccd24050f',' ',1,1000017,5,to_date('01-1月 -01','DD-MON-RR'),'0',14.4,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (19,2,to_date('05-9月 -23','DD-MON-RR'),'77bd1d13-8ece-4a65-89f3-13dccd24050f',' ',1,1000017,6,to_date('01-1月 -01','DD-MON-RR'),'0',3.3,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (20,2,to_date('05-9月 -23','DD-MON-RR'),'77bd1d13-8ece-4a65-89f3-13dccd24050f',' ',1,1000017,8,to_date('01-1月 -01','DD-MON-RR'),'0',13.42,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (21,1,to_date('05-9月 -23','DD-MON-RR'),'fe98429d-854a-4b16-8828-384204c37fcf',' ',2,1000017,4,to_date('05-9月 -23','DD-MON-RR'),'不想要了',8.8,4.4,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (22,5,to_date('05-9月 -23','DD-MON-RR'),'ab5fb53b-6cae-4435-b668-f30b8866228a',' ',0,1000017,25,to_date('01-1月 -01','DD-MON-RR'),'0',0,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (23,5,to_date('05-9月 -23','DD-MON-RR'),'30836d96-6ecc-4a54-b87d-8116a3ae5ad2','买给俺儿子徐雷喝',0,1000008,43,to_date('01-1月 -01','DD-MON-RR'),'0',7.8,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (24,3,to_date('05-9月 -23','DD-MON-RR'),'ff746520-ed75-46bc-86ce-3d4e59d37162','不吃辣椒不革命',0,1000008,14,to_date('01-1月 -01','DD-MON-RR'),'0',20.79,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (25,2,to_date('05-9月 -23','DD-MON-RR'),'f36b4ad9-a7a7-4a92-b83b-cddbeb02a602','想要捏~',1,1000017,82,to_date('01-1月 -01','DD-MON-RR'),'0',35.6,-1,0);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (26,1,to_date('05-9月 -23','DD-MON-RR'),'890617cc-b01d-4d43-a83b-e67949092bcb',' ',0,1000017,38,to_date('01-1月 -01','DD-MON-RR'),'0',3.96,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (27,1,to_date('05-9月 -23','DD-MON-RR'),'9dcd6e78-c87e-4127-a212-2f63ce0d521d',' ',0,1000017,6,to_date('01-1月 -01','DD-MON-RR'),'0',1.65,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (28,1,to_date('06-9月 -23','DD-MON-RR'),'8e0d6166-9506-4c1f-ae07-1f53e2090e5e',' ',0,1000017,92,to_date('01-1月 -01','DD-MON-RR'),'0',5.98,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (29,5,to_date('06-9月 -23','DD-MON-RR'),'7e3e1a78-3028-4a4b-afd1-fd0d9992abce',' ',2,1000017,19,to_date('07-9月 -23','DD-MON-RR'),'买错了',74.75,74.75,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (30,1,to_date('06-9月 -23','DD-MON-RR'),'5a619c6d-f0e1-485b-be5b-2e1b87ccbcec',' ',2,1000017,19,to_date('06-9月 -23','DD-MON-RR'),null,14.95,14.95,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (31,2,to_date('06-9月 -23','DD-MON-RR'),'be032e34-1285-46ea-8425-d5cf4d5e5a51',' ',2,1000017,5,to_date('06-9月 -23','DD-MON-RR'),'不想要',9.6,8,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (61,2,to_date('08-9月 -23','DD-MON-RR'),'c3f42ab1-871f-4145-a264-dff0142d1713',' ',1,1000008,5,to_date('01-1月 -01','DD-MON-RR'),'0',6.4,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (62,1,to_date('08-9月 -23','DD-MON-RR'),'c3f42ab1-871f-4145-a264-dff0142d1713',' ',1,1000008,108,to_date('01-1月 -01','DD-MON-RR'),'0',52.8,-1,5);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (63,1,to_date('08-9月 -23','DD-MON-RR'),'c3f42ab1-871f-4145-a264-dff0142d1713',' ',1,1000008,143,to_date('01-1月 -01','DD-MON-RR'),'0',17.56,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (64,3,to_date('08-9月 -23','DD-MON-RR'),'3d7b3bfe-4f35-40dd-9a0f-79e80d3e0390','请尽快备货',0,1000018,108,to_date('01-1月 -01','DD-MON-RR'),'0',158.4,-1,-1);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (65,5,to_date('08-9月 -23','DD-MON-RR'),'45de43c3-1689-4e3f-830d-144375640d84',' ',1,1000018,153,to_date('01-1月 -01','DD-MON-RR'),'0',22.4,-1,5);
Insert into C##LJX.INDENT (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (66,1,to_date('08-9月 -23','DD-MON-RR'),'1e29340f-4e02-4a05-a1ef-61b8d1b95b41',' ',1,1000017,153,to_date('01-1月 -01','DD-MON-RR'),'0',4.48,-1,2);
REM INSERTING into C##LJX.NOTICE
SET DEFINE OFF;
Insert into C##LJX.NOTICE (NTC_ID,NTC_TIME,NTC_CONTENT,NTC_STATE,STO_ID) values (1,to_date('06-9月 -23','DD-MON-RR'),'从零售商到零售服务商，苏宁易购变革的底层逻辑是“开放利他”',1,1000005);
REM INSERTING into C##LJX.SCREENSHOT
SET DEFINE OFF;
Insert into C##LJX.SCREENSHOT (APP_ID,SCT_IMAGE) values (1,'appeal_image\appeal_img_1.jpg');
Insert into C##LJX.SCREENSHOT (APP_ID,SCT_IMAGE) values (2,'appeal_image\appeal_img_2.jpg');
Insert into C##LJX.SCREENSHOT (APP_ID,SCT_IMAGE) values (3,'appeal_image\appeal_img_3.jpg');
Insert into C##LJX.SCREENSHOT (APP_ID,SCT_IMAGE) values (4,'appeal_image\appeal_img_4.jpg');
Insert into C##LJX.SCREENSHOT (APP_ID,SCT_IMAGE) values (5,'appeal_image\appeal_img_5.jpg');
Insert into C##LJX.SCREENSHOT (APP_ID,SCT_IMAGE) values (6,'appeal_image\appeal_img_6.jpg');
Insert into C##LJX.SCREENSHOT (APP_ID,SCT_IMAGE) values (7,'appeal_image\appeal_img_7.jpg');
REM INSERTING into C##LJX.STORE
SET DEFINE OFF;
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000010,'河马鲜生','盒马是中国首家以数据和技术驱动的新零售平台。通过重构零售产业 “人、货、场”，打造了“盒马鲜生”、“盒马X会员店”、“盒马奥莱”等业态，致力于满足消费者对美好生活的向往，用科技和创新引领万千家庭的“鲜·美·生活”。','licenses\1000010_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000011,'大润发超市','大润发，由台湾润泰集团于1996年创立，1997年3月即在台湾桃园开出第一家完全由中国人自行设计规划营运管理的大型现代化超市，商场融合了传统市场的新鲜，量贩的便宜及百货公司的舒适便利，以直接生活化的方式为顾客服务。  大润发，于1998年7月在中国大陆开设第一家大型超市，是会员制大型连锁综合超市。康成投资（中国）有限公司持有“大润发”商标的合法权利，是“大润发”中国地区总部。中国大陆地区的“大润发”门店均为康成投资(中国)有限公司所投资设立。','licenses\1000011_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000004,'天猫超市','天猫超市 是阿里巴巴集团打造的一个网上超市。. 天猫超市 在线销售近万种商品，提供仓库物流配送，所有商品采用统一的商品包装。','licenses\1000004_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000005,'苏宁易购','苏宁易购集团股份有限公司是中国领先的智慧零售服务商,在互联网零售时代,苏宁持续推进智慧零售、场景互联战略,全品类拓展,全渠道在线,全客群融合。','licenses\1000005_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000006,'大润发','大润发，由台湾润泰集团于1996年创立，1997年3月即在台湾桃园开出第一家完全由中国人自行设计规划营运管理的大型现代化超市，商场融合了传统市场的新鲜，量贩的便宜及百货公司的舒适便利，以直接生活化的方式为顾客服务。','licenses\1000006_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000009,'Walmart','沃尔玛百货有限公司，是一家美国的世界性连锁企业，以营业额计算为全球最大的公司。连续7年在美国《财富》杂志世界500强企业中居首位。沃尔玛公司有8500家门店，分布于全球15个国家。沃尔玛在美国50个州和波多黎各运营。沃尔玛主要有沃尔玛购物广场、山姆会员店、沃尔玛商店、沃尔玛社区店等四种营业方式。','licenses\1000009_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000013,'天猫超市','天猫超市（Tmall Mart）是阿里巴巴集团旗下的网上超市，是集采购、仓储、销售、配送于一身的便民电商平台，于2011年4月上线[1][2]。  天猫超市提供丰富和本地化的商品供应，包括进口食品、食品饮料、粮油副食、美容洗护、家居用品、家庭清洁、母婴用品等生活必需品。采用专业仓储物流，提供“1小时达”、“半日达”、“次日达”等配送服务，采用商品统一入仓、统一打包','licenses\1000013_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000014,'大润发超市','大润发主要经营生鲜食品、休闲食品、日用杂品、家用纺织、五金家电、文化体育用品，三万多种生活必需品，大润发为您提供新鲜、便宜、舒适、便利的服务','licenses\1000014_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000015,'天猫超市','天猫超市整合原有天猫超市业务以及阿里大生态内的大卖场、超市等合作伙伴紧密合作，继续推进线上线下一体化。就此，“线上天猫超市+线下超市卖场”的超市新零售模式成形。天猫超市业务于2007年上线，目前覆盖全国，商品品类涵盖食品粮油、数码电子、护肤母婴等消费者日常生活所需的方方面面，给消费者带来了方便快捷的线上超市购物体验','licenses\1000015_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000016,'天猫超市','天猫超市是阿里巴巴集团全力打造的网上超市。  天猫超市提供进口食品、食品饮料、粮油副食、美容洗护、家居用品、家庭清洁、母婴用品等所有生活必需品。提供的服务包括：  一、商品保障  天猫超市依托淘宝强大的电子商务管理系统，在系统平台、采购、仓储、配送、和客户关系管理等方面大力投入，以确保优质品牌商品能够通过淘宝网络超市这一平台打造“生产工厂到仓储中心到顾客家中”这样一个成本最低、速度最快、效率最高的流通链路。  二、物流配送  天猫超市在上海整合仓储资源和物流配送资源，采用统一的商品包装，已经实现次日送达，并将陆续实现每日三配，指定时间送达，指定日期送达等配送服务。  三、一站式购齐，统一邮寄  天猫超市实现商品统一入仓，统一专业打包。','licenses\1000016_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000021,'沃尔玛','沃尔玛于1996年进入中国,在深圳开设了第一家沃尔玛门店和山姆会员商店.作为一家全渠道连锁零售企业,沃尔玛中国立足顾客体验,融合实体门店和多个电商渠道','licenses\1000021_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000022,'苏宁易购','苏宁易购是中国领先的智慧零售服务商，在互联网零售时代，苏宁持续推进智慧零售、场景互联战略，全品类拓展，全渠道在线，全客群融合，并通过开放供应云、用户云、物流云、金融云、营销云，实现从线上到线下，从城市到县镇，从购物中心到社区全覆盖，为消费者提供无处不在的1小时场景生活圈解决方案，全方位覆盖消费者的生活所需。2020年，苏宁易购再次位列《财富》全球500强，并且在2020年《中国500最具价值品牌》中，以2968.15亿元的品牌价值稳居零售业第一位。','licenses\1000022_license.jpg',1);
Insert into C##LJX.STORE (STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,STO_STATE) values (1000023,'苏宁易购','截至2020年6月，全场景苏宁易购线下网络覆盖全国，拥有苏宁广场、苏宁家乐福社区中心、苏宁百货、苏宁零售云、苏宁极物、苏宁红孩子等“一大两小多专”各类创新互联网门店，稳居国内线下网络前列；苏宁易购线上通过自营、开放和跨平台运营，跻身中国B2C行业前列，公司零售会员总数达6.02亿。','licenses\1000023_license.jpg',1);
REM INSERTING into C##LJX.STOREIMAGE
SET DEFINE OFF;
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000004,'store_image\1000004_picture_ca0fc326-5728-4698-9b84-6aa3905a9e7e.png');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000005,'store_image\1000005_picture_f0850614-2c28-4c78-a26a-7721fc8a78d8.jpg');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000006,'store_image\1000006_picture_60481544-ff27-428f-9ff4-ecc69126eb76.jpg');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000009,'store_image\1000009_picture_ae859242-b2c1-45ad-9141-27310c45def6.png');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000010,'store_image\1000010_picture_d58cdd94-96da-491c-b003-23891914988b.png');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000011,'store_image\1000011_picture_b1e56c9f-8ca7-4a54-b38b-e423076acd72.png');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000013,'store_image\1000013_picture_e9a6edf3-13a0-4343-8f97-347798f309d7.jpg');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000014,'store_image\1000014_picture_80a29653-56f2-47a5-b4d4-2acd7ebfdbb7.png');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000015,'store_image\1000015_picture_02d5f6ee-ee0d-4f33-bbe6-3dab1d28ea23.png');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000016,'store_image\1000016_picture_ddc11795-8837-4a52-aa13-005ec3e768d2.png');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000021,'store_image\1000021_picture_19875f11-0912-4d23-9607-9bb306c15ebd.png');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000022,'store_image\1000022_picture_911d7c12-1472-41d1-92b9-4ac71f3ce671.png');
Insert into C##LJX.STOREIMAGE (STO_ID,STO_IMAGE) values (1000023,'store_image\1000023_picture_9cc26472-17ed-4e7e-963a-5c1557382021.png');
REM INSERTING into C##LJX.STORE_CATEGORIES
SET DEFINE OFF;
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000004,'其他');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000004,'果品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000004,'零食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000004,'面点');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000004,'饮料');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000005,'零食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000005,'饮料');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000006,'果品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000006,'蔬菜');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000006,'预制菜');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000009,'其他');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000009,'果品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000009,'熟食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000009,'蔬菜');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000009,'蛋奶');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000009,'零食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000009,'面点');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000010,'果品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000010,'熟食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000010,'蔬菜');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000010,'蛋奶');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000010,'调味品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000010,'零食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000010,'预制菜');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000011,'熟食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000011,'肉制品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000011,'蔬菜');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000013,'蛋奶');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000013,'零食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000013,'面点');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000014,'果品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000014,'蔬菜');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000014,'蛋奶');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000014,'饮料');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000015,'其他');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000015,'果品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000015,'熟食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000015,'零食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000015,'面点');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000016,'肉制品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000016,'蛋奶');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000016,'零食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000016,'面点');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000021,'果品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000021,'熟食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000021,'肉制品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000021,'蔬菜');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000021,'蛋奶');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000021,'零食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000021,'面点');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000021,'饮料');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000022,'熟食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000022,'蛋奶');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000022,'零食');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000022,'饮料');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000023,'肉制品');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000023,'蛋奶');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000023,'预制菜');
Insert into C##LJX.STORE_CATEGORIES (STORE_ID,COM_CATEGORY) values (1000023,'饮料');
REM INSERTING into C##LJX.USERS
SET DEFINE OFF;
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547111','123456','上海市上海市嘉定区嘉三路',1,to_date('04-9月 -23','DD-MON-RR'),1,1000004,636.95);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547112','123456','上海市上海市嘉定区曹安公路4800号',1,to_date('04-9月 -23','DD-MON-RR'),1,1000005,45.63);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547114','123456','上海市上海市嘉定区',1,to_date('04-9月 -23','DD-MON-RR'),1,1000009,234.2);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547115','123456','上海市上海市嘉定区嘉四路',1,to_date('04-9月 -23','DD-MON-RR'),1,1000010,55.6);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547113','123456','上海市上海市嘉定区嘉二路',1,to_date('04-9月 -23','DD-MON-RR'),1,1000006,-81.13);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547119','123456','上海市上海市虹口区广中路586弄-1号',1,to_date('04-9月 -23','DD-MON-RR'),1,1000011,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('17879680000','123456','上海市上海市嘉定区嘉三路',1,to_date('04-9月 -23','DD-MON-RR'),0,1000008,263.93);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('18158836180','123','北京市北京市石景山区玉泉路16号院',1,to_date('04-9月 -23','DD-MON-RR'),0,1000012,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547118','123456','上海市上海市闵行区红松东路1252号',0,to_date('04-9月 -23','DD-MON-RR'),1,1000013,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547117','123456','上海市上海市杨浦区国泓路200号',0,to_date('04-9月 -23','DD-MON-RR'),1,1000014,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547116','123456','上海市上海市浦东新区高青路',0,to_date('04-9月 -23','DD-MON-RR'),1,1000015,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15380547121','123456','上海市上海市黄浦区人民大道200号-1321室',1,to_date('04-9月 -23','DD-MON-RR'),1,1000016,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('18736901275','422563809','上海市上海市嘉定区曹安公路4800号',1,to_date('04-9月 -23','DD-MON-RR'),0,1000017,884.39);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('18739979276','123456','上海市上海市嘉定区嘉二路',1,to_date('04-9月 -23','DD-MON-RR'),0,1000018,637.43);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('18352099879','123456','上海市上海市长宁区仙霞路31号',1,to_date('06-9月 -23','DD-MON-RR'),0,1000019,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('18158836181','123','北京市北京市东城区西华门大街',0,to_date('06-9月 -23','DD-MON-RR'),0,1000020,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('16380547111','123456','上海市上海市宝山区联谊路612弄-318号-临',0,to_date('06-9月 -23','DD-MON-RR'),1,1000021,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('15390547111','123456','上海市上海市青浦区沪青平公路2750',0,to_date('06-9月 -23','DD-MON-RR'),1,1000022,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('17380547111','123456','上海市上海市浦东新区临沂路61弄-58-临',0,to_date('06-9月 -23','DD-MON-RR'),1,1000023,0);
Insert into C##LJX.USERS (USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_REGTIME,USER_TYPE,USER_ID,USER_BALANCE) values ('18736901271','422563809','北京市北京市东城区天安门东通道',0,to_date('08-9月 -23','DD-MON-RR'),1,1000040,0);
REM INSERTING into C##LJX.INDENT_VIEW
SET DEFINE OFF;
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (67,1,to_date('08-9月 -23','DD-MON-RR'),'fec71b27-0f84-40ea-be05-a7868aa22341',' ',0,1000018,43,to_date('01-1月 -01','DD-MON-RR'),'0',1.44,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (68,3,to_date('08-9月 -23','DD-MON-RR'),'6b20132f-7b59-4d17-b06a-c994269b7017','尽快备货~',1,1000017,144,to_date('01-1月 -01','DD-MON-RR'),'0',4.11,-1,4);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (69,1,to_date('09-9月 -23','DD-MON-RR'),'a3a983a1-616b-4fea-baf3-dd76283df655','包好房门口',1,1000018,61,to_date('01-1月 -01','DD-MON-RR'),'0',4.4,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (70,2,to_date('09-9月 -23','DD-MON-RR'),'a3a983a1-616b-4fea-baf3-dd76283df655','包好房门口',1,1000018,105,to_date('01-1月 -01','DD-MON-RR'),'0',16.66,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (71,3,to_date('09-9月 -23','DD-MON-RR'),'a3a983a1-616b-4fea-baf3-dd76283df655','包好房门口',1,1000018,169,to_date('01-1月 -01','DD-MON-RR'),'0',27.27,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (1,1,to_date('04-9月 -23','DD-MON-RR'),'3d81b55e-4597-4bdc-9853-fa75498732e2','要新鲜的',0,1000008,52,to_date('01-1月 -01','DD-MON-RR'),'0',5.98,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (2,5,to_date('04-9月 -23','DD-MON-RR'),'0f6a3f32-2a7a-4754-8584-a1b09b63782c','放到门口我自己拿',0,1000008,4,to_date('01-1月 -01','DD-MON-RR'),'0',44,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (3,10,to_date('04-9月 -23','DD-MON-RR'),'0f6a3f32-2a7a-4754-8584-a1b09b63782c','放到门口我自己拿',0,1000008,8,to_date('01-1月 -01','DD-MON-RR'),'0',74.5,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (4,3,to_date('04-9月 -23','DD-MON-RR'),'0f6a3f32-2a7a-4754-8584-a1b09b63782c','放到门口我自己拿',0,1000008,49,to_date('01-1月 -01','DD-MON-RR'),'0',9.24,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (41,4,to_date('07-9月 -23','DD-MON-RR'),'14f8a6c2-bd24-4d1a-aa8c-f7a2df4a171f','将于9.12取核销订单',0,1000017,94,to_date('01-1月 -01','DD-MON-RR'),'0',4.32,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (42,1,to_date('07-9月 -23','DD-MON-RR'),'8d37e469-77e9-4d6c-8360-ca7ccc20b173',' ',2,1000017,26,to_date('07-9月 -23','DD-MON-RR'),'不想要了',7.45,7.45,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (43,1,to_date('07-9月 -23','DD-MON-RR'),'3ccae5fd-812c-41b0-9b0d-cc2d8d728028',' ',2,1000017,26,to_date('07-9月 -23','DD-MON-RR'),'多买了',7.45,7.45,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (44,1,to_date('07-9月 -23','DD-MON-RR'),'b60c63ad-7e3d-4198-b630-1a7b641e345b',' ',2,1000017,26,to_date('07-9月 -23','DD-MON-RR'),'买错了',7.45,7.45,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (45,1,to_date('07-9月 -23','DD-MON-RR'),'f985aef7-ea52-4144-a78e-1cd61854f847',' ',0,1000017,26,to_date('01-1月 -01','DD-MON-RR'),'0',7.45,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (46,5,to_date('07-9月 -23','DD-MON-RR'),'914a0270-878e-4cf5-9b3f-7e76a44e2275','不错不错',0,1000017,144,to_date('01-1月 -01','DD-MON-RR'),'0',8.6,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (47,3,to_date('07-9月 -23','DD-MON-RR'),'c44b9203-de7b-4fb7-b05a-72abd42f75de',' ',0,1000017,144,to_date('01-1月 -01','DD-MON-RR'),'0',5.16,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (5,10,to_date('04-9月 -23','DD-MON-RR'),'c1aa2a7a-ae83-490c-a222-9c9c8fe107d1','希望尽快发货',1,1000017,43,to_date('01-1月 -01','DD-MON-RR'),'0',16.8,-1,5);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (6,12,to_date('04-9月 -23','DD-MON-RR'),'bc503a78-df0c-4876-ab80-baf9660bbd9c','超爱芒果，快快发货~',0,1000018,4,to_date('01-1月 -01','DD-MON-RR'),'0',105.6,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (7,2,to_date('04-9月 -23','DD-MON-RR'),'85a905f5-844c-4b3e-8fd9-9c9f77f89666',' ',0,1000017,9,to_date('01-1月 -01','DD-MON-RR'),'0',20.8,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (8,4,to_date('04-9月 -23','DD-MON-RR'),'c292f352-6150-492c-9ef2-9e7be67de620',' ',2,1000017,46,to_date('04-9月 -23','DD-MON-RR'),'不想要了',10.8,10.8,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (9,2,to_date('04-9月 -23','DD-MON-RR'),'ef362203-3853-42bf-8dd4-f4a5fa725452',' ',2,1000017,12,to_date('06-9月 -23','DD-MON-RR'),'不想要了',13.14,8.76,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (10,3,to_date('04-9月 -23','DD-MON-RR'),'ef362203-3853-42bf-8dd4-f4a5fa725452',' ',0,1000017,11,to_date('01-1月 -01','DD-MON-RR'),'0',1.5,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (11,2,to_date('04-9月 -23','DD-MON-RR'),'ef362203-3853-42bf-8dd4-f4a5fa725452',' ',0,1000017,9,to_date('01-1月 -01','DD-MON-RR'),'0',20.8,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (12,5,to_date('04-9月 -23','DD-MON-RR'),'872abf97-b3cc-4581-a59b-0c2dfbc644d5','想吃~',0,1000017,23,to_date('01-1月 -01','DD-MON-RR'),'0',108.9,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (13,5,to_date('04-9月 -23','DD-MON-RR'),'09802f75-d544-47ab-bcb7-cbf802b9fd2b','期待捏~',1,1000018,25,to_date('01-1月 -01','DD-MON-RR'),'0',15.6,-1,1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (14,2,to_date('04-9月 -23','DD-MON-RR'),'9e27e506-90f3-4e56-a958-e4c63fb4b7fb','期待~',1,1000017,25,to_date('01-1月 -01','DD-MON-RR'),'0',6.24,-1,4);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (15,2,to_date('05-9月 -23','DD-MON-RR'),'9932ef1e-ba02-4707-8ae3-db2f37a14fdf',' ',1,1000017,43,to_date('01-1月 -01','DD-MON-RR'),'0',3.36,-1,1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (16,1,to_date('05-9月 -23','DD-MON-RR'),'5a687ec8-ac9f-40c1-a455-261cf1e314bb',' ',1,1000018,10,to_date('01-1月 -01','DD-MON-RR'),'0',10.8,-1,2);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (17,1,to_date('05-9月 -23','DD-MON-RR'),'f6b9595b-b7c8-427d-bb7f-eafd8bad66a2',' ',0,1000017,7,to_date('01-1月 -01','DD-MON-RR'),'0',36.4,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (18,3,to_date('05-9月 -23','DD-MON-RR'),'77bd1d13-8ece-4a65-89f3-13dccd24050f',' ',1,1000017,5,to_date('01-1月 -01','DD-MON-RR'),'0',14.4,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (19,2,to_date('05-9月 -23','DD-MON-RR'),'77bd1d13-8ece-4a65-89f3-13dccd24050f',' ',1,1000017,6,to_date('01-1月 -01','DD-MON-RR'),'0',3.3,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (20,2,to_date('05-9月 -23','DD-MON-RR'),'77bd1d13-8ece-4a65-89f3-13dccd24050f',' ',1,1000017,8,to_date('01-1月 -01','DD-MON-RR'),'0',13.42,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (21,1,to_date('05-9月 -23','DD-MON-RR'),'fe98429d-854a-4b16-8828-384204c37fcf',' ',2,1000017,4,to_date('05-9月 -23','DD-MON-RR'),'不想要了',8.8,4.4,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (22,5,to_date('05-9月 -23','DD-MON-RR'),'ab5fb53b-6cae-4435-b668-f30b8866228a',' ',0,1000017,25,to_date('01-1月 -01','DD-MON-RR'),'0',0,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (23,5,to_date('05-9月 -23','DD-MON-RR'),'30836d96-6ecc-4a54-b87d-8116a3ae5ad2','买给俺儿子徐雷喝',0,1000008,43,to_date('01-1月 -01','DD-MON-RR'),'0',7.8,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (24,3,to_date('05-9月 -23','DD-MON-RR'),'ff746520-ed75-46bc-86ce-3d4e59d37162','不吃辣椒不革命',0,1000008,14,to_date('01-1月 -01','DD-MON-RR'),'0',20.79,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (25,2,to_date('05-9月 -23','DD-MON-RR'),'f36b4ad9-a7a7-4a92-b83b-cddbeb02a602','想要捏~',1,1000017,82,to_date('01-1月 -01','DD-MON-RR'),'0',35.6,-1,0);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (26,1,to_date('05-9月 -23','DD-MON-RR'),'890617cc-b01d-4d43-a83b-e67949092bcb',' ',0,1000017,38,to_date('01-1月 -01','DD-MON-RR'),'0',3.96,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (27,1,to_date('05-9月 -23','DD-MON-RR'),'9dcd6e78-c87e-4127-a212-2f63ce0d521d',' ',0,1000017,6,to_date('01-1月 -01','DD-MON-RR'),'0',1.65,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (28,1,to_date('06-9月 -23','DD-MON-RR'),'8e0d6166-9506-4c1f-ae07-1f53e2090e5e',' ',0,1000017,92,to_date('01-1月 -01','DD-MON-RR'),'0',5.98,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (29,5,to_date('06-9月 -23','DD-MON-RR'),'7e3e1a78-3028-4a4b-afd1-fd0d9992abce',' ',2,1000017,19,to_date('07-9月 -23','DD-MON-RR'),'买错了',74.75,74.75,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (30,1,to_date('06-9月 -23','DD-MON-RR'),'5a619c6d-f0e1-485b-be5b-2e1b87ccbcec',' ',2,1000017,19,to_date('06-9月 -23','DD-MON-RR'),null,14.95,14.95,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (31,2,to_date('06-9月 -23','DD-MON-RR'),'be032e34-1285-46ea-8425-d5cf4d5e5a51',' ',2,1000017,5,to_date('06-9月 -23','DD-MON-RR'),'不想要',9.6,8,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (61,2,to_date('08-9月 -23','DD-MON-RR'),'c3f42ab1-871f-4145-a264-dff0142d1713',' ',1,1000008,5,to_date('01-1月 -01','DD-MON-RR'),'0',6.4,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (62,1,to_date('08-9月 -23','DD-MON-RR'),'c3f42ab1-871f-4145-a264-dff0142d1713',' ',1,1000008,108,to_date('01-1月 -01','DD-MON-RR'),'0',52.8,-1,5);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (63,1,to_date('08-9月 -23','DD-MON-RR'),'c3f42ab1-871f-4145-a264-dff0142d1713',' ',1,1000008,143,to_date('01-1月 -01','DD-MON-RR'),'0',17.56,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (64,3,to_date('08-9月 -23','DD-MON-RR'),'3d7b3bfe-4f35-40dd-9a0f-79e80d3e0390','请尽快备货',0,1000018,108,to_date('01-1月 -01','DD-MON-RR'),'0',158.4,-1,-1);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (65,5,to_date('08-9月 -23','DD-MON-RR'),'45de43c3-1689-4e3f-830d-144375640d84',' ',1,1000018,153,to_date('01-1月 -01','DD-MON-RR'),'0',22.4,-1,5);
Insert into C##LJX.INDENT_VIEW (IND_ID,IND_QUANTITY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_MONEY,IND_RMONEY,IND_RATING) values (66,1,to_date('08-9月 -23','DD-MON-RR'),'1e29340f-4e02-4a05-a1ef-61b8d1b95b41',' ',1,1000017,153,to_date('01-1月 -01','DD-MON-RR'),'0',4.48,-1,2);
--------------------------------------------------------
--  DDL for Index ADMINISTRATOR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."ADMINISTRATOR_PK" ON "C##LJX"."ADMINISTRATOR" ("ADMIN_ID") 
  ;
--------------------------------------------------------
--  DDL for Index APPEAL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."APPEAL_PK" ON "C##LJX"."APPEAL" ("APP_ID") 
  ;
--------------------------------------------------------
--  DDL for Index BROWSE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."BROWSE_PK" ON "C##LJX"."BROWSE" ("BRO_TIME_START", "COM_ID", "BROWSER_ID") 
  ;
--------------------------------------------------------
--  DDL for Index CHAT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."CHAT_PK" ON "C##LJX"."CHAT" ("CHAT_TIME", "CUS_ID", "STORE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index COMMODITIES_CATEGORIES$_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."COMMODITIES_CATEGORIES$_PK" ON "C##LJX"."COMMODITIES_CATEGORIES" ("COM_CATEGORY") 
  ;
--------------------------------------------------------
--  DDL for Index COMMODITY_IMAGE_PK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."COMMODITY_IMAGE_PK1" ON "C##LJX"."COMMODITY_IMAGE" ("COM_ID", "COM_IMAGE") 
  ;
--------------------------------------------------------
--  DDL for Index COMMODITY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."COMMODITY_PK" ON "C##LJX"."COMMODITY" ("COM_ID") 
  ;
--------------------------------------------------------
--  DDL for Index COMMODITY_PRICE_CURVE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."COMMODITY_PRICE_CURVE_PK" ON "C##LJX"."COMMODITY_PRICE_CURVE" ("COM_PC_TIME", "COM_ID") 
  ;
--------------------------------------------------------
--  DDL for Index CUSTOMER_LOVE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."CUSTOMER_LOVE_PK" ON "C##LJX"."CUSTOMER_LOVE" ("CUS_ID", "COM_CATEGORY") 
  ;
--------------------------------------------------------
--  DDL for Index CUSTOMER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."CUSTOMER_PK" ON "C##LJX"."CUSTOMER" ("CUS_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FAVORITE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."FAVORITE_PK" ON "C##LJX"."FAVORITE" ("COM_ID", "CUS_ID") 
  ;
--------------------------------------------------------
--  DDL for Index INDENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."INDENT_PK" ON "C##LJX"."INDENT" ("IND_ID") 
  ;
--------------------------------------------------------
--  DDL for Index NOTICE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."NOTICE_PK" ON "C##LJX"."NOTICE" ("NTC_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PK_COMMODITY_CATEGORIES
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."PK_COMMODITY_CATEGORIES" ON "C##LJX"."COMMODITY_CATEGORIES" ("COM_ID", "COM_CATEGORY") 
  ;
--------------------------------------------------------
--  DDL for Index SCREENSHOT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."SCREENSHOT_PK" ON "C##LJX"."SCREENSHOT" ("APP_ID", "SCT_IMAGE") 
  ;
--------------------------------------------------------
--  DDL for Index STOREIMAGE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."STOREIMAGE_PK" ON "C##LJX"."STOREIMAGE" ("STO_IMAGE", "STO_ID") 
  ;
--------------------------------------------------------
--  DDL for Index STORE_CATEGORIES_PK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."STORE_CATEGORIES_PK1" ON "C##LJX"."STORE_CATEGORIES" ("STORE_ID", "COM_CATEGORY") 
  ;
--------------------------------------------------------
--  DDL for Index STORE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."STORE_PK" ON "C##LJX"."STORE" ("STO_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C008665
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."SYS_C008665" ON "C##LJX"."COMMODITY_COMMENT" ("CMT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index USERS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."USERS_PK" ON "C##LJX"."USERS" ("USER_ID") 
  ;
--------------------------------------------------------
--  DDL for Index USERS_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."USERS_UK1" ON "C##LJX"."USERS" ("USER_PHONE") 
  ;
--------------------------------------------------------
--  DDL for Index ADMINISTRATOR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."ADMINISTRATOR_PK" ON "C##LJX"."ADMINISTRATOR" ("ADMIN_ID") 
  ;
--------------------------------------------------------
--  DDL for Index APPEAL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."APPEAL_PK" ON "C##LJX"."APPEAL" ("APP_ID") 
  ;
--------------------------------------------------------
--  DDL for Index BROWSE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."BROWSE_PK" ON "C##LJX"."BROWSE" ("BRO_TIME_START", "COM_ID", "BROWSER_ID") 
  ;
--------------------------------------------------------
--  DDL for Index CHAT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."CHAT_PK" ON "C##LJX"."CHAT" ("CHAT_TIME", "CUS_ID", "STORE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index COMMODITIES_CATEGORIES$_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."COMMODITIES_CATEGORIES$_PK" ON "C##LJX"."COMMODITIES_CATEGORIES" ("COM_CATEGORY") 
  ;
--------------------------------------------------------
--  DDL for Index COMMODITY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."COMMODITY_PK" ON "C##LJX"."COMMODITY" ("COM_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PK_COMMODITY_CATEGORIES
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."PK_COMMODITY_CATEGORIES" ON "C##LJX"."COMMODITY_CATEGORIES" ("COM_ID", "COM_CATEGORY") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C008665
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."SYS_C008665" ON "C##LJX"."COMMODITY_COMMENT" ("CMT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index COMMODITY_IMAGE_PK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."COMMODITY_IMAGE_PK1" ON "C##LJX"."COMMODITY_IMAGE" ("COM_ID", "COM_IMAGE") 
  ;
--------------------------------------------------------
--  DDL for Index COMMODITY_PRICE_CURVE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."COMMODITY_PRICE_CURVE_PK" ON "C##LJX"."COMMODITY_PRICE_CURVE" ("COM_PC_TIME", "COM_ID") 
  ;
--------------------------------------------------------
--  DDL for Index CUSTOMER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."CUSTOMER_PK" ON "C##LJX"."CUSTOMER" ("CUS_ID") 
  ;
--------------------------------------------------------
--  DDL for Index CUSTOMER_LOVE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."CUSTOMER_LOVE_PK" ON "C##LJX"."CUSTOMER_LOVE" ("CUS_ID", "COM_CATEGORY") 
  ;
--------------------------------------------------------
--  DDL for Index FAVORITE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."FAVORITE_PK" ON "C##LJX"."FAVORITE" ("COM_ID", "CUS_ID") 
  ;
--------------------------------------------------------
--  DDL for Index INDENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."INDENT_PK" ON "C##LJX"."INDENT" ("IND_ID") 
  ;
--------------------------------------------------------
--  DDL for Index NOTICE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."NOTICE_PK" ON "C##LJX"."NOTICE" ("NTC_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SCREENSHOT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."SCREENSHOT_PK" ON "C##LJX"."SCREENSHOT" ("APP_ID", "SCT_IMAGE") 
  ;
--------------------------------------------------------
--  DDL for Index STORE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."STORE_PK" ON "C##LJX"."STORE" ("STO_ID") 
  ;
--------------------------------------------------------
--  DDL for Index STOREIMAGE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."STOREIMAGE_PK" ON "C##LJX"."STOREIMAGE" ("STO_IMAGE", "STO_ID") 
  ;
--------------------------------------------------------
--  DDL for Index STORE_CATEGORIES_PK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."STORE_CATEGORIES_PK1" ON "C##LJX"."STORE_CATEGORIES" ("STORE_ID", "COM_CATEGORY") 
  ;
--------------------------------------------------------
--  DDL for Index USERS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."USERS_PK" ON "C##LJX"."USERS" ("USER_ID") 
  ;
--------------------------------------------------------
--  DDL for Index USERS_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##LJX"."USERS_UK1" ON "C##LJX"."USERS" ("USER_PHONE") 
  ;
--------------------------------------------------------
--  DDL for Trigger SET_COM_RATING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##LJX"."SET_COM_RATING" 
INSTEAD OF UPDATE ON INDENT_VIEW
FOR EACH ROW
BEGIN
    -- ????????INDENT??
    UPDATE INDENT
    SET 
        IND_ID = :NEW.IND_ID,
        IND_QUANTITY = :NEW.IND_QUANTITY,
        IND_MONEY = :NEW.IND_MONEY,
        IND_CREATIONTIME = :NEW.IND_CREATIONTIME,
        IND_VERIFICATIONCODE = :NEW.IND_VERIFICATIONCODE,
        IND_NOTES = :NEW.IND_NOTES,
        IND_STATE = :NEW.IND_STATE,
        IND_RATING = :NEW.IND_RATING,
        CUS_ID = :NEW.CUS_ID,
        COM_ID = :NEW.COM_ID,
        IND_RTIME = :NEW.IND_RTIME,
        IND_RNOTES = :NEW.IND_RNOTES,
        IND_RMONEY = :NEW.IND_RMONEY
    WHERE 
        IND_ID = :OLD.IND_ID; 

    -- ????COMMODITY??
    UPDATE C##LJX.COMMODITY
    SET COM_RATING = (
        SELECT AVG(IND_RATING)
        FROM C##LJX.INDENT
        WHERE COM_ID = :NEW.COM_ID AND IND_RATING!=-1

        GROUP BY COM_ID
    )
    WHERE COM_ID = :NEW.COM_ID;
END;


/
ALTER TRIGGER "C##LJX"."SET_COM_RATING" ENABLE;
--------------------------------------------------------
--  DDL for Trigger SET_COM_STATUS_BEFORE_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##LJX"."SET_COM_STATUS_BEFORE_INSERT" 
BEFORE INSERT ON COMMODITY
FOR EACH ROW
BEGIN
    :NEW.COM_STATUS := 1;
END;




/
ALTER TRIGGER "C##LJX"."SET_COM_STATUS_BEFORE_INSERT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger SET_COM_STATUS_WHEN_ADD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##LJX"."SET_COM_STATUS_WHEN_ADD" 
BEFORE UPDATE OF COM_LEFT ON COMMODITY
FOR EACH ROW
BEGIN
    IF :OLD.COM_LEFT = 0 AND :NEW.COM_LEFT > 0 THEN
        :NEW.COM_STATUS := 1;
    END IF;
END;




/
ALTER TRIGGER "C##LJX"."SET_COM_STATUS_WHEN_ADD" ENABLE;
--------------------------------------------------------
--  DDL for Trigger SET_COM_STATUS_WHEN_EMPTY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##LJX"."SET_COM_STATUS_WHEN_EMPTY" 
BEFORE UPDATE OF COM_LEFT ON COMMODITY
FOR EACH ROW
BEGIN
    IF :NEW.COM_LEFT = 0 THEN
        :NEW.COM_STATUS := 0;
    END IF;
END;




/
ALTER TRIGGER "C##LJX"."SET_COM_STATUS_WHEN_EMPTY" ENABLE;
--------------------------------------------------------
--  DDL for Trigger SET_COM_STATUS_WHEN_ADD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##LJX"."SET_COM_STATUS_WHEN_ADD" 
BEFORE UPDATE OF COM_LEFT ON COMMODITY
FOR EACH ROW
BEGIN
    IF :OLD.COM_LEFT = 0 AND :NEW.COM_LEFT > 0 THEN
        :NEW.COM_STATUS := 1;
    END IF;
END;




/
ALTER TRIGGER "C##LJX"."SET_COM_STATUS_WHEN_ADD" ENABLE;
--------------------------------------------------------
--  DDL for Trigger SET_COM_STATUS_WHEN_EMPTY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##LJX"."SET_COM_STATUS_WHEN_EMPTY" 
BEFORE UPDATE OF COM_LEFT ON COMMODITY
FOR EACH ROW
BEGIN
    IF :NEW.COM_LEFT = 0 THEN
        :NEW.COM_STATUS := 0;
    END IF;
END;




/
ALTER TRIGGER "C##LJX"."SET_COM_STATUS_WHEN_EMPTY" ENABLE;
--------------------------------------------------------
--  DDL for Trigger SET_COM_STATUS_BEFORE_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##LJX"."SET_COM_STATUS_BEFORE_INSERT" 
BEFORE INSERT ON COMMODITY
FOR EACH ROW
BEGIN
    :NEW.COM_STATUS := 1;
END;




/
ALTER TRIGGER "C##LJX"."SET_COM_STATUS_BEFORE_INSERT" ENABLE;
--------------------------------------------------------
--  DDL for Procedure CALCULATE_ITEM_PREFERENCE_PROCEDURE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##LJX"."CALCULATE_ITEM_PREFERENCE_PROCEDURE" (
    p_userID IN INT,
    p_comID IN INT,
    p_w1 IN NUMBER,
    p_w2 IN NUMBER,
    p_w3 IN NUMBER,
    p_w4 IN NUMBER,
    p_w5 IN NUMBER,
    p_preference OUT NUMBER
) AS
    v_purchaseCount INT;
    v_browseCount INT;
    v_rating NUMBER;
    v_categoryMatch INT;
    v_isFavorite INT;
    p_fifteenDaysAgo DATE := SYSDATE - 15;
BEGIN
    -- 获取购买次数
    SELECT NVL(SUM(CASE WHEN IND_STATE = 1 THEN 1 ELSE 0 END), 0)
    INTO v_purchaseCount
    FROM INDENT
    WHERE CUS_ID = p_userID AND COM_ID = p_comID;

    -- 获取近15天浏览次数
    SELECT NVL(COUNT(*), 0)
    INTO v_browseCount
    FROM BROWSE
    WHERE com_ID = p_comID AND browser_ID = p_userID AND bro_time_start >= p_fifteenDaysAgo;

    -- 获取平均商品评分（排除评分为负1的情况）
   SELECT NVL(AVG(CASE WHEN IND_RATING <> -1 THEN IND_RATING ELSE NULL END), 0)
   INTO v_rating
   FROM INDENT
   WHERE CUS_ID = p_userID AND COM_ID = p_comID AND IND_RATING IS NOT NULL;

    -- 判断商品和用户喜好是否相同
    SELECT NVL(COUNT(*), 0)
    INTO v_categoryMatch
    FROM CUSTOMER_LOVE CL
    INNER JOIN COMMODITY_CATEGORIES C ON CL.COM_CATEGORY = C.COM_CATEGORY
    WHERE CL.CUS_ID = p_userID AND C.COM_ID = p_comID;

    -- 判断商品是否被用户收藏
    SELECT NVL(COUNT(*), 0)
    INTO v_isFavorite
    FROM FAVORITE
    WHERE CUS_ID = p_userID AND COM_ID = p_comID;

    -- 计算加权得分
    p_preference := (v_purchaseCount * p_w1) + (v_browseCount * p_w2) + (v_rating * p_w3) + (v_categoryMatch * p_w4) + (v_isFavorite * p_w5);
END;



/
--------------------------------------------------------
--  DDL for Procedure CALCULATE_ITEM_SIMILARITY_PROCEDURE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##LJX"."CALCULATE_ITEM_SIMILARITY_PROCEDURE" (
    p_itemID1 IN INT,
    p_itemID2 IN INT,
    p_w1 IN NUMBER,
    p_w2 IN NUMBER,
    p_w3 IN NUMBER,
    p_w4 IN NUMBER,
    p_w5 IN NUMBER,
    v_similarity OUT NUMBER
) 
AS
    v_dotProduct NUMBER := 0.0;
    v_norm1 NUMBER := 0.0;
    v_norm2 NUMBER := 0.0;
    v_preference1 NUMBER;
    v_preference2 NUMBER;

    -- 声明游标
    CURSOR related_users_cursor IS
        SELECT DISTINCT CUS_ID 
        FROM INDENT 
        WHERE COM_ID = p_itemID1 OR COM_ID = p_itemID2
        OR EXISTS (SELECT 1 FROM BROWSE WHERE (COM_ID = p_itemID1 OR COM_ID = p_itemID2) AND BROWSER_ID = CUS_ID);
BEGIN

    -- 插入相关用户
    FOR rec IN related_users_cursor
    LOOP
        -- 计算喜好程度
        Calculate_Item_Preference_Procedure(
            p_userID => rec.CUS_ID,
            p_comID => p_itemID1,
            p_w1 => p_w1,
            p_w2 => p_w2,
            p_w3 => p_w3,
            p_w4 => p_w4,
            p_w5 => p_w5,
            p_preference => v_preference1
        );

        Calculate_Item_Preference_Procedure(
            p_userID => rec.CUS_ID,
            p_comID => p_itemID2,
            p_w1 => p_w1,
            p_w2 => p_w2,
            p_w3 => p_w3,
            p_w4 => p_w4,
            p_w5 => p_w5,
            p_preference => v_preference2
        );

        v_dotProduct := v_dotProduct + (v_preference1 * v_preference2);
        v_norm1 := v_norm1 + (v_preference1 * v_preference1);
        v_norm2 := v_norm2 + (v_preference2 * v_preference2);
    END LOOP;

    v_norm1 := SQRT(v_norm1);
    v_norm2 := SQRT(v_norm2);

    IF v_norm1 = 0 OR v_norm2 = 0 THEN
        v_similarity := 0.0;
    ELSE
        v_similarity := v_dotProduct / (v_norm1 * v_norm2);
    END IF;


END;



/
--------------------------------------------------------
--  DDL for Procedure GET_ALL_COM_REFERENCE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##LJX"."GET_ALL_COM_REFERENCE" (
    cus_id IN INT, 
    result_cursor OUT SYS_REFCURSOR
)AS 

BEGIN
  OPEN result_cursor FOR
     WITH K2 AS (SELECT com_ID as com_ID
     FROM COMMODITY
     WHERE com_status = 1)
     SELECT com_ID, GET_PREFERENCE(cus_id,com_ID) as preference
     FROM K2;
END GET_ALL_COM_REFERENCE;



/
--------------------------------------------------------
--  DDL for Procedure GET_COM_SIM_PROC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##LJX"."GET_COM_SIM_PROC" (cus_id IN INT, result_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN result_cursor FOR
     WITH K1 AS(
        (
            SELECT com_ID
        FROM (
            SELECT com_ID,
                   ROW_NUMBER() OVER (PARTITION BY com_ID ORDER BY bro_time_start DESC) AS rn
            FROM BROWSE natural join commodity
            WHERE browser_id = cus_id and com_status = 1
              ORDER BY bro_time_start DESC
        ) temp
        WHERE rn = 1
        )UNION
        (
        SELECT com_ID
        FROM (
            SELECT com_ID,
                   ROW_NUMBER() OVER (PARTITION BY com_ID ORDER BY ind_creationTime DESC) AS rn
            FROM INDENT
            WHERE cus_ID = cus_id
              ORDER BY ind_creationTime DESC
        ) temp

        )
        ),
        K2 AS (SELECT com_ID as available_id
        FROM COMMODITY
        WHERE com_status = 1)
        SELECT com_ID,available_id,get_sim(com_ID,available_id) as sim
        FROM K1,K2;
END GET_COM_SIM_PROC;



/
--------------------------------------------------------
--  DDL for Procedure SET_COM_STATUS_TO_BAD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##LJX"."SET_COM_STATUS_TO_BAD" AS
BEGIN
  UPDATE Commodity
  SET COM_STATUS = -1
  WHERE com_expirationdate <= TRUNC(SYSDATE);
  COMMIT;
END;




/
--------------------------------------------------------
--  DDL for Package TYPES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "C##LJX"."TYPES" AS
    TYPE ref_cursor IS REF CURSOR;
END types;


/
--------------------------------------------------------
--  DDL for Function GET_AVAILABLE_COMMODITIES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "C##LJX"."GET_AVAILABLE_COMMODITIES" 
RETURN SYS_REFCURSOR IS
    result_cursor SYS_REFCURSOR;
BEGIN
    OPEN result_cursor FOR
        SELECT com_ID as available_id
        FROM COMMODITY
        WHERE com_status = 1;

    RETURN result_cursor;
END GET_AVAILABLE_COMMODITIES;



/
--------------------------------------------------------
--  DDL for Function GET_COM_SIM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "C##LJX"."GET_COM_SIM" (cus_id IN INT)
RETURN SYS_REFCURSOR IS
    result_cursor SYS_REFCURSOR;

BEGIN

        OPEN result_cursor FOR
        WITH K1 AS(
        (
            SELECT com_ID
        FROM (
            SELECT com_ID,
                   ROW_NUMBER() OVER (PARTITION BY com_ID ORDER BY bro_time_start DESC) AS rn
            FROM BROWSE
            WHERE browser_id = cus_id
              ORDER BY bro_time_start DESC
        ) temp
        WHERE rn = 1
        )UNION
        (
        SELECT com_ID
        FROM (
            SELECT com_ID,
                   ROW_NUMBER() OVER (PARTITION BY com_ID ORDER BY ind_creationTime DESC) AS rn
            FROM INDENT
            WHERE cus_ID = cus_id
              ORDER BY ind_creationTime DESC
        ) temp

        )
        ),
        K2 AS (SELECT com_ID as available_id
        FROM COMMODITY
        WHERE com_status = 1)
        SELECT com_ID,available_id,get_sim(com_ID,available_id) as sim
        FROM K1,K2;

    RETURN result_cursor;
END GET_COM_SIM;



/
--------------------------------------------------------
--  DDL for Function GET_PREFERENCE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "C##LJX"."GET_PREFERENCE" (
    p_userID IN INT,
    p_comID IN INT) 
RETURN NUMBER IS
result_num NUMBER;
BEGIN
  Calculate_Item_Preference_Procedure(p_userID,p_comID,10,2,2,10,8,result_num);
  return result_num;
END GET_PREFERENCE;



/
--------------------------------------------------------
--  DDL for Function GET_SIM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "C##LJX"."GET_SIM" (item1 in INT,item2 in INT)
RETURN NUMBER IS
result_num NUMBER;
BEGIN
  Calculate_Item_Similarity_Procedure(item1,item2,10,2,2,10,8,result_num);
  return result_num;
END GET_SIM;



/
--------------------------------------------------------
--  DDL for Function GET_USER_COMLIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "C##LJX"."GET_USER_COMLIST" (cus_id IN NUMBER)
RETURN SYS_REFCURSOR IS
    result_cursor SYS_REFCURSOR;
BEGIN
   OPEN result_cursor FOR

            SELECT com_ID
        FROM (
            SELECT com_ID,
                   ROW_NUMBER() OVER (PARTITION BY com_ID ORDER BY bro_time_start DESC) AS rn
            FROM BROWSE
            WHERE browser_id = cus_id
              ORDER BY bro_time_start DESC
        ) temp
        WHERE rn = 1

       ;

    RETURN result_cursor;
END GET_USER_COMLIST;



/
--------------------------------------------------------
--  Constraints for Table ADMINISTRATOR
--------------------------------------------------------

  ALTER TABLE "C##LJX"."ADMINISTRATOR" MODIFY ("ADMIN_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."ADMINISTRATOR" ADD CONSTRAINT "ADMINISTRATOR_CHK1" CHECK ( admin_state = 0
                                              OR admin_state = 1 ) ENABLE;
  ALTER TABLE "C##LJX"."ADMINISTRATOR" ADD CONSTRAINT "ADMINISTRATOR_PK" PRIMARY KEY ("ADMIN_ID")
  USING INDEX "C##LJX"."ADMINISTRATOR_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table APPEAL
--------------------------------------------------------

  ALTER TABLE "C##LJX"."APPEAL" ADD CONSTRAINT "APPEAL_CHK1" CHECK (app_matters = 1 OR app_matters = 2 OR app_matters = 3 OR app_matters = 4 OR app_matters = 5 OR app_matters = 6) ENABLE;
  ALTER TABLE "C##LJX"."APPEAL" MODIFY ("APP_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."APPEAL" ADD CONSTRAINT "APPEAL_PK" PRIMARY KEY ("APP_ID")
  USING INDEX "C##LJX"."APPEAL_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table BROWSE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."BROWSE" MODIFY ("BRO_TIME_START" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."BROWSE" MODIFY ("BRO_TIME_END" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."BROWSE" MODIFY ("COM_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."BROWSE" MODIFY ("BROWSER_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."BROWSE" ADD CONSTRAINT "BROWSE_PK" PRIMARY KEY ("BRO_TIME_START", "COM_ID", "BROWSER_ID")
  USING INDEX "C##LJX"."BROWSE_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CHAT
--------------------------------------------------------

  ALTER TABLE "C##LJX"."CHAT" MODIFY ("CHAT_TIME" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CHAT" MODIFY ("CUS_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CHAT" MODIFY ("STORE_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CHAT" ADD CONSTRAINT "CHAT_PK" PRIMARY KEY ("CHAT_TIME", "CUS_ID", "STORE_ID")
  USING INDEX "C##LJX"."CHAT_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table COMMODITIES_CATEGORIES
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITIES_CATEGORIES" MODIFY ("COM_CATEGORY" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITIES_CATEGORIES" ADD CONSTRAINT "COMMODITIES_CATEGORIES$_PK" PRIMARY KEY ("COM_CATEGORY")
  USING INDEX "C##LJX"."COMMODITIES_CATEGORIES$_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table COMMODITY
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY" MODIFY ("COM_RATING" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY" MODIFY ("COM_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY" MODIFY ("COM_NAME" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY" MODIFY ("COM_INTRODUCTION" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY" MODIFY ("COM_EXPIRATIONDATE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY" MODIFY ("COM_UPLOADDATE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY" MODIFY ("COM_LEFT" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY" MODIFY ("STO_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY" ADD CONSTRAINT "COMMODITYCHECK" CHECK ( com_expirationdate > com_uploaddate
                                          AND com_left > 0 ) DISABLE;
  ALTER TABLE "C##LJX"."COMMODITY" ADD CONSTRAINT "COMMODITY_PK" PRIMARY KEY ("COM_ID")
  USING INDEX "C##LJX"."COMMODITY_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table COMMODITY_CATEGORIES
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY_CATEGORIES" MODIFY ("COM_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_CATEGORIES" MODIFY ("COM_CATEGORY" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_CATEGORIES" ADD CONSTRAINT "PK_COMMODITY_CATEGORIES" PRIMARY KEY ("COM_ID", "COM_CATEGORY")
  USING INDEX "C##LJX"."PK_COMMODITY_CATEGORIES"  ENABLE;
--------------------------------------------------------
--  Constraints for Table COMMODITY_COMMENT
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY_COMMENT" MODIFY ("CMT_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_COMMENT" MODIFY ("CMT_FATHER" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_COMMENT" MODIFY ("CMT_CONTENT" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_COMMENT" MODIFY ("CMT_TIME" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_COMMENT" MODIFY ("COM_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_COMMENT" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_COMMENT" ADD PRIMARY KEY ("CMT_ID")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table COMMODITY_IMAGE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY_IMAGE" MODIFY ("COM_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_IMAGE" MODIFY ("COM_IMAGE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_IMAGE" ADD CONSTRAINT "COMMODITY_IMAGE_PK1" PRIMARY KEY ("COM_ID", "COM_IMAGE")
  USING INDEX "C##LJX"."COMMODITY_IMAGE_PK1"  ENABLE;
--------------------------------------------------------
--  Constraints for Table COMMODITY_PRICE_CURVE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY_PRICE_CURVE" MODIFY ("COM_PC_TIME" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."COMMODITY_PRICE_CURVE" ADD CONSTRAINT "COMMODITY_PRICE_CURVE_PK" PRIMARY KEY ("COM_PC_TIME", "COM_ID")
  USING INDEX "C##LJX"."COMMODITY_PRICE_CURVE_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CUSTOMER
--------------------------------------------------------

  ALTER TABLE "C##LJX"."CUSTOMER" MODIFY ("CUS_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CUSTOMER" MODIFY ("CUS_NICKNAME" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CUSTOMER" MODIFY ("CUS_NOTES" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CUSTOMER" MODIFY ("CUS_PAYPASSWORD" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CUSTOMER" MODIFY ("CUS_STATE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CUSTOMER" ADD CONSTRAINT "CUSTOMER_PK" PRIMARY KEY ("CUS_ID")
  USING INDEX "C##LJX"."CUSTOMER_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CUSTOMER_LOVE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."CUSTOMER_LOVE" MODIFY ("CUS_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CUSTOMER_LOVE" MODIFY ("COM_CATEGORY" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CUSTOMER_LOVE" MODIFY ("CUS_LOVE_WEIGHT" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."CUSTOMER_LOVE" ADD CONSTRAINT "CUSTOMER_LOVE_PK" PRIMARY KEY ("CUS_ID", "COM_CATEGORY")
  USING INDEX "C##LJX"."CUSTOMER_LOVE_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table FAVORITE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."FAVORITE" ADD CONSTRAINT "FAVORITE_PK" PRIMARY KEY ("COM_ID", "CUS_ID")
  USING INDEX "C##LJX"."FAVORITE_PK"  ENABLE;
  ALTER TABLE "C##LJX"."FAVORITE" MODIFY ("COM_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."FAVORITE" MODIFY ("CUS_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table INDENT
--------------------------------------------------------

  ALTER TABLE "C##LJX"."INDENT" MODIFY ("IND_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."INDENT" ADD CONSTRAINT "INDENT_PK" PRIMARY KEY ("IND_ID")
  USING INDEX "C##LJX"."INDENT_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table NOTICE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."NOTICE" MODIFY ("NTC_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."NOTICE" MODIFY ("STO_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."NOTICE" ADD CONSTRAINT "NOTICE_PK" PRIMARY KEY ("NTC_ID")
  USING INDEX "C##LJX"."NOTICE_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SCREENSHOT
--------------------------------------------------------

  ALTER TABLE "C##LJX"."SCREENSHOT" MODIFY ("APP_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."SCREENSHOT" MODIFY ("SCT_IMAGE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."SCREENSHOT" ADD CONSTRAINT "SCREENSHOT_PK" PRIMARY KEY ("APP_ID", "SCT_IMAGE")
  USING INDEX "C##LJX"."SCREENSHOT_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table STORE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."STORE" MODIFY ("STO_INTRODUCTION" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."STORE" MODIFY ("STO_LICENSEIMG" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."STORE" MODIFY ("STO_STATE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."STORE" ADD CONSTRAINT "STORE_CHK1" CHECK ( sto_state = 1
                                      OR sto_state = 0
                                      OR sto_state = 2 ) ENABLE;
  ALTER TABLE "C##LJX"."STORE" ADD CONSTRAINT "STORE_PK" PRIMARY KEY ("STO_ID")
  USING INDEX "C##LJX"."STORE_PK"  ENABLE;
  ALTER TABLE "C##LJX"."STORE" MODIFY ("STO_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."STORE" MODIFY ("STO_NAME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table STOREIMAGE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."STOREIMAGE" MODIFY ("STO_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."STOREIMAGE" MODIFY ("STO_IMAGE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."STOREIMAGE" ADD CONSTRAINT "STOREIMAGE_PK" PRIMARY KEY ("STO_IMAGE", "STO_ID")
  USING INDEX "C##LJX"."STOREIMAGE_PK"  ENABLE;
--------------------------------------------------------
--  Constraints for Table STORE_CATEGORIES
--------------------------------------------------------

  ALTER TABLE "C##LJX"."STORE_CATEGORIES" ADD CONSTRAINT "STORE_CATEGORIES_PK1" PRIMARY KEY ("STORE_ID", "COM_CATEGORY")
  USING INDEX "C##LJX"."STORE_CATEGORIES_PK1"  ENABLE;
  ALTER TABLE "C##LJX"."STORE_CATEGORIES" MODIFY ("STORE_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."STORE_CATEGORIES" MODIFY ("COM_CATEGORY" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table USERS
--------------------------------------------------------

  ALTER TABLE "C##LJX"."USERS" MODIFY ("USER_PHONE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."USERS" MODIFY ("USER_PASSWORD" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."USERS" MODIFY ("USER_ADDRESS" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."USERS" MODIFY ("USER_STATE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."USERS" MODIFY ("USER_REGTIME" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."USERS" MODIFY ("USER_TYPE" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."USERS" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "C##LJX"."USERS" ADD CONSTRAINT "USERS_CHK1" CHECK ( user_state = 1
                                      OR user_state = 0 ) ENABLE;
  ALTER TABLE "C##LJX"."USERS" ADD CONSTRAINT "USERS_CHK2" CHECK ( user_type = 0
                                      OR user_type = 1 ) ENABLE;
  ALTER TABLE "C##LJX"."USERS" ADD CONSTRAINT "USERS_PK" PRIMARY KEY ("USER_ID")
  USING INDEX "C##LJX"."USERS_PK"  ENABLE;
  ALTER TABLE "C##LJX"."USERS" ADD CONSTRAINT "USERS_UK1" UNIQUE ("USER_PHONE")
  USING INDEX "C##LJX"."USERS_UK1"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table APPEAL
--------------------------------------------------------

  ALTER TABLE "C##LJX"."APPEAL" ADD CONSTRAINT "APPEAL_FK1" FOREIGN KEY ("USER_ID")
	  REFERENCES "C##LJX"."USERS" ("USER_ID") ENABLE;
  ALTER TABLE "C##LJX"."APPEAL" ADD CONSTRAINT "APPEAL_FK2" FOREIGN KEY ("APP_USERID")
	  REFERENCES "C##LJX"."USERS" ("USER_ID") ENABLE;
  ALTER TABLE "C##LJX"."APPEAL" ADD CONSTRAINT "APPEAL_FK4" FOREIGN KEY ("COM_ID")
	  REFERENCES "C##LJX"."COMMODITY" ("COM_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BROWSE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."BROWSE" ADD CONSTRAINT "BROWSE_FK1" FOREIGN KEY ("COM_ID")
	  REFERENCES "C##LJX"."COMMODITY" ("COM_ID") ENABLE;
  ALTER TABLE "C##LJX"."BROWSE" ADD CONSTRAINT "BROWSE_FK2" FOREIGN KEY ("BROWSER_ID")
	  REFERENCES "C##LJX"."CUSTOMER" ("CUS_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CHAT
--------------------------------------------------------

  ALTER TABLE "C##LJX"."CHAT" ADD CONSTRAINT "CHAT_FK1" FOREIGN KEY ("CUS_ID")
	  REFERENCES "C##LJX"."CUSTOMER" ("CUS_ID") ENABLE;
  ALTER TABLE "C##LJX"."CHAT" ADD CONSTRAINT "CHAT_FK2" FOREIGN KEY ("STORE_ID")
	  REFERENCES "C##LJX"."STORE" ("STO_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COMMODITY
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY" ADD CONSTRAINT "COMMODITY_FK1" FOREIGN KEY ("STO_ID")
	  REFERENCES "C##LJX"."STORE" ("STO_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COMMODITY_CATEGORIES
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY_CATEGORIES" ADD CONSTRAINT "FK_COMMODITY_CATEGORIES_COM_ID" FOREIGN KEY ("COM_ID")
	  REFERENCES "C##LJX"."COMMODITY" ("COM_ID") ENABLE;
  ALTER TABLE "C##LJX"."COMMODITY_CATEGORIES" ADD CONSTRAINT "FK_COMMODITY_CATEGORIES_COM_CATEGORY" FOREIGN KEY ("COM_CATEGORY")
	  REFERENCES "C##LJX"."COMMODITIES_CATEGORIES" ("COM_CATEGORY") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COMMODITY_COMMENT
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY_COMMENT" ADD CONSTRAINT "FK_COM_ID" FOREIGN KEY ("COM_ID")
	  REFERENCES "C##LJX"."COMMODITY" ("COM_ID") ENABLE;
  ALTER TABLE "C##LJX"."COMMODITY_COMMENT" ADD CONSTRAINT "FK_USER_ID" FOREIGN KEY ("USER_ID")
	  REFERENCES "C##LJX"."USERS" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COMMODITY_IMAGE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY_IMAGE" ADD CONSTRAINT "COMMODITY_IMAGE_FK1" FOREIGN KEY ("COM_ID")
	  REFERENCES "C##LJX"."COMMODITY" ("COM_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COMMODITY_PRICE_CURVE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."COMMODITY_PRICE_CURVE" ADD CONSTRAINT "COMMODITY_PRICE_CURVE_FK" FOREIGN KEY ("COM_ID")
	  REFERENCES "C##LJX"."COMMODITY" ("COM_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CUSTOMER
--------------------------------------------------------

  ALTER TABLE "C##LJX"."CUSTOMER" ADD CONSTRAINT "CUSTOMER_FK1" FOREIGN KEY ("CUS_ID")
	  REFERENCES "C##LJX"."USERS" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CUSTOMER_LOVE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."CUSTOMER_LOVE" ADD CONSTRAINT "CUSTOMER_LOVE_FK1" FOREIGN KEY ("CUS_ID")
	  REFERENCES "C##LJX"."CUSTOMER" ("CUS_ID") ENABLE;
  ALTER TABLE "C##LJX"."CUSTOMER_LOVE" ADD CONSTRAINT "CUSTOMER_LOVE_FK2" FOREIGN KEY ("COM_CATEGORY")
	  REFERENCES "C##LJX"."COMMODITIES_CATEGORIES" ("COM_CATEGORY") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table FAVORITE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."FAVORITE" ADD CONSTRAINT "FAVORITE_FK1" FOREIGN KEY ("COM_ID")
	  REFERENCES "C##LJX"."COMMODITY" ("COM_ID") ENABLE;
  ALTER TABLE "C##LJX"."FAVORITE" ADD CONSTRAINT "FAVORITE_FK2" FOREIGN KEY ("CUS_ID")
	  REFERENCES "C##LJX"."CUSTOMER" ("CUS_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table INDENT
--------------------------------------------------------

  ALTER TABLE "C##LJX"."INDENT" ADD CONSTRAINT "INDENT_FK1" FOREIGN KEY ("CUS_ID")
	  REFERENCES "C##LJX"."CUSTOMER" ("CUS_ID") ENABLE;
  ALTER TABLE "C##LJX"."INDENT" ADD CONSTRAINT "INDENT_FK2" FOREIGN KEY ("COM_ID")
	  REFERENCES "C##LJX"."COMMODITY" ("COM_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table NOTICE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."NOTICE" ADD CONSTRAINT "NOTICE_FK1" FOREIGN KEY ("STO_ID")
	  REFERENCES "C##LJX"."USERS" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SCREENSHOT
--------------------------------------------------------

  ALTER TABLE "C##LJX"."SCREENSHOT" ADD CONSTRAINT "SCREENSHOT_FK1" FOREIGN KEY ("APP_ID")
	  REFERENCES "C##LJX"."APPEAL" ("APP_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table STORE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."STORE" ADD CONSTRAINT "STORE_FK1" FOREIGN KEY ("STO_ID")
	  REFERENCES "C##LJX"."USERS" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table STOREIMAGE
--------------------------------------------------------

  ALTER TABLE "C##LJX"."STOREIMAGE" ADD CONSTRAINT "STOREIMAGE_FK1" FOREIGN KEY ("STO_ID")
	  REFERENCES "C##LJX"."STORE" ("STO_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table STORE_CATEGORIES
--------------------------------------------------------

  ALTER TABLE "C##LJX"."STORE_CATEGORIES" ADD CONSTRAINT "STORE_CATEGORIES_FK1" FOREIGN KEY ("COM_CATEGORY")
	  REFERENCES "C##LJX"."COMMODITIES_CATEGORIES" ("COM_CATEGORY") ENABLE;