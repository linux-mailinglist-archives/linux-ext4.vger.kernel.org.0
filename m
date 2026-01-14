Return-Path: <linux-ext4+bounces-12833-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFAFD1F94C
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60654305C966
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2163126A8;
	Wed, 14 Jan 2026 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R349Vzmt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3ED3115B8;
	Wed, 14 Jan 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402702; cv=none; b=O8HWjqyRC/cfbFQvaxvrFqDwdG3UAV871yiVZY5548Sxc2fB3iz3GoJbAFFZmVRy6zgK0jVbD1d1MZhmfkTy1bq/7trK9AUOIZnI5mdzX5o9knkt0tFpK5lG1YN9JMP/we7du5y9yP95sbG5f37w3px0iZeeOCb1ouZzMLe0jQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402702; c=relaxed/simple;
	bh=I6ZJ9eUngMBATZZdG8LyJLymU94+L+KCUoQIrtgNvEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv12fkm9L5+K7wseT5HNwa2+FGsmWN/rIMxB4xscmHogpTxQLSEUkd5Px0HBcEzeYNsHh6VdS7wc5uSteKLQvpEOOyl2DkikiH3y2eJGSf0tsDBl/8fpC5oxuraWIKxlcVEdF/hFQOkoCAxVit5kaGoXYN9MPf06GSdL/A9hAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R349Vzmt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E5fT8U002559;
	Wed, 14 Jan 2026 14:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0+ifyeg1mkfd2QbFK
	GJVD0QGFG2MBshR+9ashQKz9PI=; b=R349Vzmt7CHOCoFgPi6iLz6WW+Lw8fcuu
	MXgioL6xKn4972TM5vT7VTskKUMmVg262JqIysulCzWCztumoczKswwcHP2ENvzl
	oBV4/p6B3d2poAgxD93WZVFeldXDLGAlkxTiks8dmxmp/Fwg/NpO5UyAZZxJkxd3
	RwQlUpO2pr6t9DWPwFj6SKTFxRhQS7Svn4lwuntuX62tm8GfqR4JHbMdmYl1vSmI
	SdO2rYwWIqwYQkMlQT+55cDDJpAAY0gaVVmTwGMsDhgJmY+HJKNCST2lYEyO3wvB
	wMbsXPUgI2sPMFYcn5iPuIhs5QvaVMBAgLVmVi3DQ7vV/thwfsEEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke931xb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EErJZv006833;
	Wed, 14 Jan 2026 14:58:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke931xav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EDwCY6014261;
	Wed, 14 Jan 2026 14:58:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fyaqk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EEw3Ge27132328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 14:58:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1845A20040;
	Wed, 14 Jan 2026 14:58:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 231722004E;
	Wed, 14 Jan 2026 14:58:01 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 14:58:00 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] ext4: Add extent status cache support to kunit tests
Date: Wed, 14 Jan 2026 20:27:47 +0530
Message-ID: <4ff7e1f19b9663f20735d321af3a8133567400f8.1768402426.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: tg6A1mJBpKr-Q-l0g3X2feDZWQQXIjUc
X-Authority-Analysis: v=2.4 cv=dYyNHHXe c=1 sm=1 tr=0 ts=6967aefe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=vzcrPjFstuySDhk4gt8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfX9pDkiadIk95k
 EMpxKOafnm5YKqwepb1U30jHu58sg22/y9bqv81GOah6d2vd8IYl8rEBwvuNFJhuD/5BzUUQz4u
 CoEw33BKFvxdt5LEeL4dYVlSoWRoULihnqDuGS/myjFiNtEWV6FxtrWRx1MuQiSOcrAlJPyKzsE
 my9UvPwURuqdLV+eLP9Wq0tbQvZQyl704ejybnNdT6oW2NIBiaU3QzLCvw6QTIo0n70ST12JV9i
 TOdRavkoV831H7UBo2aYmp/mXDuRS7eFl/GAzaXWG67w9rB9Tu7xd6QUQ1ZSucZkxyHOoBptUDd
 BvJBlq1j1/wzFe3X5Ygbm99c5ATIlbqnMVgPiYNJTax5u1zQAl+UmHYIMsj0ZTE9UehlHOHW5EC
 VIjTf/wW3/mzcJFR1j4kg/X/mid4PMaGVdbrFYp+5+DlGgTd3CrXuEacVt5ZQYHUPypFH/g0vIe
 fK3bz64+IJ7TusmeP3A==
X-Proofpoint-GUID: ZEReAFmeICIPxmAp8N9oQx7doJTeyBYg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601140123

Add support in Kunit tests to ensure that the extent status cache is
also in sync after the extent split and conversion operations.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents-test.c   | 106 ++++++++++++++++++++++++---------------
 fs/ext4/extents.c        |   2 -
 fs/ext4/extents_status.c |   5 --
 3 files changed, 65 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index ebd7af64315a..86fcac66be6f 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -149,12 +149,6 @@ static void extents_kunit_exit(struct kunit *test)
 	kfree(k_ctx.k_data);
 }
 
-static void ext4_cache_extents_stub(struct inode *inode,
-				    struct ext4_extent_header *eh)
-{
-	return;
-}
-
 static int __ext4_ext_dirty_stub(const char *where, unsigned int line,
 				 handle_t *handle, struct inode *inode,
 				 struct ext4_ext_path *path)
@@ -170,24 +164,6 @@ ext4_ext_insert_extent_stub(handle_t *handle, struct inode *inode,
 	return ERR_PTR(-ENOSPC);
 }
 
-static void ext4_es_remove_extent_stub(struct inode *inode, ext4_lblk_t lblk,
-				       ext4_lblk_t len)
-{
-	return;
-}
-
-void ext4_es_insert_extent_stub(struct inode *inode, ext4_lblk_t lblk,
-				ext4_lblk_t len, ext4_fsblk_t pblk,
-				unsigned int status, bool delalloc_reserve_used)
-{
-	return;
-}
-
-static void ext4_zeroout_es_stub(struct inode *inode, struct ext4_extent *ex)
-{
-	return;
-}
-
 /*
  * We will zeroout the equivalent range in the data area
  */
@@ -244,13 +220,7 @@ static int extents_kunit_init(struct kunit *test)
 	struct ext4_sb_info *sbi = NULL;
 	struct kunit_ext_test_param *param =
 		(struct kunit_ext_test_param *)(test->param_value);
-
-	/* setup the mock inode */
-	k_ctx.k_ei = kzalloc(sizeof(struct ext4_inode_info), GFP_KERNEL);
-	if (k_ctx.k_ei == NULL)
-		return -ENOMEM;
-	ei = k_ctx.k_ei;
-	inode = &ei->vfs_inode;
+	int err;
 
 	sb = sget(&ext_fs_type, NULL, ext_set, 0, NULL);
 	if (IS_ERR(sb))
@@ -269,6 +239,24 @@ static int extents_kunit_init(struct kunit *test)
 	if (!param || !param->disable_zeroout)
 		sbi->s_extent_max_zeroout_kb = 32;
 
+	/* setup the mock inode */
+	k_ctx.k_ei = kzalloc(sizeof(struct ext4_inode_info), GFP_KERNEL);
+	if (k_ctx.k_ei == NULL)
+		return -ENOMEM;
+	ei = k_ctx.k_ei;
+	inode = &ei->vfs_inode;
+
+	err = ext4_es_register_shrinker(sbi);
+	if (err)
+		return err;
+
+	ext4_es_init_tree(&ei->i_es_tree);
+	rwlock_init(&ei->i_es_lock);
+	INIT_LIST_HEAD(&ei->i_es_list);
+	ei->i_es_all_nr = 0;
+	ei->i_es_shk_nr = 0;
+	ei->i_es_shrink_lblk = 0;
+
 	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10)
 			 << sb->s_blocksize_bits;
 	ei->i_flags = 0;
@@ -305,16 +293,15 @@ static int extents_kunit_init(struct kunit *test)
 	if (!param || param->is_unwrit_at_start)
 		ext4_ext_mark_unwritten(EXT_FIRST_EXTENT(eh));
 
+	ext4_es_insert_extent(inode, EX_DATA_LBLK, EX_DATA_LEN, EX_DATA_PBLK,
+			      ext4_ext_is_unwritten(EXT_FIRST_EXTENT(eh)) ?
+				      EXTENT_STATUS_UNWRITTEN :
+				      EXTENT_STATUS_WRITTEN,
+			      0);
+
 	/* Add stubs */
-	kunit_activate_static_stub(test, ext4_cache_extents,
-				   ext4_cache_extents_stub);
 	kunit_activate_static_stub(test, __ext4_ext_dirty,
 				   __ext4_ext_dirty_stub);
-	kunit_activate_static_stub(test, ext4_es_remove_extent,
-				   ext4_es_remove_extent_stub);
-	kunit_activate_static_stub(test, ext4_es_insert_extent,
-				   ext4_es_insert_extent_stub);
-	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
 	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
 	kunit_activate_static_stub(test, ext4_issue_zeroout,
 				   ext4_issue_zeroout_stub);
@@ -379,11 +366,12 @@ static void test_split_convert(struct kunit *test)
 		kunit_activate_static_stub(test, ext4_ext_insert_extent,
 					   ext4_ext_insert_extent_stub);
 
-	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
+	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, EXT4_EX_NOCACHE);
 	ex = path->p_ext;
 	KUNIT_EXPECT_EQ(test, 10, ex->ee_block);
 	KUNIT_EXPECT_EQ(test, 3, ext4_ext_get_actual_len(ex));
-	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start, ext4_ext_is_unwritten(ex));
+	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start,
+			ext4_ext_is_unwritten(ex));
 	if (param->is_zeroout_test)
 		KUNIT_EXPECT_EQ(test, 0,
 				check_buffer(k_ctx.k_data, 'X',
@@ -404,17 +392,47 @@ static void test_split_convert(struct kunit *test)
 		KUNIT_FAIL(test, "param->type %d not support.", param->type);
 	}
 
-	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
+	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, EXT4_EX_NOCACHE);
 	ex = path->p_ext;
 
 	for (int i = 0; i < param->nr_exp_ext; i++) {
 		struct kunit_ext_state exp_ext = param->exp_ext_state[i];
+		bool es_check_needed = param->type != TEST_SPLIT_CONVERT;
+		struct extent_status es;
+		int contains_ex, ex_end, es_end, es_pblk;
 
 		KUNIT_EXPECT_EQ(test, exp_ext.ex_lblk, ex->ee_block);
 		KUNIT_EXPECT_EQ(test, exp_ext.ex_len,
 				ext4_ext_get_actual_len(ex));
 		KUNIT_EXPECT_EQ(test, exp_ext.is_unwrit,
 				ext4_ext_is_unwritten(ex));
+		/*
+		 * Confirm extent cache is in sync. Note that es cache can be
+		 * merged even when on-disk extents are not so take that into
+		 * account.
+		 *
+		 * Also, ext4_split_convert_extents() forces EXT4_EX_NOCACHE hence
+		 * es status are ignored for that case.
+		 */
+		if (es_check_needed) {
+			ext4_es_lookup_extent(inode, ex->ee_block, NULL, &es,
+					      NULL);
+
+			ex_end = exp_ext.ex_lblk + exp_ext.ex_len;
+			es_end = es.es_lblk + es.es_len;
+			contains_ex = es.es_lblk <= exp_ext.ex_lblk &&
+				      es_end >= ex_end;
+			es_pblk = ext4_es_pblock(&es) +
+				  (exp_ext.ex_lblk - es.es_lblk);
+
+			KUNIT_EXPECT_EQ(test, contains_ex, 1);
+			KUNIT_EXPECT_EQ(test, ext4_ext_pblock(ex), es_pblk);
+			KUNIT_EXPECT_EQ(test, 1,
+					(exp_ext.is_unwrit &&
+					 ext4_es_is_unwritten(&es)) ||
+						(!exp_ext.is_unwrit &&
+						 ext4_es_is_written(&es)));
+		}
 
 		/* Only printed on failure */
 		kunit_log(KERN_INFO, test,
@@ -424,6 +442,12 @@ static void test_split_convert(struct kunit *test)
 			  "# [extent %d] got: lblk:%d len:%d unwrit:%d\n", i,
 			  ex->ee_block, ext4_ext_get_actual_len(ex),
 			  ext4_ext_is_unwritten(ex));
+		if (es_check_needed)
+			kunit_log(
+				KERN_INFO, test,
+				"# [extent %d] es: lblk:%d len:%d pblk:%lld type:0x%x\n",
+				i, es.es_lblk, es.es_len, ext4_es_pblock(&es),
+				ext4_es_type(&es));
 		kunit_log(KERN_INFO, test, "------------------\n");
 
 		ex = ex + 1;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4cebd82ef3e4..a581e9278d48 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3149,8 +3149,6 @@ static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 	ext4_fsblk_t ee_pblock;
 	unsigned int ee_len;
 
-	KUNIT_STATIC_STUB_REDIRECT(ext4_zeroout_es, inode, ex);
-
 	ee_block = le32_to_cpu(ex->ee_block);
 	ee_len = ext4_ext_get_actual_len(ex);
 	ee_pblock = ext4_ext_pblock(ex);
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 095ccb7ba4ba..a1538bac51c6 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -916,9 +916,6 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct pending_reservation *pr = NULL;
 	bool revise_pending = false;
 
-	KUNIT_STATIC_STUB_REDIRECT(ext4_es_insert_extent, inode, lblk, len,
-				   pblk, status, delalloc_reserve_used);
-
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
@@ -1631,8 +1628,6 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	int reserved = 0;
 	struct extent_status *es = NULL;
 
-	KUNIT_STATIC_STUB_REDIRECT(ext4_es_remove_extent, inode, lblk, len);
-
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-- 
2.52.0


