# RC7 Vehicle System

A complete RC7 vehicle system for FiveM with ESX integration.

## Features

- Spawn RC7 vehicles with a command
- Track RC7 ownership in a database
- Check player money before spawning

## Requirements

- FiveM server
- ESX framework
- MySQL database

## Installation

1. Download the script files
2. Place them in your FiveM server resources folder
3. Add `start rc7system` to your server.cfg
4. Import the database.sql file into your MySQL database

## Usage

- Players can spawn an RC7 vehicle by using the `/spawnrc7` command
- The script will check if the player already owns an RC7
- The script will check if the player has enough money in their bank account
- If all checks pass, the RC7 will be spawned and ownership will be registered in the database

## Configuration

The script can be configured in the `config.lua` file. You can change the RC7 price, model, spawn location, and database settings.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=rc7-vehicle-system&utm_content=bottom) — describe it in one sentence and get the full source code.

