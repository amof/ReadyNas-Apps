Softether VPN for ReadyNAS OS 6.4.1
===================================

See the installation instruction here :

https://www.digitalocean.com/community/tutorials/how-to-setup-a-multi-protocol-vpn-server-using-softether

## Access to your NAS

If you don't follow the procedure that follows, you will be able to reach your network but not access to your NAS.

1. You have to create a new virtual hub.
2. Go into **Manage Virtual Hub** then *activate* **Secure NAT**
3. Go into **Virtual Hub Properties ** and *edit* **Virtual Hub Extened OPtion List**
4. Change the value to **1** of **DisableKernelModeSecureNAT**
