# flyscrape-test

testing [flyscrape](https://github.com/philippta/flyscrape).

## getting started

[install flyscrape](https://github.com/philippta/flyscrape?tab=readme-ov-file#installation)

then:

```bash
make
```

this will generate a large JSON file containing all the useful information on the
horrible GCP [IAM basic and predefined roles reference](https://cloud.google.com/iam/docs/understanding-roles).
The output JSON data looks something like this:

```json
[
  {
    "url": "https://cloud.google.com/iam/docs/understanding-roles",
    "data": {
      "roles": [
        {
          "description": "Ability to view or act on access approval requests and view configuration.",
          "id": "roles/accessapproval.approver",
          "permissions": [
            "accessapproval.requests.*",
            "accessapproval.serviceAccounts.get",
            "accessapproval.settings.get",
            "resourcemanager.projects.get",
            "resourcemanager.projects.list"
          ],
          "title": "Access Approval Approver"
        },
        {
          "description": "Ability to update the Access Approval configuration",
          "id": "roles/accessapproval.configEditor",
          "permissions": [
            "accessapproval.serviceAccounts.get",
            "accessapproval.settings.*",
            "resourcemanager.projects.get",
            "resourcemanager.projects.list"
          ],
          "title": "Access Approval Config Editor"
        },

        /* etc.... */

      ]
    },
    "timestamp": "2025-02-28T17:05:15.805141364+01:00"
  }
]
```

now we are free to write scripts that can search GCP role data properly so we no longer
have to visit that God-forsaken webpage.
