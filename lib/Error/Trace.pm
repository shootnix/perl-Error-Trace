package Error::Trace;

use strict;
use warnings;
use v5.16;
use overload '==' => \&equals, '""' => \&toString, fallback => 1;

our $VERSION = '0.01';

=head1 NAME

Error::Trace - Lightweight error object with trace accumulation.

=head1 SYNOPSIS

    use Error::Trace;

    my $err = Error::Trace->new('USER_NOT_FOUND', 'initial login fail');
    $err->trace('user not found in db');
    $err->trace('auth use case aborted');

    warn $err;

    if ($err == 'USER_NOT_FOUND') {
        die $err;
    }

=head1 DESCRIPTION

Error::Trace provides a simple object-oriented way to handle errors,
allowing you to accumulate contextual trace messages as the error propagates.

=head1 METHODS

=head2 new($code, $optional_message)

Creates a new error object with a given code and an optional initial trace message.

=head2 trace($message)

Adds a trace message to the error, recording the caller's file and line if available.

=head2 toString()

Returns a formatted string representation of the error and all traces.

=head2 equals($other)

Compares the error code with another string.

=cut

sub new {
    my ($class, $code, $extra) = @_;

    my $self = bless {
        code   => $code,
        traces => [],
    }, $class;

    $self->trace($extra) if defined $extra;

    return $self;
}

sub trace {
    my ($self, $msg) = @_;

    my ($filename, $line);

    for my $level (1, 0) {
        my @c = caller($level);
        if (defined $c[1] && defined $c[2]) {
            ($filename, $line) = @c[1, 2];
            last;
        }
    }

    if (defined $filename && defined $line) {
        push @{ $self->{traces} }, sprintf '"%s" at %s, line %s', $msg, $filename, $line;
    } 
    else {
        push @{ $self->{traces} }, $msg;
    }

    return $self;
}

sub toString {
    my ($self) = @_;
    return join("\n\t- ", $self->{code}, @{ $self->{traces} });
}

sub equals {
    my ($self, $other, $swap) = @_;
    return $self->{code} eq $other;
}

1;

=head1 AUTHOR

Alexander Ponomarev E<lt>shootnix@gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut