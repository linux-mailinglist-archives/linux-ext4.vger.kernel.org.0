Return-Path: <linux-ext4+bounces-5188-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1C79CD62D
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 05:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6934FB23DA7
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 04:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77E816F851;
	Fri, 15 Nov 2024 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k7n7erk9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68E2E400;
	Fri, 15 Nov 2024 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731644253; cv=none; b=sNUsBB8AsRCjfj4rUC4pQ+W2rtLFcR7vEUq5122tcJG0MYpfD8p1gyNCToNlOpUWVSgm1/LaP2+ganZbdWakTEVlYV1BxO2f4uUUkVj5bgSDPnS0ppETvqyqLQhiyqARXNtmYZ1arj1BiwMzgkdIH5zPvETWnbFOmFPFSgOJffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731644253; c=relaxed/simple;
	bh=KG0uAwTFr6G8ixxtD6WcCZ7OvypLh+bt2H/09xLcVos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktkDM4diu5NVim5oFSHqSupkt4go6EqTP3cCYII1uyrRKK31UaEc5xteDvFIe/L0m1S6JwyYTMyH/rny53DXS03351MOVmXt6eYrXBXdZFINXanA/yGBXy4rLpPrxPMxGcysf2UkVssyeLuDRSfdKibEI1Iyevn9X3FZuv+eBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k7n7erk9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF0jtx9022908;
	Fri, 15 Nov 2024 04:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iZlQeL1GosZT80pUL
	teUIR4AMWSE5RN4ZHRpwAnlrmw=; b=k7n7erk9r168In703STupdWHeGNBbFUBR
	fUCQ60ZteA3+ExZlaHPhpTRatIU+y8B7CQY11YEJ9B9PY+9bYFs61ANRB/nyTLQ2
	AM7WBcebAix+Gj7ytXZ5K+WGfsDyvi4oVA9E+cuY35JJQT2jrtQdavtTjO4DHrvS
	ZJoID6B8t23UkMfp8qU+fAOOhEA0Wly/vlzBXzocBGKzFpW32Mbuq7+b73hN6UzZ
	GMusi9gVE3v1GB780vdEMgQP5NQ5RQsRg87jusHRdqKRoSqDaylupbmOm369pIyR
	c6Og2s5Qw1eGiZ2hI29cPM+iYOTzjla4uNKrPg0FmXiLtLcE22VyQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wu2vs1y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 04:17:22 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AF4HLac019062;
	Fri, 15 Nov 2024 04:17:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wu2vs1y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 04:17:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF36XwH029698;
	Fri, 15 Nov 2024 04:17:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmp7j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 04:17:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AF4HIGg52625888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 04:17:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ABBF20043;
	Fri, 15 Nov 2024 04:17:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E540120040;
	Fri, 15 Nov 2024 04:17:16 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.124.220.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 04:17:16 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org
Subject: [PATCH v2 1/2] common/rc,xfs/207: Adding a common helper function to check xflag bits on a given file
Date: Fri, 15 Nov 2024 09:45:58 +0530
Message-ID: <9a955f34cab443d3ed0fc07c17886d5e8a11ad80.1731597226.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1731597226.git.nirjhar@linux.ibm.com>
References: <cover.1731597226.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AheU-gKSXo1NjaN92oHYGFKaN2V9ZzPE
X-Proofpoint-GUID: FT2xfyqnuIkCW3iK2-8JcjTAKVFTOn_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=910 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150032

This patch defines a common helper function to test whether any of
fsxattr xflags field is set or not. We will use this helper in the next
patch for checking extsize (e) flag.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 common/rc     |  7 +++++++
 tests/xfs/207 | 13 ++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/common/rc b/common/rc
index 2af26f23..fc18fc94 100644
--- a/common/rc
+++ b/common/rc
@@ -41,6 +41,13 @@ _md5_checksum()
 	md5sum $1 | cut -d ' ' -f1
 }
 
+# Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
+# e.g, fsxattr.xflags =  0x80000800 [----------e-----X]
+_test_fsx_xflags_field()
+{
+    grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
+}
+
 # Write a byte into a range of a file
 _pwrite_byte() {
 	local pattern="$1"
diff --git a/tests/xfs/207 b/tests/xfs/207
index bbe21307..4f6826f3 100755
--- a/tests/xfs/207
+++ b/tests/xfs/207
@@ -21,15 +21,6 @@ _require_cp_reflink
 _require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
 
-# Takes the fsxattr.xflags line,
-# i.e. fsxattr.xflags = 0x0 [--------------C-]
-# and tests whether a flag character is set
-test_xflag()
-{
-    local flg=$1
-    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
-}
-
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
@@ -65,14 +56,14 @@ echo "Set cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
 _scratch_cycle_mount
 
-$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
+_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
 
 echo "Unset cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
 _scratch_cycle_mount
 
-$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
+_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
 
 status=0
-- 
2.43.5


