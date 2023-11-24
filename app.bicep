import radius as radius

@description('The Radius Application ID. Injected automatically by the rad CLI.')
param application string

resource demo 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'silly-demo'
  properties: {
    application: application
    container: {
      image: 'c8n.io/vfarcic/silly-demo:1.4.92'
      ports: {
        web: {
          containerPort: 8080
        }
      }
    }
    connections: {
      // redis: {
      //   source: db.id
      // }
    }
  }
}

resource app 'Applications.Core/applications@2023-10-01-preview' = {
  name: 'a-team'
  properties: {
    environment: environment
    extensions: [
      {
        kind: 'kubernetesNamespace'
        namespace: 'a-team'
      }
      {
        kind: 'kubernetesMetadata'
        labels: {
          'team.contact.name': 'frontend'
        }
      }
    ]
  }
}

// @description('The environment ID of your Radius Application. Set automatically by the rad CLI.')
// param environment string

// resource db 'Applications.Datastores/redisCaches@2023-10-01-preview' = {
//   name: 'db'
//   properties: {
//     application: application
//     environment: environment
//     // recipe: {
//     //   name: 'aws'
//     // }
//   }
// }

// resource backend 'Applications.Core/containers@2023-10-01-preview' = {
//   name: 'backend'
//   properties: {
//     application: application
//     container: {
//       image: 'nginx:latest'
//       ports: {
//         api: {
//           containerPort: 80
//         }
//       }
//     }
//   }
// }

// resource gateway 'Applications.Core/gateways@2023-10-01-preview' = {
//   name: 'gateway'
//   properties: {
//     application: application
//     routes: [
//       {
//         path: '/'
//         destination: 'http://demo:3000'
//       }
//     ]
//   }
// }
