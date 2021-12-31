# cedar-deploy
This repository is used for creating and scaling infrastructure for cedar app

# To deploy infrastructure:
> ./cedar-deploy.sh

### Once infrastructure is deployed create images (repository) for container registry by following [Deploy Server](https://github.com/karthiklsarma/cedar-server#to-deploy-on-azure) and [Deploy Listener](https://github.com/karthiklsarma/cedar-listener#to-deploy-on-azure)

### Once images/repository is created, run
> ./kube-deployments.sh
