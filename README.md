# SRE-Candidate-HW-Problem
Congratulations on getting the second part of the uShip SRE Interview Process

# Problem
The Engineering Org has an ask to enforce EC2 tagging standards to measure what resources an engineering team owns. We'd like to make sure that all EC2s are tagged with the key "Team" and the value of one of our 4 teams "Yellow", "Red", "Green", & "Blue". We want to get alerts when an EC2 is created with no "Team" tag as well as when a team has has more than 5 EC2s over an hour long time frame via email. We also wanna see a dashboard of the number of EC2s created for the teams over a given time frame

# SLI
Number of EC2s

# SLO
- 0 EC2s with no "Team" tag 
- 0 EC2s with a "Team" tag without the values of "Yellow", "Red", "Green", & "Blue"
- 5 EC2s over an hour with a "Team" tag with the values of "Yellow", "Red", "Green", & "Blue"

# AC
- Build a lambda that collects this tag data and writes to cloudwatch metrics
- Build a cloudwatch dashboard to see our team tagging trends
- If an SLO has hit it's threshold send email alert to "devops@uship.com"

# SRE Notes
- All AWS resources used must be built using IAC (infrastructure as code) with Terraform
- infrastructure and code must be deployed in a pipeline using github actions
