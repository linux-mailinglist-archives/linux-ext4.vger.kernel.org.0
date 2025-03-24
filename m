Return-Path: <linux-ext4+bounces-6969-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C689A6D54F
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1C53B1D17
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5B25A327;
	Mon, 24 Mar 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n27u+TTv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09D25A2C5;
	Mon, 24 Mar 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801870; cv=none; b=WngL3fd9MtgIukWyoDD5Zqk96Vm/GE6+JheeEIT4gpkAi7e+yri0o9bp8CZx1/DY9AFUrWH2nEQCIz4w8zzX1bLTmibNJXIT1pc9bulYiSeBqLS8lCTxO4UsX3gxhlbgjULUXoxcpSA0iZn0FraSOIeIa7YC7eBkplRpHDjltpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801870; c=relaxed/simple;
	bh=p0L2J3UyOgYMszymVIBHFgnY2lak1l1GuG6/A90f+3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbtQsMFXJ2AdO36LIVgKarCuNPjMeA7W4uGRDO24mHahc5qZW7BYIxKr5n1w8Gn7W2LPubKTFyotSslGeff5OUAOZPZXVqnPCZefu075/YjxrkxldYxLXUS5qz28mQYhyaU1QvePBwpAzNCcOZovPBuOcurw1joiSyBld3KZM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n27u+TTv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O3kDaD013714;
	Mon, 24 Mar 2025 07:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qs39OneXxPBiBg9dk
	FLzNdM6vVLGoJBSoBFd5PE3qos=; b=n27u+TTvwhz50h6/+jXVP+9vclOY6ZIJw
	F4o3R/5VvEb8SJRXOJ3+QkQg8AVlL4BAtB8oV8ger7FewkPpT5HR1pqyb2j2Y93s
	uZETyQgMlzH5g/NbHXQpkal/mNka5dhp8AsRcIyW+HTfSlnrap5YXqiJhZ0FCM1b
	sxNSineFfO8FW5bQQkeE0NrNGJmvpzR/pu0VG2Ae9svnzcRFtSyDafR0hvjB1fLB
	9FC3UvQscykc1Z3D64N08dEAPfCMXkcs6oQEnQPbyz0oFkll1wNyJ6V01loi1v14
	lMgt7DDMVMoF4YNh65G3mkJ3pGmmU0zKTQst1F5JFeh8OHLTU835g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jys90vex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:40 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7bdG5001452;
	Mon, 24 Mar 2025 07:37:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jys90vev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O72cnp030299;
	Mon, 24 Mar 2025 07:37:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7ht5c5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bbXT53412220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1360D2004E;
	Mon, 24 Mar 2025 07:37:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B0B22004B;
	Mon, 24 Mar 2025 07:37:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:35 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 11/11] ext4: disallow unaligned deallocations on forcealign inodes
Date: Mon, 24 Mar 2025 13:07:09 +0530
Message-ID: <4fafc9c42962e1fdc8ce44b21fa977df5de0679e.1742800203.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742800203.git.ojaswin@linux.ibm.com>
References: <cover.1742800203.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WcMMON3tqbK7VuSSeYKFQPaTYHUqiLD2
X-Proofpoint-GUID: 7aW7Fw2d4tEQgC-_3IFwBq7ZKJNsVHeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=905 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240053

When forcealign is set, an unaligned deallocation can disturb the
alignment of the mappings of the file by introducing unaligned holes/unwritten
extents to it. This could then lead to increased allocations failures on the
file in future.

To avoid this, disallow deallocations or extent shifting operations (like insert
range) unless they are aligned to extsize as well.

Note that this is a relatively strict approach which can be relaxed a bit more
in the future by using partial zeroing tricks etc.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 36 ++++++++++++++++++++++++++++++++++++
 fs/ext4/inode.c   | 12 ++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1835e18f0eef..1ac5bb8cbbde 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4754,6 +4754,18 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			return ret;
 	}
 
+	if (ext4_should_use_forcealign(inode)) {
+		u32 extsize_bytes = ext4_inode_get_extsize(EXT4_I(inode))
+				    << inode->i_blkbits;
+
+		if (!IS_ALIGNED(offset | end, extsize_bytes)) {
+			ext4_warning(
+				inode->i_sb,
+				"tried unaligned operation on forcealign inode");
+			return -EINVAL;
+		}
+	}
+
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
 	/* Preallocate the range including the unaligned edges */
 	if (!IS_ALIGNED(offset | end, blocksize)) {
@@ -5473,6 +5485,18 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	if (end >= inode->i_size)
 		return -EINVAL;
 
+	if (ext4_should_use_forcealign(inode)) {
+		u32 extsize_bytes = ext4_inode_get_extsize(EXT4_I(inode))
+				    << inode->i_blkbits;
+
+		if (!IS_ALIGNED(offset | end, extsize_bytes)) {
+			ext4_warning(
+				inode->i_sb,
+				"tried unaligned operation on forcealign inode");
+			return -EINVAL;
+		}
+	}
+
 	/*
 	 * Write tail of the last page before removed range and data that
 	 * will be shifted since they will get removed from the page cache
@@ -5573,6 +5597,18 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	if (len > inode->i_sb->s_maxbytes - inode->i_size)
 		return -EFBIG;
 
+	if (ext4_should_use_forcealign(inode)) {
+		u32 extsize_bytes = ext4_inode_get_extsize(EXT4_I(inode))
+				    << inode->i_blkbits;
+
+		if (!IS_ALIGNED(offset | (offset + len), extsize_bytes)) {
+			ext4_warning(
+				sb,
+				"tried unaligned operation on forcealign inode");
+			return -EINVAL;
+		}
+	}
+
 	/*
 	 * Write out all dirty pages. Need to round down to align start offset
 	 * to page size boundary for page size > block size.
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b36e62872d6..4c974e461061 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4397,6 +4397,18 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		end = max_end;
 	length = end - offset;
 
+	if (ext4_should_use_forcealign(inode)) {
+		u32 extsize_bytes = ext4_inode_get_extsize(EXT4_I(inode))
+				    << inode->i_blkbits;
+
+		if (!IS_ALIGNED(offset | end, extsize_bytes)) {
+			ext4_warning(
+				sb,
+				"tried unaligned operation on forcealign inode");
+			return -EINVAL;
+		}
+	}
+
 	/*
 	 * Attach jinode to inode for jbd2 if we do any zeroing of partial
 	 * block.
-- 
2.48.1


