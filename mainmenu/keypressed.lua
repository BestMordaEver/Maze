local foo = function (k)
  if k == 'escape' then
    if B.escapeButton then B.escapeButton.action() end
  end
end
return foo