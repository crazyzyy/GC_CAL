function varargout = fit_decay_oscillations( varargin )
%[A, T1, T2, phase, offset, Ssq] = fit_decay_oscillations( t, y, options )
%fitting decaying oscillations of the form
%y(t) = A exp( -t/T1 ) cos( t / T2 + phi) + offset
%where A is the amplitude, T1 is the decay time, T2 is the period, along with 
%phase and offest. Ssq is the sum of residuals.
%
%options are 'notify' to show progress and 'plot' to give a plot
%you can also supply a guess or series of guesses via a row vector or
%matrix, m, where size( m, 2 ) = 5;
%
%if you just run program without arguments it will do an example
%
%examples are
%fit_decay_oscillations( t, y, 'notify', 'plot')
%[A, T1, T2, phase, offset] = fit_decay_oscillations( t, y, [1 2 3 4 5])
%
%Note: this script uses LMFnlsq from MATLAB central file exchange
%sak@wpi.edu 2/5/12

fnc = @(A, T1, T2, phase, offset, t ) A*exp(-t/T1).*cos( 2*pi*t/T2 + phase ) + offset;

if nargin == 0
    disp( 'doing sample fitting' );
    t = linspace( -2, 10, 1000 );
    [A, T1, T2, phase, offset] = deal( 1, 1, 10, 0.1, 1 );    
    y = fnc( A, T1, T2, phase, offset, t )+randn(size( t ) )*.01;
    varargin = { t, y, 'plot', 'Xnotify' };
end;
[t, y] = deal( shiftdim( varargin{1} ), shiftdim( varargin{2} ) );
varargin(1:2) = [];

plot_flag = strcmpi( varargin, 'plot' );
varargin( plot_flag ) = [];

if any( strcmpi( varargin, 'notify' ) ); 
    notify = @(str) fprintf( str );
else
    notify = @(str) '';
end
varargin( strcmpi( varargin, 'notify' ) ) = [];

if any( plot_flag )
    figure( sum( mfilename ) );
    clf;
    plot( t, y, '.r' );
end

t_ = t - t(1);
if any( cellfun( 'isclass', varargin, 'double' ) )
    guess = varargin{cellfun( 'isclass', varargin, 'double' )};    
else
    [phase, T1, T2] = ndgrid( pi/6*[0:5], t_(end)*[.1 1 10], t_(end)*[.1 1 10 100] );
    guess = [reshape( y(1)./cos(phase ), [], 1), reshape( T1, [], 1), reshape( T2, [], 1), reshape( phase, [], 1), repmat( mean(y), numel( phase ), 1 ) ];
end

J = @(param) [ param(1)*repmat( exp(-t_/param(2)), 1, 4 ).*[...
    repmat( cos( 2*pi*t_/param(3) + param(4) ), 1, 2).*[ repmat( 1/param(1), size( t_) ), t_/param(2)^2], ...
    + repmat( sin( 2*pi*t_/param(3) + param(4) ), 1, 2).*[ 2*pi*t_/param(3)^2, -ones( size(t_) )]], ...
    ones( size( t_) )];
warning off;
param = nan( size( guess ) );
[Ssq, CNT] = deal( nan( size( guess, 1), 1) );
tic;
for i=1:size(guess, 1);
    notify( sprintf( 'trying param A = %g, T1 = %g, T2 = %g, phase = %g, offset = %g ', guess(i,:) ) );        
    [param(i,:), Ssq(i), CNT(i)] = LMFnlsq( @(param) fnc( param(1), param(2), param(3), param(4), param(5), t_ ) - y, guess(i,:), 'Jacobian', J, 'MaxIter', 20 );
    notify( sprintf( 'error %g \n', Ssq(i) ) );
end
notify(sprintf( '%.2f sec \n', toc ) );
warning on;
[best, i] = min( Ssq );
%refining solution
[param(i,:), Ssq(i), CNT(i), Res, XY] = LMFnlsq( @(param) fnc( param(1), param(2), param(3), param(4), param(5), t_ ) - y, param(i, :), 'Jacobian', J );
T1 = param(i,2);
T2 = param(i,3);
phase = param(i, 4)-2*pi*t(1)/T2;
offset = param(i, 5 );
A = param(i, 1)*exp(t(1)/T1);
if A < 0
    A = abs(A);
    phase = phase+pi;
end
T2 = abs( T2 );
if any( plot_flag)
    hold on;
    plot( t, fnc(A, T1, T2, phase, offset, t ), '-k' );
    title( sprintf( 'A = %g, T1 = %g, T2 = %g, phase = %g, offset = %g ', A, T1, T2, phase, offset ) );
end

varargout = {A, T1, T2, phase, offset, Ssq};
varargout = varargout(1:nargout);
