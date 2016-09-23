#!/bin/bash

# ensure latest packages are downloaded
elm-package install --yes

# only create the .js as we will rely on a custom html file (ports)
elm-make --warn --output elm.js --yes app/Main.elm
