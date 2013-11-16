# Invoicerb: Simple command line invoicing

## Installation

Install **invoicerb** as a gem:

    gem install invoicerb

## Commands

Invoicerb is a command line tool and can be executed using the `invoice` command from your terminal.

    invoice

This will output something like this:

    NAME
        invoice - Invoicerb: Simple command line invoicing.

    SYNOPSIS
        invoice [global options] command [command options] [arguments...]

    VERSION
        0.0.1

    GLOBAL OPTIONS
        --help    - Show this message
        --version - Display the program version

    COMMANDS
        build - Build an invoice PDF
        help  - Shows a list of commands or help for one command
        init  - Create the initial invoice structure
        new   - Create a new invoice meta file

### Init

The `init` command will create a hidden `~/.invoicerb` directory at the root of your home directory.
This directory has a `templates` subdirectory that holds the templates that descirbe your address and footer details.
You can also configure the app by editing the `~/.invoicerb/invoicerb` config file.

    invoice init

### New

Invoicerb uses an invoice meta file to create a PDF invoice from. Use the `new` command to generate a scaffold meta file in you current directory.
Once the meta file has been created you should edit it according to the invoice you wish to create.

    invoice new my-invoice-00001

This will create the following file:

    ./my-invoice-00001.rb

### Build

To create a PDF invoice based on you specified invoice meta file use the `build` command:

    invoice build my-invoice-00001

This will create a PDF invoice file such as `output.pdf` in your current directory.

## Todo

* Pass the total currency value from the config into the PDF.
* Remove default `output.pdf` name and use specified file name.
* Add flags for passing through settings.
* Add Cucumber tests.
* Add more RSpec tests.


## MIT License

Copyright (c) 2013 B. F. B. Emson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


