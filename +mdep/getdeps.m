function deps = getdeps(filename)
  deps = matlab.codetools.requiredFilesAndProducts(filename, 'toponly');
end