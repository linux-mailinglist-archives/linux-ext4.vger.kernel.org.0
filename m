Return-Path: <linux-ext4+bounces-13051-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D2FD3B4E9
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 18:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0EAB3029EA4
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5632E126;
	Mon, 19 Jan 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fGZL/1Ym"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA601DFD96;
	Mon, 19 Jan 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844611; cv=none; b=AgXsbiI7LCbgwnGYH57tw80Ve78ol0uYm+qEz4J6FWabgkStYJzlhPxzz/tKBknJdFptxMaV8JShZSokTXwJXkToB4nOvY4DbhwalknNhYpounOTdSMWRpBov7E0JN6+LIcoxSdqOD/T8jcgWSgrWS3FDwDJQl7e43vkOX9ayR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844611; c=relaxed/simple;
	bh=kt8sye8UuKglVIRfz+ug+nyslIZcqrnkyrMPnjvFbvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxwNK8ORy3LAEwL6aW7v5Rf2Fyz7nIJh2kX3eT7kxKnLwkvzh81qRXhbq+jaOmwj4omkkT24vFTDcLbWryKzjVj3SFT15+Ofm53AUKRTdxecnTFw/9rKM56TSJz/Jz1u/NFW/ADPlnGjNoNbAU/w9y8N+rr9i9h8umwI1PDUT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fGZL/1Ym; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JGArmr000368;
	Mon, 19 Jan 2026 17:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hiUtxnzbnRI7/k+yz
	EdJhWmu9sgFQBUNiWr9jxk1+gM=; b=fGZL/1YmTkOPbp1OoereDilZN+qL9R0eW
	1rgDYAr+Cpyozf0YS86hlYpy8Gzm9wJjD5usioQ7uLuUCT5yyQjh1AzdCEf3M4uI
	fXToHooj8/JmwpWyK0rOAc2YjVk07A4Lqexz8r5emvS5ICST3eUpB4XCEh32UepT
	GEE4WmeXSVMursLitfvdl1kjEUal3jWst8nj53Byofddb+IcP039OO5+AZ8VI707
	2BOZ/gmAaqSTQ7AGPdwx5g5PG+BWMHGd5G4StXLXwWxTF2zfdqgPlhnUCbfh4cPs
	/0hu+Iaw9eYrYfi/kFVs7QsNvCYAHJegp9upvgLGXIceeA+AWdFrg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf94a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JHOYj6009360;
	Mon, 19 Jan 2026 17:43:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf94a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JGM5qG016627;
	Mon, 19 Jan 2026 17:43:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xrbqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JHhE4p61342062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 17:43:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C9B020043;
	Mon, 19 Jan 2026 17:43:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7277E20040;
	Mon, 19 Jan 2026 17:43:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 17:43:11 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] ext4: kunit tests for higher level extent manipulation functions
Date: Mon, 19 Jan 2026 23:12:58 +0530
Message-ID: <455c0744698179266659bd1f3e737de71507cb98.1768844021.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768844021.git.ojaswin@linux.ibm.com>
References: <cover.1768844021.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lOPx-9T5er3nuLyNx4PzAyBmuBrqoYB8
X-Proofpoint-ORIG-GUID: 2GkJMOtHM7MT6tNZ6e38SLVhtr86HCxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0NCBTYWx0ZWRfXwO0guNpGN5zz
 iwz/UvqBJmDpz1yCu2KZWiPsj9neOFD/ku/WtYnb94PWMH7CS1ODmc5tfbO1/jyuGkR3ECaK//6
 4uV2PCg+CYpqcSStpU44R4Ccwsucu+iTg0JK3kcvAWIHkwkJ8qu6ILczYR6KhfTEWVM7KLzPcGx
 6lM4FXfrnU/EZbHmJ9hmFR5RIsx98CPcYggt2SOChbsoE+rTH8SPwE7h2I7cV5+8vtDDlTv1a+h
 cFKhY41Vu5Qz5UX+G7u10g8RW0zOL48uHqHzLMYhGLfD11GirVK/9XLTZQB4INooUb+SYMMRuNC
 xAqhc7rXqBLjRIeixueNpqK16QYJDepJtAWk75M7rfV7BAx5QHnAPZmHIkXFs0DJ+U/G1ww/i4n
 RnvOUd52NMOKPL6mFQIW6A+xGPBa6nqdZN8UFMskFF7td8dYL9t6lXrO42NFvEabj0w3U7xWu7/
 249tRctqtPhOyrs/1uw==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696e6d35 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=M-LP-KjQj-4Pn8WnV4cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190144

Add more kunit tests to cover the high level caller
ext4_map_create_blocks(). We pass flags in a manner that covers
the below function:

1. ext4_ext_handle_unwritten_extents()
  1.1 - Split/Convert unwritten extent to written in endio convtext.
  1.2 - Split/Convert unwritten extent to written in non endio context.
  1.3 - Zeroout tests for the above 2 cases
2. convert_initialized_extent() - Convert written extent to unwritten
   during zero range

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h           |   4 +
 fs/ext4/extents-test.c   | 359 ++++++++++++++++++++++++++++++++++++++-
 fs/ext4/extents_status.c |   3 +
 fs/ext4/inode.c          |   8 +-
 4 files changed, 365 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 174c51402864..5f744bd19dea 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3786,6 +3786,10 @@ extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
 					     ext4_io_end_t *io_end);
 extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map, int flags);
+extern int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
+				  struct ext4_map_blocks *map, int flags);
+extern int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
+				  struct ext4_map_blocks *map, int flags);
 extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
 						   int num,
 						   struct ext4_ext_path *path);
diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index f68e43d924db..082c3e170e54 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -77,10 +77,18 @@ struct kunit_ext_data_state {
 	ext4_lblk_t len_blk;
 };
 
+enum kunit_test_types {
+	TEST_SPLIT_CONVERT,
+	TEST_CREATE_BLOCKS,
+};
+
 struct kunit_ext_test_param {
 	/* description of test */
 	char *desc;
 
+	/* determines which function will be tested */
+	int type;
+
 	/* is extent unwrit at beginning of test */
 	bool is_unwrit_at_start;
 
@@ -90,6 +98,9 @@ struct kunit_ext_test_param {
 	/* map describing range to split */
 	struct ext4_map_blocks split_map;
 
+	/* disable zeroout */
+	bool disable_zeroout;
+
 	/* no of extents expected after split */
 	int nr_exp_ext;
 
@@ -131,6 +142,9 @@ static struct file_system_type ext_fs_type = {
 
 static void extents_kunit_exit(struct kunit *test)
 {
+	struct ext4_sb_info *sbi = k_ctx.k_ei->vfs_inode.i_sb->s_fs_info;
+
+	kfree(sbi);
 	kfree(k_ctx.k_ei);
 	kfree(k_ctx.k_data);
 }
@@ -162,6 +176,13 @@ static void ext4_es_remove_extent_stub(struct inode *inode, ext4_lblk_t lblk,
 	return;
 }
 
+void ext4_es_insert_extent_stub(struct inode *inode, ext4_lblk_t lblk,
+				ext4_lblk_t len, ext4_fsblk_t pblk,
+				unsigned int status, bool delalloc_reserve_used)
+{
+	return;
+}
+
 static void ext4_zeroout_es_stub(struct inode *inode, struct ext4_extent *ex)
 {
 	return;
@@ -220,6 +241,7 @@ static int extents_kunit_init(struct kunit *test)
 	struct ext4_inode_info *ei;
 	struct inode *inode;
 	struct super_block *sb;
+	struct ext4_sb_info *sbi = NULL;
 	struct kunit_ext_test_param *param =
 		(struct kunit_ext_test_param *)(test->param_value);
 
@@ -237,7 +259,20 @@ static int extents_kunit_init(struct kunit *test)
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
+	ei->i_flags = 0;
+	ext4_set_inode_flag(inode, EXT4_INODE_EXTENTS);
 	inode->i_sb = sb;
 
 	k_ctx.k_data = kzalloc(EX_DATA_LEN * 4096, GFP_KERNEL);
@@ -262,7 +297,9 @@ static int extents_kunit_init(struct kunit *test)
 	eh->eh_generation = 0;
 
 	/*
-	 * add 1 extent in leaf node covering lblks [10,13) and pblk [100,103)
+	 * add 1 extent in leaf node covering:
+	 * - lblks: [EX_DATA_LBLK, EX_DATA_LBLK * + EX_DATA_LEN)
+	 * - pblks: [EX_DATA_PBLK, EX_DATA_PBLK + EX_DATA_LEN)
 	 */
 	EXT_FIRST_EXTENT(eh)->ee_block = cpu_to_le32(EX_DATA_LBLK);
 	EXT_FIRST_EXTENT(eh)->ee_len = cpu_to_le16(EX_DATA_LEN);
@@ -277,6 +314,8 @@ static int extents_kunit_init(struct kunit *test)
 				   __ext4_ext_dirty_stub);
 	kunit_activate_static_stub(test, ext4_es_remove_extent,
 				   ext4_es_remove_extent_stub);
+	kunit_activate_static_stub(test, ext4_es_insert_extent,
+				   ext4_es_insert_extent_stub);
 	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
 	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
 	kunit_activate_static_stub(test, ext4_issue_zeroout,
@@ -301,6 +340,30 @@ static int check_buffer(char *buf, int c, int size)
 	return 1;
 }
 
+/*
+ * Simulate a map block call by first calling ext4_map_query_blocks() to
+ * correctly populate map flags and pblk and then call the
+ * ext4_map_create_blocks() to do actual split and conversion. This is easier
+ * than calling ext4_map_blocks() because that needs mocking a lot of unrelated
+ * functions.
+ */
+static void ext4_map_create_blocks_helper(struct kunit *test,
+					  struct inode *inode,
+					  struct ext4_map_blocks *map,
+					  int flags)
+{
+	int retval = 0;
+
+	retval = ext4_map_query_blocks(NULL, inode, map, flags);
+	if (retval < 0) {
+		KUNIT_FAIL(test,
+			   "ext4_map_query_blocks() failed. Cannot proceed\n");
+		return;
+	}
+
+	ext4_map_create_blocks(NULL, inode, map, flags);
+}
+
 static void test_split_convert(struct kunit *test)
 {
 	struct ext4_ext_path *path;
@@ -330,8 +393,18 @@ static void test_split_convert(struct kunit *test)
 
 	map.m_lblk = param->split_map.m_lblk;
 	map.m_len = param->split_map.m_len;
-	ext4_split_convert_extents(NULL, inode, &map, path,
-				   param->split_flags, NULL);
+
+	switch (param->type) {
+	case TEST_SPLIT_CONVERT:
+		path = ext4_split_convert_extents(NULL, inode, &map, path,
+						  param->split_flags, NULL);
+		break;
+	case TEST_CREATE_BLOCKS:
+		ext4_map_create_blocks_helper(test, inode, &map, param->split_flags);
+		break;
+	default:
+		KUNIT_FAIL(test, "param->type %d not support.", param->type);
+	}
 
 	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
 	ex = path->p_ext;
@@ -383,6 +456,7 @@ static void test_split_convert(struct kunit *test)
 static const struct kunit_ext_test_param test_split_convert_params[] = {
 	/* unwrit to writ splits */
 	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
@@ -395,6 +469,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 1 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
@@ -407,6 +482,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 0 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
@@ -424,6 +500,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 
 	/* writ to unwrit splits */
 	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 0,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
 	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
@@ -436,6 +513,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 0 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 0,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
 	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
@@ -448,6 +526,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 1 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 0,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
 	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
@@ -468,6 +547,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	 */
 	/* unwrit to writ splits */
 	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
@@ -482,6 +562,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 				.off_blk = 1,
 				.len_blk = EX_DATA_LEN - 1 } } },
 	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
@@ -496,6 +577,201 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 				.off_blk = 1,
 				.len_blk = EX_DATA_LEN - 1 } } },
 	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = EX_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EX_DATA_LEN - 2 },
+			      { .exp_char = 0,
+				.off_blk = EX_DATA_LEN - 1,
+				.len_blk = 1 } } },
+};
+
+/* Tests to trigger ext4_ext_map_blocks() -> convert_initialized_extent() */
+static const struct kunit_ext_test_param test_convert_initialized_params[] = {
+	/* writ to unwrit splits */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
+	  .type = TEST_CREATE_BLOCKS,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EX_DATA_LBLK + 1,
+			       .ex_len = EX_DATA_LEN - 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
+	  .type = TEST_CREATE_BLOCKS,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EX_DATA_LBLK + 1,
+			       .ex_len = EX_DATA_LEN - 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
+	  .type = TEST_CREATE_BLOCKS,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
+	  .nr_exp_ext = 3,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EX_DATA_LBLK + 1,
+			       .ex_len = EX_DATA_LEN - 2,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EX_DATA_LBLK + 1 + (EX_DATA_LEN - 2),
+			       .ex_len = 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+};
+
+/* Tests to trigger ext4_ext_map_blocks() -> ext4_ext_handle_unwritten_exntents() */
+static const struct kunit_ext_test_param test_handle_unwritten_params[] = {
+	/* unwrit to writ splits via endio path */
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EX_DATA_LBLK + 1,
+			       .ex_len = EX_DATA_LEN - 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EX_DATA_LBLK + 1,
+			       .ex_len = EX_DATA_LEN - 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
+	  .nr_exp_ext = 3,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EX_DATA_LBLK + 1,
+			       .ex_len = EX_DATA_LEN - 2,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EX_DATA_LBLK + 1 + (EX_DATA_LEN - 2),
+			       .ex_len = 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+
+	/* unwrit to writ splits via non-endio path */
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EX_DATA_LBLK + 1,
+			       .ex_len = EX_DATA_LEN - 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
+	  .nr_exp_ext = 2,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EX_DATA_LBLK + 1,
+			       .ex_len = EX_DATA_LEN - 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (non endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
+	  .nr_exp_ext = 3,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EX_DATA_LBLK + 1,
+			       .ex_len = EX_DATA_LEN - 2,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EX_DATA_LBLK + 1 + (EX_DATA_LEN - 2),
+			       .ex_len = 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+
+	/*
+	 * ***** zeroout tests *****
+	 */
+	/* unwrit to writ splits (endio)*/
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = EX_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0,
+				.off_blk = 1,
+				.len_blk = EX_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = EX_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EX_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
@@ -512,6 +788,56 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			      { .exp_char = 0,
 				.off_blk = EX_DATA_LEN - 1,
 				.len_blk = 1 } } },
+
+	/* unwrit to writ splits (non-endio)*/
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non-endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = EX_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0,
+				.off_blk = 1,
+				.len_blk = EX_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non-endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = EX_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EX_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (non-endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = EX_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EX_DATA_LEN - 2 },
+			      { .exp_char = 0,
+				.off_blk = EX_DATA_LEN - 1,
+				.len_blk = 1 } } },
 };
 
 static void ext_get_desc(struct kunit *test, const void *p, char *desc)
@@ -519,7 +845,8 @@ static void ext_get_desc(struct kunit *test, const void *p, char *desc)
 {
 	struct kunit_ext_test_param *param = (struct kunit_ext_test_param *)p;
 
-	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s\n", param->desc);
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s %s\n", param->desc,
+		 (param->type & TEST_CREATE_BLOCKS) ? "(highlevel)" : "");
 }
 
 static int test_split_convert_param_init(struct kunit *test)
@@ -531,6 +858,24 @@ static int test_split_convert_param_init(struct kunit *test)
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
@@ -541,6 +886,10 @@ static int test_split_convert_param_init(struct kunit *test)
 static struct kunit_case extents_test_cases[] = {
 	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
 				   test_split_convert_param_init, NULL),
+	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
+				   test_convert_initialized_param_init, NULL),
+	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
+				   test_handle_unwritten_init, NULL),
 	{}
 };
 
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 6c1faf7c9f2a..095ccb7ba4ba 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -916,6 +916,9 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct pending_reservation *pr = NULL;
 	bool revise_pending = false;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_es_insert_extent, inode, lblk, len,
+				   pblk, status, delalloc_reserve_used);
+
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fdfd706c79c1..32cf362c471c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -541,8 +541,8 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
 	return map->m_len;
 }
 
-static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
-				 struct ext4_map_blocks *map, int flags)
+int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
+			  struct ext4_map_blocks *map, int flags)
 {
 	unsigned int status;
 	int retval;
@@ -588,8 +588,8 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 	return retval;
 }
 
-static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
-				  struct ext4_map_blocks *map, int flags)
+int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
+			   struct ext4_map_blocks *map, int flags)
 {
 	unsigned int status;
 	int err, retval = 0;
-- 
2.52.0


