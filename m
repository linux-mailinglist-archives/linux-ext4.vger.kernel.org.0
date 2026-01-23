Return-Path: <linux-ext4+bounces-13257-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF5hDZIUc2lksAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13257-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:26:26 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B50AE70F47
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D96E430173A9
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 06:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C59F39DB05;
	Fri, 23 Jan 2026 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S9+TXXrC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743BE35FF4B;
	Fri, 23 Jan 2026 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149573; cv=none; b=akHIBpZAx0D7KBC62DeLHIDuQO8hm/mMe79gNn5QHLp8IWTY6G3PUEIQB/7R02Ji+awGklXSvY5nQa78QXT4xdcLLVc8olK2GTRHAbwUVQr3H3ALnSIQ6pLIuqy7ish/3jMlAZJC1pfIFI0BM5UZwuhjeypeKOypD5P9bRHP4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149573; c=relaxed/simple;
	bh=0RoNooc4CjRO+Ri6Ttob59ZeDvmEf1Fi6CNq89SDcCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLOSwtd82wIgD5F/vc3quiGBweQO9dVmrVQznTyfONUgZzv2RYPrfCWTBs1RdAWEa5s/omx9O7e7GT2KEOvV+c7Y9MT83c4MFrxPHEzdJJ84hyfmozL53VTcHUc1Bj7NlauBSXZAVyMxE4Obkohf9SbpHbTHFVdp1D0w6iFiPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S9+TXXrC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N3fh49021241;
	Fri, 23 Jan 2026 06:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3BmcwHhyK/Z+Z2LtW
	2Tmgz7blpJ82bbpHkBLNVmqiPY=; b=S9+TXXrCXXUm9oTChRBPrn0pm2zwIevjM
	qheK4EgRCPHjPeXwrVviizPWkN/X5RJhlpjCaJ2oJ/ReQz/VOoNUm5+am+mP6wbX
	RTMRa5+Qelnvm41cUn3nMFn2tXcqwighn1Rlf5n2wJfn8JUg1U+XQqbdkoRo/Xf+
	Az6BtuduboH0uL9bbHSn3+nHA8MA2xb3RC2CdQgI3En7FOcaco8yEJu59dpMmquO
	au9Xv/cuRcDI8Xbtt71R7Jri/A7fv9Rzkpcz616+2RNSDFqsleMeaXsJ6/QEsJSX
	WCuPP4kg+L5RTg5dxQ/7pXWBjifJvkbfyk7Uo+OG/Fq1flRg9ZhqA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612h1br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N6GqxR016136;
	Fri, 23 Jan 2026 06:25:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612h1bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N4kEbi001171;
	Fri, 23 Jan 2026 06:25:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyk7a3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N6PnCR44106048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 06:25:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5497420043;
	Fri, 23 Jan 2026 06:25:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B57620040;
	Fri, 23 Jan 2026 06:25:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 06:25:47 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] ext4: Add extent status cache support to kunit tests
Date: Fri, 23 Jan 2026 11:55:34 +0530
Message-ID: <5f9d2668feeb89a3f3e9d03dadab8c10cbea3741.1769149131.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: lMJLXpxREvnMh1QTrzbfoBo4H2PzqBAw
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=69731470 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=mO1zcom0dC79SphzpucA:9
X-Proofpoint-ORIG-GUID: R74iuf1YfTWqsigcuEZ3Hkfme6a56osn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA0NiBTYWx0ZWRfX8Pj/1zkW0KmN
 04A5tO8vn8G7szQ8bsht1dv/nw0eLYaNswTmR+gUo18K+YHaosW4mqqVi9dMubRcGXimZqLjGaJ
 lSQ6GnRiWPUN5/D1pnH3VjkBkaMzFed72bIH3tWptBnmslA2zrzjTwKm2yDjzQWyRxfRZhN3TIv
 ++yeku862EbGPRazkkc/WHzbzfLAOycYlCbdMe5x7pAFTlig+0BzpVZQq7m/1RCNMElVlCxf4JI
 5FN5iVBFGv02h3TUt5awq130l82RcQFIntKjXCWz9jdJpeO0Obk1hyXZR9vDyuU5J3+aT9Uf41H
 g0X7WSNCbONVMIU56iciVwXN707Nkc9bNh1bsoeZJhbNRhcyqh/Nbfs/ryxPthkaVCHpm14tgNm
 39ca20cxH8KNJaJPcadFn9qIOabBVX4XH8a21/R/L6KEdr8hYlBlXGpQhz0nQMo6q4cjKwZRHPn
 jiwY8sLzSfjx/pzkucQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13257-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,suse.cz,vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B50AE70F47
X-Rspamd-Action: no action

Add support in Kunit tests to ensure that the extent status cache is
also in sync after the extent split and conversion operations.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents-test.c   | 103 ++++++++++++++++++++++++---------------
 fs/ext4/extents.c        |   2 -
 fs/ext4/extents_status.c |   5 --
 3 files changed, 63 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 4030fa5faca5..3176bf7686b5 100644
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
 	ei->i_disksize = (EXT_DATA_LBLK + EXT_DATA_LEN + 10)
 			 << sb->s_blocksize_bits;
 	ei->i_flags = 0;
@@ -307,16 +295,15 @@ static int extents_kunit_init(struct kunit *test)
 	if (!param || param->is_unwrit_at_start)
 		ext4_ext_mark_unwritten(EXT_FIRST_EXTENT(eh));
 
+	ext4_es_insert_extent(inode, EXT_DATA_LBLK, EXT_DATA_LEN, EXT_DATA_PBLK,
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
@@ -381,7 +368,7 @@ static void test_split_convert(struct kunit *test)
 		kunit_activate_static_stub(test, ext4_ext_insert_extent,
 					   ext4_ext_insert_extent_stub);
 
-	path = ext4_find_extent(inode, EXT_DATA_LBLK, NULL, 0);
+	path = ext4_find_extent(inode, EXT_DATA_LBLK, NULL, EXT4_EX_NOCACHE);
 	ex = path->p_ext;
 	KUNIT_EXPECT_EQ(test, EXT_DATA_LBLK, le32_to_cpu(ex->ee_block));
 	KUNIT_EXPECT_EQ(test, EXT_DATA_LEN, ext4_ext_get_actual_len(ex));
@@ -407,11 +394,14 @@ static void test_split_convert(struct kunit *test)
 		KUNIT_FAIL(test, "param->type %d not support.", param->type);
 	}
 
-	path = ext4_find_extent(inode, EXT_DATA_LBLK, NULL, 0);
+	path = ext4_find_extent(inode, EXT_DATA_LBLK, NULL, EXT4_EX_NOCACHE);
 	ex = path->p_ext;
 
 	for (int i = 0; i < param->nr_exp_ext; i++) {
 		struct kunit_ext_state exp_ext = param->exp_ext_state[i];
+		bool es_check_needed = param->type != TEST_SPLIT_CONVERT;
+		struct extent_status es;
+		int contains_ex, ex_end, es_end, es_pblk;
 
 		KUNIT_EXPECT_EQ(test, exp_ext.ex_lblk,
 				le32_to_cpu(ex->ee_block));
@@ -419,6 +409,33 @@ static void test_split_convert(struct kunit *test)
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
+			ext4_es_lookup_extent(inode, le32_to_cpu(ex->ee_block),
+					      NULL, &es, NULL);
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
@@ -429,6 +446,12 @@ static void test_split_convert(struct kunit *test)
 			  le32_to_cpu(ex->ee_block),
 			  ext4_ext_get_actual_len(ex),
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
index 08aa36854c11..16326d7f09b9 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3145,8 +3145,6 @@ static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
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


