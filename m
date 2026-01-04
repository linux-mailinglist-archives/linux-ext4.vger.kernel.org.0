Return-Path: <linux-ext4+bounces-12554-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E3CF0E8D
	for <lists+linux-ext4@lfdr.de>; Sun, 04 Jan 2026 13:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF15930517EA
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Jan 2026 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0965B2C0F6F;
	Sun,  4 Jan 2026 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wd1oLBSM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDD2C11C9;
	Sun,  4 Jan 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529196; cv=none; b=InpRim38sBtkF4iqygq51hY/pahFSuXCp/R6EAvuf6WjArpF5ivRR92SqXYsb9xhOFGE+O9c20iTP9m311rTtt0pcTI4R4lodCORvAH3wutg9i/cTpnYf+QkA2P2b9jLji4rK0UfAve4TSfKATepIR/WYM2T/9/tReWEScNEh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529196; c=relaxed/simple;
	bh=js9vLvfyCgTmE5g+HWKGp4cd+vIO8qzOfIzVHwm7//E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AstH+DHnEoSU6asQIVr4Oh4fvgEafX8ZgT01nWTSlpsxqblPQsSbjJbbln0rmuTqqRt3A49+h7WH+rty7xt63+MRg1xUylNrlCFQfYnfv3NeKMMOpU3V7E0pAJzR3002tpsIBZMv9xeB5Gned3PFkrrUhIhrjqZkBtQwOSnpl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wd1oLBSM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6044bQrY014881;
	Sun, 4 Jan 2026 12:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UpxKsI+wdsgOkqSdg
	Uh897RIh3zy5/1ka1TXmuc/1UU=; b=Wd1oLBSMhUW06lQqFatUn5QSPVWJwUpem
	zS0LitVggqDHWm6bw3LJMisDy/2ouJUqkrX72Sz4tBwR600Ttc4xcoTbPA/RZAVH
	jlkXp4tY/DYDLCEk9xEh9xVVefwgNFb8qgsLru1lnBNXRav7tP4oQuQR/TMtpatV
	+R+AXHDx9zdAjkdQ/DmZKxNeRDBRUUBcY8ZDydEgPGh6sjJYSHknsCI7h+MxExGw
	Ujkj+uAlzJN29vyrBC9ldSEmAi7TYzawe0VJ0FOi7trUHoN5RnGaULerVYFlnyKq
	MFZKVrdauPW1FRyE6+AKsFgwb/O8s3BNMe77U26zgTB93SRvseQmA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm6umuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 604CJcDU020115;
	Sun, 4 Jan 2026 12:19:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm6umur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6048LNjG005216;
	Sun, 4 Jan 2026 12:19:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexjscsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604CJZKW54264172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 12:19:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 418D920043;
	Sun,  4 Jan 2026 12:19:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FF220040;
	Sun,  4 Jan 2026 12:19:33 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 12:19:33 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] ext4: Refactor zeroout path and handle all cases
Date: Sun,  4 Jan 2026 17:49:18 +0530
Message-ID: <1ecffaf1edd7a37d90a7fcc8808b9b6e4e7a1245.1767528171.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767528171.git.ojaswin@linux.ibm.com>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdmVzxTY c=1 sm=1 tr=0 ts=695a5adb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=XKToGUZWHxzsijyeJD0A:9
X-Proofpoint-GUID: F7zbNecWYGyNChKe2BbH_FsH7yeGQmRd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDExMyBTYWx0ZWRfX5mlOmxSJ3REb
 g/ztdSEEfd+jhuJp4s0gojLluohXR9ybhwUzu+V+kY9BiszYQGxRPyuCrvbYRowGTA7dOcfyAjZ
 nRrAcNIEEJhe8KtNW8UjGihDyY3ft8F0BNkHPIqiq+H88YzFZVQjlrykovroLQIvWSWnhW0K2dB
 C3Av2ZehR6wq9VjtzOAK+8ThgID5DdZpzJn1zTO38BkZgDxRw2o6MTQiOSfXymQAb1q4TJ2ALI1
 A0FFINdMlOK9Seo/O3bfUKPZHazx8JN2DZ44e03zGJKLyJYXkh7CwhpYJ2WJ1Ts3tYAkXejGOgO
 0E5slYJvAHEeZCLYBBOIVNTWR9L+1SM64bkS29TG864xwYVfFG5Xe+H9flhcVMHpOfgL4Xs1Sdf
 pMZVig5QtxCCqMrv7aDhHhNccwBIEzFTCwO3clgR2uo4r+5ZiXR4N3dCtAqNbKDTNNwt3mAN7rn
 Ljr06gnwiJX3cesx3Lw==
X-Proofpoint-ORIG-GUID: vhv6A-a5_ScbD0uCcb3d1jZohMducTYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601040113

Currently, zeroout is used as a fallback in case we fail to
split/convert extents in the "traditional" modify-the-extent-tree way.
This is essential to mitigate failures in critical paths like extent
splitting during endio. However, the logic is very messy and not easy to
follow. Further, the fragile use of various flags has made it prone to
errors.

Refactor zeroout out logic by moving it up to ext4_split_extents().
Further, zeroout correctly based on the type of conversion we want, ie:
- unwritten to written: Zeroout everything around the mapped range.
- unwritten to unwritten: Zeroout everything
- written to unwritten: Zeroout only the mapped range.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 287 +++++++++++++++++++++++++++++++---------------
 1 file changed, 195 insertions(+), 92 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 460a70e6dae0..8082e1d93bbf 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -44,14 +44,6 @@
 #define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
 #define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
 
-/* first half contains valid data */
-#define EXT4_EXT_DATA_ENTIRE_VALID1	0x8   /* has entirely valid data */
-#define EXT4_EXT_DATA_PARTIAL_VALID1	0x10  /* has partially valid data */
-#define EXT4_EXT_DATA_VALID1		(EXT4_EXT_DATA_ENTIRE_VALID1 | \
-					 EXT4_EXT_DATA_PARTIAL_VALID1)
-
-#define EXT4_EXT_DATA_VALID2	0x20 /* second half contains valid data */
-
 static __le32 ext4_extent_block_csum(struct inode *inode,
 				     struct ext4_extent_header *eh)
 {
@@ -3194,7 +3186,8 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
  *  a> the extent are splitted into two extent.
  *  b> split is not needed, and just mark the extent.
  *
- * Return an extent path pointer on success, or an error pointer on failure.
+ * Return an extent path pointer on success, or an error pointer on failure. On
+ * failure, the extent is restored to original state.
  */
 static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 						  struct inode *inode,
@@ -3204,14 +3197,10 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 {
 	ext4_fsblk_t newblock;
 	ext4_lblk_t ee_block;
-	struct ext4_extent *ex, newex, orig_ex, zero_ex;
+	struct ext4_extent *ex, newex, orig_ex;
 	struct ext4_extent *ex2 = NULL;
 	unsigned int ee_len, depth;
-	int err = 0;
-
-	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) == EXT4_EXT_DATA_VALID1);
-	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
-	       (split_flag & EXT4_EXT_DATA_VALID2));
+	int err = 0, insert_err = 0;
 
 	/* Do not cache extents that are in the process of being modified. */
 	flags |= EXT4_EX_NOCACHE;
@@ -3277,11 +3266,10 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 
 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
 	if (!IS_ERR(path))
-		goto out;
+		return path;
 
-	err = PTR_ERR(path);
-	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
-		goto out_path;
+	insert_err = PTR_ERR(path);
+	err = 0;
 
 	/*
 	 * Get a new path to try to zeroout or fix the extent length.
@@ -3297,53 +3285,13 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 				 split, PTR_ERR(path));
 		goto out_path;
 	}
-	depth = ext_depth(inode);
-	ex = path[depth].p_ext;
-
-	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
-		if (split_flag & EXT4_EXT_DATA_VALID1)
-			memcpy(&zero_ex, ex2, sizeof(zero_ex));
-		else if (split_flag & EXT4_EXT_DATA_VALID2)
-			memcpy(&zero_ex, ex, sizeof(zero_ex));
-		else
-			memcpy(&zero_ex, &orig_ex, sizeof(zero_ex));
-		ext4_ext_mark_initialized(&zero_ex);
 
-		err = ext4_ext_zeroout(inode, &zero_ex);
-		if (err)
-			goto fix_extent_len;
-
-		/*
-		 * The first half contains partially valid data, the splitting
-		 * of this extent has not been completed, fix extent length
-		 * and ext4_split_extent() split will the first half again.
-		 */
-		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1) {
-			/*
-			 * Drop extent cache to prevent stale unwritten
-			 * extents remaining after zeroing out.
-			 */
-			ext4_es_remove_extent(inode,
-					le32_to_cpu(zero_ex.ee_block),
-					ext4_ext_get_actual_len(&zero_ex));
-			goto fix_extent_len;
-		}
-
-		/* update the extent length and mark as initialized */
-		ex->ee_len = cpu_to_le16(ee_len);
-		ext4_ext_try_to_merge(handle, inode, path, ex);
-		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-		if (!err)
-			/* update extent status tree */
-			ext4_zeroout_es(inode, &zero_ex);
-		/*
-		 * If we failed at this point, we don't know in which
-		 * state the extent tree exactly is so don't try to fix
-		 * length of the original extent as it may do even more
-		 * damage.
-		 */
+	err = ext4_ext_get_access(handle, inode, path + depth);
+	if (err)
 		goto out;
-	}
+
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
 
 fix_extent_len:
 	ex->ee_len = orig_ex.ee_len;
@@ -3353,9 +3301,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	 */
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 out:
-	if (err) {
+	if (err || insert_err) {
 		ext4_free_ext_path(path);
-		path = ERR_PTR(err);
+		path = err ? ERR_PTR(err) : ERR_PTR(insert_err);
 	}
 out_path:
 	if (IS_ERR(path))
@@ -3365,6 +3313,115 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	return path;
 }
 
+static struct ext4_ext_path *
+ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
+			  struct ext4_ext_path *path,
+			  struct ext4_map_blocks *map, int flags)
+{
+	struct ext4_extent *ex;
+	unsigned int ee_len, depth;
+	ext4_lblk_t ee_block;
+	uint64_t lblk, pblk, len;
+	int is_unwrit;
+	int err = 0;
+
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+	ee_block = le32_to_cpu(ex->ee_block);
+	ee_len = ext4_ext_get_actual_len(ex);
+	is_unwrit = ext4_ext_is_unwritten(ex);
+
+	if (flags & EXT4_GET_BLOCKS_CONVERT) {
+		/*
+		 * EXT4_GET_BLOCKS_CONVERT: Caller wants the range specified by
+		 * map to be initialized. Zeroout everything except the map
+		 * range.
+		 */
+
+		loff_t map_end = (loff_t) map->m_lblk + map->m_len;
+		loff_t ex_end = (loff_t) ee_block + ee_len;
+
+		if (!is_unwrit)
+			/* Shouldn't happen. Just exit */
+			return ERR_PTR(-EINVAL);
+
+		/* zeroout left */
+		if (map->m_lblk > ee_block) {
+			lblk = ee_block;
+			len = map->m_lblk - ee_block;
+			pblk = ext4_ext_pblock(ex);
+			err = ext4_issue_zeroout(inode, lblk, pblk, len);
+			if (err)
+				/* ZEROOUT failed, just return original error */
+				return ERR_PTR(err);
+		}
+
+		/* zeroout right */
+		if (map->m_lblk + map->m_len < ee_block + ee_len) {
+			lblk = map_end;
+			len = ex_end - map_end;
+			pblk = ext4_ext_pblock(ex) + (map_end - ee_block);
+			err = ext4_issue_zeroout(inode, lblk, pblk, len);
+			if (err)
+				/* ZEROOUT failed, just return original error */
+				return ERR_PTR(err);
+		}
+	} else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
+		/*
+		 * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Caller wants the
+		 * range specified by map to be marked unwritten.
+		 * Zeroout the map range leaving rest as it is.
+		 */
+
+		if (is_unwrit)
+			/* Shouldn't happen. Just exit */
+			return ERR_PTR(-EINVAL);
+
+		lblk = map->m_lblk;
+		len = map->m_len;
+		pblk = ext4_ext_pblock(ex) + (map->m_lblk - ee_block);
+		err = ext4_issue_zeroout(inode, lblk, pblk, len);
+		if (err)
+			/* ZEROOUT failed, just return original error */
+			return ERR_PTR(err);
+	} else if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
+		/*
+		 * EXT4_GET_BLOCKS_UNWRIT_EXT: Today, this flag
+		 * implicitly implies that callers when wanting an
+		 * unwritten to unwritten split. So zeroout the whole
+		 * extent.
+		 *
+		 * TODO: The implicit meaning of the flag is not ideal
+		 * and eventually we should aim for a more well defined
+		 * behavior
+		 */
+
+		if (!is_unwrit)
+			/* Shouldn't happen. Just exit */
+			return ERR_PTR(-EINVAL);
+
+		lblk = ee_block;
+		len = ee_len;
+		pblk = ext4_ext_pblock(ex);
+		err = ext4_issue_zeroout(inode, lblk, pblk, len);
+		if (err)
+			/* ZEROOUT failed, just return original error */
+			return ERR_PTR(err);
+	}
+
+	err = ext4_ext_get_access(handle, inode, path + depth);
+	if (err)
+		return ERR_PTR(err);
+
+	ext4_ext_mark_initialized(ex);
+
+	ext4_ext_dirty(handle, inode, path + path->p_depth);
+	if (err)
+		return ERR_PTR(err);
+
+	return 0;
+}
+
 /*
  * ext4_split_extent() splits an extent and mark extent which is covered
  * by @map as split_flags indicates
@@ -3383,11 +3440,12 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 					       int split_flag, int flags,
 					       unsigned int *allocated)
 {
-	ext4_lblk_t ee_block;
+	ext4_lblk_t ee_block, orig_ee_block;
 	struct ext4_extent *ex;
-	unsigned int ee_len, depth;
-	int unwritten;
-	int split_flag1, flags1;
+	unsigned int ee_len, orig_ee_len, depth;
+	int unwritten, orig_unwritten;
+	int split_flag1 = 0, flags1 = 0;
+	int err = 0, orig_err;
 
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3395,23 +3453,29 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	ee_len = ext4_ext_get_actual_len(ex);
 	unwritten = ext4_ext_is_unwritten(ex);
 
+	orig_ee_block = ee_block;
+	orig_ee_len = ee_len;
+	orig_unwritten = unwritten;
+
 	/* Do not cache extents that are in the process of being modified. */
 	flags |= EXT4_EX_NOCACHE;
 
 	if (map->m_lblk + map->m_len < ee_block + ee_len) {
-		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
 		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
 		if (unwritten)
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
 				       EXT4_EXT_MARK_UNWRIT2;
-		if (split_flag & EXT4_EXT_DATA_VALID2)
-			split_flag1 |= map->m_lblk > ee_block ?
-				       EXT4_EXT_DATA_PARTIAL_VALID1 :
-				       EXT4_EXT_DATA_ENTIRE_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
-		if (IS_ERR(path))
-			return path;
+
+		if (IS_ERR(path)) {
+			orig_err = PTR_ERR(path);
+			if (orig_err != -ENOSPC && orig_err != -EDQUOT &&
+			    orig_err != -ENOMEM)
+				return path;
+
+			goto try_zeroout;
+		}
 		/*
 		 * Update path is required because previous ext4_split_extent_at
 		 * may result in split of original leaf or extent zeroout.
@@ -3427,22 +3491,68 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 			ext4_free_ext_path(path);
 			return ERR_PTR(-EFSCORRUPTED);
 		}
-		unwritten = ext4_ext_is_unwritten(ex);
 	}
 
 	if (map->m_lblk >= ee_block) {
-		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
+		split_flag1 = 0;
 		if (unwritten) {
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
-			split_flag1 |= split_flag & (EXT4_EXT_MAY_ZEROOUT |
-						     EXT4_EXT_MARK_UNWRIT2);
+			split_flag1 |= split_flag & EXT4_EXT_MARK_UNWRIT2;
 		}
-		path = ext4_split_extent_at(handle, inode, path,
-				map->m_lblk, split_flag1, flags);
+		path = ext4_split_extent_at(handle, inode, path, map->m_lblk,
+					    split_flag1, flags);
+
+		if (IS_ERR(path)) {
+			orig_err = PTR_ERR(path);
+			if (orig_err != -ENOSPC && orig_err != -EDQUOT &&
+			    orig_err != -ENOMEM)
+				return path;
+
+			goto try_zeroout;
+		}
+	}
+
+	if (!err)
+		goto out;
+
+try_zeroout:
+	/*
+	 * There was an error in splitting the extent, just zeroout and convert
+	 * to initialize as a last resort
+	 */
+	if (split_flag & EXT4_EXT_MAY_ZEROOUT) {
+		path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
 		if (IS_ERR(path))
 			return path;
+
+		depth = ext_depth(inode);
+		ex = path[depth].p_ext;
+		ee_block = le32_to_cpu(ex->ee_block);
+		ee_len = ext4_ext_get_actual_len(ex);
+		unwritten = ext4_ext_is_unwritten(ex);
+
+		/*
+		 * The extent to zeroout should have been unchanged
+		 * but its not, just return error to caller
+		 */
+		if (WARN_ON(ee_block != orig_ee_block ||
+			    ee_len != orig_ee_len ||
+			    unwritten != orig_unwritten))
+			return ERR_PTR(orig_err);
+
+		/*
+		 * Something went wrong in zeroout, just return the
+		 * original error
+		 */
+		if (ext4_split_extent_zeroout(handle, inode, path, map, flags))
+			return ERR_PTR(orig_err);
 	}
 
+	/* There's an error and we can't zeroout, just return the err */
+	return ERR_PTR(orig_err);
+
+out:
+
 	if (allocated) {
 		if (map->m_lblk + map->m_len > ee_block + ee_len)
 			*allocated = ee_len - (map->m_lblk - ee_block);
@@ -3486,7 +3596,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
 	int err = 0;
-	int split_flag = EXT4_EXT_DATA_VALID2;
+	int split_flag = 0;
 	unsigned int max_zeroout = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
@@ -3760,11 +3870,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	ee_block = le32_to_cpu(ex->ee_block);
 	ee_len = ext4_ext_get_actual_len(ex);
 
-	/* Convert to unwritten */
-	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
-		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
-	/* Split the existing unwritten extent */
-	} else if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
+	if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
 			    EXT4_GET_BLOCKS_CONVERT)) {
 		/*
 		 * It is safe to convert extent to initialized via explicit
@@ -3773,9 +3879,6 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 		split_flag |= ee_block + ee_len <= eof_block ?
 			      EXT4_EXT_MAY_ZEROOUT : 0;
 		split_flag |= EXT4_EXT_MARK_UNWRIT2;
-		/* Convert to initialized */
-		if (flags & EXT4_GET_BLOCKS_CONVERT)
-			split_flag |= EXT4_EXT_DATA_VALID2;
 	}
 	flags |= EXT4_GET_BLOCKS_SPLIT_NOMERGE;
 	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
-- 
2.51.0


