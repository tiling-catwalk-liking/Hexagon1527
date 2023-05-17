# IAM Demo

## Intended Goals

1. [Deploy an AD Domain in Azure](#deploy-an-ad-domain-in-azure-1)
2. [Setup an Azure AD tenant](#setup-an-azure-ad-tenant-2)
3. [Configure a hybrid identity solution with Azure AD Connect](#configure-a-hybrid-identity-solution-with-azure-ad-connect-3)
4. [Configure Duo MFA to protect login to a computer](#configure-duo-mfa-to-protect-login-to-a-computer-4)
5. [Configure BitWarden to auto-provision/de-provision accounts](#configure-bitwarden-to-auto-provisionde-provision-accounts-5)

#### [Sample Images (Click to jump to sample images)](#sample-images)



## Deploy an AD Domain in Azure {##1}

- Create an Azure Subscription
- Create an Azure Resource Group
- Create PowerShell script to create VMs
- Create 3 VMs
- Install Active Directory Domain Services Role on TestVM01
- Create new AD Forest on TestVM01
- Join TestVM02 to domain
- Promote VM02 to DC
- Create OU for Users and create test accounts
- Join TestVM03 to domain
- Verify that users can login to domain joined computer (TestVM03)

## Setup an Azure AD tenant {##2}

- [Create AAD Tenant](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-access-create-new-tenant)
    - [Register a custom domain name](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/add-custom-domain)
        - Configure DNS records to connect domain
    - Create a Global Admin user to administer the tenant
        - Enable MFA for Global Admin user


## Configure a hybrid identity solution with Azure AD Connect  {##3}

- [Setup Azure AD Passthrough Authentication](https://learn.microsoft.com/en-us/azure/active-directory/hybrid/connect/how-to-connect-pta-quick-start)
    - Install Azure AD Connect on a machine in the local domain
    - Run through the setup wizard to configure connection to AAD
    - Run initial sync
    - Verify that users created in AD sync to AAD
    - Verify that changes made to users in AD (enable/disable, properties, etc)
    replicate to AAD


## Configure Duo MFA to protect login to a computer {##4}

- [Sign up for Duo trial](https://duo.com/docs/getting-started)
- [Enroll pilot user in Duo](https://duo.com/docs/enrolling-users)
    - To enable user interaction with email invitations, an Exchange mailbox was
    created for both the admin user and for the test user (Microsoft 365 Business Basic)
    - Configure Duo Push on phone for pilot user
- *At this time [Azure AD Sync](https://duo.com/docs/azuresync) was not turned on. Doing so would allow users to be automatically provisioned/de-provisioned. This would be the way to setup for actual usage.*
- Add Duo MFA authentication requirement to TestVM03 (Client Computer)
    - Add [Logon and RDP application](https://duo.com/docs/rdp) to Duo
    -  Run Duo installer on TestVM03 (*This would normally be pushed out as a software intall*)
- Confirm that user is required to use MFA when logging in
    - Authenticate with Duo push


## Configure Bitwarden to auto-provision/de-provision accounts {##5}

- [Create an enterprise account](https://vault.bitwarden.com/#/register?org=enterprise&layout=enterprise2) with Bitwarden
    - As above, use the 365 mailbox provisioned for testing purposes
- Enable SCIM integration
- Configure [SCIM integration with AAD](https://bitwarden.com/help/azure-ad-scim-integration/)
    - In AAD Create an Enterprise Application
    - Enable Provisioning
    - Configure Provisioning as Automatic
-In AAD assign a test user to the SCIM application created above. (*This might normally be a group, and all members of the group would be provisioned. Due to licensing constraints in AAD groups cannot be added; only indivdual users.*)
- Start provisioning. The user will receive an email from Bitwarden inviting them to create an account (*an alternate method would be to configure Bitwarden with an orgs SSO*)
    - After account creation, the user has access to the Collections shared with them via Bitwarden settings.
-Test disabling account
    - Disable the account in AD. This will sync to AAD, and will automatically revoke access to Bitwarden
    - Enable the account in AD. This will sync to AAD, and will automatically restore access to Bitwarden


#### Sample Images
---
Azure resources

![Azure resources](https://github.com/tiling-catwalk-liking/Hexagon1527/blob/8f0937d2444ba7c320ce209c515536771a50f2b4/Images/Screenshot%202023-05-16%20at%202.22.08%20PM.png "Screenshot of Azure resources")

---
VM creation PowerShell script

![PowerShell script - Azure VM creation](https://github.com/tiling-catwalk-liking/Hexagon1527/blob/8f0937d2444ba7c320ce209c515536771a50f2b4/Images/Screenshot%202023-05-16%20at%202.23.16%20PM.png "Screenshot of Powershell script for creation Azure VMs")

---
Configured AD domain

![Configured AD domain](https://github.com/tiling-catwalk-liking/Hexagon1527/blob/8f0937d2444ba7c320ce209c515536771a50f2b4/Images/Screenshot%202023-05-16%20at%202.23.50%20PM.png "Screenshot of a ADUC and Server Manager window")

---
Domain user can access domain joined PC

![Domain joined PC with Domain User logged in](https://github.com/tiling-catwalk-liking/Hexagon1527/blob/8f0937d2444ba7c320ce209c515536771a50f2b4/Images/Screenshot%202023-05-16%20at%202.24.38%20PM.png "Screenshot of a PowerShell window showing computer name and username")

---

!