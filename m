Return-Path: <linux-ext4+bounces-6967-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC493A6D537
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE4C16D620
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED15725A2B4;
	Mon, 24 Mar 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yzs1ZjwV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CED257ADE;
	Mon, 24 Mar 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801866; cv=none; b=QKZZQPtWOfIqMuy67tMjifvlpbvmEk9u5eLyMpHIYBuKhDmMr85wVKNVjBciexKHY1Chjgl2WiMhlkDZwbSCnZ4cACR2tn1VBy6R7q5D56fka/NhThElJ2zVd8hoXQy/fuCO9ga34x6G+Si8Ff6F4SeuB+nVubyJ2MmM9s8LAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801866; c=relaxed/simple;
	bh=LQUDFo/B4Ni7NRq4/htOT728ddTxCQjVzS5lbHiF670=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkCyxHbAqn85/QkyX6ALEVKi+gVHkJASIfMxbUHTcxS7/9IxoK9T0SUWrE70zymElIINALHu2VRqx241hYLS7nSferj51qoT5qeChIrUS03+w6PoncOflC1UvY0Q397QAlBgBRVftUKTet4iSfQMFkIk7bEwQi9YPmEO6nxDJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yzs1ZjwV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NLRT5j029155;
	Mon, 24 Mar 2025 07:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SU2l/E70z181y6juO
	TidrngautSFqTg8K/MCEhMB1Xc=; b=Yzs1ZjwVBLkaklUVbWWfHX/G1OUAvDr7o
	z4ZC32YqjDFEYtwA/TMUXgk0YSlCP1IAX4KG1oRUZTFXpe2AhIRgDZc3/XuAbLfD
	eEF3Mu/rpgVr+q/8Luer3uHn+pFoP5vYMUqWUwZOpeKp9ZLlqTsjsrPdy2FPc8NV
	BywuqxEwk1yoJFztGQuFR/6Bf89d12bEtlPVeVB/1mezRwQdDIyMZUGAB+crIWC2
	ElBGhG+HOTwfYAEMP2ByARTyA5o11H0/yJNLKK1C6FzPEe5OTtRkKEIolpYLQnd5
	1bJ4SjXkYFLdyRuWm7nSBnSYg3nrXR3asGQuWmQtn6GXP8gcaxNDA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsh021fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7NpdR007627;
	Mon, 24 Mar 2025 07:37:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsh021ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O7Ju5J025463;
	Mon, 24 Mar 2025 07:37:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7wywadv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bWwW30540494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE83120040;
	Mon, 24 Mar 2025 07:37:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6E8B20043;
	Mon, 24 Mar 2025 07:37:30 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:30 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 09/11] ext4: add forcealign support to ext4_map_blocks
Date: Mon, 24 Mar 2025 13:07:07 +0530
Message-ID: <003d7711c71a8f515687045f5b74fe045c0f01d1.1742800203.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: xZ23W9V-fS276T1fsr_L4wxJY1P25CUx
X-Proofpoint-GUID: 2aymsP6lTRyFLoW0N49uZOfdjiyJayiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240053

Introduce EXT4_GET_BLOCKS_FORCEALIGN that works with EXT4_GET_BLOCKS_EXTSIZE
and guarantees that the extent returned by allocator is physically as
well as logically aligned to the extsize hint set on the inode.

This feature will be used to guranatee aligned allocations for HW accelerated
atomic writes

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/extents.c | 24 ++++++++++++++++++++++--
 fs/ext4/inode.c   | 43 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9b9d7a354736..a7429797c1d2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -730,6 +730,7 @@ enum {
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
 #define EXT4_GET_BLOCKS_EXTSIZE			0x1000
+#define EXT4_GET_BLOCKS_FORCEALIGN			0x2000
 
 /*
  * The bit position of these flags must not overlap with any of the
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a86cc3e76f14..25c1368b49bb 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4414,13 +4414,27 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ar.flags |= EXT4_MB_USE_RESERVED;
 	if (flags & EXT4_GET_BLOCKS_EXTSIZE)
 		ar.flags |= EXT4_MB_HINT_ALIGNED;
+	if (flags & EXT4_GET_BLOCKS_FORCEALIGN) {
+		if (WARN_ON(ar.logical != map->m_lblk || ar.len != map->m_len ||
+			    !(flags & EXT4_GET_BLOCKS_EXTSIZE))) {
+			/*
+			 * This should ideally not happen but if does then error
+			 * out
+			 */
+			err = -ENOSPC;
+			goto out;
+		}
+		ar.flags |= EXT4_MB_FORCE_ALIGN;
+	}
 	newblock = ext4_mb_new_blocks(handle, &ar, &err);
 	if (!newblock)
 		goto out;
 	allocated_clusters = ar.len;
 	ar.len = EXT4_C2B(sbi, ar.len) - offset;
-	ext_debug(inode, "allocate new block: goal %llu, found %llu/%u, requested %u\n",
-		  ar.goal, newblock, ar.len, allocated);
+	ext_debug(
+		inode,
+		"allocate new block: goal %llu, found %llu/%u, requested %u\n",
+		ar.goal, newblock, ar.len, allocated);
 	if (ar.len > allocated)
 		ar.len = allocated;
 
@@ -4435,6 +4449,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 	}
 
+	if ((flags & EXT4_GET_BLOCKS_FORCEALIGN) &&
+	    (ar.len != map->m_len || pblk % map->m_len)) {
+		err = -ENOSPC;
+		goto insert_error;
+	}
+
 	if ((flags & EXT4_GET_BLOCKS_EXTSIZE) &&
 	    (flags & EXT4_GET_BLOCKS_PRE_IO)) {
 		/*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e41c97584f35..93ab76cb4818 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -753,6 +753,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 
 	__u32 extsize = ext4_inode_get_extsize(EXT4_I(inode));
 	bool should_extsize = false;
+	bool should_forcealign = false;
 
 #ifdef ES_AGGRESSIVE_TEST
 	struct ext4_map_blocks test_map;
@@ -793,6 +794,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		 * ext4_extents.h here?
 		 */
 		int max_unwrit_len = ((1UL << 15) - 1);
+		should_forcealign = (flags & EXT4_GET_BLOCKS_FORCEALIGN);
 
 		align = orig_map->m_lblk % extsize;
 		len = orig_map->m_len + align;
@@ -802,7 +804,11 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			max_t(unsigned int, roundup_pow_of_two(len), extsize);
 
 		/* Fallback to normal allocation if we go beyond max len */
-		if (extsize_map.m_len >= max_unwrit_len) {
+		if (WARN_ON(extsize_map.m_len >= max_unwrit_len)) {
+			if (should_forcealign)
+				/* forcealign has no fallback */
+				return -EINVAL;
+
 			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
 			goto set_map;
 		}
@@ -814,8 +820,10 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		 * dioread nolock to achieve this. Hence the caller has to pass
 		 * CREATE_UNWRIT with EXTSIZE
 		 */
-		if (!(flags | EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)) {
-			WARN_ON(true);
+		if (WARN_ON(!(flags | EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT))) {
+			if (should_forcealign)
+				/* forcealign has no fallback */
+				return -EINVAL;
 
 			/* Fallback to non extsize allocation */
 			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
@@ -905,6 +913,29 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	if (retval >= 0 && flags & EXT4_GET_BLOCKS_EXTSIZE) {
 		bool orig_in_range =
 			in_range(orig_mlblk, (__u64)map->m_lblk, map->m_len);
+
+		if (should_forcealign) {
+			/*
+			 * For forcealign, irrespective of it it's a hole or not,
+			 * the mapping we got should be exactly equal to the
+			 * extsize mapping we requested since allocation and
+			 * deallocation both respect extsize. If
+			 * not, something has gone terribly wrong.
+			 */
+			if (WARN_ON((map->m_lblk != extsize_mlblk) ||
+				    (map->m_len != extsize_mlen))) {
+				ext4_error_adjust_map(map, orig_map);
+				ext4_warning(
+					inode->i_sb,
+					"%s: Unaligned blocks found! Disable forcealign and try again."
+					"requested:(%u, %u) extsize:(%u, %u) got:(%u, %u)\n",
+					__func__, orig_mlblk, orig_mlen,
+					extsize_mlblk, extsize_mlen,
+					map->m_lblk, map->m_len);
+				return -EUCLEAN;
+			}
+		}
+
 		/*
 		 * Special case: if the extsize range is mapped already and
 		 * covers the original start, we return it.
@@ -925,6 +956,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 
 		if (map->m_lblk != extsize_mlblk ||
 		    map->m_len != extsize_mlen) {
+			WARN_ON(should_forcealign);
 			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
 			goto set_map;
 		}
@@ -1011,6 +1043,11 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		 * not used. Can we avoid that?
 		 */
 		if (!in_range(orig_mlblk, (__u64)map->m_lblk, map->m_len)) {
+			if (WARN_ON(should_forcealign)) {
+				/* this should never happen */
+				ext4_error_adjust_map(map, orig_map);
+				return -ENOSPC;
+			}
 			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
 			goto set_map;
 		}
-- 
2.48.1


