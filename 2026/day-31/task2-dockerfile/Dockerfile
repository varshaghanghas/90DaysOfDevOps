# 1. base image
FROM nginx:alpine

# 2 working directory
WORKDIR 'C:/Users/Vghanghas/OneDrive - Beachcomber Hot Tubs Group/Varsha Files/STudy/devops/90DaysOfDevOps/2026/day-31/task2-dockerfile'

# 3. Copy Files
COPY index.html .

# 4. Build Commands
RUN chmod 644 index.html

# 5. Document Port
EXPOSE 8088

# 6. Default Command
CMD ["nginx", "-g", "daemon off;"]
