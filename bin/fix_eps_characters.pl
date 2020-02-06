#!/usr/bin/perl
use warnings;
use strict;


# Character names that I was unable to empirically derive FrameMaker EPS encodings for:
#   AE
#   Aacute
#   Acircumflex
#   Adieresis
#   Agrave
#   Aring
#   Atilde
#   Eacute
#   OE
#   Thorn
#   Yacute
#   Ydieresis
#   cedilla
#   dieresis
#   oe
#   ring


# FrameMaker EPS encodings that I could not find a workable substitute for:
#  '\202\305\321' => 'fraction',
#  '\320\307' => 'rcommaaccent',
#  '\335\305' => 'Lslash',
#  '\335\307' => 'lslash',
#  '\335\276' => 'Zcaron',
#  '\335\346' => 'zcaron',
#  '\375\355' => 'florin',
#  '\300\334' => 'circumflex',
#  '\300\341' => 'caron',
#  '\300\362' => 'breve',
#  '\300\364' => 'dotaccent',
#  '\300\365' => 'ogonek',
#  '\300\371' => 'hungarumlaut',
#  '\300\372' => 'tilde',


# FrameMaker writes out colliding encodings for these two:
#  '\254\243' => 'Dcroat',
#  '\254\243' => 'sterling',


my %encoding_to_name = (
 '\202\304\206' => 'dagger',
 '\202\304\242' => 'bullet',
 '\202\304\260' => 'daggerdbl',
 '\202\304\266' => 'ellipsis',
 '\202\304\274' => 'guilsinglleft',
 '\202\304\327' => 'perthousand',
 '\202\304\354' => 'endash',
 '\202\304\356' => 'emdash',
 '\202\304\362' => 'quoteleft',
 '\202\304\364' => 'quoteright',
 '\202\304\366' => 'quotesinglbase',
 '\202\304\371' => 'quotedblright',
 '\202\304\372' => 'quotedblleft',
 '\202\304\373' => 'quotedblbase',
 '\202\321\242' => 'trademark',
 '\202\340\355' => 'minus',
 '\203\261' => 'dotlessi',
 '\214\272' => 'mu',
 '\254\225' => 'yen',
 '\254\231' => 'ordfeminine',
 '\254\240' => 'threesuperior',
 '\254\242' => 'cent',
 '\254\245' => 'acute',
 '\254\247' => 'currency',
 '\254\250' => 'logicalnot',
 '\254\251' => 'copyright',
 '\254\252' => 'guillemotright',
 '\254\260' => 'exclamdown',
 '\254\261' => 'plusminus',
 '\254\262' => 'periodcentered',
 '\254\264' => 'guillemotleft',
 '\254\266' => 'brokenbar',
 '\254\271' => 'paragraph',
 '\254\272' => 'onequarter',
 '\254\274' => 'onesuperior',
 '\254\275' => 'ordmasculine',
 '\254\276' => 'onehalf',
 '\254\306' => 'registered',
 '\254\327' => 'degree',
 '\254\330' => 'macron',
 '\254\337' => 'section',
 '\254\346' => 'threequarters',
 '\254\360' => 'twosuperior',
 '\254\370' => 'questiondown',
 '\320\206' => 'agrave',
 '\320\225' => 'aring',
 '\320\231' => 'ecircumflex',
 '\320\240' => 'oacute',
 '\320\242' => 'acircumflex',
 '\320\243' => 'atilde',
 '\320\245' => 'ocircumflex',
 '\320\246' => 'iacute',
 '\320\247' => 'adieresis',
 '\320\250' => 'igrave',
 '\320\251' => 'eacute',
 '\320\252' => 'ucircumflex',
 '\320\256' => 'egrave',
 '\320\260' => 'aacute',
 '\320\261' => 'ntilde',
 '\320\262' => 'divide',
 '\320\263' => 'oslash',
 '\320\264' => 'edieresis',
 '\320\265' => 'otilde',
 '\320\266' => 'ae',
 '\320\271' => 'odieresis',
 '\320\272' => 'udieresis',
 '\320\274' => 'ugrave',
 '\320\275' => 'uacute',
 '\320\276' => 'yacute',
 '\320\306' => 'icircumflex',
 '\320\327' => 'eth',
 '\320\330' => 'idieresis',
 '\320\337' => 'ccedilla',
 '\320\340' => 'Egrave',
 '\320\341' => 'Ccedilla',
 '\320\343' => 'Edieresis',
 '\320\344' => 'Ecircumflex',
 '\320\345' => 'Igrave',
 '\320\346' => 'thorn',
 '\320\347' => 'Iacute',
 '\320\350' => 'Idieresis',
 '\320\351' => 'Icircumflex',
 '\320\352' => 'Eth',
 '\320\353' => 'Ntilde',
 '\320\354' => 'Oacute',
 '\320\355' => 'Ograve',
 '\320\356' => 'Ocircumflex',
 '\320\357' => 'Otilde',
 '\320\360' => 'ograve',
 '\320\361' => 'Odieresis',
 '\320\362' => 'Oslash',
 '\320\363' => 'multiply',
 '\320\364' => 'Ugrave',
 '\320\365' => 'Ucircumflex',
 '\320\366' => 'Uacute',
 '\320\370' => 'ydieresis',
 '\320\372' => 'Udieresis',
 '\320\374' => 'germandbls',
 '\324\370\276' => 'guilsinglright',
 '\335\206' => 'Scaron',
 '\335\260' => 'scaron',
);


my %name_to_char = (
 'dagger' => '\206',
 'bullet' => '\225',
 'daggerdbl' => '\207',
 'ellipsis' => '\205',
 'guilsinglleft' => '\213',
 'perthousand' => '\211',
 'endash' => '\226',
 'emdash' => '\227',
 'quoteleft' => '\221',
 'quoteright' => '\222',
 'quotesinglbase' => '\202',
 'quotedblright' => '\224',
 'quotedblleft' => '\223',
 'quotedblbase' => '\204',
 'trademark' => '\231',
 'minus' => '\055',
 'dotlessi' => '\235',
 'mu' => '\265',
 'yen' => '\245',
 'ordfeminine' => '\252',
 'threesuperior' => '\263',
 'cent' => '\242',
 'acute' => '\264',
 'currency' => '\244',
 'logicalnot' => '\254',
 'copyright' => '\251',
 'guillemotright' => '\273',
 'exclamdown' => '\241',
 'plusminus' => '\261',
 'periodcentered' => '\267',
 'guillemotleft' => '\253',
 'brokenbar' => '\246',
 'paragraph' => '\266',
 'onequarter' => '\274',
 'onesuperior' => '\271',
 'ordmasculine' => '\272',
 'onehalf' => '\275',
 'registered' => '\256',
 'degree' => '\260',
 'macron' => '\257',
 'section' => '\247',
 'threequarters' => '\276',
 'twosuperior' => '\262',
 'questiondown' => '\277',
 'agrave' => '\340',
 'aring' => '\345',
 'ecircumflex' => '\352',
 'oacute' => '\363',
 'acircumflex' => '\342',
 'atilde' => '\343',
 'ocircumflex' => '\364',
 'iacute' => '\355',
 'adieresis' => '\344',
 'igrave' => '\354',
 'eacute' => '\351',
 'ucircumflex' => '\373',
 'egrave' => '\350',
 'aacute' => '\341',
 'ntilde' => '\361',
 'divide' => '\367',
 'oslash' => '\370',
 'edieresis' => '\353',
 'otilde' => '\365',
 'ae' => '\346',
 'odieresis' => '\366',
 'udieresis' => '\374',
 'ugrave' => '\371',
 'uacute' => '\372',
 'yacute' => '\375',
 'icircumflex' => '\356',
 'eth' => '\360',
 'idieresis' => '\357',
 'ccedilla' => '\347',
 'Egrave' => '\310',
 'Ccedilla' => '\307',
 'Edieresis' => '\313',
 'Ecircumflex' => '\312',
 'Igrave' => '\314',
 'thorn' => '\376',
 'Iacute' => '\315',
 'Idieresis' => '\317',
 'Icircumflex' => '\316',
 'Eth' => '\320',
 'Ntilde' => '\321',
 'Oacute' => '\323',
 'Ograve' => '\322',
 'Ocircumflex' => '\324',
 'Otilde' => '\325',
 'ograve' => '\362',
 'Odieresis' => '\326',
 'Oslash' => '\330',
 'multiply' => '\327',
 'Ugrave' => '\331',
 'Ucircumflex' => '\333',
 'Uacute' => '\332',
 'ydieresis' => '\377',
 'Udieresis' => '\334',
 'germandbls' => '\337',
 'guilsinglright' => '\233',
 'Scaron' => '\212',
 'scaron' => '\232',
);


while (my $filename = shift) {
 open(PSFILE, "+<$filename") or die "can't open $filename for read: $!";
 binmode(PSFILE, ":raw");

 read PSFILE, my $bytes, 30;
 my ($magic, $language_pos, $language_length, $metafile_pos, $metafile_length, $tiff_pos, $tiff_length, $checksum) = unpack('L> L L L L L L S>', $bytes);
 if ($magic ne 0xc5d0d3c6) {
  print "Error: '$filename' is not a valid EPS file.\n";
  next;
 }

 my $pscode;
 seek(PSFILE, $language_pos, 0);
 read(PSFILE, $pscode, $language_length+2);
 my $orig_length = length($pscode);

 my $changes = 0;
 my $remap_chars = sub {
  $changes++;
  return $name_to_char{$encoding_to_name{$_[0]}};
 };

 my $process_guts = sub {
  my $fmseq_pattern = '('.join('|', map {$_ =~ s!\\!\\\\!gr} sort keys %encoding_to_name).')';
  my $fmseq_re = qr/$fmseq_pattern/;
  return ($_[0] =~ s!($fmseq_re)!$remap_chars->($1)!gser);
 };

 $pscode =~ s!(%%EndSetup\r\n.*\r\n%%EOF\r\n)!$process_guts->($1)!se;
 my $new_length = length($pscode);


 print "Fixed $changes special characters in '$filename'.\n" if $changes;

 if ($changes) {
  seek(PSFILE, $language_pos, 0);
  print PSFILE $pscode;
  print PSFILE '%'x($orig_length - $new_length);
  seek(PSFILE, 8, 0);
  print PSFILE pack('L', $new_length);
 }

 close(PSFILE);
}

