Return-Path: <linux-ext4+bounces-13053-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E5D3B4EB
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 18:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35B7D302D354
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 17:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B3832B9BC;
	Mon, 19 Jan 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gX6g/DYb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215532D0DC;
	Mon, 19 Jan 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844614; cv=none; b=UIsmzsOVatBxMvdrcl9NBxgFhv/wc3hVqd/2u0esAHv1JXggYQA/UTibD85qkbqcU7uGqgq2jabb/nSWOmwlYnZOhh3FUMycx+wMIEljb3vVJbGNuaPdYQ2Li9zsqWPFVc4Cpj/Afcmz4C22/MmLnAToD1nTXHloEyzzjLndW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844614; c=relaxed/simple;
	bh=j4izDwJFPE/GHTjcLl8ooKHtF7XKOWYbKDRMEgVHr3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuiyALJ3/hhC9KGwA/B6ky1bzCi9c3zqulDon/Lo1pgpXPsL7698aFY35YdfoZuWg49nSBYCsVAfPIIb9+NYuV0Pg3S8l8ynWLoWRc3xPgw7bCM+0vSHLEUrgVIgPB+9U89cOaN357/+Wv4YWcXLpqpjWoOpRBy1qYzMsoHS1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gX6g/DYb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDUs1I020107;
	Mon, 19 Jan 2026 17:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XIA3bAo38/ZFOvHt8
	kVGua+Qk479+vUj2vzug9Gcw0A=; b=gX6g/DYbEDaifaXPMjxz6UaD3JdnAHaJx
	CzFvjJbtYsWkUXWar640C/sj92/zTXZatJ90WZnzHVJu+gcZuC71VWLrXuBaoXCJ
	BwVdONNTuA+XceEACp3nQrZ7xQCzwMK69hgdggZ4EzqKtVCZfX7Rn9a7j2BFK2Eh
	ezDshAjhKk6eX9HJGQTdeFV3uVruBHexkn8lTDRS8vBMh5rIsJKzKs7xydg2wZgE
	JCNDCcSlo7JKPXfOIcyjBitkn3+gEm/ix4cbaDbSawH1naOgGwZx2YypdPcxJ3fK
	RrsbVHuZ/gO8HwIKSPZF8PV/JzYEwW2MttMO+0WXkLiwZ9tIMEuMg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rstbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JHh4he016657;
	Mon, 19 Jan 2026 17:43:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rstbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JGXqg0017070;
	Mon, 19 Jan 2026 17:43:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xrbqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JHhHOg42271160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 17:43:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69D3020043;
	Mon, 19 Jan 2026 17:43:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88F6E20040;
	Mon, 19 Jan 2026 17:43:14 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 17:43:14 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] ext4: Add extent status cache support to kunit tests
Date: Mon, 19 Jan 2026 23:12:59 +0530
Message-ID: <5e78d0dbd45a8677ed9590abace42e4c8b0c2489.1768844021.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: 0SJFS8vaTAfShnbpWjoyk-y2h5O48_eD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0NCBTYWx0ZWRfX5GjBfkS6FqNI
 nUsXxFK7WqHKxkpojYM4XEvaJiJHwDgHeZV8cdhAUgxAQXb+xuO+/F2fOPMdq1TMKMm1Jb14w+q
 4iulsDP6lVsYhCfHwsM717I07N4BICBdocxMaN2EqglGjwCceVQ3gKu7snUC/zJcdZx2yx6wglw
 UCsT1UgwHvNpHexDLdSh0IrDMMyNcs+gEr8CgxgHRWIB0OyoojNP3pob0et0mIKEYaWfyMHvUmJ
 48amgaAw8xu0bM7UNnfBi+lieaH73js9qkNB6nr1Imuyijq3xPNBzG+AJMV1xbR0ev6YOAieXvL
 NeFwEUOCTOuySNq7hzW+YMpSTiDV+L/HjO/kCFUMM0yjA6GCTgO3Wp0KIbNljvHW7WMebCmAbrF
 UhMGe0Yi5Q8urrQFrDBs7PBCunlezWi9FY2huzg/67wVL56yWe4pgy5lhkAXz8SmUbTGSf9bFHQ
 kUwf22JVNCz7FzodUFA==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=696e6d39 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=mO1zcom0dC79SphzpucA:9
X-Proofpoint-ORIG-GUID: oZtZigFvy9ffx7vjyLefb4e04QgXk-pf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190144

Add support in Kunit tests to ensure that the extent status cache is
also in sync after the extent split and conversion operations.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents-test.c   | 106 ++++++++++++++++++++++++---------------
 fs/ext4/extents.c        |   2 -
 fs/ext4/extents_status.c |   5 --
 3 files changed, 65 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 082c3e170e54..7b7ed347e14e 100644
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
@@ -307,16 +295,15 @@ static int extents_kunit_init(struct kunit *test)
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
@@ -381,11 +368,12 @@ static void test_split_convert(struct kunit *test)
 		kunit_activate_static_stub(test, ext4_ext_insert_extent,
 					   ext4_ext_insert_extent_stub);
 
-	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
+	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, EXT4_EX_NOCACHE);
 	ex = path->p_ext;
 	KUNIT_EXPECT_EQ(test, EX_DATA_LBLK, ex->ee_block);
 	KUNIT_EXPECT_EQ(test, EX_DATA_LEN, ext4_ext_get_actual_len(ex));
-	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start, ext4_ext_is_unwritten(ex));
+	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start,
+			ext4_ext_is_unwritten(ex));
 	if (param->is_zeroout_test)
 		KUNIT_EXPECT_EQ(test, 0,
 				check_buffer(k_ctx.k_data, 'X',
@@ -406,17 +394,47 @@ static void test_split_convert(struct kunit *test)
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
@@ -426,6 +444,12 @@ static void test_split_convert(struct kunit *test)
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


