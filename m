Return-Path: <linux-ext4+bounces-13262-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOTbJucUc2l3sAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13262-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:27:51 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE98D70F7B
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66BDC3029A62
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 06:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650831A571;
	Fri, 23 Jan 2026 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EXvAIOtg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E139C648;
	Fri, 23 Jan 2026 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149591; cv=none; b=FncpW/q38tFkW/OXDwVqLITWjeQWr6KD5mkl4o4oCoFdLzApr2vPl/L8q7n1bAGj0awZAj9kUhbSXrHsd1kDpkbm0+NY0OghBROSIUK2hf2f8uFatUmc1gn/SMBQLu2f0CrghSEOAl3WyuM+VmmwttItjtCfbXWT67FBsmFxWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149591; c=relaxed/simple;
	bh=49iU/pDPPN8/COZt8J+i2YNnaeo0Z4Ei0LNoJUcL9iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJWYJqLXIrwuGvPtuVYV1Pv8HrpEZJbDIxzmXZMUOd8UKqK3KfCnLHcjbwiDEBPVo5rHoln8ec6VxyP+qNXX4iF1Bk/K2967ZLFXQZcm7rQs+pFhxy+DtoO8iZUlwI741WwLQCHr2DXljO3iLyHWCjMsl99kwgSOpCJFqTkHZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EXvAIOtg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N1M0ku007709;
	Fri, 23 Jan 2026 06:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/CSwR1Won6R5+4Ws+
	177w8lPd87qTn/1kGQhFAYBblA=; b=EXvAIOtgUlgAbO0i8FsAX33dVzUZ5qeKF
	9D+DeZTUUOwvirxgbSy/Pp7w0MEP7HysP7xMJRinUlae5fMujx4o3sIsgV0oOaZB
	mrFl5emsO3WHKua/K4Gkaz7jjrzySMymqZmWX9BgzEXD6u19cCQLP5tx22BtHT1t
	IayvusRXB2miP9CrzwJ/yhbKBfaDr0CgudeGaAqTM+Mcxf0OpJr9ZwCUrbHDVLML
	ara1AbWLPxS1po7xxOZGaJohpOIImjrW4zqO7WCZLE3Se6UkJT/V7Jv6hkhJFxcX
	6c1cEpzuxKhAKz8eHBtWX1R96pQEheje+HmP+6lenTE8muHQbUM7Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukmuw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:26:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N6PFYI023420;
	Fri, 23 Jan 2026 06:26:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukmuvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:26:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N4SaKL001168;
	Fri, 23 Jan 2026 06:26:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyk7a4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:26:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N6Pwhs23200074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 06:25:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C40A2004F;
	Fri, 23 Jan 2026 06:25:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B170C20040;
	Fri, 23 Jan 2026 06:25:56 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 06:25:56 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] ext4: Refactor split and convert extents
Date: Fri, 23 Jan 2026 11:55:38 +0530
Message-ID: <2084a383d69ceefbaa293b8fcf725365eca0a349.1769149131.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769149131.git.ojaswin@linux.ibm.com>
References: <cover.1769149131.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA0NiBTYWx0ZWRfX09u63YW+d/3n
 7LzDCG5Tu8WlKzfpwjr0C8pK2yMYJqHJHUjmGVqBVTjOV36co6jLMX/Z9DzVJzThVJXSXYpkrLO
 Ie4YvPcUZ7ODlYqYd/QPv0zCQzwJKfLf+WPHD8cCZYgj6B1E58hvAYRx5N6knLKIEWNsNusM9T5
 8fiTA/eGdz01KY4bCTtuJ8ZzRnCVaEVkWvtfDJJMQPMxBZDbhcFnMQf5rXCzJkdKATa8RZ9hral
 RLUFsJKara0tX0TZwsa6L8afMX6yAtz5VLZB02+MNvgpieFJ4+FVj/FJ2lg3ErklK5nsb2PIHYK
 eSDPLwuTt9Sjrazk1kP43vAilxjDfe3v8IWltxQTmQfQP8Ddu+0ERb6vR0Q8rCud9qGsIqBZChg
 O+ttDIFDsnFl8MVmzSd5ddYqh2B4c1udDChbtgKbLOFTs0rNuWnVU/bnv9p+5iWhCcmnMohdKRl
 1fJvzKBS+7s4xQaaJ0w==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=69731479 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=Roo43mxO8Zpiw3MSSV4A:9
X-Proofpoint-ORIG-GUID: SaKOvfM7Nq7_dmEuXp1FksnY2YMft2XZ
X-Proofpoint-GUID: THjvxXPkZ9PwhBtCxLJItwEkak6Vu1Bp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13262-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,suse.cz,vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,suse.cz:email,linux.ibm.com:mid]
X-Rspamd-Queue-Id: DE98D70F7B
X-Rspamd-Action: no action

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

>From an end user point of view, we should not see any changes in
behavior of ext4.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 277 +++++++++++++++++++---------------------------
 1 file changed, 112 insertions(+), 165 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8d709bfd299b..14f38b3cda27 100644
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
@@ -3169,17 +3166,11 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
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
@@ -3188,14 +3179,14 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
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
@@ -3209,39 +3200,24 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
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
@@ -3256,7 +3232,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	ex2->ee_block = cpu_to_le32(split);
 	ex2->ee_len   = cpu_to_le16(ee_len - (split - ee_block));
 	ext4_ext_store_pblock(ex2, newblock);
-	if (split_flag & EXT4_EXT_MARK_UNWRIT2)
+	if (is_unwrit)
 		ext4_ext_mark_unwritten(ex2);
 
 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
@@ -3389,20 +3365,10 @@ static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
 
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
 
@@ -3422,15 +3388,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
 	int orig_err = 0;
-	int orig_flags = flags;
 
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3446,12 +3410,8 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
 
@@ -3479,13 +3439,8 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
@@ -3522,9 +3477,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 		    unwritten != orig_unwritten))
 		goto out_free_path;
 
-	if (ext4_split_extent_zeroout(handle, inode, path, map, orig_flags))
+	if (ext4_split_extent_zeroout(handle, inode, path, map, flags))
 		goto out_free_path;
 
+	/* zeroout succeeded */
+	if (did_zeroout)
+		*did_zeroout = true;
+
 success:
 	if (allocated) {
 		if (map->m_lblk + map->m_len > ee_block + ee_len)
@@ -3575,7 +3534,6 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
 	int err = 0;
-	int split_flag = 0;
 	unsigned int max_zeroout = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
@@ -3727,9 +3685,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	 * It is safe to convert extent to initialized via explicit
 	 * zeroout only if extent is fully inside i_size or new_size.
 	 */
-	split_flag |= ee_block + ee_len <= eof_block ? EXT4_EXT_MAY_ZEROOUT : 0;
-
-	if (EXT4_EXT_MAY_ZEROOUT & split_flag)
+	if (ee_block + ee_len <= eof_block)
 		max_zeroout = sbi->s_extent_max_zeroout_kb >>
 			(inode->i_sb->s_blocksize_bits - 10);
 
@@ -3784,8 +3740,8 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	}
 
 fallback:
-	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
-				 flags | EXT4_GET_BLOCKS_CONVERT, NULL);
+	path = ext4_split_convert_extents(handle, inode, &split_map, path,
+					  flags | EXT4_GET_BLOCKS_CONVERT, NULL);
 	if (IS_ERR(path))
 		return path;
 out:
@@ -3835,7 +3791,8 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	ext4_lblk_t ee_block;
 	struct ext4_extent *ex;
 	unsigned int ee_len;
-	int split_flag = 0, depth;
+	int split_flag = 0, depth, err = 0;
+	bool did_zeroout = false;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len);
@@ -3849,19 +3806,81 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
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
@@ -3873,7 +3892,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
 	int depth;
-	int err = 0;
 
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3883,41 +3901,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
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
@@ -3931,7 +3916,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
 	int depth;
-	int err = 0;
 
 	/*
 	 * Make sure that the extent is no bigger than we support with
@@ -3948,40 +3932,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
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
@@ -3991,10 +3946,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 		*allocated = map->m_len;
 	map->m_len = *allocated;
 	return path;
-
-errout:
-	ext4_free_ext_path(path);
-	return ERR_PTR(err);
 }
 
 static struct ext4_ext_path *
@@ -5629,7 +5580,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	struct ext4_extent *extent;
 	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
 	unsigned int credits, ee_len;
-	int ret, depth, split_flag = 0;
+	int ret, depth;
 	loff_t start;
 
 	trace_ext4_insert_range(inode, offset, len);
@@ -5700,12 +5651,8 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
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


