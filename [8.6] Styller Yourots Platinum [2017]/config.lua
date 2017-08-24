-- The Forgotten Server Config

	-- Extras configs
		-- General
		generateAccountSalt = false
		allowedMaxSizedPackets = 3
		mysqlReconnectionAttempts = 3
		tradelimit = 100
		skipItemsVersionCheck = true
		healPlayersOnLevelAdvance = true
		tibiaClassicSlots = true
		useCapSystem = true
		enableCast = true
		useMultiClient = false
		savePlayerData = true
		houseSkipInitialRent = true
		houseProtection = true
		enableProtectionQuestForGM = true
		advertisingBlock = ".net;servegame;no-ip,.net;.com;.com.br;.org;.pl;.net;.biz"

		-- Rook System
		enableRookSystem = false
		rookLevelTo = 6
		rookTownId = 1

		-- Mailbox Block
		mailMaxAttempts = 2
		mailBlockPeriod = 60 * 60 * 1000
		mailAttemptsFadeTime = 60 * 60 * 1000

		-- Depot System
		-- 1000 depot limet defined on depot.cpp
		defaultDepotSizePremium = 1000
		defaultDepotSizefree = 500

		-- Spawns
		noDisableBlockRespawn = true
		monstersGoBackToSpawn = false

		-- Summons
		noShareExpSummonMonster = false

		-- Spells
		unifiedSpells = false

		-- RSA
		-- NOTE: These should not be changed unless you know what your doing
		-- Prime1 - known as p; Prime2 - known as q; Public - known as e;
		-- Modulus - known as n; Private - known as d.
		-- How make custom client with custom RSA Key: http://vapus.net/customclient
		rsaPrime1 = "14299623962416399520070177382898895550795403345466153217470516082934737582776038882967213386204600674145392845853859217990626450972452084065728686565928113"
		rsaPrime2 = "7630979195970404721891201847792002125535401292779123937207447574596692788513647179235335529307251350570728407373705564708871762033017096809910315212884101"
		rsaPublic = "65537"
		rsaModulus = "109120132967399429278860960508995541528237502902798129123468757937266291492576446330739696001110603907230888610072655818825358503429057592827629436413108566029093628212635953836686562675849720620786279431090218017681061521755056710823876476444260558147179707119674283982419152118103759076030616683978566631413"
		rsaPrivate = "46730330223584118622160180015036832148732986808519344675210555262940258739805766860224610646919605860206328024326703361630109888417839241959507572247284807035235569619173792292786907845791904955103601652822519121908367187885509270025388641700821735345222087940578381210879116823013776808975766851829020659073"

		-- Removed Config
		
		houseDataStorage = "binary-tilebased"

	-- Account manager
	accountManager = true
	namelockManager = true
	newPlayerChooseVoc = true
	newPlayerSpawnPosX = 160
	newPlayerSpawnPosY = 51
	newPlayerSpawnPosZ = 7
	newPlayerTownId = 1
	newPlayerLevel = 8
	newPlayerMagicLevel = 1
	generateAccountNumber = false

	
	useFragHandler = true
	redSkullLength = 24 * 60 * 60
	blackSkullLength = 48 * 60 * 60
	dailyFragsToRedSkull = 12
	weeklyFragsToRedSkull = 60
	monthlyFragsToRedSkull = 140
	dailyFragsToBlackSkull = dailyFragsToRedSkull
	weeklyFragsToBlackSkull = weeklyFragsToRedSkull
	monthlyFragsToBlackSkull = monthlyFragsToRedSkull
	dailyFragsToBanishment = dailyFragsToRedSkull
	weeklyFragsToBanishment = weeklyFragsToRedSkull
	monthlyFragsToBanishment = monthlyFragsToRedSkull
	blackSkulledDeathHealth = 40
	blackSkulledDeathMana = 0
	useBlackSkull = true
	advancedFragList = false

	
	notationsToBan = 3
	warningsToFinalBan = 4
	warningsToDeletion = 5
	banLength = 1 * 24 * 60 * 60
	killsBanLength = 1 * 24 * 60 * 60
	finalBanLength = 1 * 24 * 60 * 60
	ipBanishmentLength = 1 * 24 * 60 * 60
	broadcastBanishments = false
	maxViolationCommentSize = 200
	violationNameReportActionType = 2
	autoBanishUnknownBytes = false

	-- Battle
	-- NOTE: showHealingDamageForMonsters inheritates from showHealingDamage.
	-- loginProtectionPeriod is the famous Tibia anti-magebomb system.
	-- deathLostPercent set to nil enables manual mode.
	worldType = "open"
	protectionLevel = 80
	pvpTileIgnoreLevelAndVocationProtection = true
	pzLocked = 60 * 1000
	huntingDuration = 60 * 1000
	criticalHitChance = 7
	criticalHitMultiplier = 1
	displayCriticalHitNotify = true
	removeWeaponAmmunition = false
	removeWeaponCharges = true
	removeRuneCharges = false
	whiteSkullTime = 3 * 60 * 1000
	noDamageToSameLookfeet = false
	showHealingDamage = true
	showHealingDamageForMonsters = false
	fieldOwnershipDuration = 5 * 1000
	stopAttackingAtExit = false
	loginProtectionPeriod = 10 * 1000
	deathLostPercent = 10
	stairhopDelay = 2 * 1000
	pushCreatureDelay = 1 * 1000
	deathContainerId = 1987
	gainExperienceColor = 215
	addManaSpentInPvPZone = true
	squareColor = 0
	allowFightback = true
	fistBaseAttack = 7

	-- Connection config
	worldId = 0
	ip = "127.0.0.1"
	loginPort = 7171
	gamePort = 7172
	loginTries = 10
	retryTimeout = 5 * 1000
	loginTimeout = 60 * 1000
	maxPlayers = 175	
	motd = "Bem vindo ao Best Styller! War System: !infowar"
	displayOnOrOffAtCharlist = false
	onePlayerOnlinePerAccount = true
	allowClones = false
	serverName = "Styller"
	loginMessage = "Bem vindo ao Best Styller! War System: !infowar"
	statusTimeout = 5 * 60 * 1000
	replaceKickOnLogin = true
	forceSlowConnectionsToDisconnect = false
	loginOnlyWithLoginServer = false
	premiumPlayerSkipWaitList = false

	-- Database
	-- NOTE: sqlFile is used only by sqlite database, and sqlKeepAlive by mysql database.
	-- To disable sqlKeepAlive such as mysqlReadTimeout use 0 value.
	-- encryptionType can be plain, md5, sha1, sha256, sha512 or vahash.
	sqlType = "sqlite"
	sqlHost = "127.0.0.1"
	sqlPort = 3306
	sqlUser = "root"
	sqlPass = ""
	sqlDatabase = "otserv"
	sqlFile = "Styller.s3db"
	sqlKeepAlive = 0
	mysqlReadTimeout = 10
	mysqlWriteTimeout = 10
	encryptionType = "sha1"

	-- Deathlist
	deathListEnabled = true
	deathListRequiredTime = 1 * 60 * 1000
	deathAssistCount = 19
	maxDeathRecords = 5

	-- Guilds
	ingameGuildManagement = true
	levelToFormGuild = 8
	premiumDaysToFormGuild = 0
	guildNameMinLength = 4
	guildNameMaxLength = 20

	-- Highscores
	highscoreDisplayPlayers = 15
	updateHighscoresAfterMinutes = 60

	-- Houses
	buyableAndSellableHouses = true
	houseNeedPremium = true
	bedsRequirePremium = true
	levelToBuyHouse = 50
	housesPerAccount = 0
	houseRentAsPrice = false
	housePriceAsRent = false
	housePriceEachSquare = 1000
	houseRentPeriod = "never"
	houseCleanOld = 0
	guildHalls = false

	-- Item usage
	timeBetweenActions = 400
	timeBetweenExActions = 1000
	hotkeyAimbotEnabled = true

	-- Map
	-- NOTE: storeTrash costs more memory, but will perform alot faster cleaning.
	mapName = "Styller.otbm"
	mapAuthor = "King"
	randomizeTiles = true
	storeTrash = true
	cleanProtectedZones = true
	mailboxDisabledTowns = ""
		
	defaultPriority = "high"
	niceLevel = 5
	coresUsed = "-1"

	-- Startup
	startupDatabaseOptimization = true
	updatePremiumStateAtStartup = true
	confirmOutdatedVersion = false

	-- Spells
	formulaLevel = 5.0
	formulaMagic = 1.0
	bufferMutedOnSpellFailure = false
	spellNameInsteadOfWords = false
	emoteSpells = true

	-- Outfits
	allowChangeOutfit = true
	allowChangeColors = true
	allowChangeAddons = true
	disableOutfitsForPrivilegedPlayers = false
	addonsOnlyPremium = true

	
	dataDirectory = "data/"
	logsDirectory = "data/logs/"
	bankSystem = true
	displaySkillLevelOnAdvance = false
	promptExceptionTracerErrorBox = true
	maximumDoorLevel = 500
	maxMessageBuffer = 4

	-- VIP list
	separateVipListPerCharacter = false
	vipListDefaultLimit = 20
	vipListDefaultPremiumLimit = 100

	-- Saving-related
	-- useHouseDataStorage usage may be found at README.
	saveGlobalStorage = true
	storePlayerDirection = false

	
	checkCorpseOwner = true
	monsterLootMessage = 3
	monsterLootMessageType = 25

	-- Ghost mode
	ghostModeInvisibleEffect = false
	ghostModeSpellEffects = true

	-- Limits
	idleWarningTime = 30 * 60 * 1000
	idleKickTime = 31 * 60 * 1000
	reportsExpirationAfterReads = 1
	playerQueryDeepness = 2
	tileLimit = 0
	protectionTileLimit = 0
	houseTileLimit = 0

	-- Premium-related
	freePremium = true
	premiumForPromotion = true

	-- Blessings
	-- NOTE: blessingReduction* regards items/containers loss.
	-- eachBlessReduction is how much each bless reduces the experience/magic/skills loss.
	blessings = true
	blessingOnlyPremium = true
	blessingReductionBase = 30
	blessingReductionDecrement = 5
	eachBlessReduction = 8

	-- Rates
	-- NOTE: experienceStages configuration is located in data/XML/stages.xml.
	-- rateExperienceFromPlayers 0 to disable.
	experienceStages = true
	rateExperience = 5.0
	rateExperienceFromPlayers = 0
	rateSkill = 35	
	rateMagic = 20
	rateLoot = 3
	rateSpawn = 1

	-- Monster rates
	rateMonsterHealth = 1.0
	rateMonsterMana = 1.0
	rateMonsterAttack = 1.0
	rateMonsterDefense = 1.0

	
	minLevelThresholdForKilledPlayer = 0.9
	maxLevelThresholdForKilledPlayer = 1.1

	
	rateStaminaLoss = 1
	rateStaminaGain = 3
	rateStaminaThresholdGain = 12
	staminaRatingLimitTop = 40 * 60
	staminaRatingLimitBottom = 14 * 60
	staminaLootLimit = 14 * 60
	rateStaminaAboveNormal = 1.5
	rateStaminaUnderNormal = 0.5
	staminaThresholdOnlyPremium = true

	-- Party
	-- NOTE: experienceShareLevelDifference is float number.
	-- experienceShareLevelDifference is highestLevel * value
	experienceShareRadiusX = 30
	experienceShareRadiusY = 30
	experienceShareRadiusZ = 1
	experienceShareLevelDifference = 2 / 3
	extraPartyExperienceLimit = 20
	extraPartyExperiencePercent = 5
	experienceShareActivity = 2 * 60 * 1000

	-- Global save
	-- NOTE: globalSaveHour means like 03:00, not that it will save every 3 hours,
	-- if you want such a system please check out data/globalevents/globalevents.xml.
	globalSaveEnabled = false
	globalSaveHour = 8
	globalSaveMinute = 0
	shutdownAtGlobalSave = true
	cleanMapAtGlobalSave = false

	-- Spawns
	deSpawnRange = 2
	deSpawnRadius = 50

	-- Summons
	maxPlayerSummons = 2
	teleportAllSummons = false
	teleportPlayerSummons = false

	-- Status
	statusPort = 7171
	ownerName = "X Styller"
	ownerEmail = "@otland.net"
	url = "http://otland.net/"
	location = "Europe"
	displayGamemastersWithOnlineCommand = false

	-- Logs
	-- NOTE: This kind of logging does not work in GUI version.
	-- For such, please compile the software with __GUI_LOGS__ flag.
	displayPlayersLogging = true
	prefixChannelLogs = ""
	runFile = ""
	outputLog = ""
	truncateLogsOnStartup = false

	-- Manager
	-- NOTE: managerPassword left blank disables manager.
	managerPort = 7171
	managerLogs = true
	managerPassword = ""
	managerLocalhostOnly = true
	managerConnectionsLimit = 1

	
	adminPort = 7171
	adminLogs = true
	adminPassword = ""
	adminLocalhostOnly = true
	adminConnectionsLimit = 1
	adminRequireLogin = true
	adminEncryption = ""
	adminEncryptionData = ""
