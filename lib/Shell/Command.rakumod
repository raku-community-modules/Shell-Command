unit module Shell::Command;

use File::Find;

my @run-invoke = BEGIN $*DISTRO.is-win ?? <cmd.exe /x/d/c>.Slip !! '';
sub run-command(*@_, *%_) is export {
    run (|@run-invoke, |@_).grep(*.?chars), |%_
}

sub cat(*@files) is export {
    for @files -> $f {
        .say for $f.IO.lines;
    }
}

sub eqtime($source, $dest) is export {
    ???
}

sub rm_f(*@files) is export {
    for @files -> $f {
        unlink $f if $f.IO.e;
    }
}

sub rm_rf(*@files) is export {
    for @files -> $path {
        if $path.IO.d {
            for find(dir => $path).map({ .Str }).sort.reverse -> $f {
                $f.IO.d ?? rmdir($f) !! unlink($f);
            }
            rmdir $path;
        }
        elsif $path.IO.e {
            unlink($path);
        }
    }
}

sub touch(*@files) is export {
    ???
}

sub mv(*@args) is export {
    ???
}

sub cp(Str() $from,Str() $to is copy, :$r, :$v) is export {
    if ($from.IO ~~ :d and $r) {
        mkdir("$to") if $to.IO !~~ :d;
        for dir($from)».basename -> $item {
            mkdir("$to/$item") if "$from/$item".IO ~~ :d;
            cp("$from/$item", "$to/$item", :r, :$v);
        }
    } else {
        if $to.IO.d {
            $to = "$to/" ~ $from.IO.basename;
        }
        $from.IO.copy($to);
        say "$from -> $to" if $v;
    }
}

sub mkpath(*@paths) is export {
    for @paths -> $name {
        for [\~] $name.split(/<[\/\\]>/).map({"$_/"}) {
            mkdir($_) unless .IO.d
        }
    }
}

sub test_f($file) is export {
    ???
}

sub test_d($file) is export {
    ???
}

sub dos2unix($file) is export {
    ???
}

sub which($name) is export {
  warn "Please use File::Which instead for a more portable solution."
    if $*DISTRO.is-win || $*DISTRO.name eq 'macosx';

  for $*SPEC.path.map({ $*SPEC.catfile($^dir, $name) }) {
    return $_ if .IO.x;
  }
  Str
}

=begin pod

=head1 NAME

Shell::Command - provide cross-platform routines emulating common *NIX shell commands

=head1 SYNOPSIS

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

=head1 AUTHOR

Tadeusz “tadzik” Sośnierz"

=head1 COPYRIGHT AND LICENSE

Copyright 2010-2017 Tadeusz Sośnierz
Copyright 2023 Raku Community
        
This library is free software; you can redistribute it and/or modify it under the MIT license.
    
Please see the LICENCE file in the distribution

=head1 CONTRIBUTORS

=item Dagur Valberg Johansson
=item Elizabeth Mattijsen
=item Filip Sergot
=item Geoffrey Broadwell
=item GlitchMr
=item Heather
=item Kamil Kułaga
=item Moritz Lenz
=item Steve Mynott
=item timo
=item Tobias Leich
=item Tim Smith
=item Ahmad M. Zawawi (azawawi @ #raku)
=item Martin Barth

=end pod

# vim: expandtab shiftwidth=4
