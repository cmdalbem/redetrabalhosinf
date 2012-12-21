![infHUB](https://dl-web.dropbox.com/get/Academico/Trabalhos/2012/02/Laborat%C3%B3rio%20de%20Software/design/logo/logo_mini.png?w=6aa84f38) _A rede de compartilhamento de trabalhos do INF_

Developers
---------------------

###What do I need to run a local server and start developing?

1.  **PostGreSQL** database running locally. Please setup it with name "postgres" and password "pass". On Windows/Linux, the following client is recomended: http://www.enterprisedb.com/products-services-training/pgdownload
2.  **Authentication file** (s3.yml) for uploading to Amazon S3. It must be located one directory level above your repository folder on your computer. If you don't have this file, ask for one of the developers. This file MUST NOT be publicly available.
3.  **ImageMagick** for automatic resizing of uploading images: http://imagemagick.org

#####Before your first time...

Remember to execute the following commands on your command line:

    bundle install
    rake db:migrate
    rake db:seed
