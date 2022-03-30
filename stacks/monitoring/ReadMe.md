## Monitoring Stack installation
### Creation of following volume directories on the host file system will be needed
```
    mkdir -p /volumes/monitoring/prometheus/config
    mkdir -p /volumes/monitoring/prometheus
    mkdir -p /volumes/monitoring/grafana-data        
    cd /volumes/monitoring/prometheus/config
    wget https://raw.githubusercontent.com/doc4child/portainer-templates/main/stacks/monitoring/prometheus.yml

```