if _G["u2mm"] == nil then
    dofile(Application:base_path() .. "/mods/[u2] Mod Manager/u2mm.lua")
end

if RequiredScript == "lib/managers/menumanager" then
	Hooks:Add("LocalizationManagerPostInit", "u2mmStrings", function(loc)
		LocalizationManager:add_localized_strings({
			u2mm_title = "Mod Manager",
			u2mm_desc = "View and change the settings of your mods",
		})
	end)

	Hooks:PostHook(MenuManager, "init", "AddModManagerMenuPostHook", function(self, is_start_menu)
		u2mm:addModManagerMenu()
		u2mm:createSaveFolder()
	end)

	function u2mm:addButton(name, title, desc, cbk, parent)
		local params = {
			name = name,
			text_id = title,
			help_id = desc,
			callback = cbk
		}
		
		local menuItem = parent:create_item(nil, params)
		parent:add_item(menuItem)
	end

	function u2mm:addMultichoice(name, title, desc, cbk, value, parent, data)
		local params = {
			name = name,
			text_id = title,
			help_id = desc,
			callback = cbk,
			filter = true
		}
		
		local menuItem = parent:create_item(data, params)
		menuItem:set_current_index(value)
		parent:add_item(menuItem)
	end

	function u2mm:addSlider(name, title, desc, cbk, value, parent)
		local data = {
			type = "CoreMenuItemSlider.ItemSlider",
			min = 0,
			max = 1,
			step = 0.1,
			show_value = true
		}

		local params = {
			name = name,
			text_id = title,
			help_id = desc,
			callback = cbk
		}

		local menuItem = parent:create_item(data, params)
		menuItem:set_value( math.clamp(value, data.min, data.max) or data.min )
		parent:add_item(menuItem)
	end

	function u2mm:addToggle(name, title, desc, cbk, value, parent, data)
		local params = {
			name = name,
			text_id = title,
			help_id = desc,
			callback = cbk
		}

		local menuItem = parent:create_item( data, params )
		menuItem:set_value( value )
		parent:add_item( menuItem )
	end

	function u2mm:addSubmenu(name, title, desc, parent)	
		local newNode = deep_clone(u2mm.origin["u2mm"])
		newNode._parameters.topic_id = "menu_" .. name -- may as well give this a unique id
		newNode._parameters.name = name -- we must change it or else toggles won't work in submenus
		newNode._parameters.modifier = {}
		newNode._items = {}
		
		MenuManager:add_back_button(newNode)
		u2mm.origin[name] = newNode
		
		local button = deep_clone( u2mm.origin.options._items[1] )
		button._parameters.name = name
		button._parameters.text_id = title
		button._parameters.help_id = desc
		button._parameters.next_node = name

		parent:add_item(button)
		return newNode
	end

	function u2mm:addModManagerMenu()
		--u2mm.origin = managers.menu._registered_menus.menu_main and managers.menu._registered_menus.menu_main.logic._data._nodes or managers.menu._registered_menus.menu_pause.logic._data._nodes
		u2mm.origin = managers.menu._registered_menus.menu_main.logic._data._nodes or managers.menu._registered_menus.menu_pause.logic._data._nodes
		
		local menuEntry = deep_clone(u2mm.origin.video)
		menuEntry._legends = {} -- no clue what this is but wipe it
		menuEntry._parameters.topic_id = "menu_u2mm"
		menuEntry._parameters.name = "u2mm"
		menuEntry._parameters.modifier = {}
		menuEntry._items = {} -- 
		
		MenuManager:add_back_button(menuEntry)
		u2mm.origin["u2mm"] = menuEntry

		local optionsButton = deep_clone( u2mm.origin.options._items[1] )
		optionsButton._parameters.name = "u2mm"
		optionsButton._parameters.text_id = "u2mm_title"
		optionsButton._parameters.help_id = "u2mm_desc"
		optionsButton._parameters.next_node = "u2mm"
		--mainMenuNodes.main:add_item(optionsButton) --to what menu do we want to append, or:
		u2mm.origin.main:insert_item(optionsButton, #u2mm.origin.main._items - 1) --where and at what index do we want to insert
		
		u2mm.origin.main:delete_item("gamehub")
		u2mm.origin.main:delete_item("credits")
		u2mm.origin.main:delete_item("divider_test2")
		u2mm.origin.main:delete_item("divider_test2")
	end
end