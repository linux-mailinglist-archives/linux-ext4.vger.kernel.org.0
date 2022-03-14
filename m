Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D1C4D800E
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Mar 2022 11:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiCNKm2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Mar 2022 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiCNKm1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Mar 2022 06:42:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C13EA92;
        Mon, 14 Mar 2022 03:41:17 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22E8a3U8011989;
        Mon, 14 Mar 2022 10:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=CWAf8f5TJCbQpdwIz0ofQ9Dva67XSRgREsrrNLuwR9c=;
 b=klV9G+whGYzATWcvlvJ+tJNC2VIlxd+vsF5+qJdKS96KQrLV+jZTFRX1KRRmLLC3jS0R
 +36EX2xsnn7jfK64QiwvpAHQeQ/rxfPp4UFw3XfeHppYsSHD6W750YZI2y2rSDN13KPG
 +NFaToHJSA5EoiT53C+FVZ/0rOQYbC1jYjwIqMUzQJI53xD+Mtp9wBGQ+Iqmah4EyubH
 rQtRIjGnpqldEMzATxOW5Ic/StmAzn1vbE5+dUUy8Z1f7uAPUDr4V7ad73RT4behrR0y
 k9y0/Jz89jDUfkTbuTPmMI3iiWdrpgdWE78n3S5Jz5MxixN6aa68RkrTVEqNcwkao1U+ bg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3es5kmqf47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 10:41:17 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EAbQ2Q027535;
        Mon, 14 Mar 2022 10:41:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3erk58kc7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 10:41:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22EAfBI743844076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 10:41:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B4C311C6E8;
        Mon, 14 Mar 2022 10:32:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D897311C6C7;
        Mon, 14 Mar 2022 10:32:10 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.29.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Mar 2022 10:32:10 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     riteshh@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ext4/053: Add support for testing mb_optimize_scan
Date:   Mon, 14 Mar 2022 16:02:07 +0530
Message-Id: <5b0d252484cbe973c2df0c677cb47b30012b0db1.1647253313.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jofw897RvP4hcS-2YBWXAd3cvoNMdPUR
X-Proofpoint-GUID: Jofw897RvP4hcS-2YBWXAd3cvoNMdPUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_04,2022-03-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=921 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add support to test the mb_optimize_scan mount option.
Since its value is not reflected in the "options" file in proc,
use "mb_structs_summary" to verify its value.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/053 | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tests/ext4/053 b/tests/ext4/053
index e1e79592..bd92002f 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -100,6 +100,7 @@ test_mnt() {
 	(
 	ret=0
 	IFS=','
+	proc_path="/proc/fs/ext4/$(_short_dev $SCRATCH_DEV)"
 	for option in $OPTS; do
 		if echo $IGNORED | grep -w $option; then
 			continue
@@ -114,11 +115,16 @@ test_mnt() {
 		fi
 		option=${option#^}
 
-		if echo $CHECK_MINFO | grep -w $option; then
+		if [[ $option =~ ^mb_optimize_scan=.*$ ]]; then
+			# mb_optimize_scan needs special handling
+			expected=${option#*=}
+			ret=$(cat $proc_path/mb_structs_summary | grep "optimize_scan" \
+				| awk '{ print $2 }')
+		elif echo $CHECK_MINFO | grep -w $option; then
 			findmnt -n -o OPTIONS $SCRATCH_DEV | grep $option
 			ret=$?
 		else
-			grep $option /proc/fs/ext4/$(_short_dev $SCRATCH_DEV)/options
+			grep $option $proc_path/options
 			ret=$?
 		fi
 
@@ -526,13 +532,10 @@ for fstype in ext2 ext3 ext4; do
 
 	mnt prefetch_block_bitmaps removed
 	mnt no_prefetch_block_bitmaps
-	# We don't currently have a way to know that the option has been
-	# applied, so comment it out for now. This should be fixed in the
-	# future.
-	#mnt mb_optimize_scan=0
-	#mnt mb_optimize_scan=1
-	#not_mnt mb_optimize_scan=9
-	#not_mnt mb_optimize_scan=
+	mnt mb_optimize_scan=0
+	mnt mb_optimize_scan=1
+	not_mnt mb_optimize_scan=9
+	not_mnt mb_optimize_scan=
 	mnt nombcache
 	mnt no_mbcache nombcache
 	mnt check=none removed
-- 
2.27.0

