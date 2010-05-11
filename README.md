Radiant Tiny-Paper Extension
===

About
---

An extension by [Aissac][ai] that adds [Paperclipped][paperclipped] based [Tiny MCE][tinymce] support to [Radiant CMS][rd]. This extension provides a `Rich Text Editor` filter and allows you to edit the content using the TinyMCE editor. It also provides an Image and File browser to help you manage the Paperclipped assets.

Tested on Radiant 0.7.1, 0.8 and 0.9 RC2.

Features
---

* TinyMCE WYSIWYG editor in your Radiant page as a filter;
* Image Browser, based on Paperclipped image assets;
* File Browser, based on Paperclipped assets;
* Upload assets directly in TinyMCE Image/File browser;
* Thumbnails and text list views;
* Directly add a link to a Radiant Page from TinyMce editor.

Important Notice!
---

The git branches of this repository hold stable versions of the extension for older versions of Radiant CMS. For example the _0.8_ branch is compatible with Radiant 0.8. 

To checkout one of these branches:

    git clone git://github.com/Aissac/radiant-tiny-paper-extension.git vendor/extensions/tiny_paper
    cd vendor/extensions/tiny_paper
    git checkout -b <branch-name> origin/<remote-branch-name>

As an example, if you're working on Radiant 0.8 you will need to checkout the 0.8 branch:
    
    cd vendor/extensions/tiny_paper
    git checkout -b my_branch origin/0.8
    
Also, be sure to checkout a version of the Paperclipped extension that is compatible with the Radiant version you're working on.

Installation
---

Tiny-Paper Extension has two dependencies, the Paperclipped extension and the will\_paginate gem/plugin.

Install the [Paperclipped Extension][paperclipped] (be sure to checkout a version of Paperclipped compatible with the Radiant version you're working on.)

    git clone git://github.com/kbingman/paperclipped.git vendor/extensions/paperclipped
    
And the will\_paginate gem/plugin:

    git clone git://github.com/mislav/will_paginate.git vendor/plugins/will_paginate

or

    sudo gem install mislav-will_paginate

You may also want to install the [Settings Extension][settings] since it provides a very convenient way to configure thumbnail sizes for image assets:

    git clone git://github.com/Squeegy/radiant-settings.git vendor/extensions/settings

Finally, install the [Tiny-Paper Extension][tp]

    git clone git://github.com/Aissac/radiant-tiny-paper-extension.git vendor/extensions/tiny_paper

For more information about installing and configuring Settings and Paperclipped check the extensions official pages.
    
If you choose to use the Settings extension, you will need to migrate it first:

    rake radiant:extensions:settings:migrate
    rake radiant:extensions:settings:update
    
and then run the Paperclipped migrations and updates:

    rake radiant:extensions:paperclipped:migrate
    rake radiant:extensions:paperclipped:update
    
The last step is to update the Tiny-Paper assets:

    rake radiant:extensions:tiny_paper:update

Usage
---

The Tiny-Paper Extension adds a "Rich Text Editor" filter, just toggle the filter and start using it.

It also provides two management systems, one for images and one for files, both based on Paperclipped.

The Image Browser can be accessed through the `insert/edit image` icon, and presents all the images uploaded through Paperclipped. There are two types of views (text list and thumbnails), filtering, sorting and pagination facilities, and a form for directly uploading images.

The File Browser can be accessed through the `insert/edit link` icon and has two sections: one for adding a link to a Radiant Page, and one for adding a link to an uploaded file.

Contributors
---

* Cristi Duma ([@cristi_duma][cd])
* Istvan Hoka ([@ihoka][ih])

[ai]: http://aissac.ro/
[rd]: http://radiantcms.org/
[settings]: http://github.com/Squeegy/radiant-settings/tree/master
[paperclipped]: http://github.com/kbingman/paperclipped/tree/master
[tp]: http://blog.aissac.ro/radiant/tiny-paper-extension/
[tinymce]: http://tinymce.moxiecode.com/
[cd]: http://twitter.com/cristi_duma
[ih]: http://twitter.com/ihoka