# Spring Authorization Server

## Environment Variables
* JEMBER_SECRET - The secret used to sign the JWT token for the JEMBER client. Use {noop}<secret> to store the secret in plain text.
* JEMBER2_SECRET - The secret used to sign the JWT token for the JEMBER2 client. Use {noop}<secret> to store the secret in plain text.
* GATEWAY_SERVER - The URL of the gateway server. 
* GATEWAY_SERVER_PORT - the port of the gateway server.
* LOG_LEVEL - The log level for the application. Default is INFO.

Note: currently secret is stored in memory only.


### Kubernetes Configuration
This application has been configured with Spring Boot Actuator. This provides readiness and liveness probes for Kubernetes.

This application will start on port 8080. To override the port, set the SERVER_PORT environment variable to desired port.

#### Example Configuration Snippet
```yaml
        readinessProbe:
          httpGet:
            port: 8080 # Set to server port
            path: /actuator/health/readiness
        livenessProbe:
          httpGet:
            port: 8080
            path: /actuator/health/liveness
```