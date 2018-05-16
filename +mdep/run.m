% RUN investigate and graph dependencies in your code
%
%   RUN performs its analysis on the code in the current working dir.
%
%   RUN('..') does so in the parent directory.

function varargout = run(dirname)
  uo = {'UniformOutput', false};

  % default wd
  if ~nargin
    dirname = '.';
  end

  % list everything in the directory
  items = mdep.parsewhat(what(dirname));

  % get dependencies
  deps = cellfun(@mdep.getdeps, items, uo{:});

  % build the graph
  nodes = cat(1, items, setdiff([deps{:}], items).');
  con_list = cellfun(@(el) ismember(nodes, el), deps, uo{:});

  con_mat = cat(2, con_list{:});
  con_mat(:, end+1:size(con_mat, 1)) = 0;

  % display it
  grph = digraph(con_mat.', nodes, 'OmitSelfLoops');
  nodes_short = cellfun(@mdep.path2name, nodes, uo{:});
  plot(grph, 'layout', 'circle', 'NodeLabel', nodes_short)
  axis off

  % return it
  if nargout
    varargout = {grph};
  end
end