param sku string
param tag string

module acrDeploy 'acr.bicep' = {
  name: 'acrDeploy'
  params: {
    sku: sku
    tag: tag
  }
}
