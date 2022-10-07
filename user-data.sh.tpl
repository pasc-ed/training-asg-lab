#!/bin/bash

sudo apt-get update -y
sudo apt-get install apache2 -y

cat <<EOF > /var/www/html/index.html
<html>
<title> Talent-Academy ${version}</title>
<body style="background-color:${color};">
    <h1> This is the ${version} !! </h1>
</body>
</html>
EOF

sudo service apache2 restart