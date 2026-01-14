Return-Path: <linux-ext4+bounces-12836-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0137D1F971
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 16:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00EA4307C340
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4FA312828;
	Wed, 14 Jan 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YdlwHMlS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A468331064B;
	Wed, 14 Jan 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402710; cv=none; b=cDZa5h5oItrzNOXhBfP0m2JAhHsf/xb/rsBQFydky6jJ9IKm7pZ9naM0vjsaQbgJwirLSiSQo7pPAvRPYFbcOB5g7+efE54nj6oPT5I6lHkx9mBCo5TUFdu9DjFOoHiu26kJP9kB7iIX0flhkP6ON4vYpD4O2z1BwuzDfbAWy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402710; c=relaxed/simple;
	bh=SgJnuneZfBEptjk3CKrzVeOvzK2/qxj16pUsOPyIfCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUHq08J93IHmUZiRSq181wwF/ISJjadzWCPFEJ5Dt+P+lzIgZqwAC9VLOW+0es1JzZorMu+qyQHg4n4zCaqagGph6CK65T1VKtGhEtoJtBWgKEin3eMp0JkW+uNoADJqcsOG7ZpINiV5pcLpcoEvGZRcPkV7VXERsdRh/AEwg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YdlwHMlS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E73Fuu001282;
	Wed, 14 Jan 2026 14:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7He49mbVXbJMKnOLs
	7QJ4/Yi8+c8ZqLxolUX1ivDuqM=; b=YdlwHMlSr7RBnq9fDD8YWXnHrd0zrb5vn
	UPuAlhCgnEznQJomP+fCrm7V43DWzkyZ2Ks4eNs6XeNck5oWTZKbsvnK/qt9QTin
	GdvEIedhCp36vFHajGhFFcVA7m93J4iaIw9aEl4PdDrhdEAwVm47D9FEYR8Kd4rX
	mISIoE2PJC4PT83RonLKvEL/sFW1PeIo9ZoW1UhAJRhcZ5F6ZctCAFxp2qn9tCPC
	Ne282CtiIAQggz62m9tvRmeZdCYB6acv6f1lVbNyFk5FmDrKVPJ7nyvouuy3QvbR
	V5o4IDpSs3O1CzfHwVyuorXWKzDwVaRLEs/CpPZIRsdWOcnTeQ1JA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeq1xwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EEagAF017194;
	Wed, 14 Jan 2026 14:58:18 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeq1xw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EEspTY030126;
	Wed, 14 Jan 2026 14:58:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajtesc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EEwFl051184110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 14:58:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9166720043;
	Wed, 14 Jan 2026 14:58:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 825AD20040;
	Wed, 14 Jan 2026 14:58:13 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 14:58:13 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] ext4: Allow zeroout when doing written to unwritten split
Date: Wed, 14 Jan 2026 20:27:52 +0530
Message-ID: <16dc2c0921f482fd3dc6fa1d5bbae64eaba591eb.1768402426.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=6967af0b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=w28e6cZkELUtuWLa0a8A:9
X-Proofpoint-GUID: XAx9OrGiJD0wAoUnQ7SOhgD9rF8JXMDN
X-Proofpoint-ORIG-GUID: a5_lzgO9k2JN7tfF0P6ggfEs3Zbfxykv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfX8dkLYEeDqvnZ
 aI27Q8HnVKcUV/hxGe2tkGI7M90tQARur5cKJW4Vgy3EPyLcM/qXh8RxxyDZCmonQ0tYwp1i4ah
 80efF6VS3M31wD8HChyy6fw8HAcalHg5zJCOkcW2gutotS4EaQvCAS0YuE/H41GjhmK49QK2Ofo
 s6P++ehaZ/dH5plxVY0v4ikG+jid8NtruFe/sJWaIW+/UmZ5EnlsyxJHRymsJpV8otvy+Px3Y7C
 Tf+6C8ZhOpy+oAXacD69/xjteXL5rFM7M6nooOXGAI33pavL/gtvC86C+MOm2U0TLjzHPDoRG+x
 g3y23TXqJqDBE0dnu3jqVrtx7IIz9y060e6InRUWjEl2wW69cKvm+EDCNTxXD5OoJjR3E5+XCmn
 3xpc36A75aZQqBQLJmYJxNkf4NYrXQhH8iiku42vvP9n0W3fR0IQ2lJpitU8tM/B/0dbTl8Elzs
 qXss7LOplkDZGfk8ZSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140123

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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents-test.c | 71 ++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c      | 33 +++++++++++++++-----
 2 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 86fcac66be6f..d3a26cc8a9ad 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -578,6 +578,41 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			      { .exp_char = 'X', .off_blk = 1, .len_blk = 1 },
 			      { .exp_char = 0, .off_blk = 2, .len_blk = 1 } } },
 
+	/* writ to unwrit splits */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
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
+	  .type = TEST_SPLIT_CONVERT,
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
+	  .type = TEST_SPLIT_CONVERT,
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
 
 static const struct kunit_ext_test_param test_convert_initialized_params[] = {
@@ -610,6 +645,42 @@ static const struct kunit_ext_test_param test_convert_initialized_params[] = {
 			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 1 },
 			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 0 } },
 	  .is_zeroout_test = 0 },
+
+	/* writ to unwrit splits */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
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
+	  .type = TEST_CREATE_BLOCKS,
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
+	  .type = TEST_CREATE_BLOCKS,
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
 
 static const struct kunit_ext_test_param test_handle_unwritten_params[] = {
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8ade9c68ddd8..4c6e4e7a80b0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3463,6 +3463,15 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 		 */
 		goto out_orig_err;
 
+	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
+		int max_zeroout_blks =
+			EXT4_SB(inode->i_sb)->s_extent_max_zeroout_kb >>
+			(inode->i_sb->s_blocksize_bits - 10);
+
+		if (map->m_len > max_zeroout_blks)
+			goto out_orig_err;
+	}
+
 	path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
 	if (IS_ERR(path))
 		goto out_orig_err;
@@ -3818,15 +3827,10 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
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
@@ -3948,7 +3952,20 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
-	map->m_flags |= EXT4_MAP_UNWRITTEN;
+	/*
+	 * The extent might be initialized in case of zeroout.
+	 */
+	path = ext4_find_extent(inode, map->m_lblk, path, flags);
+	if (IS_ERR(path))
+		return path;
+
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+
+	if (ext4_ext_is_unwritten(ex))
+		map->m_flags |= EXT4_MAP_UNWRITTEN;
+	else
+		map->m_flags |= EXT4_MAP_MAPPED;
 	if (*allocated > map->m_len)
 		*allocated = map->m_len;
 	map->m_len = *allocated;
-- 
2.52.0


