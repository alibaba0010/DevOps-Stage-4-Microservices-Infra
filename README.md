# Microservices-Infra

The infrastructure for the Dev-Ops Stage 4 microservices application

```
infrastructure/
├── README.md
├── terraform
│ ├── main.tf
│ ├── outputs.tf
│ ├── variables.tf
│ └── provider.tf
├── ansible
│ ├── inventory.ini (or dynamic inventory script)
│ ├── roles
│ │ └── docker_install
│ │ ├── tasks
│ │ │ └── main.yml
│ └── site.yml
└── deploy.sh
```
