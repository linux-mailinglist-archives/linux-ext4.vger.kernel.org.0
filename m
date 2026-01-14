Return-Path: <linux-ext4+bounces-12837-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B826BD1F962
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 16:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51FA3301D505
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765C314D0C;
	Wed, 14 Jan 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K5JLxKvd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C482314B86;
	Wed, 14 Jan 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402713; cv=none; b=pCLk7W68hTm0rvgi8dbTLm9eY+JrCIuJRsDpV97OMpsVS6X/enhENkpZwmGw81eBgkxUPOFJNQjK/vcEs0TdC0sHstXdNVLa5He6SUpNdQZHuRxSZhSo/8dYJVHPjl4+BT4jb+l9/P3MiEh8Bce5Krl3gBk8e/zFLhUzNFmUgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402713; c=relaxed/simple;
	bh=3u3vh9o7Y1y4VsDUU6LAZNcT+MRbFu22hUEhoHgD48c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcUJ2xKind7prJ3RnDy0WfNZdaSqJY2XlL6P3JhYAX85wVdtPAcwsIgvxHepd4mC1znHNIRCsDVF+EY/ghgJyitchvi4FyTJCPRdcH/IeJhLYq8xPtVKrtVkwfVZIqmu1fL+lskRRGmS2BXmBlOnDLIW89MwbG87FGm6FN4zyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K5JLxKvd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E5s5CA025535;
	Wed, 14 Jan 2026 14:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KJWeIhRgGAX1UEAj7
	nyEHo2lCvBbfkWmVdzCFrR03nc=; b=K5JLxKvdk6RsRImOckwWxIOZIcbEC20of
	TCPC3qmEZF4Win7KPp+XYDF4W02RIccCMisCGBO+OPkUvczH3/8Nf3Qrw3xHq/e5
	21b5yz67WK8mV/Ymmwsg2iwhiUOzAhEegeAy39dBrwrysB85kJV0z9NkwpXUr6TJ
	NS0XOHnPiilZnHxxOjJDAWOC7w5PLELisyzZuVQIDlmXsNFmcA98Kylpt0j7xdVn
	ysplsERB4ht0wBl+aMhCUwEogACha+3ESD5WeUMDtXDsg5mPWXf1VlxaJVirWR81
	+Kek5Mmx+CYL0e1LcazVH1GRlHB+cKcgrlxGWiKIPz/uN+gpDhR5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6e9kjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EEwIRo020249;
	Wed, 14 Jan 2026 14:58:18 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6e9kjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EC757t031273;
	Wed, 14 Jan 2026 14:58:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t1tamb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EEwD9K15204676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 14:58:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F5CC20043;
	Wed, 14 Jan 2026 14:58:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1347020040;
	Wed, 14 Jan 2026 14:58:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 14:58:10 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] ext4: Refactor split and convert extents
Date: Wed, 14 Jan 2026 20:27:51 +0530
Message-ID: <140ffcc7e0108cdf89ed3d380f6494437eb8d02a.1768402426.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768402426.git.ojaswin@linux.ibm.com>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uh6IvQxpj61whRDtQRzrsLguGl7OtvJx
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=6967af0a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=w3_2pTfmiPULyj0UcucA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfX3M1FaU9jcRTW
 2BeY/m0EK8sS3aIKM9h01GfOqPrb6y+OzvSOZiQe0FsvofSIET1MU8NDext+dEMT6T9cYq48ZQT
 Wmr28AZaxX5ll9WWwQljQRTLFcOdsSX8FVstHVJCSDbnf4AX84YSAgOjZkQGdWi9w6vo2iGDSqf
 0bybCndgF/OkM+iwEc8vafrJ7uFEOflnjec8tzKTKA/mX+qQqlTzqcIfgmND7Wgt0kZlD0dHkNW
 ZMFZENyQD9k4AgabxWSHHQKsGB9wWgwZyaIoYXXn5FPr0T8aruSnRQBBQWMM1b6EiEcWSZUQ4H2
 Se+/M2z+Mk+ld3zjOIomQu0o0kC3oGj+YCLwl0CUqHJBO8wFOUCwynsUulmJ8ybMaU9IfGCP2Wy
 cwz4RoAI1QYRBDQbXnlICPzhy7ibYLpN9/HzvfNDjrBk53yhTUv33Ob6mqUrhJY9tyedM0JOMgh
 3968zBi7+/agJFTXodg==
X-Proofpoint-ORIG-GUID: CIOQzlIah2L6veeYlIQsxFuJzieDNa9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601140123

ext4_split_convert_extents() has been historically prone to subtle
bugs and inconsistent behavior due to the way all the various flags
interact with the extent split and conversion process. For example,
callers like ext4_convert_unwritten_extents_endio() and
convert_initialized_extents() needed to open code extent conversion
despite passing CONVERT or CONVERT_UNWRITTEN flags because
ext4_split_convert_extents() wasn't performing the conversion.

Hence, refactor ext4_split_convert_extents() to clearly enforce the
semantics of each flag. The major changes here are:

 * Clearly separate the split and convert process:
   * ext4_split_extent() and ext4_split_extent_at() are now only
     responsible to perform the split.
   * ext4_split_convert_extents() is now responsible to perform extent
     conversion after calling ext4_split_extent() for splitting.
   * This helps get rid of all the MARK_UNWRIT* flags.

 * Clearly enforce the semantics of flags passed to
   ext4_split_convert_extents():

   * EXT4_GET_BLOCKS_CONVERT: Will convert the split extent to written
   * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Will convert the split extent to
     unwritten
   * Modify all callers to enforce the above semantics.

 * Use ext4_split_convert_extents() instead of ext4_split_extents()
   in ext4_ext_convert_to_initialized() for uniformity.

 * Now that ext4_split_convert_extents() is handling caching to es, we
   dont need to do it in ext4_split_extent_zeroout().

 * Cleanup all callers open coding the conversion logic. Further, modify
   kuniy tests to pass flags based on the new semantics.

From an end user point of view, we should not see any changes in
behavior of ext4.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 279 +++++++++++++++++++---------------------------
 1 file changed, 113 insertions(+), 166 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 70d85f007dc7..8ade9c68ddd8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -41,8 +41,9 @@
  */
 #define EXT4_EXT_MAY_ZEROOUT	0x1  /* safe to zeroout if split fails \
 					due to ENOSPC */
-#define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
-#define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
+static struct ext4_ext_path *ext4_split_convert_extents(
+	handle_t *handle, struct inode *inode, struct ext4_map_blocks *map,
+	struct ext4_ext_path *path, int flags, unsigned int *allocated);
 
 static __le32 ext4_extent_block_csum(struct inode *inode,
 				     struct ext4_extent_header *eh)
@@ -84,8 +85,7 @@ static void ext4_extent_block_csum_set(struct inode *inode,
 static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 						  struct inode *inode,
 						  struct ext4_ext_path *path,
-						  ext4_lblk_t split,
-						  int split_flag, int flags);
+						  ext4_lblk_t split, int flags);
 
 static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
 {
@@ -333,15 +333,12 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
 			   struct ext4_ext_path *path, ext4_lblk_t lblk,
 			   int nofail)
 {
-	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
 	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
 
 	if (nofail)
 		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
 
-	return ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
-			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
-			flags);
+	return ext4_split_extent_at(handle, inode, path, lblk, flags);
 }
 
 static int
@@ -3173,17 +3170,11 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
  * @inode: the file inode
  * @path: the path to the extent
  * @split: the logical block where the extent is splitted.
- * @split_flags: indicates if the extent could be zeroout if split fails, and
- *		 the states(init or unwritten) of new extents.
  * @flags: flags used to insert new extent to extent tree.
  *
  *
  * Splits extent [a, b] into two extents [a, @split) and [@split, b], states
- * of which are determined by split_flag.
- *
- * There are two cases:
- *  a> the extent are splitted into two extent.
- *  b> split is not needed, and just mark the extent.
+ * of which are same as the original extent. No conversion is performed.
  *
  * Return an extent path pointer on success, or an error pointer on failure. On
  * failure, the extent is restored to original state.
@@ -3192,14 +3183,14 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 						  struct inode *inode,
 						  struct ext4_ext_path *path,
 						  ext4_lblk_t split,
-						  int split_flag, int flags)
+						  int flags)
 {
 	ext4_fsblk_t newblock;
 	ext4_lblk_t ee_block;
 	struct ext4_extent *ex, newex, orig_ex;
 	struct ext4_extent *ex2 = NULL;
 	unsigned int ee_len, depth;
-	int err = 0, insert_err = 0;
+	int err = 0, insert_err = 0, is_unwrit = 0;
 
 	/* Do not cache extents that are in the process of being modified. */
 	flags |= EXT4_EX_NOCACHE;
@@ -3213,39 +3204,24 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	ee_block = le32_to_cpu(ex->ee_block);
 	ee_len = ext4_ext_get_actual_len(ex);
 	newblock = split - ee_block + ext4_ext_pblock(ex);
+	is_unwrit = ext4_ext_is_unwritten(ex);
 
 	BUG_ON(split < ee_block || split >= (ee_block + ee_len));
-	BUG_ON(!ext4_ext_is_unwritten(ex) &&
-	       split_flag & (EXT4_EXT_MAY_ZEROOUT |
-			     EXT4_EXT_MARK_UNWRIT1 |
-			     EXT4_EXT_MARK_UNWRIT2));
 
-	err = ext4_ext_get_access(handle, inode, path + depth);
-	if (err)
+	/*
+	 * No split needed
+	 */
+	if (split == ee_block)
 		goto out;
 
-	if (split == ee_block) {
-		/*
-		 * case b: block @split is the block that the extent begins with
-		 * then we just change the state of the extent, and splitting
-		 * is not needed.
-		 */
-		if (split_flag & EXT4_EXT_MARK_UNWRIT2)
-			ext4_ext_mark_unwritten(ex);
-		else
-			ext4_ext_mark_initialized(ex);
-
-		if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
-			ext4_ext_try_to_merge(handle, inode, path, ex);
-
-		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
+	err = ext4_ext_get_access(handle, inode, path + depth);
+	if (err)
 		goto out;
-	}
 
 	/* case a */
 	memcpy(&orig_ex, ex, sizeof(orig_ex));
 	ex->ee_len = cpu_to_le16(split - ee_block);
-	if (split_flag & EXT4_EXT_MARK_UNWRIT1)
+	if (is_unwrit)
 		ext4_ext_mark_unwritten(ex);
 
 	/*
@@ -3260,7 +3236,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	ex2->ee_block = cpu_to_le32(split);
 	ex2->ee_len   = cpu_to_le16(ee_len - (split - ee_block));
 	ext4_ext_store_pblock(ex2, newblock);
-	if (split_flag & EXT4_EXT_MARK_UNWRIT2)
+	if (is_unwrit)
 		ext4_ext_mark_unwritten(ex2);
 
 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
@@ -3393,20 +3369,10 @@ static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
 
 	ext4_ext_mark_initialized(ex);
 
-	ext4_ext_dirty(handle, inode, path + path->p_depth);
+	ext4_ext_dirty(handle, inode, path + depth);
 	if (err)
 		return err;
 
-	/*
-	 * The whole extent is initialized and stable now so it can be added to
-	 * es cache
-	 */
-	if (!(flags & EXT4_EX_NOCACHE))
-		ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
-				      ext4_ext_get_actual_len(ex),
-				      ext4_ext_pblock(ex),
-				      EXTENT_STATUS_WRITTEN, false);
-
 	return 0;
 }
 
@@ -3426,15 +3392,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 					       struct ext4_ext_path *path,
 					       struct ext4_map_blocks *map,
 					       int split_flag, int flags,
-					       unsigned int *allocated)
+					       unsigned int *allocated, bool *did_zeroout)
 {
 	ext4_lblk_t ee_block, orig_ee_block;
 	struct ext4_extent *ex;
 	unsigned int ee_len, orig_ee_len, depth;
 	int unwritten, orig_unwritten;
-	int split_flag1 = 0, flags1 = 0;
-	int  orig_err = 0;
-	int orig_flags = flags;
+	int orig_err = 0;
 
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3450,12 +3414,8 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	flags |= EXT4_EX_NOCACHE;
 
 	if (map->m_lblk + map->m_len < ee_block + ee_len) {
-		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
-		if (unwritten)
-			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
-				       EXT4_EXT_MARK_UNWRIT2;
 		path = ext4_split_extent_at(handle, inode, path,
-				map->m_lblk + map->m_len, split_flag1, flags1);
+					    map->m_lblk + map->m_len, flags);
 		if (IS_ERR(path))
 			goto try_zeroout;
 
@@ -3478,13 +3438,8 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	}
 
 	if (map->m_lblk >= ee_block) {
-		split_flag1 = 0;
-		if (unwritten) {
-			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
-			split_flag1 |= split_flag & EXT4_EXT_MARK_UNWRIT2;
-		}
 		path = ext4_split_extent_at(handle, inode, path, map->m_lblk,
-					    split_flag1, flags);
+					    flags);
 		if (IS_ERR(path))
 			goto try_zeroout;
 	}
@@ -3526,12 +3481,16 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 		 */
 		goto out_free_path;
 
-	if (ext4_split_extent_zeroout(handle, inode, path, map, orig_flags))
+	if (ext4_split_extent_zeroout(handle, inode, path, map, flags))
 		/*
 		 * Something went wrong in zeroout
 		 */
 		goto out_free_path;
 
+	/* zeroout succeeded */
+	if (did_zeroout)
+		*did_zeroout = true;
+
 success:
 	if (allocated) {
 		if (map->m_lblk + map->m_len > ee_block + ee_len)
@@ -3582,7 +3541,6 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
 	int err = 0;
-	int split_flag = 0;
 	unsigned int max_zeroout = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
@@ -3734,9 +3692,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	 * It is safe to convert extent to initialized via explicit
 	 * zeroout only if extent is fully inside i_size or new_size.
 	 */
-	split_flag |= ee_block + ee_len <= eof_block ? EXT4_EXT_MAY_ZEROOUT : 0;
-
-	if (EXT4_EXT_MAY_ZEROOUT & split_flag)
+	if (ee_block + ee_len <= eof_block)
 		max_zeroout = sbi->s_extent_max_zeroout_kb >>
 			(inode->i_sb->s_blocksize_bits - 10);
 
@@ -3791,8 +3747,8 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	}
 
 fallback:
-	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
-				 flags | EXT4_GET_BLOCKS_CONVERT, NULL);
+	path = ext4_split_convert_extents(handle, inode, &split_map, path,
+					  flags | EXT4_GET_BLOCKS_CONVERT, NULL);
 	if (IS_ERR(path))
 		return path;
 out:
@@ -3842,7 +3798,8 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	ext4_lblk_t ee_block;
 	struct ext4_extent *ex;
 	unsigned int ee_len;
-	int split_flag = 0, depth;
+	int split_flag = 0, depth, err = 0;
+	bool did_zeroout = false;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len);
@@ -3856,19 +3813,81 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	ee_block = le32_to_cpu(ex->ee_block);
 	ee_len = ext4_ext_get_actual_len(ex);
 
-	if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
-			    EXT4_GET_BLOCKS_CONVERT)) {
-		/*
-		 * It is safe to convert extent to initialized via explicit
-		 * zeroout only if extent is fully inside i_size or new_size.
-		 */
+	/* No split needed */
+	if (ee_block == map->m_lblk && ee_len == map->m_len)
+		goto convert;
+
+	/*
+	 * We don't use zeroout fallback for written to unwritten conversion as
+	 * it is not as critical as endio and it might take unusually long.
+	 * Also, it is only safe to convert extent to initialized via explicit
+	 * zeroout only if extent is fully inside i_size or new_size.
+	 */
+	if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
 		split_flag |= ee_block + ee_len <= eof_block ?
-			      EXT4_EXT_MAY_ZEROOUT : 0;
-		split_flag |= EXT4_EXT_MARK_UNWRIT2;
+				      EXT4_EXT_MAY_ZEROOUT :
+				      0;
+
+	/*
+	 * pass SPLIT_NOMERGE explicitly so we don't end up merging extents we
+	 * just split.
+	 */
+	path = ext4_split_extent(handle, inode, path, map, split_flag,
+				 flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE,
+				 allocated, &did_zeroout);
+	if (IS_ERR(path))
+		return path;
+
+convert:
+	path = ext4_find_extent(inode, map->m_lblk, path, flags);
+	if (IS_ERR(path))
+		return path;
+
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+
+	/*
+	 * Conversion is already handled in case of zeroout
+	 */
+	if (!did_zeroout) {
+		err = ext4_ext_get_access(handle, inode, path + depth);
+		if (err)
+			goto err;
+
+		if (flags & EXT4_GET_BLOCKS_CONVERT)
+			ext4_ext_mark_initialized(ex);
+		else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)
+			ext4_ext_mark_unwritten(ex);
+
+		if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
+		       /*
+			* note: ext4_ext_correct_indexes() isn't needed here because
+			* borders are not changed
+			*/
+			ext4_ext_try_to_merge(handle, inode, path, ex);
+
+		err = ext4_ext_dirty(handle, inode, path + depth);
+		if (err)
+			goto err;
+	}
+
+	/* Lets update the extent status tree after conversion */
+	if (!(flags & EXT4_EX_NOCACHE))
+		ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
+				      ext4_ext_get_actual_len(ex),
+				      ext4_ext_pblock(ex),
+				      ext4_ext_is_unwritten(ex) ?
+					      EXTENT_STATUS_UNWRITTEN :
+					      EXTENT_STATUS_WRITTEN,
+				      false);
+
+err:
+	if (err) {
+		ext4_free_ext_path(path);
+		return ERR_PTR(err);
 	}
-	flags |= EXT4_GET_BLOCKS_SPLIT_NOMERGE;
-	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
-				 allocated);
+
+	return path;
 }
 
 static struct ext4_ext_path *
@@ -3880,7 +3899,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
 	int depth;
-	int err = 0;
 
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3890,41 +3908,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)ee_block, ee_len);
 
-	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		path = ext4_split_convert_extents(handle, inode, map, path,
-						  flags, NULL);
-		if (IS_ERR(path))
-			return path;
-
-		path = ext4_find_extent(inode, map->m_lblk, path, flags);
-		if (IS_ERR(path))
-			return path;
-		depth = ext_depth(inode);
-		ex = path[depth].p_ext;
-	}
-
-	err = ext4_ext_get_access(handle, inode, path + depth);
-	if (err)
-		goto errout;
-	/* first mark the extent as initialized */
-	ext4_ext_mark_initialized(ex);
-
-	/* note: ext4_ext_correct_indexes() isn't needed here because
-	 * borders are not changed
-	 */
-	ext4_ext_try_to_merge(handle, inode, path, ex);
-
-	/* Mark modified extent as dirty */
-	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-	if (err)
-		goto errout;
-
-	ext4_ext_show_leaf(inode, path);
-	return path;
-
-errout:
-	ext4_free_ext_path(path);
-	return ERR_PTR(err);
+	return ext4_split_convert_extents(handle, inode, map, path, flags,
+					  NULL);
 }
 
 static struct ext4_ext_path *
@@ -3938,7 +3923,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
 	int depth;
-	int err = 0;
 
 	/*
 	 * Make sure that the extent is no bigger than we support with
@@ -3955,40 +3939,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)ee_block, ee_len);
 
-	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		path = ext4_split_convert_extents(handle, inode, map, path,
-						  flags, NULL);
-		if (IS_ERR(path))
-			return path;
-
-		path = ext4_find_extent(inode, map->m_lblk, path, flags);
-		if (IS_ERR(path))
-			return path;
-		depth = ext_depth(inode);
-		ex = path[depth].p_ext;
-		if (!ex) {
-			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
-					 (unsigned long) map->m_lblk);
-			err = -EFSCORRUPTED;
-			goto errout;
-		}
-	}
-
-	err = ext4_ext_get_access(handle, inode, path + depth);
-	if (err)
-		goto errout;
-	/* first mark the extent as unwritten */
-	ext4_ext_mark_unwritten(ex);
-
-	/* note: ext4_ext_correct_indexes() isn't needed here because
-	 * borders are not changed
-	 */
-	ext4_ext_try_to_merge(handle, inode, path, ex);
+	path = ext4_split_convert_extents(handle, inode, map, path, flags,
+					  NULL);
+	if (IS_ERR(path))
+		return path;
 
-	/* Mark modified extent as dirty */
-	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-	if (err)
-		goto errout;
 	ext4_ext_show_leaf(inode, path);
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
@@ -3998,10 +3953,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 		*allocated = map->m_len;
 	map->m_len = *allocated;
 	return path;
-
-errout:
-	ext4_free_ext_path(path);
-	return ERR_PTR(err);
 }
 
 static struct ext4_ext_path *
@@ -5635,7 +5586,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	struct ext4_extent *extent;
 	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
 	unsigned int credits, ee_len;
-	int ret, depth, split_flag = 0;
+	int ret, depth;
 	loff_t start;
 
 	trace_ext4_insert_range(inode, offset, len);
@@ -5706,12 +5657,8 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		 */
 		if ((start_lblk > ee_start_lblk) &&
 				(start_lblk < (ee_start_lblk + ee_len))) {
-			if (ext4_ext_is_unwritten(extent))
-				split_flag = EXT4_EXT_MARK_UNWRIT1 |
-					EXT4_EXT_MARK_UNWRIT2;
 			path = ext4_split_extent_at(handle, inode, path,
-					start_lblk, split_flag,
-					EXT4_EX_NOCACHE |
+					start_lblk, EXT4_EX_NOCACHE |
 					EXT4_GET_BLOCKS_SPLIT_NOMERGE |
 					EXT4_GET_BLOCKS_METADATA_NOFAIL);
 		}
-- 
2.52.0


