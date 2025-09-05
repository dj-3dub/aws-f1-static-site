# Use lightweight nginx as the base image
FROM nginx:alpine

# Copy everything from your website folder into nginx’s web root
COPY website/ /usr/share/nginx/html/

# Expose port 80 (default for nginx)
EXPOSE 80
