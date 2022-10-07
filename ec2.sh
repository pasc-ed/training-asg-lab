ami_id="ami-0a750371997a814a7"
security_groups_list="sg-058c8e809976df879"
subnet_id="subnet-03447d57048db290c"

# Linux instance in us-east-1
aws ec2 run-instances --image-id $ami_id --count 1 \
    --instance-type t2.small \
    --key-name talent-academy-ec2 \
    --security-group-ids $security_groups_list \
    --subnet-id $subnet_id \
    --tag-specification '[
        {
            "ResourceType":"instance",
            "Tags":[
            {"Key":"Name","Value":"example-test-instance-name"},
            {"Key":"BusinessUnit","Value":"IT"},
            {"Key":"Department","Value":"IT"},
            {"Key":"ApplicationName","Value":"test"},
            {"Key":"Env","Value":"DevTest"},
            {"Key":"AppID","Value":"APP000"},
            {"Key":"CostCenter","Value":"TST000"}
        ]
        },
        {
            "ResourceType":"volume",
            "Tags":[
            {"Key":"Name","Value":"example-test-instance-name"},
            {"Key":"BusinessUnit","Value":"IT"},
            {"Key":"Department","Value":"IT"},
            {"Key":"ApplicationName","Value":"test"},
            {"Key":"Env","Value":"DevTest"},
            {"Key":"AppID","Value":"APP000"},
            {"Key":"CostCenter","Value":"TST000"}
        ]
        }
    ]'|jq
