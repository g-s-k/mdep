% PATH2NAME convert a file path into a legible name
%
%   PATH2NAME('C:\matlab\function_xy.m') returns 'function_xy.m'.
%
%   PATH2NAME('/home/user123/matlab/@MyClass/MyClass.m') returns '@MyClass'.
%
%   See also MDEP.RUN

function name = path2name(fullpth)
  [p, f, e] = fileparts(fullpth);
  [p2, d] = fileparts(p);
  if d(1) == '@'
    name = d;
  elseif f(1) == '@'
    name = f;
  elseif d(1) == '+'
    name = [d, filesep, f, e];
  elseif any(strcmp(e, {'.m', '.fig', ['.', mexext]}))
    name = [f, e];
  else
    name = fullpth;
  end
end