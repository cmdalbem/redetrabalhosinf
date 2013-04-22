![infHUB](https://dl.dropbox.com/u/14133634/infhub.png) _A rede de compartilhamento de trabalhos do INF_

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

#### Ideas

* Add any number of links and files
* File format detection and pretty display
* A special place on the user profile page for display set of his featured works (chosen by himself)
* Tree-style navigation for a better exploring experience.
* Integrate with Dropbox Chooser (https://www.dropbox.com/developers/chooser) (upload files directly from Dropbox)
* Create a special field for an user to mark how good he rates his own project (like "Best project in class", "So-so", "Awful! Can't even tell why I'm publishing this")
* Playlist style content aggregation. (like: "my favorite CG projects")