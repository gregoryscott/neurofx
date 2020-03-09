function Y = neurofx(X, varargin)
%NEUROFX Generalised complexity function
%   NEUROFX(X, ...) computes one or more complexity measures on X
%
%
%   NEUROFX(X, ...) computes one or more complexity measures on X
%
%
%   Measures
%   --------
%   The available measures, their codes and reference to implementation
%   details are as follows. For more information on each measure, please
%   see the corresponding function.
%
%       Code/s      Uni/bi  Name                     Notes          Ref
%       -------------------------------------------------------------------
%       'std'       uni     Standard deviation
%       'var'       uni     Variance

%       'h','e'     uni     Shannon entropy
%       'ae'        uni     Approximate entropy
%       'pe'        uni     Permutation entropy
%       'se'        uni     Sample entropy
%       'spe'       uni     Spectral entropy
%       'we'        uni     Wiener entropy
%       'mse'       uni     Multi-scale entropy
%       'ie'        uni     Increment entropy
%       'ace'       uni     Amplitude coalition entropy
%       'sce'       uni     Synchrony coalition entropy
%       'k'         uni     Kappa

%       'kurmean'   uni     Mean Kuramoto order parameter
%       'kurstd'    uni     Standard deviation of Kuramoto order parameter
%       'kurent'    uni     Entropy of  Kuramoto order parameter

%       'lzca'      uni     Lempel-Ziv complexity*
%       'lzcb'      uni     Lempel-Ziv complexity*
%       'fd'        uni     Fractal dimension

%       'corr2'     bi      Pearson correlation
%       'scorr2'    bi      Spearman's (rank) correlation
%       'cov2'      bi      Covariance
%
%       'ce2'       bi      Conditional entropy
%       'je2'       bi      Joint entropy
%       'mi2'       bi      Mutual information
%       'swmi2'     bi      Symbolic weighted mutual information
%
%   Macros
%   ------
%   A number of groups of measures are predefined ('macros') and can be
%   used in place of the measures above.
%
%       Code/s      Uni/bi  Measure codes (above)
%       -------------------------------------------------------------------
%       'all'       uni     All univariate measures above
%       'all2'      bi      All bivariate measures above
%

%   Data descriptors
%   ----------------
%   You must use the following system to define the arrangement of your
%   input data.
%
%   o = observation (optional)
%
%   Common examples
%       A single epoch
%
%   Normalisation
%   -------------

%
%   Examples
%   --------
%
%   Example:
%   
%
%
%   Reading this code
%   -----------------
%
%   Writing this code
%   -----------------
%   Guiding principles:
%   
%   https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005412#sec003
%   https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1002802#s3
%
%   References
%   ----------
%   1.
%   2.
%   ...
%  
%   Acknowledgements
%   ----------------
%   Thanks to the ASCII text generator http://patorjk.com/software/taag/
%   Apologies to anyone who feels the should be acknowledged here or if
%   any protected method is being inappropriately used, please do get in
%   touch (email below).

%   Authors
%   -------
%    Gregory Scott (gregory.scott99@imperial.ac.uk)
%
%--------------------------------------------------------------------------
opts.normalise   = 'shuffle';
opts = handleopts(varargin, opts);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%     _      __           _ _
%  __| |___ / _|__ _ _  _| | |_ ___
% / _` / -_)  _/ _` | || | |  _(_-<
% \__,_\___|_| \__,_|\_,_|_|\__/__/
%--------------------------------------------------------------------------


%~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

%--------------------------------------------------------------------------
%__ __ ___ _ __ _ _ __ _ __  ___ _ _ ___
% \ V  V / '_/ _` | '_ \ '_ \/ -_) '_(_-<
%  \_/\_/|_| \__,_| .__/ .__/\___|_| /__/
%                 |_|  |_|
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%  _ __  ___ __ _ ____  _ _ _ ___ ___
% | '  \/ -_) _` (_-< || | '_/ -_|_-<
% |_|_|_\___\__,_/__/\_,_|_| \___/__/
%--------------------------------------------------------------------------


%~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

%--------------------------------------------------------------------------
%				 _   _
%  __ _ _  ___ _(_) (_)__ _ _ _ _  _
% / _` | || \ \ / | | / _` | '_| || |
% \__,_|\_,_/_\_\_|_|_\__,_|_|  \_, |
%                               |__/
%--------------------------------------------------------------------------
    function opts = handleopts(args, defopts)
        %HANDLEOPTS Creates an options struct based on arguments and a
        %   default optiosn struct
        if(numel(args) < 1)
            opts = defopts;
        else
            if(isstruct(args{1}))
                opts = mergestructs(args{1}, defopts);
            else
                opts = defopts;
                for i=1:2:numel(args)-1
                    if(strcmpi(lower(args{i}), 'opts'))
                        opts = mergestructs(args{i+1}, opts);
                    else
                        if(~isfield(defopts, lower(args{i})))
                            warning(['Unexpected optional argument ', lower(args{i})]);
                        end
                        opts.(lower(args{i})) = args{i+1};
                    end
                end
            end
        end
    end
%~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    function a = mergestructs(a, b)
        %MERGESTRUCTS Copies fields of structure b to structure a only when
        %   they do not already exist in a
        f = fieldnames(b);
        for i = 1:length(f)
            n = f{i};
            if(~isfield(a,n))
                a.(n) = b.(n);
            else
                if(isstruct(a.(n)))
                    a.(n) = mergestructs(a.(n), b.(n));
                end
            end
        end
    end
end
