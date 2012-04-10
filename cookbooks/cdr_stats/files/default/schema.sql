CREATE TABLE cdr (
    acctid integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    src varchar(80) NOT NULL,
    dst varchar(80) NOT NULL,
    calldate datetime NOT NULL,
    clid varchar(80) NOT NULL,
    dcontext varchar(80) NOT NULL,
    channel varchar(80) NOT NULL,
    dstchannel varchar(80) NOT NULL,
    lastapp varchar(80) NOT NULL,
    lastdata varchar(80) NOT NULL,
    duration integer unsigned NOT NULL,
    billsec integer unsigned NOT NULL,
    disposition integer unsigned NOT NULL,
    amaflags integer unsigned NOT NULL,
    accountcode integer unsigned NOT NULL,
    uniqueid varchar(32) NOT NULL,
    userfield varchar(80) NOT NULL
);
