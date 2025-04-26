use strict;
use warnings;
use Test::More tests => 6;

use lib 'lib';
use Error::Trace;

# Тест создания ошибки
my $err = Error::Trace->new('USER_NOT_FOUND', 'initial problem');

isa_ok($err, 'Error::Trace');

# Тест сравнения ошибки
ok($err == 'USER_NOT_FOUND', 'Error code matches');

# Тест, что коды разные
ok(!($err == 'SOME_OTHER_ERROR'), 'Error code mismatch');

# Тест трассы
$err->trace('second issue');
my $output = $err->toString;

like($output, qr/USER_NOT_FOUND/, 'Output includes error code');
like($output, qr/initial problem/, 'Output includes initial trace');
like($output, qr/second issue/, 'Output includes second trace');

done_testing;