Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211DB528002
	for <lists+linux-ext4@lfdr.de>; Mon, 16 May 2022 10:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiEPIqh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 May 2022 04:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbiEPIpq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 May 2022 04:45:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F7E0F6;
        Mon, 16 May 2022 01:45:17 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G7GMl3029172;
        Mon, 16 May 2022 08:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=hfH9ENXHmkvYY4SrhVI4B6ngajE5iyLDfRCRRzKHlPg=;
 b=lHrPtOe/MHrttYPkGozCjIffvk+BnrAEG+suQqEnnEpr+08XieQfsiG0QI8GSOcE7a2F
 jSsQo+Vc4iMR62ILnembAj1J2FMQFnfapwgQDt/QAcNrkaaoyGVn++vi5bI+SghdvQDQ
 iI4fBp2ReSqPwzG8f01FFWVA5tsFUCAn/eJ9bG/ub7Djs7riEm3APVU3vooT0mDaajHb
 rNM+hlWCAAFGT4V55zRe7sCW5azxTcCKJ4pZnS7iFcCPmVUZV9FcqUmh33JQwMcQCeKY
 7gBucRe+8LNnj57scpnNve0zUK9ot7senVit54drQdkPl+kuLWugfbUdqNtv4LzY1nac VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3j2s9kx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 08:45:17 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24G8Mfnj024366;
        Mon, 16 May 2022 08:45:16 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3j2s9kvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 08:45:16 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24G8hLA0020581;
        Mon, 16 May 2022 08:45:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3g24291su0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 08:45:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24G8jCRx41484640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 08:45:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6D8DA4064;
        Mon, 16 May 2022 08:45:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 185F6A405F;
        Mon, 16 May 2022 08:45:10 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.41.34])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 May 2022 08:45:09 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] common/rc: Modify _require_batched_discard to improve test coverage
Date:   Mon, 16 May 2022 14:15:05 +0530
Message-Id: <20220516084505.97655-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kgmcdx_mKfYLTsSXVvCTqddhbJ44qoT3
X-Proofpoint-ORIG-GUID: 7XO7ltc0Mnxms-7HRpVW9KauZzzBWQ3X
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_03,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=772
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A recent ext4 patch discussed [1] that some devices (eg LVMs) can
have a discard granularity as big as 42MB which makes it larger
than the group size of ext4 FS with 1k BS.  This causes the FITRIM
IOCTL to fail.

This case was not correctly handled by this test since
"_require_batched_discard" incorrectly interpreted the FITRIM
failure as SCRATCH_DEV not supporting the IOCTL. This caused the test
to report "not run" instead of "failed" in case of large discard granularity.

Fix "_require_batched_discard" to use a more accurate method
to determine if discard is supported.

[1] commit 173b6e383d2
    ext4: avoid trim error on fs with small groups

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---

Changes since v2 [1] 

*  Eliminated redundant $ret variable

[1]
https://lore.kernel.org/all/20220516063951.87838-1-ojaswin@linux.ibm.com/

 common/rc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index e2d3d72a..94344248 100644
--- a/common/rc
+++ b/common/rc
@@ -3858,7 +3858,12 @@ _require_batched_discard()
 		exit 1
 	fi
 	_require_fstrim
-	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
+
+	grep -q "not supported" <($FSTRIM_PROG $1 2>&1)
+	if [ "$?" = "0" ]
+	then
+		_notrun "FITRIM not supported on $1"
+	fi
 }
 
 _require_dumpe2fs()
-- 
2.27.0

