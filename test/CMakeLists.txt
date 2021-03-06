# Copyright (c) 2014-2016 Samsung Electronics Co., Ltd All Rights Reserved
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
# @file        CMakeLists.txt
# @author      Aleksander Zdyb <a.zdyb@samsung.com>
# @author      Radoslaw Bartosiak <r.bartosiak@samsung.com>
# @brief       Cmake for tests
#
PKG_CHECK_MODULES(PKGS REQUIRED gmock)

ADD_DEFINITIONS("-DCYNARA_NO_LOGS")
SET(CYNARA_SRC ${PROJECT_SOURCE_DIR}/src)

SET(CYNARA_SOURCES_FOR_TESTS
    ${CYNARA_SRC}/client-async/sequence/SequenceContainer.cpp
    ${CYNARA_SRC}/client-common/cache/MonitorCache.cpp
    ${CYNARA_SRC}/common/config/PathConfig.cpp
    ${CYNARA_SRC}/common/containers/BinaryQueue.cpp
    ${CYNARA_SRC}/common/protocol/ProtocolAdmin.cpp
    ${CYNARA_SRC}/common/protocol/ProtocolFrame.cpp
    ${CYNARA_SRC}/common/protocol/ProtocolFrameHeader.cpp
    ${CYNARA_SRC}/common/protocol/ProtocolFrameSerializer.cpp
    ${CYNARA_SRC}/common/protocol/ProtocolMonitorGet.cpp
    ${CYNARA_SRC}/common/request/AdminCheckRequest.cpp
    ${CYNARA_SRC}/common/request/DescriptionListRequest.cpp
    ${CYNARA_SRC}/common/request/EraseRequest.cpp
    ${CYNARA_SRC}/common/request/InsertOrUpdateBucketRequest.cpp
    ${CYNARA_SRC}/common/request/ListRequest.cpp
    ${CYNARA_SRC}/common/request/MonitorGetEntriesRequest.cpp
    ${CYNARA_SRC}/common/request/MonitorGetFlushRequest.cpp
    ${CYNARA_SRC}/common/request/RemoveBucketRequest.cpp
    ${CYNARA_SRC}/common/request/RequestTaker.cpp
    ${CYNARA_SRC}/common/request/SetPoliciesRequest.cpp
    ${CYNARA_SRC}/common/response/AdminCheckResponse.cpp
    ${CYNARA_SRC}/common/response/DescriptionListResponse.cpp
    ${CYNARA_SRC}/common/response/CheckResponse.cpp
    ${CYNARA_SRC}/common/response/CodeResponse.cpp
    ${CYNARA_SRC}/common/response/ListResponse.cpp
    ${CYNARA_SRC}/common/response/MonitorGetEntriesResponse.cpp
    ${CYNARA_SRC}/common/response/ResponseTaker.cpp
    ${CYNARA_SRC}/common/types/PolicyBucket.cpp
    ${CYNARA_SRC}/common/types/PolicyKey.cpp
    ${CYNARA_SRC}/common/types/PolicyKeyHelpers.cpp
    ${CYNARA_SRC}/common/types/PolicyDescription.cpp
    ${CYNARA_SRC}/common/types/PolicyResult.cpp
    ${CYNARA_SRC}/common/types/PolicyType.cpp
    ${CYNARA_SRC}/chsgen/ChecksumGenerator.cpp
    ${CYNARA_SRC}/cyad/AdminPolicyParser.cpp
    ${CYNARA_SRC}/cyad/CommandlineParser/CmdlineErrors.cpp
    ${CYNARA_SRC}/cyad/CommandlineParser/CmdlineOpts.cpp
    ${CYNARA_SRC}/cyad/CommandlineParser/CyadCommand.cpp
    ${CYNARA_SRC}/cyad/CommandlineParser/CyadCommandlineParser.cpp
    ${CYNARA_SRC}/cyad/CommandlineParser/HumanReadableParser.cpp
    ${CYNARA_SRC}/cyad/CommandsDispatcher.cpp
    ${CYNARA_SRC}/cyad/CynaraAdminPolicies.cpp
    ${CYNARA_SRC}/cyad/PolicyTypeTranslator.cpp
    ${CYNARA_SRC}/helpers/creds-commons/CredsCommonsInner.cpp
    ${CYNARA_SRC}/helpers/creds-commons/creds-commons.cpp
    ${CYNARA_SRC}/service/main/CmdlineParser.cpp
    ${CYNARA_SRC}/service/monitor/EntriesManager.cpp
    ${CYNARA_SRC}/service/monitor/EntriesQueue.cpp
    ${CYNARA_SRC}/storage/BucketDeserializer.cpp
    ${CYNARA_SRC}/storage/ChecksumStream.cpp
    ${CYNARA_SRC}/storage/ChecksumValidator.cpp
    ${CYNARA_SRC}/storage/InMemoryStorageBackend.cpp
    ${CYNARA_SRC}/storage/Integrity.cpp
    ${CYNARA_SRC}/storage/Storage.cpp
    ${CYNARA_SRC}/storage/StorageDeserializer.cpp
    ${CYNARA_SRC}/external/md5.c
    ${CYNARA_SRC}/external/md5wrapper.cpp
)

SET(CYNARA_TESTS_SOURCES
    TestEventListenerProxy.cpp
    chsgen/checksumgenerator.cpp
    client-async/sequence/sequencecontainer.cpp
    common/cache/monitorcache.cpp
    common/exceptions/bucketrecordcorrupted.cpp
    common/protocols/admin/admincheckrequest.cpp
    common/protocols/admin/admincheckresponse.cpp
    common/protocols/admin/descriptionlistrequest.cpp
    common/protocols/admin/descriptionlistresponse.cpp
    common/protocols/admin/eraserequest.cpp
    common/protocols/admin/listrequest.cpp
    common/protocols/admin/listresponse.cpp
    common/protocols/monitor/flushrequest.cpp
    common/protocols/monitor/getentriesrequest.cpp
    common/protocols/monitor/getentriesresponse.cpp
    common/protocols/ProtocolSerialization.cpp
    common/types/policybucket.cpp
    common/types/string_validation.cpp
    credsCommons/parser/Parser.cpp
    cyad/commandline.cpp
    cyad/commandline_errors.cpp
    cyad/commandline_options.cpp
    cyad/commandline_short.cpp
    cyad/commands_dispatcher.cpp
    cyad/helpers.cpp
    cyad/policy_collection.cpp
    cyad/policy_parser.cpp
    helpers.cpp
    service/main/cmdlineparser.cpp
    service/monitor/entriesmanager.cpp
    service/monitor/entriesqueue.cpp
    storage/checksum/checksumvalidator.cpp
    storage/performance/bucket.cpp
    storage/storage/policies.cpp
    storage/storage/check.cpp
    storage/storage/buckets.cpp
    storage/inmemorystoragebackend/inmemorystoragebackend.cpp
    storage/inmemorystoragebackend/search.cpp
    storage/inmemorystoragebackend/buckets.cpp
    storage/serializer/bucket_load.cpp
    storage/serializer/deserialize.cpp
    storage/serializer/dump.cpp
    storage/serializer/dump_load.cpp
    storage/serializer/serialize.cpp
    tests.cpp
    types/policykey.cpp
)

SET(CYNARA_MIGRATION_TOOL_TESTS tools/cynara-db-migration-tests)

INCLUDE_DIRECTORIES(
    ${PKGS_INCLUDE_DIRS}
    ${CYNARA_SRC}/common
    ${CYNARA_SRC}/include
    ${CYNARA_SRC}
    ${CYNARA_SRC}/external
    test-common
    credsCommons/parser
    common/protocols
)

ADD_EXECUTABLE(${TARGET_CYNARA_TESTS}
    ${CYNARA_SOURCES_FOR_TESTS}
    ${CYNARA_TESTS_SOURCES}
)

TARGET_LINK_LIBRARIES(${TARGET_CYNARA_TESTS}
    ${PKGS_LDFLAGS}
    ${PKGS_LIBRARIES}
    crypt
)
INSTALL(TARGETS ${TARGET_CYNARA_TESTS} DESTINATION ${BIN_DIR})

INSTALL(FILES ${CYNARA_MIGRATION_TOOL_TESTS} DESTINATION ${BIN_DIR})

FILE(GLOB TEST_DB_DIRS db/db*/)
INSTALL(DIRECTORY ${TEST_DB_DIRS} DESTINATION ${DATA_ROOT_DIR}/${PROJECT_NAME}/tests)
INSTALL(DIRECTORY DESTINATION ${DATA_ROOT_DIR}/${PROJECT_NAME}/tests/empty_db)
