$IPAddress = [Environment]::GetEnvironmentVariable("DeploymentIPAddress","User")
az network application-gateway address-pool update --gateway-name rkulkarni -n appGatewayBackendPool -g devOpsDemo --servers $IPAddress.tostring()
