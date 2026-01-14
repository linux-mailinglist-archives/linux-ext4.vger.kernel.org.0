Return-Path: <linux-ext4+bounces-12831-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77677D1F93D
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 15:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9A4F3051C62
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA082522A1;
	Wed, 14 Jan 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fOBvxKGI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620531196A;
	Wed, 14 Jan 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402698; cv=none; b=qtf/j9f36RpFcSrhmoRc5zxRPVo3rS4RnGs/zUxmEBn4O4hNCysJRUAXl3lSqIRxFw0o0SIkVh8/6NGXzpq4LK1/z6vWJ91S/xyGDN0D7uwb4Uipd9F9ATPZNu7rig697ebPAU+dj1EiH4UFV9fDVVwfZDp6+YfsvExeWoX4FkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402698; c=relaxed/simple;
	bh=w/4+DAJJo3zAe1FnAhJ4cgN6q5Cfg3Mr22jqrpkWyUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBDsDbETHmRpDYaE+H+CX+o4kzsyS1kNREbzIK3VuzCrcdsKo9mKiwZQGg7DcwtyRJeWf4Yc/M6pK1NO44TTPG5D7w0ZEw1rU3WHY2YujyoKTIqq1wb8LcBG8oCK+Z4Ih6ZihiB4oBr22yA4W1wD3MW07trq2akQFac0zrhdRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fOBvxKGI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E65Hl2020192;
	Wed, 14 Jan 2026 14:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gEE4yqCs4hQgKfpof
	w7IDKCVnPUJ+xR5k6pwDJZsg00=; b=fOBvxKGIBA/+Tybqsfa1GE2BYI6Wi6/uW
	gXjr5Dgdl5Jm5ZRL//5WUdiYPGOC0bpGpJkV+1f6nUYGWFKNLiWzsK6w3HNxXIcw
	+GDeoOKIoiKZXoOqnNsNs4Hd2quWWmuo8cX7iOxKpYq4TrRrd7jPBoUAzb8tFfBb
	ACLD3h3jno1Q5TfYNK6ezQodK+WR6QV0lIoVW/Yu6dhFqgoDPI39QATB/mjfgRuB
	ALgTQ+UrjrEwTa2359d4Brt+rOY4kmoWVdJpPr5PC9gZGu9myrkkKALvgbDAT0wL
	OInEGHWRjO6XF99i3i45R+oimQqom3nUWklG3tffgyMOEk61X7vWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4hvq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EEs6XO022970;
	Wed, 14 Jan 2026 14:58:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4hvpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EEGfl2025566;
	Wed, 14 Jan 2026 14:58:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23naka5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EEw0r650266484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 14:58:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B34E22004E;
	Wed, 14 Jan 2026 14:58:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D95E20040;
	Wed, 14 Jan 2026 14:57:58 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 14:57:58 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] ext4: kunit tests for higher level extent manipulation functions
Date: Wed, 14 Jan 2026 20:27:46 +0530
Message-ID: <9d586426ba81a0b9fcb359325a23a0b7ae1d7cbf.1768402426.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfX0eQooDdb/UIu
 oPSeEEmRUxvn6cTSfCm9g4kadGeKR2QXQ+Pqk9JwCA41skT4CmV+QwMqFyZygFzeCGYC4hK2DIy
 e/E+nXyqrCcE0aIsFdp5RV0Cti0ADgQ4r++nLjzji1VbhKSzWdZU5BWRYU15tzEznfN3Z969znU
 6PHEAvrSeZS/Q0uiOgVcgcgsFDCj0eyiP/Gdv+lkmsBz2t4HsFCyyADXLe/KXJMqGkoenEEKqtR
 fSEd5zr16/6cN11qFFy/QfyLgqgA8Rc3+GYlkbAo8GyO1jhxczd1e4bycjgXilQbleuNH4pIQgI
 MxMH00OyeTkiOVNGCj7CdWiMKH4qTxq5xUytXsGu0iiviw5jN/7Bkr/r9ZNrLNOfcDIiA++szB2
 cv64NfPCdq74zVZ9y9/9NqvJseSHfS0RRih0s7BE/KIGaXS34b1yrhJVJ5ykgDkt16dGmE3Ult0
 jQhDJLreZ/boHTYrqHQ==
X-Proofpoint-ORIG-GUID: jQaDBC-buS_LiNcOCUIeU51RMpuev5sJ
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=6967aefc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=zy751XSonsXWAkRVtvEA:9
X-Proofpoint-GUID: XzxxuYE3NJPWPyI-jJKLb1b-UaZZLBrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601140123

Add more kunit tests to cover the high level caller
ext4_map_create_blocks(). We pass flags in a manner that covers
the below function:

1. ext4_ext_handle_unwritten_extents()
  1.1 - Split/Convert unwritten extent to written in endio convtext.
  1.2 - Split/Convert unwritten extent to written in non endio context.
  1.3 - Zeroout tests for the above 2 cases
2. convert_initialized_extent() - Convert written extent to unwritten
   during zero range

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h           |   4 +
 fs/ext4/extents-test.c   | 287 ++++++++++++++++++++++++++++++++++++++-
 fs/ext4/extents_status.c |   3 +
 fs/ext4/inode.c          |   8 +-
 4 files changed, 295 insertions(+), 7 deletions(-)

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
index 02565ad19abe..ebd7af64315a 100644
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
@@ -277,6 +312,8 @@ static int extents_kunit_init(struct kunit *test)
 				   __ext4_ext_dirty_stub);
 	kunit_activate_static_stub(test, ext4_es_remove_extent,
 				   ext4_es_remove_extent_stub);
+	kunit_activate_static_stub(test, ext4_es_insert_extent,
+				   ext4_es_insert_extent_stub);
 	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
 	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
 	kunit_activate_static_stub(test, ext4_issue_zeroout,
@@ -301,6 +338,30 @@ static int check_buffer(char *buf, int c, int size)
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
@@ -330,8 +391,18 @@ static void test_split_convert(struct kunit *test)
 
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
@@ -383,6 +454,7 @@ static void test_split_convert(struct kunit *test)
 static const struct kunit_ext_test_param test_split_convert_params[] = {
 	/* unwrit to writ splits */
 	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = 10, .m_len = 1 },
@@ -391,6 +463,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = 11, .m_len = 2 },
@@ -399,6 +472,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = 11, .m_len = 1 },
@@ -410,6 +484,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 
 	/* writ to unwrit splits */
 	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 0,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
 	  .split_map = { .m_lblk = 10, .m_len = 1 },
@@ -418,6 +493,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 0,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
 	  .split_map = { .m_lblk = 11, .m_len = 2 },
@@ -426,6 +502,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 0,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
 	  .split_map = { .m_lblk = 11, .m_len = 1 },
@@ -440,6 +517,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	 */
 	/* unwrit to writ splits */
 	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = 10, .m_len = 1 },
@@ -451,6 +529,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
 			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
 	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = 11, .m_len = 2 },
@@ -462,6 +541,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
 			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
 	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = 11, .m_len = 1 },
@@ -476,6 +556,185 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 
 };
 
+static const struct kunit_ext_test_param test_convert_initialized_params[] = {
+	/* writ to unwrit splits */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
+	  .type = TEST_CREATE_BLOCKS,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = 10, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
+	  .type = TEST_CREATE_BLOCKS,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = 11, .m_len = 2 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
+	  .type = TEST_CREATE_BLOCKS,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
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
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = 10, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = 11, .m_len = 2 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (endio)",
+	  .type = TEST_CREATE_BLOCKS,
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
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = 10, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = 11, .m_len = 2 },
+	  .nr_exp_ext = 2,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
+			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (non endio)",
+	  .type = TEST_CREATE_BLOCKS,
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
+	/*
+	 * ***** zeroout tests *****
+	 */
+	/* unwrit to writ splits (endio)*/
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = 10, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  /* 1 block of data followed by 2 blocks of zeroes */
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = 11, .m_len = 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  /* 1 block of zeroes followed by 2 blocks of data */
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = 11, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  /* [zeroes] [data] [zeroes] */
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X', .off_blk = 1, .len_blk = 1 },
+			      { .exp_char = 0, .off_blk = 2, .len_blk = 1 } } },
+
+	/* unwrit to writ splits (non-endio)*/
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non-endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = 10, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  /* 1 block of data followed by 2 blocks of zeroes */
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non-endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = 11, .m_len = 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  /* 1 block of zeroes followed by 2 blocks of data */
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (non-endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = 11, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  /* [zeroes] [data] [zeroes] */
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X', .off_blk = 1, .len_blk = 1 },
+			      { .exp_char = 0, .off_blk = 2, .len_blk = 1 } } },
+
+};
+
 static void ext_get_desc(struct kunit *test, const void *p, char *desc)
 
 {
@@ -493,6 +752,24 @@ static int test_split_convert_param_init(struct kunit *test)
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
@@ -503,6 +780,10 @@ static int test_split_convert_param_init(struct kunit *test)
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
index c60813260f9a..8a6ad16e7417 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -542,8 +542,8 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
 	return map->m_len;
 }
 
-static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
-				 struct ext4_map_blocks *map, int flags)
+int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
+			  struct ext4_map_blocks *map, int flags)
 {
 	unsigned int status;
 	int retval;
@@ -589,8 +589,8 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
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


