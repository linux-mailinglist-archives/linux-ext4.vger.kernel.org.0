Return-Path: <linux-ext4+bounces-13255-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FcSKcoVc2l3sAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13255-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:31:38 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 204297101A
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99A09303B7DE
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421439DB14;
	Fri, 23 Jan 2026 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XgG+pU1w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B95385EFE;
	Fri, 23 Jan 2026 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149571; cv=none; b=FXeLVjChDLL5oZRjM4CnO/uETGUVxNYcRAVTTZhyETfhqW64M1KxBn2a78DGc1w5TDy0h+5BQk8haWMoQWpeB9Vp9zz7mSuA8uFivVRJpIp+fuAv/e5Njj2WVYqvAH4RxY2W9ME/kRafU6VDJPcmZE19jzY+s5EIwsy1NvO9JiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149571; c=relaxed/simple;
	bh=IV4PmrTNjcUDMmjTXQzvx25AvRNb9OxK7kSMJcrKHOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0wA5CvZ8LFnuTJ7B516om37D3VrreaMbLFs49zFh+VzvzCQe1aRADsGBqWJbNg/OE0pUD/kybCD/NckxfGkE7RGPB6wrRd9TZtxyjVGXHLaOlUrY9Mk4cdWLkw7+IyJzS9cLyAJM5ovJIzJ/bU35NbF7aht6MzpONHADrLcwZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XgG+pU1w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MMqRmR028543;
	Fri, 23 Jan 2026 06:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BaJyhcVUwUfqs8Lns
	yhnQuFV+Fo+AqlXEKOiHTlg8FU=; b=XgG+pU1wEaTX17OjGP13hkjWJAMAFpXXZ
	gxiexF/RkTKfcNBiRaGbPQMKOlYqqdp79T1dBVlvBvrFp5oy8+bT7Vmw+ezexcu0
	lbvm1uGAtJ8iQOCC8UuEO8o662VcY3rwqQOWnOBGnWof0Zcy704IMaxrSA/YAy+6
	4s1yRzMnqcqQi7OiQudpi9MBOZOnkYlalgeidd3YGJnWF7wkNMOHX40qsTu4dLqo
	Q2hHcvktdoz60I47LvKV13Nyh9+yNFsz43ovPbmPmfNbyuwwMZg7mCV22TqyHT9k
	MT/xzgBQTIsab0AepIjhu2Qd5oI8+Qxo5tB1HnKnndfUi6q1/q8fQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60f1wn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N6JemN028144;
	Fri, 23 Jan 2026 06:25:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60f1wmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N47bwG027382;
	Fri, 23 Jan 2026 06:25:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnfg4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N6Plt542926546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 06:25:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16D0C20040;
	Fri, 23 Jan 2026 06:25:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5EFD20043;
	Fri, 23 Jan 2026 06:25:44 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 06:25:44 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] ext4: kunit tests for higher level extent manipulation functions
Date: Fri, 23 Jan 2026 11:55:33 +0530
Message-ID: <9d8ad32cb62f44999c0fe3545b44fc3113546c70.1769149131.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=6973146f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=Qhauk3kxTGDP0Of3FaYA:9
X-Proofpoint-GUID: f2fjUDaoNkKghANZpBD0c6rGVOjb4wRP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA0NiBTYWx0ZWRfX3yqqiI5z1shA
 spfk5f8HnpQEJ3AHox4SkNcRN3xEbFkv3lsK4IjE5RATr86jy6L8MFnn/aKXbyo4cU5LBgXQp0q
 fwrIQTQVjtzx9J7UqEjJm7CHB37aeXiU46I9KQbKfgYZFGbAh8TTlLSIkvR8cNURaceJA3vXMIx
 R/WKV5siUC1eIsY+n1OuOlA8gDE8aUxBmrzbxtiB+uRAhyNv0kT/LrwkapAvKmSA1ytpKJ+g0fm
 roORwZTri6AbrtsxUhhJeVE9jxt8p/v+Pj8+YZXxJbeTYeX+toq4eDwcOQqc9BwKu0+Z+GNATst
 txaACEZCrkWCIImZjO/sA2/KdaAMTnT0ksL3Xk3WvZg0OmE7bTYLcn+JTfj598V+3LneF8ybj0D
 I7ZwhYmC82aJ9DWkIUMxZOuyoGS354Awqcgv1Z2lNNBssl0Ce9zX2Bdd7Kcgn0NRywpfJ/JRrwF
 AN/37VhmrE+hsKsNbRQ==
X-Proofpoint-ORIG-GUID: CAAdXD_aOeRoYfYnUNJ_T0RMrS0M4R_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13255-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,suse.cz,vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 204297101A
X-Rspamd-Action: no action

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
index 9610602fe37b..b76966dc06c0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3804,6 +3804,10 @@ extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
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
index 15053c607cfd..4030fa5faca5 100644
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
 
-	ei->i_disksize = (EXT_DATA_LBLK + EXT_DATA_LEN + 10) << sb->s_blocksize_bits;
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
+	ei->i_disksize = (EXT_DATA_LBLK + EXT_DATA_LEN + 10)
+			 << sb->s_blocksize_bits;
+	ei->i_flags = 0;
+	ext4_set_inode_flag(inode, EXT4_INODE_EXTENTS);
 	inode->i_sb = sb;
 
 	k_ctx.k_data = kzalloc(EXT_DATA_LEN * 4096, GFP_KERNEL);
@@ -262,7 +297,9 @@ static int extents_kunit_init(struct kunit *test)
 	eh->eh_generation = 0;
 
 	/*
-	 * add 1 extent in leaf node covering lblks [10,13) and pblk [100,103)
+	 * add 1 extent in leaf node covering:
+	 * - lblks: [EXT_DATA_LBLK, EXT_DATA_LBLK * + EXT_DATA_LEN)
+	 * - pblks: [EXT_DATA_PBLK, EXT_DATA_PBLK + EXT_DATA_LEN)
 	 */
 	EXT_FIRST_EXTENT(eh)->ee_block = cpu_to_le32(EXT_DATA_LBLK);
 	EXT_FIRST_EXTENT(eh)->ee_len = cpu_to_le16(EXT_DATA_LEN);
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
@@ -331,8 +394,18 @@ static void test_split_convert(struct kunit *test)
 
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
 
 	path = ext4_find_extent(inode, EXT_DATA_LBLK, NULL, 0);
 	ex = path->p_ext;
@@ -386,6 +459,7 @@ static void test_split_convert(struct kunit *test)
 static const struct kunit_ext_test_param test_split_convert_params[] = {
 	/* unwrit to writ splits */
 	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
@@ -398,6 +472,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 1 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
@@ -410,6 +485,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 0 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
@@ -427,6 +503,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 
 	/* writ to unwrit splits */
 	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 0,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
 	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
@@ -439,6 +516,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 0 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 0,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
 	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
@@ -451,6 +529,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 1 } },
 	  .is_zeroout_test = 0 },
 	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 0,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
 	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
@@ -471,6 +550,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 	 */
 	/* unwrit to writ splits */
 	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
@@ -485,6 +565,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 				.off_blk = 1,
 				.len_blk = EXT_DATA_LEN - 1 } } },
 	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
@@ -499,6 +580,201 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 				.off_blk = 1,
 				.len_blk = EXT_DATA_LEN - 1 } } },
 	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 2 },
+			      { .exp_char = 0,
+				.off_blk = EXT_DATA_LEN - 1,
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
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
+	  .type = TEST_CREATE_BLOCKS,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
+	  .type = TEST_CREATE_BLOCKS,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .is_unwrit_at_start = 0,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 3,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 2,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1 + (EXT_DATA_LEN - 2),
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
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 3,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 2,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1 + (EXT_DATA_LEN - 2),
+			       .ex_len = 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+
+	/* unwrit to writ splits via non-endio path */
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
+	  .nr_exp_ext = 2,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (non endio)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 3,
+	  .disable_zeroout = true,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 2,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1 + (EXT_DATA_LEN - 2),
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
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0,
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
 	  .is_unwrit_at_start = 1,
 	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
 	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
@@ -515,6 +791,56 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			      { .exp_char = 0,
 				.off_blk = EXT_DATA_LEN - 1,
 				.len_blk = 1 } } },
+
+	/* unwrit to writ splits (non-endio)*/
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non-endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0,
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non-endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (non-endio, zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CREATE,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 2 },
+			      { .exp_char = 0,
+				.off_blk = EXT_DATA_LEN - 1,
+				.len_blk = 1 } } },
 };
 
 static void ext_get_desc(struct kunit *test, const void *p, char *desc)
@@ -522,7 +848,8 @@ static void ext_get_desc(struct kunit *test, const void *p, char *desc)
 {
 	struct kunit_ext_test_param *param = (struct kunit_ext_test_param *)p;
 
-	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s\n", param->desc);
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s %s\n", param->desc,
+		 (param->type & TEST_CREATE_BLOCKS) ? "(highlevel)" : "");
 }
 
 static int test_split_convert_param_init(struct kunit *test)
@@ -534,6 +861,24 @@ static int test_split_convert_param_init(struct kunit *test)
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
@@ -544,6 +889,10 @@ static int test_split_convert_param_init(struct kunit *test)
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
index fafe673e5e17..15ba4d42982f 100644
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


