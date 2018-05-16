function parsed = parsewhat(whatout)
  uo = {'UniformOutput', false};
  classes_fixed = cellfun(@(c) ['@', c], whatout.classes, uo{:});
  packages_fixed = cellfun(@(p) ['+', p], whatout.packages, uo{:});
  parsed = cat(1, packages_fixed, classes_fixed, whatout.m, whatout.mex);
end