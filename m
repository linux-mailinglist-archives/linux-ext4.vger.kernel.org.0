Return-Path: <linux-ext4+bounces-12549-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB9CF0E66
	for <lists+linux-ext4@lfdr.de>; Sun, 04 Jan 2026 13:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 236AF3012CD7
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Jan 2026 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54782C0F79;
	Sun,  4 Jan 2026 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bYcCSVAp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568A298CC0;
	Sun,  4 Jan 2026 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529185; cv=none; b=SeWaVo/vK7DkOhER1wuw8c2+bbIAlqHRNcjS56WeIXBlHnHOAlndk8tqUTkF1pgslbtXci3Z4L8H5SVVfhgII/189rQ8bxxZLahPsvt5rIpKL5F0ba+8dmVCAQlzcL8fxm5xA/812SjdJklBIL9iwGjEpR2rvHajwbXaKNjly/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529185; c=relaxed/simple;
	bh=SrXfZRmWshWJYK4edRSYSu8lWguZ+V2ojeo16vQJaGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeAJ53T9FRp9zsQv7taiLRiy/3NGQ65Jui0s6+bgcyYS9HhsyssATaesk04tQfqSA7NKPK/sniTBJvbM+NvD/YLjMmO+wIvdd+qWTddBj+avskKQiiCu3cYnDP4F1T2ITsGkqR/l4VIrUj4h3GFli/jyYG5xFa0H+7jqQFZB+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bYcCSVAp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6046oag6000524;
	Sun, 4 Jan 2026 12:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UtAYpgqgo2p60Xakg
	HErtCk52XWyl7Mcy0L0JbPECHM=; b=bYcCSVApM0qxXQm7CmRsoRS+iZ/OrTRwe
	98KFUyLAdE82S67riOjUARjN9auFR0++gBURIdhbVIQjavpoU4R2O4JQEx4JWaBS
	CialVWJi3CL3BkBetvTrEBNnU1VVEgU80VoJN3pI8b31tLz4T3EbJtrorWNd5ocA
	tBaP7qTjHszI1De7cuNMHr/Fwmy7f4kKKJSpLB5goHXiY9AW6OM7nyl8Ipw7wGFq
	yrp1dddvrCHzwpauGvFNHM2JKk8lim8xoTlz7tOUi1MpzH6INFg+Zw7RmxZW7h+n
	OLRitcG1xchgevNFckyJlWp9No4D/xE1PrP20q4e7h4/YnL3sDi0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshekbre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 604CJUaw008450;
	Sun, 4 Jan 2026 12:19:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshekbrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60481hSe014503;
	Sun, 4 Jan 2026 12:19:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeemhess-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604CJSV454264152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 12:19:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D9120043;
	Sun,  4 Jan 2026 12:19:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55E0F20040;
	Sun,  4 Jan 2026 12:19:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 12:19:26 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ext4: kunit tests for higher level extent manipulation functions
Date: Sun,  4 Jan 2026 17:49:15 +0530
Message-ID: <0182586e50e4332375d0db77f31c596536a94f2e.1767528171.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDExMyBTYWx0ZWRfXxCaO6v1o972z
 qU9r2+ujQHsF+iG3rqJcl506eanU07cLB2QYps+b180CGML8P0NxMGvIFGqwA4J1IUWVcDTf/vk
 sGzv2U+jeI/EVFemaqXyVPKp9SEMQ69FKKcyUwhNnHOc/BPJkvQQVF5JTv3CFgtqeqAbwtvqw64
 vIv8ejHFird66plGMdU07wWeIaNsPZMqxzLtwOW/TFia/hGJcXjbbU/0aox3o8giCaMNiPq+qxG
 c71KxhAcgGoBBGZXCSHq5jUf3J5VOTZ9f51UZy5rYKJCWdey9yTnMpmG5vQVHQkxYuFUhE637BW
 +WVSTZXviyNMlUu9/eE2fWuCzASkAtDwZhuZHpGyf0BrV42lPMtiAdCHgUFbOPz09aNzo6EZIMS
 P/eYPzHf8Vzqz4VWoST+xgiYQ0me3C6nJ1Kx1TPpRNiKzSiGGR7BkeZNYj84vUqqtpw53AD7uZx
 VoRSYNUtaJC+hGinVqA==
X-Proofpoint-GUID: s1Agf7W41WNs1jUeyMBgi2CcDyJQHCuz
X-Proofpoint-ORIG-GUID: FnzyVH3BjYDCrbfMF4ylDGeIvEikyeKK
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695a5ad3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=7WsZmUPGbgfodfxRVaIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040113

Add more kunit tests to cover all high level callers of
ext4_split_convert_extents(). The main functions we cover are:

1. ext4_ext_handle_unwritten_extents()
  1.1 - Split/Convert unwritten extent to written in endio convtext.
  1.2 - Split/Convert unwritten extent to written in non endio context.
2. convert_initialized_extent() - Convert written extent to unwritten
   during zero range

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents-test.c | 275 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 937810a0f264..4fb94d3c8a1e 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -90,6 +90,9 @@ struct kunit_ext_test_param {
 	/* map describing range to split */
 	struct ext4_map_blocks split_map;
 
+	/* disable zeroout */
+	bool disable_zeroout;
+
 	/* no of extents expected after split */
 	int nr_exp_ext;
 
@@ -131,6 +134,9 @@ static struct file_system_type ext_fs_type = {
 
 static void extents_kunit_exit(struct kunit *test)
 {
+	struct ext4_sb_info *sbi = k_ctx.k_ei->vfs_inode.i_sb->s_fs_info;
+
+	kfree(sbi);
 	kfree(k_ctx.k_ei);
 	kfree(k_ctx.k_data);
 }
@@ -220,6 +226,7 @@ static int extents_kunit_init(struct kunit *test)
 	struct ext4_inode_info *ei;
 	struct inode *inode;
 	struct super_block *sb;
+	struct ext4_sb_info *sbi = NULL;
 	struct kunit_ext_test_param *param =
 		(struct kunit_ext_test_param *)(test->param_value);
 
@@ -237,7 +244,18 @@ static int extents_kunit_init(struct kunit *test)
 	sb->s_blocksize = 4096;
 	sb->s_blocksize_bits = 12;
 
-	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10) << sb->s_blocksize_bits;
+	sbi = kzalloc(sizeof(struct ext4_sb_info), GFP_KERNEL);
+	if (sbi == NULL)
+		return -ENOMEM;
+
+	sbi->s_sb = sb;
+	sb->s_fs_info = sbi;
+
+	if (!param || !param->disable_zeroout)
+		sbi->s_extent_max_zeroout_kb = 32;
+
+	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10)
+			 << sb->s_blocksize_bits;
 	inode->i_sb = sb;
 
 	k_ctx.k_data = kzalloc(EX_DATA_LEN * 4096, GFP_KERNEL);
@@ -279,6 +297,8 @@ static int extents_kunit_init(struct kunit *test)
 				   ext4_es_remove_extent_stub);
 	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
 	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
+	kunit_activate_static_stub(test, ext4_issue_zeroout,
+				   ext4_issue_zeroout_stub);
 	kunit_activate_static_stub(test, ext4_issue_zeroout,
 				   ext4_issue_zeroout_stub);
 	return 0;
@@ -372,6 +392,150 @@ static void test_split_convert(struct kunit *test)
 	return;
 }
 
+static void test_convert_initialized(struct kunit *test)
+{
+	struct ext4_ext_path *path;
+	struct inode *inode = &k_ctx.k_ei->vfs_inode;
+	struct ext4_extent *ex;
+	struct ext4_map_blocks map;
+	const struct kunit_ext_test_param *param =
+		(const struct kunit_ext_test_param *)(test->param_value);
+	int blkbits = inode->i_sb->s_blocksize_bits;
+	int allocated = 0;
+
+	if (param->is_zeroout_test)
+		/*
+		 * Force zeroout by making ext4_ext_insert_extent return ENOSPC
+		 */
+		kunit_activate_static_stub(test, ext4_ext_insert_extent,
+					   ext4_ext_insert_extent_stub);
+
+	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
+	ex = path->p_ext;
+	KUNIT_EXPECT_EQ(test, 10, ex->ee_block);
+	KUNIT_EXPECT_EQ(test, 3, ext4_ext_get_actual_len(ex));
+	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start, ext4_ext_is_unwritten(ex));
+	if (param->is_zeroout_test)
+		KUNIT_EXPECT_EQ(test, 0,
+				check_buffer(k_ctx.k_data, 'X',
+					     EX_DATA_LEN << blkbits));
+
+	map.m_lblk = param->split_map.m_lblk;
+	map.m_len = param->split_map.m_len;
+	convert_initialized_extent(NULL, inode, &map, path, &allocated);
+
+	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
+	ex = path->p_ext;
+
+	for (int i = 0; i < param->nr_exp_ext; i++) {
+		struct kunit_ext_state exp_ext = param->exp_ext_state[i];
+
+		KUNIT_EXPECT_EQ(test, exp_ext.ex_lblk, ex->ee_block);
+		KUNIT_EXPECT_EQ(test, exp_ext.ex_len, ext4_ext_get_actual_len(ex));
+		KUNIT_EXPECT_EQ_MSG(
+			test, exp_ext.is_unwrit, ext4_ext_is_unwritten(ex),
+			"# exp: lblk:%d len:%d unwrit:%d, got: lblk:%d len:%d unwrit:%d\n",
+			exp_ext.ex_lblk, exp_ext.ex_len, exp_ext.is_unwrit,
+			ex->ee_block, ext4_ext_get_actual_len(ex), ext4_ext_is_unwritten(ex));
+
+		ex = ex + 1;
+	}
+
+	if (!param->is_zeroout_test)
+		return;
+
+	/*
+	 * Check that then data area has been zeroed out correctly
+	 */
+	for (int i = 0; i < param->nr_exp_data_segs; i++) {
+		loff_t off, len;
+		struct kunit_ext_data_state exp_data_seg = param->exp_data_state[i];
+
+		off = exp_data_seg.off_blk << blkbits;
+		len = exp_data_seg.len_blk << blkbits;
+		KUNIT_EXPECT_EQ_MSG(test, 0,
+				    check_buffer(k_ctx.k_data + off,
+						 exp_data_seg.exp_char, len),
+				    "# corruption in byte range [%lld, %lld)",
+				    off, len);
+	}
+
+	return;
+}
+
+static void test_handle_unwritten(struct kunit *test)
+{
+	struct ext4_ext_path *path;
+	struct inode *inode = &k_ctx.k_ei->vfs_inode;
+	struct ext4_extent *ex;
+	struct ext4_map_blocks map;
+	const struct kunit_ext_test_param *param =
+		(const struct kunit_ext_test_param *)(test->param_value);
+	int blkbits = inode->i_sb->s_blocksize_bits;
+	int allocated = 0;
+	ext4_fsblk_t dummy_pblk = 999;
+
+	if (param->is_zeroout_test)
+		/*
+		 * Force zeroout by making ext4_ext_insert_extent return ENOSPC
+		 */
+		kunit_activate_static_stub(test, ext4_ext_insert_extent,
+					   ext4_ext_insert_extent_stub);
+
+	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
+	ex = path->p_ext;
+	KUNIT_EXPECT_EQ(test, 10, ex->ee_block);
+	KUNIT_EXPECT_EQ(test, 3, ext4_ext_get_actual_len(ex));
+	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start, ext4_ext_is_unwritten(ex));
+	if (param->is_zeroout_test)
+		KUNIT_EXPECT_EQ(test, 0,
+				check_buffer(k_ctx.k_data, 'X',
+					     EX_DATA_LEN << blkbits));
+
+	map.m_lblk = param->split_map.m_lblk;
+	map.m_len = param->split_map.m_len;
+	ext4_ext_handle_unwritten_extents(NULL, inode, &map, path, param->split_flags,
+					  &allocated, dummy_pblk);
+
+	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
+	ex = path->p_ext;
+
+	for (int i = 0; i < param->nr_exp_ext; i++) {
+		struct kunit_ext_state exp_ext = param->exp_ext_state[i];
+
+		KUNIT_EXPECT_EQ(test, exp_ext.ex_lblk, ex->ee_block);
+		KUNIT_EXPECT_EQ(test, exp_ext.ex_len, ext4_ext_get_actual_len(ex));
+		KUNIT_EXPECT_EQ_MSG(
+			test, exp_ext.is_unwrit, ext4_ext_is_unwritten(ex),
+			"# exp: lblk:%d len:%d unwrit:%d, got: lblk:%d len:%d unwrit:%d\n",
+			exp_ext.ex_lblk, exp_ext.ex_len, exp_ext.is_unwrit,
+			ex->ee_block, ext4_ext_get_actual_len(ex), ext4_ext_is_unwritten(ex));
+
+		ex = ex + 1;
+	}
+
+	if (!param->is_zeroout_test)
+		return;
+
+	/*
+	 * Check that then data area has been zeroed out correctly
+	 */
+	for (int i = 0; i < param->nr_exp_data_segs; i++) {
+		loff_t off, len;
+		struct kunit_ext_data_state exp_data_seg = param->exp_data_state[i];
+
+		off = exp_data_seg.off_blk << blkbits;
+		len = exp_data_seg.len_blk << blkbits;
+		KUNIT_EXPECT_EQ_MSG(test, 0,
+				    check_buffer(k_ctx.k_data + off,
+						 exp_data_seg.exp_char, len),
+				    "# corruption in byte range [%lld, %lld)",
+				    off, len);
+	}
+
+	return;
+}
+
 static const struct kunit_ext_test_param test_split_convert_params[] = {
 	/* unwrit to writ splits */
 	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
@@ -523,6 +687,93 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 3 } } },
 };
 
+static const struct kunit_ext_test_param
+test_convert_initialized_params[] = {
+	/* writ to unwrit splits */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = 10, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = 11, .m_len = 2 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = 11, .m_len = 1 },
+	  .nr_exp_ext = 3,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
+			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 1 },
+			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+};
+
+static const struct kunit_ext_test_param test_handle_unwritten_params[] = {
+	/* unwrit to writ splits via endio path */
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (endio)",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = 10, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio)",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = 11, .m_len = 2 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (endio)",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = 11, .m_len = 1 },
+	  .nr_exp_ext = 3,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
+			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 0 },
+			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+
+	/* unwrit to writ splits via non-endio path */
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non endio)",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = 10, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non endio)",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = 11, .m_len = 2 },
+	  .nr_exp_ext = 2,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (non endio)",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = 11, .m_len = 1 },
+	  .nr_exp_ext = 3,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
+			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 0 },
+			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+
+};
+
 static void ext_get_desc(struct kunit *test, const void *p, char *desc)
 
 {
@@ -540,6 +791,24 @@ static int test_split_convert_param_init(struct kunit *test)
 	return 0;
 }
 
+static int test_convert_initialized_param_init(struct kunit *test)
+{
+	size_t arr_size = ARRAY_SIZE(test_convert_initialized_params);
+
+	kunit_register_params_array(test, test_convert_initialized_params,
+				    arr_size, ext_get_desc);
+	return 0;
+}
+
+static int test_handle_unwritten_init(struct kunit *test)
+{
+	size_t arr_size = ARRAY_SIZE(test_handle_unwritten_params);
+
+	kunit_register_params_array(test, test_handle_unwritten_params,
+				    arr_size, ext_get_desc);
+	return 0;
+}
+
 /*
  * Note that we use KUNIT_CASE_PARAM_WITH_INIT() instead of the more compact
  * KUNIT_ARRAY_PARAM() because the later currently has a limitation causing the
@@ -550,6 +819,10 @@ static int test_split_convert_param_init(struct kunit *test)
 static struct kunit_case extents_test_cases[] = {
 	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
 				   test_split_convert_param_init, NULL),
+	KUNIT_CASE_PARAM_WITH_INIT(test_convert_initialized, kunit_array_gen_params,
+				   test_convert_initialized_param_init, NULL),
+	KUNIT_CASE_PARAM_WITH_INIT(test_handle_unwritten, kunit_array_gen_params,
+				   test_handle_unwritten_init, NULL),
 	{}
 };
 
-- 
2.51.0


