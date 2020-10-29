Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB629F596
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJ2TxT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 15:53:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgJ2TxS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Oct 2020 15:53:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TJXRHk196154;
        Thu, 29 Oct 2020 15:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QqwY4XihXOf86ySBA5WxNci+O2Si7XfCBSjMtTbChBY=;
 b=KSghU9IwPGOT0kYugnRMu65fvuVXgWjz6oL+kb+JhJWVWShW0v/vjI7vuSZ5CYEKtaHR
 sM7RvJK31UHwjDcnfNIDj0TJ2x6CwAjO2js++GNoN2tpiRl6uAr5VyewHQNoT9h4vpk5
 dgyZSWb5uYQdR8LmUOGkodaXMo6WwS1lOZUOF6yF6gpyBClRQZslVqBcGxwZm18H7fgY
 zS5bkRDlhNP2ZLMnPC+YCORh/iweSY/HfNb5V3ihdUSIQaV5zo2r7fhnWpau+uVwA2/p
 dJ5LwewQ7HVMuqCJkI/5pioKzF7bGOHvQS9lw2kMiD3gBjQfeXolFcOBNInnWhJDxnpb Eg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34g31ctf3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 15:53:15 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09TJmAcB016310;
        Thu, 29 Oct 2020 19:53:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 34f7s3rs2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 19:53:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09TJrAir36045232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 19:53:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AD554C04A;
        Thu, 29 Oct 2020 19:53:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD9044C040;
        Thu, 29 Oct 2020 19:53:08 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.33.247])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Oct 2020 19:53:08 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com, Eryu Guan <guan@eryu.me>,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/3] common/rc: Make swapon check in _require_scratch_swapfile() specific to btrfs
Date:   Fri, 30 Oct 2020 01:22:51 +0530
Message-Id: <6070d16aab6a61bbbc988fc68cc727c21ec7baef.1604000570.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604000570.git.riteshh@linux.ibm.com>
References: <cover.1604000570.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_12:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 suspectscore=3 adultscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290134
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

swapon/off check in _require_scratch_swapfile() was specifically added
for btrfs[1]/[2] since in previous kernels, swapfile was not supported on btrfs.
This rather masks the issue sometimes with swapon system call in
case if it fails.
for e.g. in latest ext4 upstream tree when "-g quick" (which ran swap tests too)
was tested, all swap tests resulted into "_notrun" since swapon failed
inside _require_scratch_swapfile() itself.
Whereas this failure on ext4 was actually due to a regression with latest
fast-commit patch, which went un-noticed.
Hence make this swapon/off check only specific to btrfs.
Tested default config of xfs/btrfs/ext4/f2fs with this patch.

With this change on buggy kernel, we could clearly catch the swap failures.
e.g.
generic/472 17s ...
<...>
@@ -1,4 +1,7 @@
QA output created by 472
regular swap
+swapon: Invalid argument
too long swap
+swapon: Invalid argument
tiny swap
+swapon: Invalid argument
...
(Run 'diff -u /home/qemu/src/tools-work/xfstests-dev/tests/generic/472.out \
/home/qemu/src/tools-work/xfstests-dev/results//ext4/generic/472.out.bad' \
to see the entire diff)

[1]: 8c96cfbfe530 ("generic/35[67]: disable swapfile tests on Btrfs")
[2]: bd6d67ee598e ("generic: enable swapfile tests on Btrfs")

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/rc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/common/rc b/common/rc
index b0c353c4c107..4c59968a6bd3 100644
--- a/common/rc
+++ b/common/rc
@@ -2358,18 +2358,20 @@ _require_scratch_swapfile()
 	[ -n "$SELINUX_MOUNT_OPTIONS" ] && export \
 		SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:swapfile_t:s0"
 
-	_scratch_mount
+	if [ "$FSTYP" = "btrfs" ]; then
+		_scratch_mount
+
+		# Minimum size for mkswap is 10 pages
+		_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
 
-	# Minimum size for mkswap is 10 pages
-	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
+			_scratch_unmount
+			_notrun "swapfiles are not supported"
+		fi
 
-	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
+		swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
 		_scratch_unmount
-		_notrun "swapfiles are not supported"
 	fi
-
-	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
-	_scratch_unmount
 }
 
 # Check that a fs has enough free space (in 1024b blocks)
-- 
2.26.2

