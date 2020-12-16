Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621192DBA60
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 06:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgLPFUr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 00:20:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgLPFUr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 00:20:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BG537w5047435;
        Wed, 16 Dec 2020 00:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ojk8NqSbS+gOgI7FZfYfjW8e8jxnix0uaMLoEyuz8T0=;
 b=Yrfj1kHvBxJeuJSERbcc0fPnQmhWlC244cr58tAazvp0KYT8NpegK32wUCBgurWVQIgs
 tKio7V40Aq9qWVnaKTYyhHV96OhRlmcUJVBJc+afEB5CrMKpDFPqIfX3N+TNu3vjZYsW
 LRsRkTicdpvytvwITNwk4RaPN/z+NM7qpx18pavQ6gR6hxLe5HPQDvIa23+25a0nqZE7
 B4jZz1Yj9xWDyJWbFe8HxsCU1JaAcSUxgK8qLGf0uZDwy+ksmB+6nFLlHey+gzKbvYP/
 7jq8utAsxHX3UIqCCCWsBdGMLm62eovP1pLQmCjSX2YuEtsC3p0oYXQDro2oVyzDcXJq oA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35f9u92s65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 00:20:02 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BG5H2GW030520;
        Wed, 16 Dec 2020 05:20:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8dueq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 05:20:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BG5HTGw24576270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 05:17:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB5D84C059;
        Wed, 16 Dec 2020 05:17:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 561794C050;
        Wed, 16 Dec 2020 05:17:27 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.42.232])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Dec 2020 05:17:27 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guan@eryu.me>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/2] common/rc: Add whitelisted FS support in _require_scratch_swapfile()
Date:   Wed, 16 Dec 2020 10:47:24 +0530
Message-Id: <f161a49e6e3476d83c35b8e6a111644110ec4c8c.1608094988.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_01:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=957
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160031
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Filesystems e.g. ext4 and XFS supports swapon by default and an error
returned with swapon should be treated as a failure. Hence
add ext4/xfs as whitelisted fstype in _require_scratch_swapfile()

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
v1->v2: Addressed comments from Eryu @[1]
[1]: https://patchwork.kernel.org/project/fstests/cover/cover.1604000570.git.riteshh@linux.ibm.com/

 common/rc | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 33b5b598a198..635b77a005c6 100644
--- a/common/rc
+++ b/common/rc
@@ -2380,6 +2380,7 @@ _format_swapfile() {
 # Check that the filesystem supports swapfiles
 _require_scratch_swapfile()
 {
+	local fstyp=$FSTYP
 	_require_scratch
 	_require_command "$MKSWAP_PROG" "mkswap"

@@ -2401,10 +2402,21 @@ _require_scratch_swapfile()
 	# Minimum size for mkswap is 10 pages
 	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))

-	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
-		_scratch_unmount
-		_notrun "swapfiles are not supported"
-	fi
+	# For whitelisted fstyp swapon should not fail.
+	case "$fstyp" in
+	ext4|xfs)
+		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
+			_scratch_unmount
+			_fail "swapon failed for $fstyp"
+		fi
+		;;
+	*)
+		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
+			_scratch_unmount
+			_notrun "swapfiles are not supported"
+		fi
+		;;
+	esac

 	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
 	_scratch_unmount
--
2.26.2

