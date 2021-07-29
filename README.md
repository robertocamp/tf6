# tf6

## AMI
- Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-0233c2d874b811deb
- Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami-00399ec92321828f5


## Using the default VPC as a test bed
- For AWS accounts created after 2013-12-04, each region comes with a Default VPC.
- This is an "advanced resource", and has special caveats to be aware of when using it
- The `aws_default_vpc` behaves differently from normal resources, in that Terraform does not create this resource, but instead "adopts" it into management.

## CREATE KEY PAIR IS US-WEST-2 CONSOLE
- after creating key pair, copy to your ssh directory (where you launch ssh sessions from)
- `cp 24JULYUSW2.pem ~/Documents/KEYS`
- `cd ~/Documents/KEYS`
- `chmod 400 24JULYUSW2.pem`