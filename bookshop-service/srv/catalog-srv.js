const cds = require('@sap/cds');

module.exports = srv => {
    console.log(`Service ${srv.name} is served at ${srv.path}`);
    const { Stocks } = srv.entities('my.bookshop');

    srv.after('READ', 'Books', _currentStock);

    async function _currentStock(books, req) {

        const ordersByID = Array.isArray(books)
        ? books.reduce ((all,o) => { (all[o.ID] = o).currentStock=0; return all },{})
        : { [books.ID]: books };

        const query = SELECT.from(Stocks).where( { book_ID: { in: Object.keys(ordersByID) }});

        const booksWithStock = cds.transaction(req).run(query).then(items => items.forEach(item => {
            if(item.date == '2020-01-01') {
                ordersByID[item.book_ID].currentStock = item.stock;
            }
        }));

        return booksWithStock;
    };
}