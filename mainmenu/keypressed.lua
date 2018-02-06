local foo = function (k)
  if k == 'escape' then
    if B.backButton then B.backButton.action() end
  end
end
return foo