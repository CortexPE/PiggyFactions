<?php

declare(strict_types=1);

namespace DaPigGuy\PiggyFactions\players;

use DaPigGuy\PiggyFactions\factions\Faction;
use DaPigGuy\PiggyFactions\factions\FactionsManager;
use DaPigGuy\PiggyFactions\PiggyFactions;
use pocketmine\utils\UUID;

class FactionsPlayer
{
    /** @var UUID */
    private $uuid;
    /** @var string */
    private $username;
    /** @var ?int */
    private $faction;
    /** @var ?string */
    private $role;
    /** @var float */
    private $power;

    /** @var bool */
    private $canSeeChunks = false;

    public function __construct(UUID $uuid, string $username, ?int $faction, ?string $role, float $power)
    {

        $this->uuid = $uuid;
        $this->username = $username;
        $this->faction = $faction;
        $this->role = $role;
        $this->power = $power;
    }

    public function getUuid(): UUID
    {
        return $this->uuid;
    }

    public function getUsername(): string
    {
        return $this->username;
    }

    public function setUsername(string $username): void
    {
        $this->username = $username;
        $this->update();
    }

    public function getFaction(): ?Faction
    {
        return $this->faction === null ? null : FactionsManager::getInstance()->getFaction($this->faction);
    }

    public function setFaction(?Faction $faction): void
    {
        $this->faction = $faction === null ? null : $faction->getId();
        $this->update();
    }

    public function getRole(): ?string
    {
        return $this->role;
    }

    public function setRole(?string $role): void
    {
        $this->role = $role;
        $this->update();
    }

    public function getPower(): float
    {
        return $this->power;
    }

    public function setPower(float $power): void
    {
        $this->power = $power;
        $this->update();
    }

    public function canSeeChunks(): bool
    {
        return $this->canSeeChunks;
    }

    public function setCanSeeChunks(bool $value): void
    {
        $this->canSeeChunks = $value;
    }

    public function update(): void
    {
        PiggyFactions::getInstance()->getDatabase()->executeChange("piggyfactions.players.update", [
            "uuid" => $this->uuid->toString(),
            "username" => $this->username,
            "faction" => $this->faction,
            "role" => $this->role,
            "power" => $this->power
        ]);
    }
}