[![Actions Status](https://github.com/raku-community-modules/Shell-Command/actions/workflows/test.yml/badge.svg)](https://github.com/raku-community-modules/Shell-Command/actions)

NAME Shell::Command
===================

Provides **cross-platform** routines emulating common \*NIX shell commands

SYNOPSIS
========

    use Shell::Command;

    # Recursive folder copy
    cp 't/dir1', 't/dir2', :r;

    # Remove a file
    rm_f 'to_delete';

    # Remove directory
    rmdir 't/dupa/foo/bar';

    # Make path
    mkpath 't/dir2';

    # Remove path
    rm_rf 't/dir2';

    # Find Raku in executable path
    my $raku-path = which('raku');

    # Concatenate the contents of a file or list of files and print to STDOUT
    cat "file1.txt", "file2.txt";

    # A cross platfrom syncronous run()
    my $command = $*DISTRO.is-win ?? 'binary.exe' !! 'binary';
    run-command($binary, 'some', 'parameter');

AUTHOR
======

Tadeusz “tadzik” Sośnierz"

COPYRIGHT AND LICENSE
=====================

Copyright 2010-2017 Tadeusz Sośnierz Copyright 2023 Raku Community

This library is free software; you can redistribute it and/or modify it under the MIT license.

Please see the LICENCE file in the distribution

CONTRIBUTORS
============

  * Dagur Valberg Johansson

  * Elizabeth Mattijsen

  * Filip Sergot

  * Geoffrey Broadwell

  * GlitchMr

  * Heather

  * Kamil Kułaga

  * Moritz Lenz

  * Steve Mynott

  * timo

  * Tobias Leich

  * Tim Smith

  * Ahmad M. Zawawi (azawawi @ #raku)

  * Martin Barth

