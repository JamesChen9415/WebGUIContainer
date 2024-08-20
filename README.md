# WebGUIContainer
 WebGUIContainer is a project that containerizes Linux GUI applications, making them accessible via web browsers. It uses Xvfb and noVNC to run non-web-native apps in the cloud, allowing users to interact with the app directly through their browser.


# Usage
```bash

docker rm -f gui-app-web
docker rmi your-gui-app-image:latest

docker build -t your-gui-app-image:latest .
docker run  --name gui-app-web -d -p 8888:8080 your-gui-app-image:latest

docker exec -it gui-app-web /bin/bash
```