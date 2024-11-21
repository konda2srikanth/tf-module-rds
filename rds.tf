resource "aws_db_instance" "main" {
  allocated_storage      = 10
  identifier             = "${var.env}-rds"
  db_name                = "expense"
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  password               = jsondecode(data.vault_generic_secret.rds.data_json).password
  username               = jsondecode(data.vault_generic_secret.rds.data_json).username
  parameter_group_name   = aws_db_parameter_group.main.name
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.main.id]
}

# DB Parameter group
resource "aws_db_parameter_group" "main" {
  name   = "${var.env}-rds-pg"
  family = var.family
}

# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.env}-rds-subnet-group"
  subnet_ids = var.subnet_ids
}