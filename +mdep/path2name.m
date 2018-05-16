function name = path2name(fullpth)
    [p, f, e] = fileparts(fullpth);
    [p2, d] = fileparts(p);
    if d(1) == '@'
      name = d;
    elseif strcmp(e, '.m')
      name = [f, e];
    else
      name = fullpth;
    end
end