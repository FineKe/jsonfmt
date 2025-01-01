# 使用 Node.js 作为基础镜像
FROM node:16-alpine

# 设置工作目录
WORKDIR /app

# 复制打包后的文件
COPY dist/ /app/dist

# 全局安装 serve
RUN npm install -g serve

# 暴露端口
EXPOSE 3000

# 启动 serve
CMD ["serve", "-s", "dist", "-l", "3000"]
