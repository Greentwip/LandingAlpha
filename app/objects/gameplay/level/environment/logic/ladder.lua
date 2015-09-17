--
-- Created by Victor on 8/22/2015 5:32 PM
--

local block = import("app.objects.gameplay.level.environment.core.block")

local ladder = class("ladder", block)

function ladder:ctor(position, size)
    self:setup(position, size)
    self:getPhysicsBody():getFirstShape():setTag(cc.tags.ladder)
end

function ladder:prepare(raw_element)
    local shape  = self:getPhysicsBody():getFirstShape()

    self.center_ = self:convertToWorldSpace(shape:getCenter())

    self.top_       = self.center_.y + shape.size_.height * 0.5
    self.bottom_    = self.center_.y - shape.size_.height * 0.5

    local ceiling_size      = cc.size(shape.size_.width, 12.0)
    local ceiling_position  = cc.p(self:getPositionX(), self.top_ - ceiling_size.height * 0.5)
    ceiling_position = self:convertToNodeSpace(ceiling_position)

    self.ceiling_ = block:create(ceiling_position, ceiling_size)
                         :addTo(self)

    self:solidify()
    return self
end

function ladder:solidify()
    self.ceiling_:getPhysicsBody():getFirstShape():setTag(cc.tags.block)
    self.solidified_ = true
    return self
end

function ladder:unsolidify()
    self.ceiling_:getPhysicsBody():getFirstShape():setTag(cc.tags.none)
    self.solidified_ = false
    return self
end

return ladder

