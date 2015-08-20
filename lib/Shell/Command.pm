unit module Shell::Command;
use File::Find;

sub cat(*@files) is export {
    for @files -> $f {
        given open($f) {
            for .lines -> $line {
                say $line;
            }
            .close
        }
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

sub cp($from as Str, $to as Str, :$r) is export {
    if ($from.IO ~~ :d and $r) {
        mkdir("$to") if $to.IO !~~ :d;
        for dir($from).map(*.basename) -> $item {
            mkdir("$to/$item") if "$from/$item".IO ~~ :d;
            cp("$from/$item", "$to/$item", :r);
        }
    } else {
        $from.IO.copy($to);
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

# vim: ft=perl6
