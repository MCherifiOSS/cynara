/*
 *  Copyright (c) 2014 Samsung Electronics Co., Ltd All Rights Reserved
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License
 */
/*
 * @file        cynara-creds-commons.h
 * @author      Lukasz Wojciechowski <l.wojciechow@partner.samsung.com>
 * @author      Radoslaw Bartosiak <r.bartosiak@samsung.com>
 * @author      Aleksander Zdyb <a.zdyb@partner.samsung.com>
 * @version     1.0
 * @brief       This file contains common APIs for Cynara credentials helper.
 */


#ifndef CYNARA_CREDS_COMMONS_H
#define CYNARA_CREDS_COMMONS_H

#include <cynara-client-error.h>

enum cynara_client_creds {
    CLIENT_METHOD_SMACK,
    CLIENT_METHOD_PID
};

enum cynara_user_creds {
    USER_METHOD_UID,
    USER_METHOD_GID
};

#ifdef __cplusplus
extern "C" {
#endif

/**
 * \par Description:
 * Gets the system default method value for client feature used in cynara-creds.
 *
 * \par Purpose:
 * Functions cynara_creds_dbus_get_client() and cynara_creds_socket_get_client() take a method
 * parameter, which determines a kind of process feature (i.e PID, SMACK label) returned by them.
 * The described function provides implementation for obtaining a system default value
 * for this parameter.
 *
 * \par Typical use case:
 * The function might be called before cynara_creds_dbus_get_client() and cynara_creds_socket_get_client(),
 * when functions shall be invoked with system default value of method parameter.
 *
 * \par Method of function operation:
 * Now the function is mocked up. It sets method to CLIENT_METHOD_SMACK and returns CYNARA_API_SUCCESS.
 * In the future the function will probably read the value from /etc/cynara/cynara_client_creds file.
 *
 * \par Sync (or) Async:
 * This is a synchronous API.
 *
 * \par Thread safety:
 * This function is thread-safe.
 *
 * \param[out] method Placeholder for system default client feature
 *                     (like CLIENT_METHOD_SMACK, CLIENT_METHOD_PID)
 *
 * \return CYNARA_API_SUCCESS on success, negative error code on error
 */
int cynara_creds_get_default_client_method(enum cynara_client_creds *method);

/**
 * \par Description:
 * Gets the system default method value for user feature used in cynara-creds.
 *
 * \par Purpose:
 * Functions cynara_creds_dbus_get_user() and cynara_creds_socket_get_user() take a method
 * parameter, which determines a kind of process feature (i.e UID, GID) returned by them.
 * The described function provides implementation for obtaining a system default value
 * for this parameter.
 *
 * \par Typical use case:
 * The function might be called before cynara_creds_dbus_get_user() and cynara_creds_socket_get_user(),
 * when functions shall be invoked with system default value of method parameter.
 *
 * \par Method of function operation:
 *
 * The function reads the value from /etc/cynara/cynara_user_creds file.
 * Now the function is mocked up. It sets method to USER_METHOD_UID and returns CYNARA_API_SUCCESS.
 * In the future the function will probably read the value from /etc/cynara/cynara_user_creds file.
 *
 * \par Sync (or) Async:
 * This is a synchronous API.
 *
 * \par Thread safety:
 * This function is thread-safe.
 *
 * \param[out] method Placeholder for system default user feature (like USER_METHOD_UID, USER_METHOD_GID)
 *
 * \return CYNARA_API_SUCCESS on success, negative error code on error
 */
int cynara_creds_get_default_user_method(enum cynara_user_creds *method);

#ifdef __cplusplus
}
#endif

#endif /* CYNARA_CREDS_COMMONS_H */