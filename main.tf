
# Creacion Perfil de Inicio de Sesión

resource "aws_iam_user_login_profile" "CloudEngineer" {
  user    = aws_iam_user.CloudEngineer
  pgp_key = "keybase:some_person_that_exists"
}

# Creación de usuario
resource "aws_iam_user" "CloudEngineer" {
  name = "Cloud Engineer:"
  path = "/system/"

  tags = {
    tag-key = "Cloud Engineer"
  }
}

resource "aws_iam_access_key" "CloudEngineer" {
  user = aws_iam_user.CloudEngineer.name
}

# Creación de grupo
resource "aws_iam_group" "CloudEngineerGroup" {
  name = "Cloud Engineer Group"
  path = "/system/"
}

# Asignación de usuario al grupo
resource "aws_iam_user_group_membership" "CloudEngineer" {
  user  = aws_iam_user.CloudEngineer.name
  groups = [aws_iam_group.CloudEngineerGroup.name]

}




# Creación de políticas
resource "aws_iam_policy" "CloudEngineerPolicy" {
  name        = "CloudEngineerPolicy"
  description = "Cloud Engineer Policy"
  path        = "/system/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudEngineerPolicy",
            "Effect": "Allow",
            "Action": [
                "ec2:*",
        }
        {
            "Sid": "CloudEngineerPolicy",
            "Effect": "Deny",
            "Action": [
                "ec2:TerminateInstances",
        }
    ]
}
EOF
}

# Asignación de políticas al grupo
resource "aws_iam_group_policy_attachment" "CloudEngineer" {
  group      = aws_iam_group.CloudEngineerGroup.name
  policy_arn = aws_iam_policy.CloudEngineerPolicy.arn
}

