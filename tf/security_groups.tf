resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP to ALB"
  vpc_id      = aws_vpc.this.id
  ingress = [
    {
      description      = "Allow HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    }
  ]
  egress = [
    {
      description      = "Allow all outbound"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    }
  ]
  tags = { Name = "${var.project_name}-alb-sg" }
}

resource "aws_security_group" "ecs_tasks_sg" {
  name        = "${var.project_name}-tasks-sg"
  description = "Allow traffic from ALB"
  vpc_id      = aws_vpc.this.id

  ingress = [
    {
      description = "Allow from ALB"
      from_port   = var.container_port
      to_port     = var.container_port
      protocol    = "tcp"
      security_groups = [aws_security_group.alb_sg.id]
    }
  ]

  egress = [
    {
      description      = "Allow all outbound"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]
  tags = { Name = "${var.project_name}-tasks-sg" }
}
