-- testing the module oled.lua on x86 LUA
local oled = require "oled"
local oled_font = require "oled_basic_font"

-- mock i2c
i2c = {}
i2c.__index = i2c
i2c.SLOW = "i2c.SLOW"
i2c.TRANSMITTER = "i2c.TRANSMITTER"
function i2c.setup(id, pinSDA, pinSCL, speed)
	print("i2c set up")
	print("id: "..id)
	print("pinSDA: "..pinSDA)
	print("pinSCL: "..pinSCL)
	print("speed: "..speed)
end
function i2c.start(id)
	print("i2c started. id:"..id)
end
function i2c.address(id, address, direction)
	print("i2c addressed")
	print("address: "..address)
	print("direction: "..direction)
end
function i2c.write(id, ...)
	print("i2c written", unpack({...}))
end

-- test address set
print "test oled.set_address(addr)"
local old_address = oled.address
local changed_address = 234
oled.set_address(changed_address)
if oled.address == changed_address then
	print "oled.set_address(addr) [ok]"
else
	print "oled.set_address(addr) [err]"
end
print "\n"

-- test init
oled.init(1,2)

print(oled_font.chars[1])
print(oled_font.char_value('a'))
