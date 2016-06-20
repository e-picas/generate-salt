Generate salt
=============

The `generate-salt.sh` command is a shell script (written in *Bash*) to generate random *salt* or *password*
strings based on various presets.

Usage
-----

    usage: ./generate-salt.sh <preset> [length=default]

    available presets:
                 name	length	mask                          
           ----------	------	----                          
                num :	8     	0-9                           
         upperalpha :	10    	A-Z                           
         loweralpha :	10    	a-z                           
              alpha :	12    	A-Za-z                        
           alphanum :	12    	A-Za-z0-9                     
              basic :	16    	A-Za-z0-9#!$*@&%              
               hard :	64    	A-Za-z0-9#!$*@&%\-+=\/.,:;?()[]^`

    e.g. ./generate-salt.sh alpha      : dlNMPuMhfXCG
         ./generate-salt.sh basic 18   : VjO23Jv4K@2&sLwUF4
         ./generate-salt.sh hard 64    : vDm@UMG%5+CKsgY5xJX]jA(WtsN^8Ik;/,k6mFW.qNRvq(bf(WM+E2tGaR`R(m@]
     
Installation
------------

As the command is a simple shell script, it can be used from source anywhere you need.
In a terminal, run:

    $ git clone https://github.com/e-picas/generate-salt.git
    $ cd generate-salt
    $ ./generate-salt.sh

To install it as a command available for all your system users, you can do (as a *root* user):

    $ cp /path/to/generate-salt.sh /usr/local/bin/
    $ chmod a+x /usr/local/bin/generate-salt.sh

If you want to use a clone (to keep up-to-date), you can also do something like (as a *root* user):

    $ cd /usr/local/lib/
    $ git clone https://github.com/e-picas/generate-salt.git
    $ ln -s /usr/local/lib/generate-salt/generate-salt.sh /usr/local/bin/

Support
-------

The *generate salt* source code repository is [hosted on GitHub](https://github.com/e-picas/generate-salt).
You can use this repository to transmit bug on the issue tracker or submit tested pull requests for review.

---

(c) 2014-2016 Pierre Cassat. *Generate salt* is released under the terms of the MIT license; see `LICENSE` for details.
