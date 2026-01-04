Return-Path: <linux-ext4+bounces-12555-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4728FCF0E93
	for <lists+linux-ext4@lfdr.de>; Sun, 04 Jan 2026 13:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A663059EA1
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Jan 2026 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D472C0F6C;
	Sun,  4 Jan 2026 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JRsmlTP6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2842BD597;
	Sun,  4 Jan 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529198; cv=none; b=UN2IPNz9893uOxIyDY9du6BdKzCBAMaGIne4OYij9jJJg6fiWnT41u9jflj/5UhenXR7XrHBnAN651edtxelkSb0ia1hJU3k65X7CdDnsNm0lM2TbH8TpHWJ4W6XRylCHWfSffzhAMr3OOs4CtSlrmRuVZ1yh7xeSdO6sQdEmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529198; c=relaxed/simple;
	bh=SNo2AbTr2sVvtTLkY3sMibyU89UDkPGQj928bVzH1Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8BOPgtmQFZelMC2GG9VogTZBRQyTMK/HJzTwUhMz/6H/+ad5lAhGbzGk5mOP3YDPe+A5Et7Nrv/QTOSqMjAyYw4kcGJh4QzTMRIKHQgkS0uTtsB9IK2Vx/+ANKh+lEaCf5Jml4HvceuJznlqgWJDsAqlLEql857T0CZNWh2Sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JRsmlTP6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604CELaO011872;
	Sun, 4 Jan 2026 12:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3dVjpVIL6kSx4Mu8T
	IaRadTJhlEtVT4sD5Ywm03WP/s=; b=JRsmlTP6NErtg2hnPfK122+QaMA4BtIvg
	5OhmNvBbeB0dMnlnaG2nsuId/rqWD6P5bO+q9BRsHh7K6u0784ck8qdseBQk7Zca
	7XeTJNHA5mEjleA6dPTOvbtzvV+ZKJ7OB6P+O63qVJyMmbe+zYwjdEfJERyN6FWi
	BIrIKvbJPcYazI8E/KkwdJTMGzGsHt/9biyklTVCe45fxcC9lF2WZL/hPPqpl7Mt
	+TwAFK/YzUrWwQl5Oy4VeAKgO2Gl2QlUwhfXZqmlkI9q+ThAKmnV+ZT0VoLUl2Q6
	jJDqbPeNwX6s6hFVH7SxP5/37IPNIlsgtSBgc/DKrStNy4di4ugmw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betspumkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 604CJf2l022145;
	Sun, 4 Jan 2026 12:19:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betspumkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6048F8VA005250;
	Sun, 4 Jan 2026 12:19:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexjscsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604CJcZZ51708268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 12:19:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AF3020043;
	Sun,  4 Jan 2026 12:19:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C1F20040;
	Sun,  4 Jan 2026 12:19:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 12:19:35 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] ext4: Refactor split and convert extents
Date: Sun,  4 Jan 2026 17:49:19 +0530
Message-ID: <8c318aa0eeb0c5c4ad0b5f620de3a7f4df596b82.1767528171.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: IREgye1eZUjXMnJYvvhOixK2is53va3r
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695a5ade cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ZYXug0Eu6Bm6DWOy85EA:9
X-Proofpoint-ORIG-GUID: mDIgYugPfWChNd_R6-1yv98eAsaJNlMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDExMyBTYWx0ZWRfX1pkEadhsbG4F
 vEogGEqhDYvp400ybvbAQLQ57n1yrYa2eKiBk3xzF7/cT0FCLKGq9UhtGhuP5qWPd6XKCRevJy2
 pfvJFsph6KoVhwKuKZY2cecIAdd1Jw7VF9Ceb8BUoVF61C0KncDed+CE3ei3qMNo9S1JK2EcFGp
 Y8t7Y+T1vPcBi2gS7OZVoy9dR4KQ3R3M0UZR/okcL0nnsFCikGzFZTGXqe+GywEF4n02fsl8Jdz
 SHZyKFA8OTmWjduu7o+HGQdr+SY8cT8Sb7f6X9pNPxiogdpQ4WrD4RZUTccsPFe9ckwr7Tm0NVT
 AGNQQmq0qJSKHjgViJ1FklBxJkp2k1VulSK6bENnR4bN0PHO+vZwrwzCRccJd4BCp1A+mKEjvBy
 DXfB9UA7sbymPtzIRqJLKQQT8C80skHOhrO987rjSHn5nrq/nVAUMLFFmGgiKOelGdRmClWyFEL
 AYb6/0BVCHB8b+Lx0Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601040113

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
   * Passing neither of the above means we only want a split.
   * Modify all callers to enforce the above semantics.

 * Use ext4_split_convert_extents() instead of ext4_split_extents()
 * in ext4_ext_convert_to_initialized() for uniformity.

 * Cleanup all callers open coding the conversion logic.
 * Further, modify kuniy tests to pass flags based on the new semantics.

From an end user point of view, we should not see any changes in
behavior of ext4.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents-test.c |  12 +-
 fs/ext4/extents.c      | 299 +++++++++++++++++++----------------------
 2 files changed, 145 insertions(+), 166 deletions(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 54aed3eabfe2..725d5e79be96 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -567,7 +567,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	/* unwrit to unwrit splits */
 	{ .desc = "split unwrit extent to 2 unwrit extents",
 	  .is_unwrit_at_start = 1,
-	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
+	  .split_flags = 0,
 	  .split_map = { .m_lblk = 10, .m_len = 1 },
 	  .nr_exp_ext = 2,
 	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
@@ -575,7 +575,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	  .is_zeroout_test = 0 },
 	{ .desc = "split unwrit extent to 2 extents (2)",
 	  .is_unwrit_at_start = 1,
-	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
+	  .split_flags = 0,
 	  .split_map = { .m_lblk = 11, .m_len = 2 },
 	  .nr_exp_ext = 2,
 	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
@@ -583,7 +583,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	  .is_zeroout_test = 0 },
 	{ .desc = "split unwrit extent to 3 unwrit extents",
 	  .is_unwrit_at_start = 1,
-	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
+	  .split_flags = 0,
 	  .split_map = { .m_lblk = 11, .m_len = 1 },
 	  .nr_exp_ext = 3,
 	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
@@ -660,7 +660,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	/* unwrit to unwrit splits */
 	{ .desc = "split unwrit extent to 2 unwrit extents (zeroout)",
 	  .is_unwrit_at_start = 1,
-	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
+	  .split_flags = 0,
 	  .split_map = { .m_lblk = 10, .m_len = 1 },
 	  .nr_exp_ext = 1,
 	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
@@ -669,7 +669,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 3 } } },
 	{ .desc = "split unwrit extent to 2 unwrit extents (2) (zeroout)",
 	  .is_unwrit_at_start = 1,
-	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
+	  .split_flags = 0,
 	  .split_map = { .m_lblk = 11, .m_len = 2 },
 	  .nr_exp_ext = 1,
 	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
@@ -678,7 +678,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 3 } } },
 	{ .desc = "split unwrit extent to 3 unwrit extents (zeroout)",
 	  .is_unwrit_at_start = 1,
-	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
+	  .split_flags = 0,
 	  .split_map = { .m_lblk = 11, .m_len = 1 },
 	  .nr_exp_ext = 1,
 	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8082e1d93bbf..9fb8a3220ae2 100644
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
@@ -3174,17 +3171,11 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
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
@@ -3193,14 +3184,14 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
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
@@ -3214,39 +3205,24 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
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
@@ -3261,7 +3237,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	ex2->ee_block = cpu_to_le32(split);
 	ex2->ee_len   = cpu_to_le16(ee_len - (split - ee_block));
 	ext4_ext_store_pblock(ex2, newblock);
-	if (split_flag & EXT4_EXT_MARK_UNWRIT2)
+	if (is_unwrit)
 		ext4_ext_mark_unwritten(ex2);
 
 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
@@ -3384,16 +3360,11 @@ ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
 		if (err)
 			/* ZEROOUT failed, just return original error */
 			return ERR_PTR(err);
-	} else if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
+	} else {
 		/*
-		 * EXT4_GET_BLOCKS_UNWRIT_EXT: Today, this flag
-		 * implicitly implies that callers when wanting an
-		 * unwritten to unwritten split. So zeroout the whole
-		 * extent.
-		 *
-		 * TODO: The implicit meaning of the flag is not ideal
-		 * and eventually we should aim for a more well defined
-		 * behavior
+		 * None of the convert flags imply we just want a split.
+		 * In this case we can only zeroout if an unwritten split
+		 * was needed.
 		 */
 
 		if (!is_unwrit)
@@ -3415,7 +3386,7 @@ ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
 
 	ext4_ext_mark_initialized(ex);
 
-	ext4_ext_dirty(handle, inode, path + path->p_depth);
+	ext4_ext_dirty(handle, inode, path + depth);
 	if (err)
 		return ERR_PTR(err);
 
@@ -3438,13 +3409,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
+	int flags1 = 0;
 	int err = 0, orig_err;
 
 	depth = ext_depth(inode);
@@ -3462,11 +3433,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 
 	if (map->m_lblk + map->m_len < ee_block + ee_len) {
 		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
-		if (unwritten)
-			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
-				       EXT4_EXT_MARK_UNWRIT2;
+
 		path = ext4_split_extent_at(handle, inode, path,
-				map->m_lblk + map->m_len, split_flag1, flags1);
+					    map->m_lblk + map->m_len, flags1);
 
 		if (IS_ERR(path)) {
 			orig_err = PTR_ERR(path);
@@ -3494,13 +3463,8 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
 
 		if (IS_ERR(path)) {
 			orig_err = PTR_ERR(path);
@@ -3546,6 +3510,11 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 		 */
 		if (ext4_split_extent_zeroout(handle, inode, path, map, flags))
 			return ERR_PTR(orig_err);
+
+		/* zeroout succeeded */
+		if (did_zeroout)
+			*did_zeroout = true;
+		goto out;
 	}
 
 	/* There's an error and we can't zeroout, just return the err */
@@ -3596,7 +3565,6 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
 	int err = 0;
-	int split_flag = 0;
 	unsigned int max_zeroout = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
@@ -3748,9 +3716,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	 * It is safe to convert extent to initialized via explicit
 	 * zeroout only if extent is fully inside i_size or new_size.
 	 */
-	split_flag |= ee_block + ee_len <= eof_block ? EXT4_EXT_MAY_ZEROOUT : 0;
-
-	if (EXT4_EXT_MAY_ZEROOUT & split_flag)
+	if (ee_block + ee_len <= eof_block)
 		max_zeroout = sbi->s_extent_max_zeroout_kb >>
 			(inode->i_sb->s_blocksize_bits - 10);
 
@@ -3805,8 +3771,8 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	}
 
 fallback:
-	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
-				 flags, NULL);
+	path = ext4_split_convert_extents(handle, inode, &split_map, path,
+					  flags | EXT4_GET_BLOCKS_CONVERT, NULL);
 	if (IS_ERR(path))
 		return path;
 out:
@@ -3820,6 +3786,26 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	return ERR_PTR(err);
 }
 
+static bool ext4_ext_needs_conv(struct inode *inode, struct ext4_ext_path *path,
+				int flags)
+{
+	struct ext4_extent *ex;
+	bool is_unwrit;
+	int depth;
+
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+	is_unwrit = ext4_ext_is_unwritten(ex);
+
+	if (is_unwrit && (flags & EXT4_GET_BLOCKS_CONVERT))
+		return true;
+
+	if (!is_unwrit && (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
+		return true;
+
+	return false;
+}
+
 /*
  * This function is called by ext4_ext_map_blocks() from
  * ext4_get_blocks_dio_write() when DIO to write
@@ -3856,7 +3842,9 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	ext4_lblk_t ee_block;
 	struct ext4_extent *ex;
 	unsigned int ee_len;
-	int split_flag = 0, depth;
+	int split_flag = 0, depth, err = 0;
+	bool did_zeroout = false;
+	bool needs_conv = ext4_ext_needs_conv(inode, path, flags);
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len);
@@ -3870,19 +3858,81 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	ee_block = le32_to_cpu(ex->ee_block);
 	ee_len = ext4_ext_get_actual_len(ex);
 
-	if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
-			    EXT4_GET_BLOCKS_CONVERT)) {
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
+		split_flag |= ee_block + ee_len <= eof_block ?
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
+
+convert:
+	/*
+	 * We don't need a conversion if:
+	 * 1. There was an error in split.
+	 * 2. We split via zeroout.
+	 * 3. None of the convert flags were passed.
+	 */
+	if (IS_ERR(path) || did_zeroout || !needs_conv)
+		return path;
+
+	path = ext4_find_extent(inode, map->m_lblk, path, flags);
+	if (IS_ERR(path))
+		return path;
+
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+
+	err = ext4_ext_get_access(handle, inode, path + depth);
+	if (err)
+		goto err;
+
+	if (flags & EXT4_GET_BLOCKS_CONVERT)
+		ext4_ext_mark_initialized(ex);
+	else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)
+		ext4_ext_mark_unwritten(ex);
+
+	if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
 		/*
-		 * It is safe to convert extent to initialized via explicit
-		 * zeroout only if extent is fully inside i_size or new_size.
+		 * note: ext4_ext_correct_indexes() isn't needed here because
+		 * borders are not changed
 		 */
-		split_flag |= ee_block + ee_len <= eof_block ?
-			      EXT4_EXT_MAY_ZEROOUT : 0;
-		split_flag |= EXT4_EXT_MARK_UNWRIT2;
+		ext4_ext_try_to_merge(handle, inode, path, ex);
+
+	err = ext4_ext_dirty(handle, inode, path + depth);
+	if (err)
+		goto err;
+
+	/* Lets update the extent status tree after conversion */
+	ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
+			      ext4_ext_get_actual_len(ex), ext4_ext_pblock(ex),
+			      ext4_ext_is_unwritten(ex) ?
+				      EXTENT_STATUS_UNWRITTEN :
+				      EXTENT_STATUS_WRITTEN,
+			      false);
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
@@ -3894,7 +3944,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
 	int depth;
-	int err = 0;
 
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3904,41 +3953,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)ee_block, ee_len);
 
-	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		path = ext4_split_convert_extents(handle, inode, map, path,
-						  flags, NULL);
-		if (IS_ERR(path))
-			return path;
-
-		path = ext4_find_extent(inode, map->m_lblk, path, 0);
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
@@ -3952,7 +3968,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
 	int depth;
-	int err = 0;
 
 	/*
 	 * Make sure that the extent is no bigger than we support with
@@ -3969,40 +3984,12 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)ee_block, ee_len);
 
-	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		path = ext4_split_convert_extents(handle, inode, map, path,
-				flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
-		if (IS_ERR(path))
-			return path;
-
-		path = ext4_find_extent(inode, map->m_lblk, path, 0);
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
+	path = ext4_split_convert_extents(
+		handle, inode, map, path,
+		flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
+	if (IS_ERR(path))
+		return path;
 
-	/* Mark modified extent as dirty */
-	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-	if (err)
-		goto errout;
 	ext4_ext_show_leaf(inode, path);
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
@@ -4012,10 +3999,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 		*allocated = map->m_len;
 	map->m_len = *allocated;
 	return path;
-
-errout:
-	ext4_free_ext_path(path);
-	return ERR_PTR(err);
 }
 
 static struct ext4_ext_path *
@@ -5649,7 +5632,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	struct ext4_extent *extent;
 	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
 	unsigned int credits, ee_len;
-	int ret, depth, split_flag = 0;
+	int ret, depth;
 	loff_t start;
 
 	trace_ext4_insert_range(inode, offset, len);
@@ -5720,12 +5703,8 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
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
2.51.0


