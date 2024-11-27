Return-Path: <linux-ext4+bounces-5427-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048069DA17F
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C7C284866
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 04:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4C913A89B;
	Wed, 27 Nov 2024 04:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M8YY3JOF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B21946B;
	Wed, 27 Nov 2024 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732681721; cv=none; b=KnpWdwQUgjBbKUzSG4iYa88Ttpq1O6yzNZtp39kZuR9UwENWTqzUgprVXjjmYwjazCIi7UDfn+qv3KpCh9PfZzenc40hKs0VGmDeW1UU/HU/HKgyBPwJd4iq/a0A2pZlvQZ3ehmofjYaBpAAONER6E2PvJS1jmXQ1b0j+KMoUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732681721; c=relaxed/simple;
	bh=hNEB5pFoibFN5nR8pa0CbpLafYkLhM3CKqOIaBiPjeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRK1CCN5exlzEijWKYg79DW9tV3SgkxYS7PzhuK7Oj3EXbrJQrHjRKCF6v8IK1oy/WjrecqPRVOj2VfRbRwAEHJr9BCjzEk0FiNoAZQ6odcvQVL9ita8K6U28KaJ9bR7N8Z4dAdTg0r7A6if0amQ2y/4RjLZShpURh8IQK7uNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M8YY3JOF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1hH0K029192;
	Wed, 27 Nov 2024 04:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7oWLQ8di2FfB9SYs3
	BOnVABV0K1McxWbsA/JneXFo6Q=; b=M8YY3JOFGLldlmbT+NHZrI/Jnc+2LKKIZ
	PQUT1mj9+pXhg7MuAWXknIhHlbe1M44NZ02DBw0BcOCdb5lJqfto698sjJIF2Xv1
	Ki3SE1MDnxaahux+QpTHP9Rd6RWVDtEYnQ4qYGm5KdCc8MIpC2MUIHrHLLMIq9Qh
	08wKkQNHazmEJ9E/9F8awJImEolPE5vP5KwyBArUHzWDxdM52Q1UHYvTJySF1w3D
	3T/nDUBgws3qQzOXT4ETCzqoGAAEgUZtvvclSPo0Psu6bROlqoy+Ooqij+3BK4po
	DGAdsXhiYyI1HcXlCi/JHS+kM5Xf1OOBApLvHYOGXyeVf0NwmrP3w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nhsy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR4Sb02023338;
	Wed, 27 Nov 2024 04:28:37 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nhsxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR3lhpV005727;
	Wed, 27 Nov 2024 04:28:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 433ukj5pxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR4SXTt34210338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 04:28:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E51BF2004B;
	Wed, 27 Nov 2024 04:28:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F35720040;
	Wed, 27 Nov 2024 04:28:31 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.39.20.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 04:28:31 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v5 1/3] common/rc,xfs/207: Add a common helper function to check xflag bits
Date: Wed, 27 Nov 2024 09:57:59 +0530
Message-ID: <92c333d56d48065707de7d0a29fed9ab8fd6c654.1732681064.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1732681064.git.nirjhar@linux.ibm.com>
References: <cover.1732681064.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MMwR9psuRI-2HcmCbMkt7igTKxGAdNCd
X-Proofpoint-ORIG-GUID: plVQ4Sn3PNWkNAJgPPIRpmF-ahrNik_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=759 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270035

This patch defines a common helper function to test whether any of
fsxattr xflags field is set or not. We will use this helper in
an upcoming patch for checking extsize (e) flag.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


