FROM nginx:alpine

# 将打包后的文件复制到 Nginx 的默认静态文件目录
COPY dist/ /usr/share/nginx/html

# 暴露 80 端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
