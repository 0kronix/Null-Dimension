---- Constants ----

local mod = NullDimension
local game = Game()
local PlayPass = {}

PlayPass.id = Isaac.GetTrinketIdByName("Play Pass")

---- Descriptions ----

PlayPass.description = {
	"{{ArcadeRoom}} Arcade rooms always open"
}
PlayPass.description_ru = {
    "{{ArcadeRoom}} Аркады всегда открыты"
}
mod:CreateEID(PlayPass.id, PlayPass.description, "Play Pass")
mod:CreateEID(PlayPass.id, PlayPass.description_ru, "Игровой пропуск", "ru")

PlayPass.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
PlayPass.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    PlayPass.id,
    PlayPass.goldenData.Numbers,
    PlayPass.goldenData.ExtraText,
    PlayPass.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    PlayPass.id,
    PlayPass.goldenData_ru.Numbers,
    PlayPass.goldenData_ru.ExtraText,
    PlayPass.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function PlayPass:roomEnter()
    local room = game:GetRoom()
    
    if PlayerManager.AnyoneHasTrinket(PlayPass.id) then
        for i = 0, 8 do
            local door = room:GetDoor(i)
             
            if door and door.TargetRoomType == RoomType.ROOM_ARCADE then
                door:TryUnlock(Isaac.GetPlayer(), true)
            end 
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PlayPass.roomEnter)