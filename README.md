Radiant Tiny-Paper Extension
===

About
---

An extension by [Aissac][ai] that adds Paperclipped based Tiny MCE support to [Radiant CMS][rd]. This extension provides a `Rich Text Editor filter` and allows you to edit the content using the TinyMCE editor. It also provides an Image and File browser to help you manage the Paperclipped assets.

The Tiny-Paper Extension is Radiant 0.7.1 compatible.

Features
---

* TinyMCE WYSIWYG editor in your Radiant page as a toggable filter;
* Image Browser, based on Paperclipped image assets;
* File Browser, based on Paperclipped assets;
* Upload facilities directly in TinyMCE Image/File browser;
* Thumbnails and text list views
* Directly add a link to a Radiant Page from TinyMce editor;

Installation
---

Tiny-Paper Extension has three dependencies, the Paperclipped and Settings extensions, and the will\_paginate gem/plugin

Install the [Settings Extension][settings]

    git submodule add git://github.com/Squeegy/radiant-settings.git vendor/extensions/settings

Install the [Paperclipped Extension][paperclipped]

    git submodule add git://github.com/kbingman/paperclipped.git vendor/extensions/paperclipped
    
And the will\_paginate gem/plugin:

    git submodule add git://github.com/mislav/will_paginate.git vendor/plugins/will_paginate

or

    sudo gem install mislav-will_paginate
    
Finally, install the [Tiny-Paper Extension][tp]

    git submodule add git://github.com/Aissac/tiny-paper.git vendor/extensions/tiny_paper

For more information about installing and configuring Settings and Paperclipped check the extensions official pages.
    
Because Paperclipped is based on Settings, you will need to migrate the Settings Extension first:

    rake radiant:extensions:settings:migrate
    rake radiant:extensions:settings:update
    
and then run the Paperclipped migrations and updates:

    rake radiant:extensions:paperclipped:migrate
    rake radiant:extensions:paperclipped:update
    
The last step is to update the Tiny-Paper assets:

    rake radiant:extensions:tiny_paper:update

Configuration
---

Usage
---

The Tiny-Paper Extension add a "Rich Text Editor" filter, just toggle the filter and start using it.

It also provides two management systems, one for images and one for files, both based on Paperclipped

The Image Browser can be accessed through the `insert/edit image` icon, and presents all the images uploaded through Paperclipped. There are two types of views (text list and thumbnails), filtering, sorting and pagination facilities, and a form for directly uploading images.

The File Browser can be accessed through the `insert/edit link` icon and present two sections: one for adding a link to a Radiant Page, and one for adding a link to an uploaded file.

Contributors
---

TODO
---

* Be more user friedly, by presenting more information (like image actual size in pixels);
* Change the way a user chooses the image size to insert;


[ai]: http://www.aissac.ro/
[rd]: http://radiantcms.org/
[settings]: http://github.com/Squeegy/radiant-settings/tree/master
[paperclipped]: http://github.com/kbingman/paperclipped/tree/master
[tp]: http://blog.aissac.ro/radiant/tiny-paper/