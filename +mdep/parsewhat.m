% PARSEWHAT turn the output of the `what` command into something useful
%
%   PARSEWHAT(what) returns a list of all the scripts, functions, and
%   class directories residing in the current working directory, as well
%   as any of those residing in package directories below.
%
%   See also WHAT, MDEP.RUN

function parsed = parsewhat(whatout)
  % helper variable
  uo = {'UniformOutput', false};

  % fix class names
  classes_fixed = cellfun(@(c) ['@', c], whatout.classes, uo{:});

  % special handling for packages
  package_contents = cellfun(@(p) meta.package.fromName(p), whatout.packages, uo{:});
  package_functions = cellfun(@(c) {c.FunctionList.Name}, package_contents, uo{:});
  package_classes = cellfun(@(c) {c.ClassList.Name}, package_contents, uo{:});

  pkg = cell(sum(cellfun(@numel, cat(1, package_functions, package_classes))), 1);
  k = 1;
  for l = 1:length(package_contents)
    for m = 1:length(package_functions{l})
      pkg{k} = sprintf('+%s%s%s.m', whatout.packages{l}, filesep, package_functions{l}{m});
      k = k + 1;
    end

    for m = 1:length(package_classes{l})
      pkg{k} = ['+', strrep(package_classes{l}{m}, '.', [filesep, '@'])];
      k = k + 1;
    end
  end

  % put it all together
  parsed = cat(1, pkg, classes_fixed, whatout.m, whatout.mex);
end