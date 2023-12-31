param sku string
param tag string

@allowed([
  'staging'
  'dev'
  'live'
])
param deploymentType string = 'staging'
param location string = deployment().location

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-portal-${deploymentType}'
  location: location
  tags: {
    owner: tag
  }
}

module stack 'resources.bicep' = {
  scope: rg
  name: 'stackDeploy'
  params: {
    sku: sku
    tag: tag
    deploymentType: deploymentType
    location: location
  }
}
