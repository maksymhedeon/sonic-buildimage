# docker image for database

DOCKER_DATABASE_STEM = docker-database
DOCKER_DATABASE = $(DOCKER_DATABASE_STEM).gz
DOCKER_DATABASE_DBG = $(DOCKER_DATABASE_STEM)-$(DBG_IMAGE_MARK).gz

$(DOCKER_DATABASE)_DEPENDS += $(LIBSWSSCOMMON) \
                              $(SONIC_DB_CLI)

$(DOCKER_DATABASE)_PATH = $(DOCKERS_PATH)/$(DOCKER_DATABASE_STEM)

$(DOCKER_DATABASE)_DBG_DEPENDS = $($(DOCKER_CONFIG_ENGINE_BUSTER)_DBG_DEPENDS)

$(DOCKER_DATABASE)_DBG_IMAGE_PACKAGES = $($(DOCKER_CONFIG_ENGINE_BUSTER)_DBG_IMAGE_PACKAGES)

$(DOCKER_DATABASE)_LOAD_DOCKERS += $(DOCKER_CONFIG_ENGINE_BUSTER)

$(DOCKER_DATABASE)_VERSION = 1.0.0
$(DOCKER_DATABASE)_PACKAGE_NAME = database

SONIC_DOCKER_IMAGES += $(DOCKER_DATABASE)
ifeq ($(INCLUDE_DATABASE), y)
SONIC_INSTALL_DOCKER_IMAGES += $(DOCKER_DATABASE)
endif

SONIC_DOCKER_DBG_IMAGES += $(DOCKER_DATABASE_DBG)
ifeq ($(INCLUDE_DATABASE), y)
SONIC_INSTALL_DOCKER_DBG_IMAGES += $(DOCKER_DATABASE_DBG)
endif

$(DOCKER_DATABASE)_CONTAINER_NAME = database
$(DOCKER_DATABASE)_RUN_OPT += --privileged -t
$(DOCKER_DATABASE)_RUN_OPT += -v /etc/sonic:/etc/sonic:ro

$(DOCKER_DATABASE)_BASE_IMAGE_FILES += redis-cli:/usr/bin/redis-cli
$(DOCKER_DATABASE)_FILES += $(SYSCTL_NET_CONFIG) $(SUPERVISOR_PROC_EXIT_LISTENER_SCRIPT)
$(DOCKER_DATABASE)_FILES += $(UPDATE_CHASSISDB_CONFIG_SCRIPT)

SONIC_BUSTER_DOCKERS += $(DOCKER_DATABASE)
SONIC_BUSTER_DBG_DOCKERS += $(DOCKER_DATABASE_DBG)
