Return-Path: <linux-ext4+bounces-12553-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFDDCF0E7E
	for <lists+linux-ext4@lfdr.de>; Sun, 04 Jan 2026 13:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 470E7303A3BD
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Jan 2026 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3B2C11FE;
	Sun,  4 Jan 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oUJ/7ubV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1502C11CB;
	Sun,  4 Jan 2026 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529195; cv=none; b=ssor+laP+5mBGyd+r1Vukn81oYIoR44RFs8LsQXUJvVOLV3m5/Ot0Qulm9pmVbOif4SGvzXOjdfgP0ArNjtNJAvgsZhGUz3xv/NZmrjSpnNV2EJ4qSoyvJ56uVIZm+AwCtBtelh6Wei0Pex2fsNUR9fxyzy/O3vhITaxj8WVX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529195; c=relaxed/simple;
	bh=Vulze1vMc+tESBFZpH/5XzM2AG1BKG9F+7GDaQYaJ0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/ElOthsndai0Ta2n9BSDPx4hH1SigTv95nOJwvMnUGvNZz02nFvMg6IiYTXzBaVIC0RN3beI95+q8l5NSA8xgS1+vbzq/WF/4T1o/A6Pna5liXIvi+vYSF+glnFLYPKkP/6zc+ONFCGl7EuwBUIyNh8f5CzjV+Ee1i+4fIjudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oUJ/7ubV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604AQ64P022476;
	Sun, 4 Jan 2026 12:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nXXr14/OlUPzMIO3/
	twUP670NEGFv3NawPrdsMqIcCg=; b=oUJ/7ubVw1oy79KtG8zpJwxJtNvXynZK0
	L2Yxj7m+syrEsPHhB7UhOSl0mGnxlCicVeceCcUQXORn3b9b8Vg055+4FgDxHYbs
	JyTRseQlOslFvCDiWCsrVo7SeS53ypRDH5fysQZ0WOomG/28QDeelfKeG55nPe//
	fENZQsmFha0AQw4UPrggxtWv0cLg5GdcTPLf/mNbJbY/3toVa1HuTtuh5SmSU5X0
	xmkqZO3gFWHSOaOcaZlmRUSaciFd63hzUGettuxe+elsr8rdtGY+nC03Bj8BVQMx
	ZAOTXoeDdmz2QnXVArstQpHw/7cC/ToX87bXqoNFrSlDMTEUNb8sQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtb7jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 604CJhVK023169;
	Sun, 4 Jan 2026 12:19:43 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtb7jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6046hklV015656;
	Sun, 4 Jan 2026 12:19:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdes1kxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604CJeDT54984962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 12:19:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F0D20043;
	Sun,  4 Jan 2026 12:19:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E6E420040;
	Sun,  4 Jan 2026 12:19:38 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 12:19:38 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] ext4: Allow zeroout when doing written to unwritten split
Date: Sun,  4 Jan 2026 17:49:20 +0530
Message-ID: <bd83af6cd845ac1567900f84c754fc2c0ffd40b3.1767528171.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695a5adf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=EvvdACev9lTnxgf03zoA:9
X-Proofpoint-GUID: 6IF7psMpwyTXjdU60xxWuuBdJEerm7Mv
X-Proofpoint-ORIG-GUID: c8VILyWO0upZDXtxHExclfcVs6ykHxrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDExMyBTYWx0ZWRfX/t/b6IDttd0E
 ChvthEcteIdgW8J2cCe9oCtpfllHUwzSjSQtdf1SZxsPq6W0k560TkAIbhjC9rkj1MuyIr5enqH
 VoMzW12VoIZ8HxKGPviEmPBUGYYDG1MWl6W5/9Au9GMkMLEHmlHXjCxYRqiyEXcUYmeHtNAjYJH
 1hnuPYpRPnptJwuZxZiGmRoxh+KryCI0c+JP0n5HKeyjZEfIZN6CBwSmWQ8HXkjID3xEnPqF2Uz
 0qHOVtNd/2OwwG47q567XFWLCIpeW+9scgnjDTtxn8L3HYq1zqhZSe+asmpAuGRrTGBw6VrPrCY
 QYC/3YBY0Vy+NrrTR0yVVPc3LJ1M7dYGxrif/GYvPO56bnIXqxkXooe6mSK3m7WvmWmZCXZFyu8
 C14PzXZLgSgBvieRbWfDPo3Mo/mUSRck2OQs/AVMCM9XIm+1LgTG9Ay25qoPqMNBxK3j5voWczo
 5Qa06a5ysjTHxjqp6Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040113

Currently, when we are doing an extent split and convert operation of
written to unwritten extent (example, as done by ZERO_RANGE), we don't
allow the zeroout fallback in case the extent tree manipulation fails.
This is mostly because zeroout might take unsually long and the fact that
this code path is more tolerant to failures than endio.

Since we have zeroout machinery in place, we might as well use it hence
lift this restriction. To mitigate zeroout taking too long respect the
max zeroout limit here so that the operation finishes relatively fast.

Also, add kunit tests for this case.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents-test.c | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/extents.c      | 23 +++++++++++++++--------
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 725d5e79be96..3b5274297fe9 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -685,6 +685,39 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	  .is_zeroout_test = 1,
 	  .nr_exp_data_segs = 1,
 	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 3 } } },
+
+	/* writ to unwrit splits */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = 10, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 }}},
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit (zeroout)",
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = 11, .m_len = 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
+	{ .desc = "split writ extent to 3 extents and convert 2nd half unwrit (zeroout)",
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = 11, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0, .off_blk = 1, .len_blk = 1 },
+			      { .exp_char = 'X', .off_blk = 2, .len_blk = 1 }}},
 };
 
 static const struct kunit_ext_test_param
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9fb8a3220ae2..95dd88df8fe4 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3485,7 +3485,19 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	 * to initialize as a last resort
 	 */
 	if (split_flag & EXT4_EXT_MAY_ZEROOUT) {
-		path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
+		int max_zeroout_blks =
+			EXT4_SB(inode->i_sb)->s_extent_max_zeroout_kb >>
+			(inode->i_sb->s_blocksize_bits - 10);
+		if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN &&
+		    map->m_len > max_zeroout_blks)
+			/*
+			 * Written to unwritten extent is not a critical path so
+			 * lets respect the max zeroout
+			 */
+			return ERR_PTR(orig_err);
+
+		path = ext4_find_extent(inode, map->m_lblk, NULL,
+						flags);
 		if (IS_ERR(path))
 			return path;
 
@@ -3863,15 +3875,10 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 		goto convert;
 
 	/*
-	 * We don't use zeroout fallback for written to unwritten conversion as
-	 * it is not as critical as endio and it might take unusually long.
-	 * Also, it is only safe to convert extent to initialized via explicit
+	 * It is only safe to convert extent to initialized via explicit
 	 * zeroout only if extent is fully inside i_size or new_size.
 	 */
-	if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
-		split_flag |= ee_block + ee_len <= eof_block ?
-				      EXT4_EXT_MAY_ZEROOUT :
-				      0;
+	split_flag |= ee_block + ee_len <= eof_block ? EXT4_EXT_MAY_ZEROOUT : 0;
 
 	/*
 	 * pass SPLIT_NOMERGE explicitly so we don't end up merging extents we
-- 
2.51.0


