# Azure roleAssignments name

`roleAssignments` are identified by a unique Id property named `name`. This `name` needs to be the same for all deployment to the same environment.

The consensus when assigning the `name` property is to use the [guid][arm-guid] ARM function and to [feed it arguments that are specific enough to uniquely identify the role assignment][role-assignment-sample-name]. People tend to use a combination of scope, role definition Id… This has several drawbacks:

- When the role assignment fails, you’re provided with the generated name. This makes it harder to determine which assignment failed
- Once you’ve determined which assignment failed you now need to determine which of the argument provided to the guid function has changed (if any)
  - This is particularly hilarious when a resource has been deleted and re-created and the principal Id has changed
- As role can be assigned at different scopes, you need to be careful which arguments you provide to the guid function to avoid collision

A simpler alternative is to generate actual GUIDs and store them as variables.

```json
"roleAssignmentIds": {
    "dev": {
        "myApi": "0d01f691-7117-4e36-857c-420b919a5604",
        "myOtherApi": "ec36e933-e74f-41ea-9135-295beeb667c1"
    },
    "uat": {
        "myApi": "53488995-7cde-45ee-9c7e-9e28333120e6",
        "myOtherApi": "4e72378d-accd-406f-80dc-6f2dc5fd4e26"
    },
    "prod": {
        "myApi": "b446da61-1a29-4088-8268-8c38131b642b",
        "myOtherApi": "95e82147-31f1-4faa-8e03-27dba1a2a077"
    }
}
```

Usage:

```json
{
    "type": "Microsoft.Storage/storageAccounts/providers/roleAssignments",
    "apiVersion": "2020-04-01-preview",
    "name": "[concat(variables('dataProtectionStorage').name, '/Microsoft.Authorization/', variables('roleAssignmentIds')[variables('environmentLowerCase')].myApi)]",
    "properties": {
        "roleDefinitionId": "[concat('/subscriptions/', subscription().subscriptionId, '/providers/Microsoft.Authorization/roleDefinitions/', variables('builtInAzureRoles').storageBlobDataContributor)]",
        "principalId": "[reference(concat('Microsoft.Web/sites/', variables('myApiFunction').name), '2019-08-01', 'Full').identity.principalId]",
        "principalType": "ServicePrincipal"
    },
    "dependsOn": [
        "[variables('dataProtectionStorage').name]",
        "[variables('myApiFunction').name]"
    ]
}
```

As an aside, if you delete an Azure resource you’ll need to delete its role assignments too before being able to recreate the Azure resource. This is because role assignments are defined by a scope and principal Id and these cannot be updated. When you recreate the Azure resource you deleted, it will get a new managed identity with a new principal Id. If you didn’t delete the existing role assignment, the assignment will fail because the principal Id is not matching.

```json
{
    "status": "Failed",
    "error": {
        "code": "DeploymentFailed",
        "message": "At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/DeployOperations for usage details.",
        "details": [
            {
                "code": "BadRequest",
                "message": "{\r\n  \"error\": {\r\n    \"code\": \"RoleAssignmentUpdateNotPermitted\",\r\n    \"message\": \"Tenant ID, application ID, principal ID, and scope are not allowed to be updated.\"\r\n  }\r\n}"
            }
        ]
    }
}
```

[arm-guid]: https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-functions-string#guid
[role-assignment-sample-name]: https://docs.microsoft.com/en-us/azure/role-based-access-control/role-assignments-template#resource-group-or-subscription-scope
