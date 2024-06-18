<h1 align="center">MONGODB COM DOCKER</h1>

## OBJETIVO DO PROJETO
Este projeto visa configurar um laboratório do MongoDB de modo ágil e prático, e também monitorá-lo com o Zabbix.

### CONTEÚDO
<!--ts-->
   * [Pré-requisitos](#pr%C3%A9-requisitos)
   * [Instalar MongoDB](#instalar-mongodb)
   * [Monitorando com o Zabbix](#monitorando-com-o-zabbix)
   * [Remover MongoDB](#remover-mongodb)
<!--te-->

### PRÉ-REQUISITOS

Antes de começar, você vai precisar ter instalado em sua máquina as ferramentas abaixo:

- [Git](https://git-scm.com/download/linux)
- [Docker](https://docs.docker.com/engine/install/)

### INSTALAR MONGODB

Clone o reponsitório com o comando abaixo:
```bash
git clone https://github.com/zthiagosantos/mongodb-docker.git
```

Edite as variáveis de usuário e senha no arquivo `.env`:
```env
MONGO_USER=admin
MONGO_PASS=admin
```

Execute o container com o comando abaixo:
```bash
docker compose up -d
```

Para verificar se o container está executando use o comando abaixo:
```bash
docker ps
```

<br>

> [!IMPORTANT]
> #### Para que o monitoramento do `MongoDB` funcione corretamente, siga as instruções abaixo:

### MONITORANDO COM O ZABBIX

a. Instale o Zabbix Agent2 seguindo a documentação da [Zabbix](https://www.zabbix.com/br/download)

b. Execute o contrainer no modo interativo:

```bash
docker exec -it mongodb mongosh
```

c. Execute os comandos:
```bash
# use admin
# db.auth("admin", "<ADMIN_PASSWORD>")

# db.createUser({
#   "user": "zbx_monitor",
#   "pwd": "<PASSWORD>",
#   "roles": [
#     { role: "readAnyDatabase", db: "admin" },
#     { role: "clusterMonitor", db: "admin" },
#   ]
# })
```

> [!NOTE]
> #### Substitua `<PASSWORD>` pela senha desejada para o usuário zabbix e `<ADMIN_PASSWORD>` pela senha do usuário administrador.

d. Adicione o template no host e configure as macros abaixo:

| MACRO                 | VALOR PADRÃO          |
| --------------------- | --------------------- |
| {$MONGODB.CONNSTRING} | tcp://localhost:27017 |
| {$MONGODB.USER}       |          --           |
| {$MONGODB.PASSWORD}   |          --           |

e. Por fim, valide as coletas.

#### Referencia
> [Documentação Zabbix](https://www.zabbix.com/integrations/mongodb)

### REMOVER MONGODB
Remover apenas o container:
```bash
docker compose down
```

Remover os container + volume:
```bash
docker compose down -v
```
