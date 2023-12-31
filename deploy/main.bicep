param sku string
param tag string

// @allowed([
//   'staging'
//   'dev'
//   'live'
// ])
// param deploymentType string = 'staging'
param location string = 'uksouth'

@description('Git commit hash which is also the tag of the image to use in ACR')
param gitHash string

// // Not working for some reason...
// resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
//   name: 'rg-portal-${deploymentType}'
//   location: location
//   tags: {
//     environment: tag
//   }
// }

module stack 'resources.bicep' = {
  // scope: rg
  name: 'stackDeploy'
  params: {
    // sku: sku
    // tag: tag
    // deploymentType: deploymentType
    location: location
    gitHash: gitHash
  }
}
