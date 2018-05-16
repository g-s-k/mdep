% GETDEPS a shortcut to get top-level dependencies.
%
%   GETDEPS('function_abc.m') invokes the command
%   `matlab.codetools.requiredFilesAndProducts('function_abc.m', 'toponly')`.
%
%   See also MATLAB.CODETOOLS.REQUIREDFILESANDPRODUCTS, MDEP.RUN

function deps = getdeps(filename)
  deps = matlab.codetools.requiredFilesAndProducts(filename, 'toponly');
end