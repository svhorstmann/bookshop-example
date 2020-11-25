namespace my.bookshop;

using { Currency, cuid, managed } from '@sap/cds/common';

entity Books : managed {
  key ID : Integer;
  title  : localized String(111);
  descr  : localized String(1111);
  author : Association to Authors;
  stock  : Association to many Stocks on stock.book = $self;
  currentStock: Integer @readonly;
  price  : Decimal(9,2);
  currency : Currency;
}

entity Authors : managed {
  key ID : Integer;
  name   : String(111);
  dateOfBirth  : Date;
  dateOfDeath  : Date;
  placeOfBirth : String;
  placeOfDeath : String;
  books  : Association to many Books on books.author = $self;
}

entity Stocks: managed {
    key ID: Integer;
    key book: Association to Books;
    key storage: Association to Storages;
    date : Date;
    stock: Integer;
}

entity Storages: managed {
    key ID: String;
    name: String;
    stock: Association to many Stocks on stock.storage = $self;
}