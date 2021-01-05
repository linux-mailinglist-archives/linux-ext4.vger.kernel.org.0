Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813542EAD5F
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 15:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbhAEOci (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 09:32:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726429AbhAEOch (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 09:32:37 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 105EAOJe115940;
        Tue, 5 Jan 2021 09:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=mhxO1yNpwDzubrD22PikR7AmV6DiGBm6utdbPUIFYCc=;
 b=hcb4GuxmhLkwHq2Lq/baCfAjpqfPSlhVg9Cd3B0Vm0nGkjSF6GibsH/85bI+HuUZ2c3I
 46qr9wdWbSFTgDRMOu0nwykGh/D1jlOOJotoP386asLdtfzOuE8fzYs2WLPRe1W1jw3a
 wvtm9c3RYqWHYL2HcgijUfu36VTOzgsBgEmYTQ75VqkO96ssxabhCi7GWOsglnOB9Ajk
 DHoasWea7RBYEdH3Pqv+pCKERFjoGeJH5o/+twcqUysdD0brMf3lYmco9FA/2XZtU1vD
 Z/bHrYe5RTjYyGXmsih/WeyjfPgojCfsCkezM8YC1pbwMhjeN8AD6TaAxuZOZCChgNFU aQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35vsn20p5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 09:31:53 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 105ESqdr027842;
        Tue, 5 Jan 2021 14:31:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 35tgf8hhdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 14:31:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 105EVk8Z22610226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 14:31:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C08074C052;
        Tue,  5 Jan 2021 14:31:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 813294C058;
        Tue,  5 Jan 2021 14:31:45 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.32.130])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jan 2021 14:31:45 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        anju@linux.vnet.ibm.com, guan@eryu.me, darrick.wong@oracle.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 1/2] common/rc: swapon should not fail for given FS in _require_scratch_swapfile()
Date:   Tue,  5 Jan 2021 20:01:42 +0530
Message-Id: <aad3aeb9c717c76fc4e5fd124037da2510f51054.1609848797.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_02:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1011 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=773
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050089
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Filesystems e.g. ext* and XFS supports swapon by default and an error
returned with swapon should be treated as a failure.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
v2 -> v3:
1. Removed whitelisted naming convention.
2. Added ext2/ext3 as well as supported FS for swapon.
3. Removed local variable $fstyp, instead used $FSTYP directly in switch case.

 common/rc | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 33b5b598a198..649b1cfd884a 100644
--- a/common/rc
+++ b/common/rc
@@ -2401,10 +2401,22 @@ _require_scratch_swapfile()
 	# Minimum size for mkswap is 10 pages
 	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))

-	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
-		_scratch_unmount
-		_notrun "swapfiles are not supported"
-	fi
+	# ext* and xfs have supported all variants of swap files since their
+	# introduction, so swapon should not fail.
+	case "$FSTYP" in
+	ext2|ext3|ext4|xfs)
+		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
+			_scratch_unmount
+			_fail "swapon failed for $FSTYP"
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

