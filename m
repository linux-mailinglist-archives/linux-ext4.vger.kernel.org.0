Return-Path: <linux-ext4+bounces-5287-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF79D4714
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 06:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89058B230C5
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 05:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712014C5BD;
	Thu, 21 Nov 2024 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ll2DKKbc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D046126C05;
	Thu, 21 Nov 2024 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732165963; cv=none; b=Y3fK+7bUg12hHd13QAJ94K9Pw5hjxk1tY5XjSfxAXneJP4P0IB71ntsflIflLecjHUMOjWp69bGsFBUD4Uug63HCSMwwelBXyE4P2vZ7ppLw1sOUmqTS507NNpL9h5gCSAO1d2g12HTP0CIt6RLvvWQ8S2A37c/jIrUpwqOSPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732165963; c=relaxed/simple;
	bh=LRz0FzAbQhN6XuGwpbfEze8/UCYLz1uXrcJy3Nbry/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRj7IYP24G/N4pxrjtmlZzAgnIVHT0javLVscg17wMbpa+bzL8OR7s2vQxhk8NeT4p+KhEsJuNAf0kJNyqdiaJLacXbuTxh7HpoAfdVnl6xcndQ8j/WD6iBGVo3Lpg1pMMcERnj5kecYUZff8y7EZAXZAuqdXks7VLqDU/POzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ll2DKKbc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKHllrT006958;
	Thu, 21 Nov 2024 05:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z6KAlmUxbPY20PH1N
	XE+mX6BXC3Yd0pnxF6UT63F2QE=; b=Ll2DKKbcwU2Lm1Oics3M7jIS9hXZNzMIh
	YLUAi5T8o2yPbCMQrJPOhQl2o1FECnhm21awNYNbs1b6xmGMIbHSiGeQTD9GNfeR
	ercfbEIMcn4PSBRmqDI8pjR+CWI6gPhLtZ8dUmR1PFglikEj+ZCgyG3L48CRt12R
	c17lPTtx1L5bj2F4uGU5oftPAZppPwdLVKtk2FJZnIsfeG9kEfzkbwxHxetxPBCX
	fKyCaR/h4YaWv+gTtEGhbiTy+vOqDhCCtyHnj+rmh3cHKhdq+wnY9chXuGNdyBwN
	x0cXdZsdEWfJZVduLWXPx2opRaDvretTxVhI4bMd4pspFGgS5Wjtw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk218jsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:12:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AL57uT8007411;
	Thu, 21 Nov 2024 05:12:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk218jsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:12:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL3irNn000626;
	Thu, 21 Nov 2024 05:12:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77mjvse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:12:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AL5CWIu55902468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 05:12:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B4702004D;
	Thu, 21 Nov 2024 05:12:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2B520040;
	Thu, 21 Nov 2024 05:12:30 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.39.16.21])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Nov 2024 05:12:30 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v3 2/3] common/rc: Add a new _require_scratch_extsize helper function
Date: Thu, 21 Nov 2024 10:39:11 +0530
Message-ID: <4412cece5c3f2175fa076a3b29fe6d0bb4c43a6e.1732126365.git.nirjhar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: rTFtOIg7qui6Uq28IolsVsC7HQe962j0
X-Proofpoint-GUID: WBDUp3nwwr3W7mYUItSRIbWSs7WmgCxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=850 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210037

_require_scratch_extsize helper function will be used in the
the next patch to make the test run only on filesystems with
extsize support.

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 common/rc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/common/rc b/common/rc
index cccc98f5..995979e9 100644
--- a/common/rc
+++ b/common/rc
@@ -48,6 +48,23 @@ _test_fsxattr_xflag()
 	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
 }
 
+# This test requires extsize support on the  filesystem
+_require_scratch_extsize()
+{
+	_require_scratch
+	_scratch_mkfs > /dev/null
+	_scratch_mount
+	local filename=$SCRATCH_MNT/$RANDOM
+	local blksz=$(_get_block_size $SCRATCH_MNT)
+	local extsz=$(( blksz*2 ))
+	local res=$($XFS_IO_PROG -c "open -f $filename" -c "extsize $extsz" \
+		-c "extsize")
+	_scratch_unmount
+	grep -q "\[$extsz\] $filename" <(echo $res) || \
+		_notrun "this test requires extsize support on the filesystem"
+}
+
+
 # Write a byte into a range of a file
 _pwrite_byte() {
 	local pattern="$1"
-- 
2.43.5


