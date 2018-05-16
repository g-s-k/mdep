function deps = getdeps(mfilename)
  deps = matlab.codetools.requiredFilesAndProducts(mfilename, 'toponly');
end