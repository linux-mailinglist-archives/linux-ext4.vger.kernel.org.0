Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E14EE7FB
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Apr 2022 07:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245236AbiDAF7M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Apr 2022 01:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiDAF7L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Apr 2022 01:59:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4223258FEC;
        Thu, 31 Mar 2022 22:57:22 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2314FDoX016154;
        Fri, 1 Apr 2022 05:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xAYWMp0cYwuqmYWn8cnpCUs9Qu9kOKD+lAGd+kWvD8g=;
 b=jDSWgqeGs4NPh36NaW6W+b51xPawt5WLZkr+Y7Nk8JUCUNtc3DTgV2Gl8VPA2yeNUH7v
 lWg/t/K0IwMxDsRkPWUNUb7hmPpsu9ewhIkEawFadF2an3N6t3tFsL+8x7h+6EHsN5Gp
 RWLkTkDHRcHohatpEhoAorc324VayJa2JXK8wjZT/d8eNv7HqyrIWfKuzeQ74rAdC9+6
 wB2cEVrTmE91z5KuuclV+ycHcaWDn00n3OzmUjvxzG7Go8prgzfiucq3tAEwRawIEgnE
 GKMjAt2ZeBUq+AGjxfcmkJz4lxt7w7NxXkuBgsspL1cASHoZGKhTdewn32s8d4Lx2QlY 7g== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f50af8fyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 05:57:21 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2315r6Kl005963;
        Fri, 1 Apr 2022 05:57:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3f1t3j2fcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 05:57:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2315vHlD30605634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 05:57:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7C30AE045;
        Fri,  1 Apr 2022 05:57:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F75FAE04D;
        Fri,  1 Apr 2022 05:57:16 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.119.93])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Apr 2022 05:57:15 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     riteshh@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] common/rc: Modify _require_batched_discard to improve test coverage
Date:   Fri,  1 Apr 2022 11:27:13 +0530
Message-Id: <20220401055713.634842-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 14k2siXI2nwkBmAtHtFY6y9D_vMjUjkt
X-Proofpoint-GUID: 14k2siXI2nwkBmAtHtFY6y9D_vMjUjkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 phishscore=0 mlxlogscore=637 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A recent ext4 patch discussed [1] that some devices (eg LVMs) can
have a discard granularity as big as 42MB which makes it larger
than the group size of ext4 FS with 1k BS. This causes the FITRIM
IOCTL to fail on filesystems like ext4.

This case was not correctly handle by "_require_batched_discard" as
it incorrectly interpreted the FITRIM failure as fs not supporting
the IOCTL. This caused the tests like generic/260 to incorectly
report "not run" instead of "failed" in case of large discard
granularity.

Fix "_require_batched_discard" to use a more accurate method
to determine if discard is supported.

[1] commit 173b6e383d2
    ext4: avoid trim error on fs with small groups

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index e2d3d72a..97386342 100644
--- a/common/rc
+++ b/common/rc
@@ -3858,7 +3858,13 @@ _require_batched_discard()
 		exit 1
 	fi
 	_require_fstrim
-	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
+
+	$FSTRIM_PROG $1 2>&1 | grep -q "not supported"
+	RET=$?
+	if [ "$RET" = "0" ]
+	then
+		_notrun "FITRIM not supported on $1"
+	fi
 }
 
 _require_dumpe2fs()
-- 
2.27.0

