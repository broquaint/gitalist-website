package GitalistWeb::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

GitalistWeb::Controller::Root - Root Controller for GitalistWeb

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 fav

=cut

sub fav : Chained('base') PathPart('favicon.ico') Args(0) {
    my ( $self, $c ) = @_;
    $c->res->redirect('/static/favicon.ico');
    $c->res->status(301);
}


=head2 base

=head2 default

=cut

sub base : Chained('/') PathPart('') CaptureArgs(0) {}

sub default : Chained('base') PathPart('') Args {
    my ($self, $c, @args) = @_;
    my $path = join('/', @args);
    if ($path !~ /\w+\.\w+$/) {
        $path .= '/index.html';
    }
    $path =~ s{^/}{};
    $c->log->debug('Template path: /' . $path) if $c->debug;
    $c->detach('/error404')
        if $path =~ m|^inc/|;
    $c->detach('/error404')
        unless -f $c->path_to('root', $path);
    $c->stash(template => $path);

}

=head2 error404

=cut

sub error404 : Action {
    my ($self, $c) = @_;
    $c->stash(template => 'error404.html');
    $c->response->code(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
