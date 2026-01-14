Return-Path: <linux-ext4+bounces-12835-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85538D1F95C
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 16:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47B8230082D0
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04130FC13;
	Wed, 14 Jan 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KobVXX2G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72909311968;
	Wed, 14 Jan 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402709; cv=none; b=YBKXBJtk+VXEOKKO0UQQIEv9szKIqXULr1EwPnR0WhXCUfmWDp91imi4LI4mqjX0OnI/+wX54qKt4ScN2LCrddxWFqfbqMEvxqF8AWs6I4deOj8O0Kkwb5OglqR8g5U45p9XyJr0J/ac/ZJTsBfSN0Pkaw/2tOQoF/8BWsMMBRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402709; c=relaxed/simple;
	bh=q0RlM1W4s+ONgYXqzgEUr0IGJ6pkxHirynBiO2TzhZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9+ffGrrrTNxU5RhtS937OCojUkyhaEwzBfBZeKOEcJ0wQ6awKkFbmxzJx812cNViWOU52a9VB6YGEzGopi4z+GVOlCdaX/SJ8eurI3UHCt2O6x3w3KryDI1TjlCr74uz6/EmCD7PEb7BG6R5N4+tvoY5yRhCFhsPHegazI1biA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KobVXX2G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E03JqZ024310;
	Wed, 14 Jan 2026 14:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hjwoqpzlx8JWd5Peb
	o9H+fjGS0FN+5xs+4cuVciZxpM=; b=KobVXX2GCyTg9CRA0XCgjWwFkFWJsjL+j
	pCFHobH1E195alS/c+Ya9a+Td10mGWew6SdOT9PLCl9+TF9baGvHp64Mzma5Jeb+
	NGsb2wf2doondTOA1cCaRHj+LLP4jrBf0zek/nzYIiFODw5sCLp3CUg+Y+Qy8XOB
	zBPbrXaFzMKzHD5SYX7FBHOwMyWVrVlaU1VcepCnuKni3fsxoezfV+MeYowRzYbv
	1eK9XvMKQTNvrhDouDqT45TlEwnF2LDDjwG3/Gf+QbLbSnB0Na3+azooBBHapkrJ
	oNrwpdbvAMQ79T7OwpI7bTdxHJ/pp2CIHztSLjBk+ZuhYybJQqCjA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4hvre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EEujK2027841;
	Wed, 14 Jan 2026 14:58:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4hvr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EDIkeT002493;
	Wed, 14 Jan 2026 14:58:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sttbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EEwAeM28770630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 14:58:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2B7A20043;
	Wed, 14 Jan 2026 14:58:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC4220040;
	Wed, 14 Jan 2026 14:58:08 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 14:58:08 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] ext4: Refactor zeroout path and handle all cases
Date: Wed, 14 Jan 2026 20:27:50 +0530
Message-ID: <3a63beac9855f41efcdb11b839b4cb6fdc9fb3a4.1768402426.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfX5U3k3C5xvfs7
 L1XVunXA0fHo5/AlHlR544PQPOGo+puiYTE5tkN/zkzIhNFIfQ+DiBtVsTahFSPRGeYTl6PR5za
 QzNVn6DIF4OjxElym1rOCKGnkazrc2yBquHFJp/1QYbuei1EmczDxjK9pYhzx/7Uej/k43MrS61
 gks3R5vKN/V9HMZsUZxcuGfLxFFvzocTB1qaNr6SHzLERyW7d3Xwk+/ZweK4FDt38h6AEpd3kdh
 n6vVdaEccZ4414NCRyILoYWv44TAX1XDIyQ2zqRI7Hbr6qOELbR/B4r+2lOQmCY89Q4hALXR9JE
 ElnaGQsL4dptmmZsjULBKjtnOJjrtFf+P1YGDOCt6ZU8G0HK17rCgH7P6LKfWstDFzMHVlVHhdt
 T1d06zxXc5rC+9DDYL4Md2l7ULclUrcBdZ/KgXEglm9wfnHN+molnC1PM9dWe6cAAczMbBH671t
 4VaIm4YQOMrF6nFnCEA==
X-Proofpoint-ORIG-GUID: 8AyzEbl_W9zeiu66OaZbkvD-JLsxWbS6
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=6967af06 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=CHfUTuQ1SsgL1pUXN6wA:9
X-Proofpoint-GUID: ZGlKh2zhFX5_2gCbeyw3nEFr-B0SIJUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601140123

Currently, zeroout is used as a fallback in case we fail to
split/convert extents in the "traditional" modify-the-extent-tree way.
This is essential to mitigate failures in critical paths like extent
splitting during endio. However, the logic is very messy and not easy to
follow. Further, the fragile use of various flags has made it prone to
errors.

Refactor zeroout out logic by moving it up to ext4_split_extents().
Further, zeroout correctly based on the type of conversion we want, ie:
- unwritten to written: Zeroout everything around the mapped range.
- written to unwritten: Zeroout only the mapped range.

Also, ext4_ext_convert_to_initialized() now passes
EXT4_GET_BLOCKS_CONVERT to make the intention clear.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 286 ++++++++++++++++++++++++++++++----------------
 1 file changed, 188 insertions(+), 98 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 54f45b40fe73..70d85f007dc7 100644
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
@@ -3193,7 +3185,8 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
  *  a> the extent are splitted into two extent.
  *  b> split is not needed, and just mark the extent.
  *
- * Return an extent path pointer on success, or an error pointer on failure.
+ * Return an extent path pointer on success, or an error pointer on failure. On
+ * failure, the extent is restored to original state.
  */
 static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 						  struct inode *inode,
@@ -3203,14 +3196,10 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
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
@@ -3276,11 +3265,10 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 
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
@@ -3296,72 +3284,130 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 				 split, PTR_ERR(path));
 		goto out_path;
 	}
+
+	err = ext4_ext_get_access(handle, inode, path + depth);
+	if (err)
+		goto out;
+
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
 
-	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
-		if (split_flag & EXT4_EXT_DATA_VALID1)
-			memcpy(&zero_ex, ex2, sizeof(zero_ex));
-		else if (split_flag & EXT4_EXT_DATA_VALID2)
-			memcpy(&zero_ex, ex, sizeof(zero_ex));
-		else
-			memcpy(&zero_ex, &orig_ex, sizeof(zero_ex));
-		ext4_ext_mark_initialized(&zero_ex);
+fix_extent_len:
+	ex->ee_len = orig_ex.ee_len;
+	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
+out:
+	if (err || insert_err) {
+		ext4_free_ext_path(path);
+		path = err ? ERR_PTR(err) : ERR_PTR(insert_err);
+	}
+out_path:
+	if (IS_ERR(path))
+		/* Remove all remaining potentially stale extents. */
+		ext4_es_remove_extent(inode, ee_block, ee_len);
+	ext4_ext_show_leaf(inode, path);
+	return path;
+}
 
-		err = ext4_ext_zeroout(inode, &zero_ex);
-		if (err)
-			goto fix_extent_len;
+static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
+				     struct ext4_ext_path *path,
+				     struct ext4_map_blocks *map, int flags)
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
 
+	if (flags & EXT4_GET_BLOCKS_CONVERT) {
 		/*
-		 * The first half contains partially valid data, the splitting
-		 * of this extent has not been completed, fix extent length
-		 * and ext4_split_extent() split will the first half again.
+		 * EXT4_GET_BLOCKS_CONVERT: Caller wants the range specified by
+		 * map to be initialized. Zeroout everything except the map
+		 * range.
 		 */
-		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1) {
-			/*
-			 * Drop extent cache to prevent stale unwritten
-			 * extents remaining after zeroing out.
-			 */
-			ext4_es_remove_extent(inode,
-					le32_to_cpu(zero_ex.ee_block),
-					ext4_ext_get_actual_len(&zero_ex));
-			goto fix_extent_len;
+
+		loff_t map_end = (loff_t) map->m_lblk + map->m_len;
+		loff_t ex_end = (loff_t) ee_block + ee_len;
+
+		if (!is_unwrit)
+			/* Shouldn't happen. Just exit */
+			return -EINVAL;
+
+		/* zeroout left */
+		if (map->m_lblk > ee_block) {
+			lblk = ee_block;
+			len = map->m_lblk - ee_block;
+			pblk = ext4_ext_pblock(ex);
+			err = ext4_issue_zeroout(inode, lblk, pblk, len);
+			if (err)
+				/* ZEROOUT failed, just return original error */
+				return err;
 		}
 
-		/* update the extent length and mark as initialized */
-		ex->ee_len = cpu_to_le16(ee_len);
-		ext4_ext_try_to_merge(handle, inode, path, ex);
-		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-		if (!err)
-			/* update extent status tree */
-			ext4_zeroout_es(inode, &zero_ex);
+		/* zeroout right */
+		if (map->m_lblk + map->m_len < ee_block + ee_len) {
+			lblk = map_end;
+			len = ex_end - map_end;
+			pblk = ext4_ext_pblock(ex) + (map_end - ee_block);
+			err = ext4_issue_zeroout(inode, lblk, pblk, len);
+			if (err)
+				/* ZEROOUT failed, just return original error */
+				return err;
+		}
+	} else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
 		/*
-		 * If we failed at this point, we don't know in which
-		 * state the extent tree exactly is so don't try to fix
-		 * length of the original extent as it may do even more
-		 * damage.
+		 * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Caller wants the
+		 * range specified by map to be marked unwritten.
+		 * Zeroout the map range leaving rest as it is.
 		 */
-		goto out;
+
+		if (is_unwrit)
+			/* Shouldn't happen. Just exit */
+			return -EINVAL;
+
+		lblk = map->m_lblk;
+		len = map->m_len;
+		pblk = ext4_ext_pblock(ex) + (map->m_lblk - ee_block);
+		err = ext4_issue_zeroout(inode, lblk, pblk, len);
+		if (err)
+			/* ZEROOUT failed, just return original error */
+			return err;
+	} else {
+		/*
+		 * We no longer perform unwritten to unwritten splits in IO paths.
+		 * Hence this should not happen.
+		 */
+		WARN_ON_ONCE(true);
+		return -EINVAL;
 	}
 
-fix_extent_len:
-	ex->ee_len = orig_ex.ee_len;
+	err = ext4_ext_get_access(handle, inode, path + depth);
+	if (err)
+		return err;
+
+	ext4_ext_mark_initialized(ex);
+
+	ext4_ext_dirty(handle, inode, path + path->p_depth);
+	if (err)
+		return err;
+
 	/*
-	 * Ignore ext4_ext_dirty return value since we are already in error path
-	 * and err is a non-zero error code.
+	 * The whole extent is initialized and stable now so it can be added to
+	 * es cache
 	 */
-	ext4_ext_dirty(handle, inode, path + path->p_depth);
-out:
-	if (err) {
-		ext4_free_ext_path(path);
-		path = ERR_PTR(err);
-	}
-out_path:
-	if (IS_ERR(path))
-		/* Remove all remaining potentially stale extents. */
-		ext4_es_remove_extent(inode, ee_block, ee_len);
-	ext4_ext_show_leaf(inode, path);
-	return path;
+	if (!(flags & EXT4_EX_NOCACHE))
+		ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
+				      ext4_ext_get_actual_len(ex),
+				      ext4_ext_pblock(ex),
+				      EXTENT_STATUS_WRITTEN, false);
+
+	return 0;
 }
 
 /*
@@ -3382,11 +3428,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
+	int  orig_err = 0;
+	int orig_flags = flags;
 
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3394,30 +3442,31 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
 		if (IS_ERR(path))
-			return path;
+			goto try_zeroout;
+
 		/*
 		 * Update path is required because previous ext4_split_extent_at
 		 * may result in split of original leaf or extent zeroout.
 		 */
 		path = ext4_find_extent(inode, map->m_lblk, path, flags);
 		if (IS_ERR(path))
-			return path;
+			goto try_zeroout;
+
 		depth = ext_depth(inode);
 		ex = path[depth].p_ext;
 		if (!ex) {
@@ -3426,22 +3475,64 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
 		if (IS_ERR(path))
-			return path;
+			goto try_zeroout;
 	}
 
+	goto success;
+
+try_zeroout:
+	/*
+	 * There was an error in splitting the extent. So instead, just zeroout
+	 * unwritten portions and convert it to initialize as a last resort. If
+	 * there is any failure here we just return the original error
+	 */
+
+	orig_err = PTR_ERR(path);
+	if (orig_err != -ENOSPC && orig_err != -EDQUOT && orig_err != -ENOMEM)
+		goto out_orig_err;
+
+	if (!(split_flag & EXT4_EXT_MAY_ZEROOUT))
+		/* There's an error and we can't zeroout, just return the
+		 * original err
+		 */
+		goto out_orig_err;
+
+	path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
+	if (IS_ERR(path))
+		goto out_orig_err;
+
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+	ee_block = le32_to_cpu(ex->ee_block);
+	ee_len = ext4_ext_get_actual_len(ex);
+	unwritten = ext4_ext_is_unwritten(ex);
+
+	if (WARN_ON(ee_block != orig_ee_block || ee_len != orig_ee_len ||
+		    unwritten != orig_unwritten))
+		/*
+		 * The extent to zeroout should have been unchanged
+		 * but its not.
+		 */
+		goto out_free_path;
+
+	if (ext4_split_extent_zeroout(handle, inode, path, map, orig_flags))
+		/*
+		 * Something went wrong in zeroout
+		 */
+		goto out_free_path;
+
+success:
 	if (allocated) {
 		if (map->m_lblk + map->m_len > ee_block + ee_len)
 			*allocated = ee_len - (map->m_lblk - ee_block);
@@ -3450,6 +3541,12 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	}
 	ext4_ext_show_leaf(inode, path);
 	return path;
+
+out_free_path:
+	ext4_free_ext_path(path);
+out_orig_err:
+	return ERR_PTR(orig_err);
+
 }
 
 /*
@@ -3485,7 +3582,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
 	int err = 0;
-	int split_flag = EXT4_EXT_DATA_VALID2;
+	int split_flag = 0;
 	unsigned int max_zeroout = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
@@ -3695,7 +3792,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 
 fallback:
 	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
-				 flags, NULL);
+				 flags | EXT4_GET_BLOCKS_CONVERT, NULL);
 	if (IS_ERR(path))
 		return path;
 out:
@@ -3759,11 +3856,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
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
@@ -3772,9 +3865,6 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
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
2.52.0


