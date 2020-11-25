using my.bookshop as my from '../db/schema';

service CatalogService {
    @readonly
    entity Books as projection on my.Books;
    entity Authors as projection on my.Authors;
    @readonly
    entity Stocks as projection on my.Stocks;
    entity Storages as projection on my.Storages;
}