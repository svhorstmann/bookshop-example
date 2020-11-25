using from './catalog-srv'; 


annotate CatalogService.Books with @(
    UI: {
        HeaderInfo: {
            TypeName: 'Book',
            TypeNamePlural: 'Books',
            Title: { Value: title },
            Description: { Value: ID }
        },
        Identification: [{Value: ID, Label: 'Test' }],
        SelectionFields: [ ID, title, author.name ],
        LineItem: [
            { Value: ID, Label: '{i18n>ID}' },
            { Value: title, Label: '{i18n>Title}' },
            { Value: author.name, Label: '{i18n>AuthorName}' },
            { Value: descr, Label: '{i18n>Description}' },
            { Value: price, Label: '{i18n>Price}' },
            { Value: currentStock, Label: '{i18n>Stock}' },
            { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#Progress'}     
        ],
        HeaderFacets: [
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#AuthorDetails', Label: 'Header Facet Author'},
            {$Type: 'UI.ReferenceFacet', Target: '@UI.StatusInfo', Label: 'Header Facet StatusInfo'},
            {$Type: 'UI.ReferenceFacet', Target: '@UI.Identification', Label: 'Header Facet Identification'},
            {$Type: 'UI.ReferenceFacet', Target: '@UI.DataPoint#Price', Label: 'Header Facet Price'},
            {$Type: 'UI.ReferenceFacet', Target: '@UI.DataPoint#Progress' },
        ],
        Facets: [
            {
                $Type: 'UI.CollectionFacet',
                Label: 'Book Info',
                ID: 'Facet1',
                Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Main', Label: 'Main Facet'},
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Second', Label: 'Second Facet'}
                ]
            },
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#OtherBooks', Label: 'Author Facet'},
            {$Type: 'UI.ReferenceFacet', Target: 'stock/@UI.Chart', Label: 'Stock Facet'}, 
            {$Type: 'UI.ReferenceFacet', Target: 'stock/@UI.LineItem', Label: 'Stock Table Facet'}
        ],
        
        DataPoint#Price: {
            Value: price, Title: 'Price Datapoint'
        },
        FieldGroup#Main: {
            Data: [
                { Value: ID },
                { Value: title },
                { Value: author_ID },
                { Value: currentStock }           
            ]
        },
        FieldGroup#Second: {
            Data: [
                { Value: descr },             
            ]
        },
        FieldGroup#AuthorDetails: {
            Data: [
                { $Type: 'UI.DataField', Value: author_ID },
                { $Type: 'UI.DataField', Value: author.name },           
            ]
        },
        FieldGroup#OtherBooks: {
            Data: [
                { $Type: 'UI.DataField', Value: author_ID },
                { $Type: 'UI.DataField', Value: author.name },
                { $Type: 'UI.DataField', Value: author.dateOfBirth },
                { $Type: 'UI.DataField', Value: author.placeOfBirth },
                { $Type: 'UI.DataField', Value: author.dateOfDeath },
                { $Type: 'UI.DataField', Value: author.placeOfDeath },       
            ]
        },
        DataPoint#Progress: {
            Title: 'PROGRESS TEST',
            Description: 'DATA',
            Value: currentStock,
            TargetValue: 200,
            Criticality: #Critical,
            Visualization: #Progress
        },
        StatusInfo: [{Value: title, Label: 'StatusInfo'}]
    }
);

annotate CatalogService.Storages with @(
    UI: {
         HeaderInfo: {
            TypeName: 'Storage',
            TypeNamePlural: 'Storages',
            Title: { Value: name },
            Description: { Value: ID }
        },
        LineItem: [
            { Value: ID, Label: '{i18n>ID}' },
            { Value: name, Label: 'Name Storage' }       
        ],
    }
); 

annotate CatalogService.Stocks with @(
    sap.semantics : 'aggregate',
    UI: {
         HeaderInfo: {
            TypeName: 'Stock',
            TypeNamePlural: 'Stocks',
            Title: { Value: date },
            Description: { Value: ID }
        },
        LineItem: [
            {
                $Type:'UI.DataFieldWithIntentBasedNavigation', 
                Value: storage_ID, 
                SemanticObject: 'Storages',
                Action: 'display',
                Mapping: [
                    {
                        LocalProperty: storage_ID,
                        SemanticObjectProperty: 'ID'
                    }
                ]
            },
            { Value: ID, Label: '{i18n>ID}' },
            { Value: date, Label: 'Date' },
            { Value: stock, Label: '{i18n>Stock}' }         
        ],
        Chart: {
            Title: 'Chart TEST',
            ChartType: #Column,
            Dimensions: [ID],
            DimensionAttributes: [{
                Dimension: ID,
                Role: #Category
            }],
            Measures: [stock],
            MeasureAttributes: [{
                Measure: stock,
                Role: #Axis1
            }]
        }
    }
); 

annotate CatalogService.Stocks with {
    stock @(
        title                : 'Stock',
        sap.aggregation.role : 'measure'
    );

    date @(
        title                : 'DATE',
        sap.aggregation.role : 'dimension'
    );
    books @(
        sap.aggregation.role : 'dimension',
        UI                   : {Hidden : true}
    );
    ID @(
        sap.aggregation.role : 'dimension'
    );
} 

annotate CatalogService.Books with {
    title @(
        title: '{i18n>Title}',
        description: 'Description for the title'
    );
    author @(
        title: '{i18n>Author}'
    );
    ID @(
        title: '{i18n>ID}'
    );
    currentStock @(
        title: '{i18n>Stock}'
    );
    price @( Common.Label: '{i18n>Price}', Measures.ISOCurrency: currency_code )
} ;

annotate CatalogService.Authors with {
    name @(
        title: '{i18n>AuthorName}',
        description: '{i18n>}'
    );
} ;

