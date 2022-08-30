sudo apt update -y && \
  sudo apt upgrade -y 

sudo apt install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  jq \
  software-properties-common \
  vim

curl -fsSL \
  https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor \
  -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt-cache policy docker-ce
sudo apt install -y docker-ce
usermod -aG docker ubuntu

mkdir -p /opt/minecraft/data


