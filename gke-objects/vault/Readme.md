Every command from CLI. Example for keycloak.

```sh
vault login
```

```sh
vault auth enable kubernetes
```

```sh
# execute from pod
vault write auth/kubernetes/config \
  token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
  kubernetes_host=https://$KUBERNETES_PORT_443_TCP_ADDR:443 \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

```sh
vault write auth/kubernetes/role/keycloak-role \
  bound_service_account_names=default \
  bound_service_account_namespaces=keycloak \
  policies=read-kv \
  ttl=1h
```

```sh
vault policy write read-kv read-kv.hcl
```
