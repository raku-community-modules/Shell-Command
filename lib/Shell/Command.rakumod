use File::Find:ver<0.2.2+>:auth<zef:raku-community-modules>;

my @run-invoke = BEGIN $*DISTRO.is-win ?? <cmd.exe /x/d/c>.Slip !! '';

my sub run-command(*@_, *%_) is export {
    run (|@run-invoke, |@_).grep(*.?chars), |%_
}

my sub cat(*@files) is export {  # UNCOVERABLE
    .say for @files.map(*.IO.slurp);  # UNCOVERABLE
}

my sub rm_f(*@files) is export {
    for @files -> $f {
        unlink $f if $f.IO.e;
    }
}

my sub rm_rf(*@files) is export {
    for @files -> $path {
        if $path.IO.d {
            for find(dir => $path).map({ .Str }).sort.reverse -> $f {
                $f.IO.d ?? rmdir($f) !! unlink($f);
            }
            rmdir $path;
        }
        elsif $path.IO.e {  # UNCOVERABLE
            unlink($path);
        }
    }
}

my sub cp(Str() $from,Str() $to is copy, :$r, :$v) is export {
    if ($from.IO ~~ :d and $r) {
        mkdir("$to") if $to.IO !~~ :d;
        for dir($from)».basename -> $item {
            mkdir("$to/$item") if "$from/$item".IO ~~ :d;
            cp("$from/$item", "$to/$item", :r, :$v);
        }
    }
    else {
        if $to.IO.d {
            $to = "$to/" ~ $from.IO.basename;
        }
        $from.IO.copy($to);
        say "$from -> $to" if $v;
    }
}

my sub mkpath(*@paths) is export {
    for @paths -> $name {
        for [\~] $name.split(/<[\/\\]>/).map({"$_/"}) {
            mkdir($_) unless .IO.d
        }
    }
}

my sub which($name) is export {
    for $*SPEC.path.map({ $*SPEC.catfile($^dir, $name) }) {
        return $_ if .IO.x;
    }
    Str
}

#- hack ------------------------------------------------------------------------
# To allow version
unit module Shell::Command:ver<1.2>:auth<zef:lizmat>;

# vim: expandtab shiftwidth=4
