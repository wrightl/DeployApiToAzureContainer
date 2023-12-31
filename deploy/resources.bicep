param sku string
param tag string

@allowed([
  'staging'
  'dev'
  'live'
])
param deploymentType string = 'staging'
param location string = resourceGroup().location

module acrDeploy 'acr.bicep' = {
  name: 'acrDeploy'
  params: {
    sku: sku
    tag: tag
    deploymentType: deploymentType
    location: location
  }
}
