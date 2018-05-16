% RUN investigate and graph dependencies in your code
%
%   RUN performs its analysis on the code in the current working dir.
%
%   RUN('..') does so in the parent directory.

function varargout = run(dirname)
  % default wd
  if ~nargin
    dirname = '.';
  end

  % list everything in the directory
  items = mdep.parsewhat(what(dirname));

  % preallocate and get dependencies
  [deps, deps_clean] = deal(cell(size(items)));

  parfor k = 1:length(items)
    deps{k} = mdep.getdeps(items{k});
  end

  % build the graph
  parfor k = 1:length(deps)
    deps_clean{k} = cellfun(@mdep.path2name, deps{k}, 'uniformoutput', false);
  end

  nodes = cat(1, items, setdiff([deps_clean{:}], items).');
  con_list = cellfun(@(el) ismember(nodes, el), deps_clean, 'uniformoutput', ...
                     false);

  con_mat = cat(2, con_list{:});
  con_mat(:, end+1:size(con_mat, 1)) = 0;

  % display it
  grph = digraph(con_mat.', nodes, 'OmitSelfLoops');
  plot(grph, 'k--', 'layout', 'layered')
  grid off
  axis off

  % return it
  if nargout
    varargout = {grph};
  end
end