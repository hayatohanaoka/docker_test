# Pythonのイメージ
FROM python:3.12.2
USER root

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
# 作業ディレクトリを設定する
WORKDIR /test

# 必要なパッケージをインストールする
COPY requirements.txt ./ 
RUN apt-get install -y vim less
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
