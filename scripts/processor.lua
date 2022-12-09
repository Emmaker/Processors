function init()

  self.recipeList = config.getParameter("recipeList")
  self.recipes = root.assetJson("/recipes/" .. self.recipeList .. ".config")

  sb.logInfo("%s", self.recipes)
end

function update()
  if world.containerItemAt(entity.id(), 0) == nil then return end

  for r, recipe in pairs(self.recipes) do
    if world.containerItemAt(entity.id(), 0).name == recipe[1] and canAddItems(recipe[2]) then
      world.containerConsumeAt(entity.id(), 0, 1)
      return
    end
  end
end

function canAddItems(items)
  for i, item in pairs(items) do
    if math.random() <= item[1] then
      if not addItem(item[2]) then return false end
    end
  end

  return true
end

function addItem(i)
  for x = 1, world.containerSize(entity.id()) - 1, 1 do
    local slotItem = world.containerItemAt(entity.id(), x)

    if not slotItem or slotItem.name == i then
      world.containerPutItemsAt(entity.id(), i, x)
      return true
    end
  end

  return false
end
