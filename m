Return-Path: <linux-ext4+bounces-5408-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024EC9D9185
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 06:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4E5287D34
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 05:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8E15575F;
	Tue, 26 Nov 2024 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bNtAS1R9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F799539A;
	Tue, 26 Nov 2024 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732600542; cv=none; b=IZyrAMb6PvXJ6y6WaBWT+EBUkaqD/riP4ebW3GZLDqXAffuyc5JRz3fTEUZzA2L7qbrDtvFoEHUvaqyTwfuPbm2dUHDV9iaUNngJCTMk3RE91ivEKmi8KkI8qb8gXNFpgpbBcm8NRNbnafHQqcJZaAaR3XWkuoCoDHEXwm/DLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732600542; c=relaxed/simple;
	bh=WBKszhpOKgF3UyQr8mTdW7QxZYNMO0Ee3X18lNrovWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvXddqmKUi6vJlxMdi2FOsHrUG7SIjHQlVtFv3sukStBvjGkVoErudbuFCSjYuSJiZqI3D5v12TSZE2AtJOhxv1mTJCFbHCWKh0LGa8VzFmhxsoKgbVXdB9vN8iadj/SfuooZIjvl2XLpC+PmTZDZffKC+DeZDzvc/rIr1sMBr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bNtAS1R9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APKwmr7026552;
	Tue, 26 Nov 2024 05:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XPYJFCdqNeyKarHqs
	UjZg0EHKA/rjhdvsPd2xJ2dLYU=; b=bNtAS1R99c6C+QsAjPqgHo8/meQNY5zgt
	cr/WhkgnplRj1VuPABSibbnRE/CTVo58yY6zkOTMUUfppGM2CDoq2Djtd8QbbCm0
	ZsHM7CcdogR9AtQGYw9MDRiJM5u5yawQ8RhIcA54Z7bTonHsOQG6vrVSpV87kiIm
	kkXYTEZq4n8Vxom8EaO0d2IZ97IcRLmKskolMwZOcepOVlO5z8yDyQvQPIhA+MW4
	ZmjGxm2KggwNuszYyC6dNF2J4bZ/ZIuS3SzvucQH+ELx/vk47MdQ+72cIe9qXLFd
	gu3nrNLGKgbmqT8JwXFfGJwRLHw0smPYsbJIfk1pdooYtT5hlr6Cw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4350rhhne1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:55:31 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQ5obaB003904;
	Tue, 26 Nov 2024 05:55:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4350rhhndy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:55:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ4fYXk000840;
	Tue, 26 Nov 2024 05:55:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433sry7e24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:55:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQ5tQaK34931342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 05:55:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A9052004F;
	Tue, 26 Nov 2024 05:55:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D0B20043;
	Tue, 26 Nov 2024 05:55:24 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.124.222.125])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 05:55:24 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v4 1/3] common/rc,xfs/207: Add a common helper function to check xflag bits
Date: Tue, 26 Nov 2024 11:24:06 +0530
Message-ID: <31b0c72649ec4308aa4e8981ac416addae4e1fdb.1732599868.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1732599868.git.nirjhar@linux.ibm.com>
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ogrf8yI4PNcFqrHj_tckvrok1V4Vekmd
X-Proofpoint-ORIG-GUID: 5Tk-uHz8wTTO6LyPj4faMYFHMnLWP63D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=767 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260043

This patch defines a common helper function to test whether any of
fsxattr xflags field is set or not. We will use this helper in
an upcoming patch for checking extsize (e) flag.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 common/rc     |  7 +++++++
 tests/xfs/207 | 15 ++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/common/rc b/common/rc
index 2ee46e51..f94bee5e 100644
--- a/common/rc
+++ b/common/rc
@@ -41,6 +41,13 @@ _md5_checksum()
 	md5sum $1 | cut -d ' ' -f1
 }
 
+# Check whether a fsxattr xflags name ($2) field is set on a given file ($1).
+# e.g, fsxattr.xflags =  0x80000800 [extsize, has-xattr]
+_test_fsxattr_xflag()
+{
+	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
+}
+
 # Write a byte into a range of a file
 _pwrite_byte() {
 	local pattern="$1"
diff --git a/tests/xfs/207 b/tests/xfs/207
index bbe21307..394e7e55 100755
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
@@ -65,14 +56,16 @@ echo "Set cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
 _scratch_cycle_mount
 
-$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
+_test_fsxattr_xflag "$testdir/file3" "cowextsize" && echo "C flag set" || \
+	echo "C flag unset"
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
 
 echo "Unset cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
 _scratch_cycle_mount
 
-$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
+_test_fsxattr_xflag "$testdir/file3" "cowextsize" && echo "C flag set" || \
+	echo "C flag unset"
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
 
 status=0
-- 
2.43.5


