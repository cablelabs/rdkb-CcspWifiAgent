#!/bin/sh
######################################################################################
# If not stated otherwise in this file or this component's Licenses.txt file the
# following copyright and licenses apply:

#  Copyright 2018 RDK Management

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#######################################################################################

if [ -f /etc/device.properties ]
then
    source /etc/device.properties
fi

uptime=`cat /proc/uptime | awk '{ print $1 }' | cut -d"." -f1`
echo "before running aphealth.sh printing top output" >> $WIFI_CONSOLE_LOG_NAME
top -n1 > /tmp/top.txt
cat /tmp/top.txt >> $WIFI_CONSOLE_LOG_NAME
if [ "$BOX_TYPE" = "XB3" ]; then
	if [ $uptime -gt 1800 ] && [ "$(pidof CcspWifiSsp)" != "" ] && [ "$(pidof hostapd)" != "" ]  && [ "$(pidof apup)" == "" ] && [ "$(pidof fastdown)" == "" ] && [ "$(pidof apdown)" == "" ]  && [ "$(pidof aphealth.sh)" == "" ] && [ "$(pidof stahealth.sh)"  == "" ] && [ "$(pidof radiohealth.sh)" == "" ] && [ "$(pidof radiohealth_log.sh)" == "" ] && [ "$(pidof stahealth_log.sh)" == "" ] && [ "$(pidof bandsteering.sh)" == "" ] && [ "$(pidof bandsteering_log.sh)" == "" ] && [ "$(pidof l2shealth_log.sh)" == "" ] && [ "$(pidof l2shealth.sh)" == "" ]  && [ "$(pidof log_mem_cpu_info_atom.sh)" == "" ] && [ "$(pidof dailystats.sh)" == "" ] && [ "$(pidof dailystats_log.sh)" == "" ] ; then
                /usr/ccsp/wifi/aphealth.sh >> /rdklogs/logs/wifihealth.txt
                #/usr/ccsp/wifi/stahealth.sh >> /rdklogs/logs/wifihealth.txt  #zqiu: start from cosa_start.sh or systemd
                /usr/ccsp/wifi/bandsteering.sh >> /rdklogs/logs/bandsteering_periodic_status.txt
                echo "after running aphealth.sh printing top output" >> $WIFI_CONSOLE_LOG_NAME
                top -n1 > /tmp/top.txt
                cat /tmp/top.txt>> $WIFI_CONSOLE_LOG_NAME
        else
                echo "skipping apheath.sh run" >> $WIFI_CONSOLE_LOG_NAME
        fi
else
	if [ $uptime -gt 1800 ] && [ "$(pidof CcspWifiSsp)" != "" ] && [ "$(pidof aphealth.sh)" == "" ] && [ "$(pidof stahealth.sh)"  == "" ] && [ "$(pidof radiohealth.sh)" == "" ] && [ "$(pidof bandsteering.sh)" == "" ] && [ "$(pidof log_mem_cpu_info_atom.sh)" == "" ] && [ "$(pidof dailystats.sh)" == "" ] && [ "$(pidof dailystats_log.sh)" == "" ] ; then
                /usr/ccsp/wifi/aphealth.sh >> /rdklogs/logs/wifihealth.txt
                #/usr/ccsp/wifi/stahealth.sh >> /rdklogs/logs/wifihealth.txt  #zqiu: start from cosa_start.sh or systemd
                /usr/ccsp/wifi/bandsteering.sh >> /rdklogs/logs/bandsteering_periodic_status.txt
                echo "after running aphealth.sh printing top output" >> $WIFI_CONSOLE_LOG_NAME
                top -n1 > /tmp/top.txt
                cat /tmp/top.txt>> $WIFI_CONSOLE_LOG_NAME
        else
                echo "skipping apheath.sh run" >> $WIFI_CONSOLE_LOG_NAME
        fi
fi



