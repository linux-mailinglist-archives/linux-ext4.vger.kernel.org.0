Return-Path: <linux-ext4+bounces-5286-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC849D4711
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 06:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12351F22541
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 05:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF914F10E;
	Thu, 21 Nov 2024 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sE3NiKix"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5969230986;
	Thu, 21 Nov 2024 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732165931; cv=none; b=k3R6l/FthQ116EHp76r6iqW2DqlB4oRdlV4hR+EVstU/15GTQFLefONX+fqSk7oCWxn4iB6XqOGy1LAQ7yYBpq/fkJaW5nRmorK+DOTT/86iUrpthj1PPVx1oNLpOIbKV5SsiXuujbd4nONUpHvYdL5yTzxqnQNG+561QjSTaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732165931; c=relaxed/simple;
	bh=hahRfpVRIWTXrd+6Tj3mW8YzyzvEwPNQ6wu0YpnuERc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxY9dzXEHOjCpmF38Ity4DKiC/7smADQo6PKyY5hCA78UDeLt91ZcEMiWojDauTt7eXe00DI6Il/z8kMFeRZZrzlaBRlvyCRxwthzSNk52IzIvx9GpXXqxqULGMMKYCgod3g45Gjd5MI5nSwRKbNX5Nvrgpq6d7jxDaPhCjfnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sE3NiKix; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKH5kZn027646;
	Thu, 21 Nov 2024 05:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4kB0aYZRAkvqzUHeK
	dryr8VwdlIG5hhBgrymsjPS1bA=; b=sE3NiKixqRVAOkV6fKUi9OXXRVLv0U1kE
	ZZ+JLEwKYftRwu8NU6u+cLvVCV0E99liTXkGUGz6+S2YN4/Vi1tflSFnk+bQlTaF
	Psio6/xpgOE73p06vm5yXRoUqrZQMphdk2C5EY7buvPNUPCTbBQnXaIshezKnzt+
	y8m2ZaAp+atwGEABd8vmS+2npnulQSfF2/udPR70Ul5GpJhPDF2EW6LEfZORFI2W
	c8ldGHvRl3xOTgivcgJxGIJmytBN5yHtxwAZ7g/N0gPj6cZ1c8vBD+8aioF/rvjD
	IhC0NUrKMU5VUHs/Vkl/KWIiCSOKB3JsOW7+y8SInHZWsNKyn/oOQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu1yppv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:12:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AL5C6mO022303;
	Thu, 21 Nov 2024 05:12:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu1yppn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:12:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKK8G3S011747;
	Thu, 21 Nov 2024 05:12:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1fwn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:12:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AL5C2nr40304916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 05:12:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 189D620049;
	Thu, 21 Nov 2024 05:12:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 817AE2004E;
	Thu, 21 Nov 2024 05:12:00 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.39.16.21])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Nov 2024 05:12:00 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v3 1/3] common/rc,xfs/207: Add a common helper function to check xflag bits
Date: Thu, 21 Nov 2024 10:39:10 +0530
Message-ID: <e3fe55386a702d34147612b2ce46698b6257e821.1732126365.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1732126365.git.nirjhar@linux.ibm.com>
References: <cover.1732126365.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gxtuGc964g2opPm-7jNOV3Xv36pn-5J9
X-Proofpoint-ORIG-GUID: Xh9Q_9sbUNVNMET2GZPB4-RSkEzlhfon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=806 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210037

This patch defines a common helper function to test whether any of
fsxattr xflags field is set or not. We will use this helper in
an upcoming patch for checking extsize (e) flag.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 common/rc     |  7 +++++++
 tests/xfs/207 | 15 ++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/common/rc b/common/rc
index 2af26f23..cccc98f5 100644
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


