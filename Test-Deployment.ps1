az network application-gateway address-pool update --gateway-name rkulkarni -n appGatewayBackendPool -g devOpsDemo --servers [Environment]::GetEnvironmentVariable("DeploymentIPAddress","User")
