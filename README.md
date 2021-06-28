# SRE-Candidate-HW-Problem
Congratulations on getting the second part of the uShip SRE Interview Process

# Problem
The Engineering Org has an ask to enforce EC2 tagging standards to measure what resources an engineering team owns. We'd like to make sure that all EC2s are tagged with the key "Team" and the value of one of our 4 teams "Yellow", "Red", "Green", & "Blue". We want to get alerts when an EC2 is created with no "Team" tag or an incomplete "Team" tag. 

# SLI
- EC2 tags

# SLO
- 0 EC2s with no "Team" tag 
- 0 EC2s with a "Team" tag without the values of "Yellow", "Red", "Green", & "Blue"

# AC
- Use AWS Config to monitor tagging standards
- If an SLO has hit it's threshold send email alert to "devops@uship.com"
- All AWS resources used must be built using IAC (infrastructure as code) with Terraform
- Infrastructure and code must be deployed in a pipeline using github actions
