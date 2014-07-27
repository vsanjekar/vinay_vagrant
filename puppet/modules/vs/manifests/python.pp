class vs::python {

    package { 
      [ "python", "python-setuptools", "python-dev", "python-pip",
        "python-matplotlib", "python-imaging", "python-numpy", "python-scipy",
        "python-software-properties", "idle", "python-qt4", "python-wxgtk2.8" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }

    exec {
      "virtualenv":
      command => "/usr/bin/sudo pip install virtualenv",
      require => Package["python-dev", "python-pip"]
    }

}

class vs::web {

    exec {
      "oauth2":
      command => "/usr/bin/sudo pip install oauth2",
      require => Package["python-pip"]
    }

    exec {
      "beautifulsoup4":
      command => "/usr/bin/sudo pip install beautifulsoup4",
      require => Package["python-pip"]
    }

    package { 
      [ "python-twisted" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }

    exec {
      "bottle":
      command => "/usr/bin/sudo pip install bottle",
      require => Package["python-dev", "python-pip"]
    }

    exec {
      "sqlalchemy":
      command => "/usr/bin/sudo pip install sqlalchemy",
      require => Package["python-pip"],
    }

    exec {
      "django":
      command => "/usr/bin/sudo pip install django",
      require => Package["python-pip"],
    }

    exec {
      "mechanize":
      command => "/usr/bin/sudo pip install mechanize",
      require => Package["python-pip"]
    }
    
    exec {
      "scrapelib":
      command => "/usr/bin/sudo pip install scrapelib",
      require => Package["python-pip"]
    }

    exec {
      "Pyes":
      command => "/usr/bin/sudo pip install Pyes",
      require => Package["python-pip"]
    }

}

class vs::flask {

  exec {
    "fabric":
      command => "/usr/bin/sudo pip install Fabric",
      require => Package["python-pip"],
  }

  exec {
    "Flask":
      command => "/usr/bin/sudo pip install Flask",
      require => Package["python-pip"],
  }

  exec {
    "flask-sqlalchemy":
      command => "/usr/bin/sudo pip install Flask-SQLAlchemy",
      require => Package["python-pip"],
  }

  exec {
    "flask-script":
      command => "/usr/bin/sudo pip install Flask-Script",
      require => Package["python-pip"],
  }

  exec {
    "flask-wtforms":
      command => "/usr/bin/sudo pip install Flask-WTF",
      require => Package["python-pip"],
  }

  exec {
    "argparse":
      command => "/usr/bin/sudo pip install argparse",
      require => Package["python-pip"],
  }

  exec {
    "distribute":
      command => "/usr/bin/sudo pip install distribute",
      require => Package["python-pip"],
  }

  exec {
    "pyGeoDB":
      command => "/usr/bin/sudo pip install pyGeoDB",
      require => Package["python-pip"],
  }

  exec {
    "wtforms-recaptcha":
      command => "/usr/bin/sudo pip install wtforms-recaptcha",
      require => Package["python-pip"],
  }

  exec {
    "flup":
      command => "/usr/bin/sudo pip install flup",
      require => Package["python-pip"],
  }

}

