param location string = resourceGroup().location

resource acr 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' ={
  name: 'portal-registry'
  location: location
  sku: {
    name: 'Basic'
  }
}

output acrName string = acr.name
