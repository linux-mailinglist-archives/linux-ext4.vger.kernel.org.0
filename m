Return-Path: <linux-ext4+bounces-4720-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C66729AB6B6
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 21:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558991F2451C
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 19:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7551CB503;
	Tue, 22 Oct 2024 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AWQzp8KF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C80145A1C;
	Tue, 22 Oct 2024 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625198; cv=none; b=RGdFj38hMm5YS+NjWZ+4BZoAhA4ppDnFLd5TX4GbhgibY91nIyAfFz1uZ6OOHRnwK5FpNe9YyNCy2SpJ3XPPGhhiWswAfjU+dXD4dDp36hBMCfz88Ji2my4jmMQ0kHmsErjbLeNfW1Y4l5SIUleroqeyE+DeCqWheRj7QVK5Ioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625198; c=relaxed/simple;
	bh=phbILsG2JeioBUL62i1rkn/spWpJxGlo8OU+0cDYwhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNnKDhk4OJXRx9bw5n/ViUf144fxuHZj8iZZ3BzETiYkb6Pp2jManq5dBV8Mb4bvtRqQ3WhOsuDoMbP4OhUmFH2cxYEJEG2LDbtSaTtpP5RzrlRpASoqQvqnVmgghj8ip7t1RLErhTjY1afjPV686xyKDGHB/gGcNKFDCZ9hrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AWQzp8KF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MFm7T1004806;
	Tue, 22 Oct 2024 19:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cDH0L0bsb1qLazu8S
	KIld++0u7+2tBFHacW9JNGFwEY=; b=AWQzp8KFHD9lMPF60jxnGky1A1ISqRdRh
	H79zjRPgpPGVEIiMwd0q5Jn4Zj2V0CqM4aZsVjnOE++SXXvgzLs/infdAlhZdCAw
	4aaCynGmgXNXZhSmwt90oPhsxC3jX9bJ1UxC66GbLILJ/6gwS8q8WrE7MP+WIopH
	eCGzhXn/Zab6nBiU0MkCrOEku2pnfospJiVUU52uRs0joUvlHe+UrO/AbicTGNqS
	HMXhLFNWCSW+7UAaOT7BlNrq27MKnfUFM4iOFxYS0yi49uznJdtDaw47zgFE6OwQ
	IullLaOEFsQ6UONrHQwD/O00QxFioc5VGdaSJ7EeSPoDHbQoveLpQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42e4xfknfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:26:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49MJQW3v027380;
	Tue, 22 Oct 2024 19:26:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42e4xfknfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:26:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MIXPmw018655;
	Tue, 22 Oct 2024 19:26:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csajcj10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:26:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49MJQU5833423854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 19:26:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 711A82004B;
	Tue, 22 Oct 2024 19:26:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 087DE2004D;
	Tue, 22 Oct 2024 19:26:29 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.39.26.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 19:26:28 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org
Subject: [PATCH 1/2] common/xfs,xfs/207: Adding a common helper function to check xflag bits on a given file
Date: Wed, 23 Oct 2024 00:56:19 +0530
Message-ID: <6ba7f682af7e0bc99a8baeccc0d7aa4e5062a433.1729624806.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1729624806.git.nirjhar@linux.ibm.com>
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hmT8PEWnrYuiOLula7lr9Gu29dB5VY0c
X-Proofpoint-ORIG-GUID: cuHix2Rslp8iKoXqM0gZZg4yH12hg7Lc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=946 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410220125

This patch defines a common helper function to test whether any of
fsxattr xflags field is set or not. We will use this helper in the next
patch for checking extsize (e) flag.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 common/xfs    |  9 +++++++++
 tests/xfs/207 | 14 +++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/common/xfs b/common/xfs
index 62e3100e..7340ccbf 100644
--- a/common/xfs
+++ b/common/xfs
@@ -13,6 +13,15 @@ __generate_xfs_report_vars() {
 	REPORT_ENV_LIST_OPT+=("TEST_XFS_REPAIR_REBUILD" "TEST_XFS_SCRUB_REBUILD")
 }
 
+# Check whether a fsxattr xflags character field is set on a given file.
+# e.g. fsxattr.xflags = 0x0 [--------------C-]
+# Returns 0 if passed flag character is set, otherwise returns 1
+_test_xfs_xflags_field()
+{
+    $XFS_IO_PROG -c "stat" "$1" | grep "fsxattr.xflags" | grep -q "\[.*$2.*\]" \
+        && return 0 || return 1
+}
+
 _setup_large_xfs_fs()
 {
 	fs_size=$1
diff --git a/tests/xfs/207 b/tests/xfs/207
index bbe21307..adb925df 100755
--- a/tests/xfs/207
+++ b/tests/xfs/207
@@ -15,21 +15,13 @@ _begin_fstest auto quick clone fiemap
 # Import common functions.
 . ./common/filter
 . ./common/reflink
+. ./common/xfs
 
 _require_scratch_reflink
 _require_cp_reflink
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
@@ -65,14 +57,14 @@ echo "Set cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
 _scratch_cycle_mount
 
-$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
+_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
 
 echo "Unset cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
 _scratch_cycle_mount
 
-$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
+_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
 
 status=0
-- 
2.43.5


