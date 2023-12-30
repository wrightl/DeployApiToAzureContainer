param sku string
param tag string
param location string = resourceGroup().location

resource acr 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: 'portalregistry${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: sku
  }
  tags: {
    environment: tag
  }
}

output acrName string = acr.name
