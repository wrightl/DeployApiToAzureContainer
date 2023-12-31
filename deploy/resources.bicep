param sku string
param tag string

// @allowed([
//   'staging'
//   'dev'
//   'live'
// ])
// param deploymentType string = 'staging'
param location string = resourceGroup().location

param baseName string = 'em-portal'
param acrName string = 'portalregistry${uniqueString(resourceGroup().id)}'

module acrDeploy 'acr.bicep' = {
  name: 'acrDeploy'
  params: {
    acrName: acrName
    sku: sku
    tag: tag
    // deploymentType: deploymentType
    location: location
  }
}

// LA workspace required...
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: '${baseName}-logs'
  location: location
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

// resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
//   // scope: resourceGroup('bicep-modules')
//   name: acrName
// }

resource environment 'Microsoft.App/managedEnvironments@2023-05-01' = {
  name: '${baseName}-environment'
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspace.properties.customerId
        sharedKey: logAnalyticsWorkspace.listKeys().primarySharedKey
      }
    }
  }
}

// module service 'container.bicep' = {
//   name: '${baseName}-service-deploy'
//   params: {
//     location: location
//     containerAppName: '${baseName}-backend-02'
//     containerImage: '${acr.properties.loginServer}/lfa/lfa-back:${gitHash}'
//     containerPort: 3000
//     containerRegistry: acr.properties.loginServer
//     containerRegistryUsername: acr.listCredentials().username
//     containerRegistryPassword: acr.listCredentials().passwords[0].value
//     environmentId: environment.id
//     isExternalIngress: true
//     minReplicas: 1
//     // env: [
//     //   {
//     //     name: 'DB_USERNAME'
//     //     value: 'sonofdiesel'
//     //   }
//     //   {
//     //     name: 'DB_PASSWORD'
//     //     value: dbPassword
//     //   }
//     //   {
//     //     name: 'CLOUDINARY_API_SECRET'
//     //     value: cloudinaryKey
//     //   }
//     //   {
//     //     name: 'DB'
//     //     value: deploymentType == 'prod' ? 'LFA' : 'LFA-DEV'
//     //   }
//     //   {
//     //     name: 'IMAGE_FOLDER'
//     //     value: deploymentType == 'prod' ? 'lfa-items' : 'lfa-items-test'
//     //   }
//     //   {
//     //     name: 'GSUITE_CLIENT_ID'
//     //     value: '1092000076053-gskfckaqihntrefibkmlce55n7dvul2b'
//     //   }
//     //   {
//     //     name: 'GIT_HASH'
//     //     value: gitHash
//     //   }
//     // ]
//   }
// }

