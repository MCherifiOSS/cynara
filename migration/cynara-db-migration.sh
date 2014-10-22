#!/bin/sh
#
# Copyright (c) 2014 Samsung Electronics Co., Ltd All Rights Reserved
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
# @file        migration/cynara-db-migration.sh
# @author      Pawel Wieczorek <p.wieczorek2@samsung.com>
# @brief       Migration tool for Cynara's database
#

##### Constants (these must not be modified by shell)

STATE_PATH='/var/cynara'
DB_DIR='db'
INDEX_NAME='buckets'
DEFAULT_NAME='_'
DENY_POLICY=';0x0;'

##### Variables, with default values (optional)

CYNARA_USER='cynara'
CYNARA_GROUP='cynara'

SMACK_LABEL='System'

OLD_VERSION=
NEW_VERSION=

##### Functions

parse_opts() {
    while getopts ":f:t:u:g:l:" opt; do
        case $opt in
            f )
                OLD_VERSION=${OPTARG}
                ;;
            t )
                NEW_VERSION=${OPTARG}
                ;;
            u )
                CYNARA_USER=${OPTARG}
                ;;
            g )
                CYNARA_GROUP=${OPTARG}
                ;;
            l )
                SMACK_LABEL=${OPTARG}
                ;;
            \? )
                echo "Invalid option: -$OPTARG" >&2
                failure
                ;;
            : )
                echo "Option -$OPTARG requires an argument." >&2
                failure
                ;;
        esac
    done
}

create_db() {
    if [ -z ${NEW_VERSION} ]; then
        failure
    fi

    # Create Cynara's database directory:
    mkdir -p ${STATE_PATH}/${DB_DIR}

    # Create contents of minimal database: first index file, then default bucket
    echo ${DENY_POLICY} > ${STATE_PATH}/${DB_DIR}/${INDEX_NAME}
    touch ${STATE_PATH}/${DB_DIR}/${DEFAULT_NAME}

    # Set proper permissions for newly created database
    chown -R ${CYNARA_USER}:${CYNARA_GROUP} ${STATE_PATH}/${DB_DIR}

    # Set proper SMACK labels for newly created database
    chsmack -a ${SMACK_LABEL} ${STATE_PATH}/${DB_DIR}
    chsmack -a ${SMACK_LABEL} ${STATE_PATH}/${DB_DIR}/*
}

migrate_db() {
    if [ -z ${OLD_VERSION} -o -z ${NEW_VERSION} ]; then
        failure
    fi

    :
    # : is a null command, as functions may not be empty.
    # Actual body will be added if database structure changes.
}

remove_db() {
    if [ -z ${OLD_VERSION} ]; then
        failure
    fi

    rm -rf ${STATE_PATH}
}

usage() {
    cat << EOF
Usage: $0 COMMAND OPTIONS

This script installs, migrates to another version or removes Cynara's policies database

Commands:
  upgrade (up)    migrate old data to new version of database structure
  install (in)    create minimal database
  uninstall (rm)  remove database entirely

Options:
  -f from   Set old version of database (mandatory for upgrade and uninstall)
  -t to     Set new version of database (mandatory for upgrade and install)
  -u user   Set database owner (default: cynara)
  -g group  Set database group (default: cynara)
  -l label  Set SMACK label for database (default: System)
  -h        Show this help message
EOF
}

failure() {
    usage
    exit 1
}

##### Main

if [ 0 -eq $# ]; then
    failure
fi

case $1 in
    "up" | "upgrade" )
        shift $OPTIND
        parse_opts "$@"
        migrate_db
        ;;
    "in" | "install" )
        shift $OPTIND
        parse_opts "$@"
        create_db
        ;;
    "rm" | "uninstall" )
        shift $OPTIND
        parse_opts "$@"
        remove_db
        ;;
    "-h" | "--help" )
        usage
        ;;
    * )
        failure
esac
