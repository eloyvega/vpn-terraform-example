# Ejemplo de Pritunl VPN en AWS EC2

Este ejemplo crea una VPC con 3 subnets públicas, 3 privadas y 2 internas para bases de datos.

También crea un servidor EC2 con Pritunl y MongoDB instalado para realizar pruebas de VPN.

## Configuración

Revisa los valores por default en el archivo `vars.tf` y modifica la región, AMI, instance_type si así lo requires.

## Ejecución

**Requiere Terraform > 0.12**

Inicializa Terraform:

```
terraform init
```

Aplica los archivos de configuración para crear la infraestructura:

```
terraform apply
```

Introduce el valor de una llave .pem de EC2 que exista en la región seleccionada:

```
var.key_name
  The key that will be attached to the instance. Create it first using EC2 console

  Enter a value:
```

Cuando te pida confirmación, teclea `yes` para continuar con la ejecución:

```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
```

## Configuración de VPN

Al finalizar la ejecución de Terraform, se imprime la IP pública del servidor de VPN. Utiliza esa dirección para realizar los pasos de la [guía de configuración de Pritunl](https://docs.pritunl.com/docs/configuration-5#section-database-setup). Necesitarás acceder desde el navegador y a través de SSH.

## Clientes VPN

Los usuarios de la VPN pueden ocupar alguno de los siguientes clientes para conectarse a tu VPN:

- [Pritunl Client](https://client.pritunl.com/)
- [OpenVPN Client](https://openvpn.net/community-downloads/)

## Pruebas

Intenta crear un servidor EC2 o una base de datos RDS en alguna subnet privada y validar el acceso a través de la VPN que configuraste previamente.

Utiliza el id del security group de la VPN para permitir el acceso a tus recursos privados.

## Destrucción

Utiliza el siguiente comando de Terraform para destruir la infraestructura de este ejemplo:

```
terraform destroy
```
