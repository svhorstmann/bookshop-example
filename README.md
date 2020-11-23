# bookshop-example

## Structure

The folder _bookshop-service_ contains the backend.

The folders _bookshopbooks_ and _bookshopstorages_ contain the fiori apps. In the launchpad you can navigate from bookshopbooks to bookshopbooks to the object page of bookshopstorages.

The folders _bookshop-book-deployment_ and _bookshop-storages-deployment_ are there for the deployment of the corresponding app with this approach:  https://github.com/SAP-samples/multi-cloud-html5-apps-samples/tree/master/managed-html5-runtime-fiori-mta

![Image](https://github.com/SAP-samples/multi-cloud-html5-apps-samples/blob/master/managed-html5-runtime-fiori-mta/diagram.png)

## Deployment to launchpad

For deployment please add the url of the backend service to the destination.json.
```json
{
  "init_data": {
    "instance": {
      "existing_destinations_policy": "update",
      "destinations": []
    },
    "subaccount": {
      "existing_destinations_policy": "update",
      "destinations": [
        {
          "Name": "Bookshop",
          "Description": "Automatically generated Bookshop destination",
          "Authentication": "NoAuthentication",
          "ProxyType": "Internet",
          "Type": "HTTP",
          "URL": "TODO", //Add your url here
          "HTML5.DynamicDestination": true
        }
      ]
    }
  }
}
```

For more information on the deployment please refer to the following links:
https://github.com/SAP-samples/multi-cloud-html5-apps-samples/tree/master/managed-html5-runtime-fiori-mta
https://developers.sap.com/tutorials/sapui5-fiori-portal-deploy.html

After deployment you should see your app in "Content Explorer" section of the launchpad subscription in SAP Cloud Platform Cockpit. Follow these steps to see it in your custom launchpad: https://developers.sap.com/tutorials/cp-launchpad-integrate-sapui5-app.html
