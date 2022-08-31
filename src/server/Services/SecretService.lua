local ServerStorage = game:GetService("ServerStorage")

local SecretService = {}
SecretService.__index = SecretService

local FOLDER_NAME = "SECRETS"

function SecretService.new()
	local self = setmetatable({
		_secrets = {};
		_secretsFolder = ServerStorage:FindFirstChild(FOLDER_NAME);
	}, SecretService)

	return self
end

function SecretService:init()
	assert(self._secretsFolder, "NO SECRETS FOLDER FOUND")
	self:_importSecrets()
end

function SecretService:_importSecrets()
	for _, instance in ipairs(self._secretsFolder:GetChildren()) do
		if instance:IsA("ValueBase") then
			self._secrets[instance.Name] = instance.Value
		end
	end
end

function SecretService:get(key)
	local value = self._secrets[key]
	if value then
		return value
	else
		error(("INVALID SECRET KEY: %s"):format(key))
	end
end

return SecretService.new()