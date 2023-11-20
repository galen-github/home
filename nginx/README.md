# nginx相关配置

## 使用nginx搭建webdav，参考webdav文件夹
```
docker run -p 801:80 --name nginx -v /opt/data/nginx/html:/usr/share/nginx/html -v /opt/data/nginx/logs:/var/log/nginx -d nginx

docker container cp nginx:/etc/nginx /opt/data/nginx/conf


    location /dav {
        root /mnt/webdav;    
        if ($request_method = MKCOL) {    
            # ...... MKCOL .........'/'......    
            rewrite  ^(.*[^/])$  $1/  break;    
        }    
        dav_methods PUT DELETE MKCOL COPY MOVE;    
        dav_ext_methods PROPFIND OPTIONS;    
        create_full_put_path on;              
        dav_access user:rw group:rw all:r;        
        auth_basic "Authorized Users WebDAV";          
        auth_basic_user_file /etc/nginx/.davpasswd;    
    }

mkdir /mnt/webdav

docker run -p 80:80 -p 443:443 --name nginx -v /opt/data/nginx/html:/usr/share/nginx/html -v /opt/data/nginx/logs:/var/log/nginx  -v /opt/data/nginx/conf:/etc/nginx -v /mnt/webdav:/mnt/webdav -d nginx

```