Return-Path: <linux-ext4+bounces-13057-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94603D3B4C7
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 18:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 400A33068FA3
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 17:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6171D37C10D;
	Mon, 19 Jan 2026 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q5+NNjnB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799A3659F5;
	Mon, 19 Jan 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844623; cv=none; b=PEs8ktYuhmtjj0pM6yFqLqStEjUz0P+T6wPDz57JC4Y7hQqolR2HGlc6pf64PWdkCH7/o9zaqiHvfypvR+Bo3QTWIL++GolHI0X8C4FX403s8wMv4SjY5CBkDOwDX3I96wR43WZsUtANsBLgAbhjaIKEJJGkPObCYvt9s0NNus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844623; c=relaxed/simple;
	bh=+s/h8WJppVKzzUHvAQjxlIa3VRKnGTPCvZL1eqkR6kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5/T2qumyebY8/9VJOupeNMQJiNrvFgOH08kanFPnPa9vDUv0v90qzFvqPY1Y9QM5uGJqEbinepbZSt6ItNcI19oqwl6bh7rlADum/MvsIUPpTGEnoElwgx8YkFAX2mKdqRLC4zb2jRlajdPZq4/f0J7Qua3AC+yHIvnxxeHEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q5+NNjnB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDUDaJ032418;
	Mon, 19 Jan 2026 17:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jsoQTB2b/hNGorzIg
	t09q6mjMQ9NXv3UIZdugbKGb4Q=; b=Q5+NNjnB+lDQDEvFJeqP9vWpy85AhguMc
	By8p3vTHQsyGWs3plxZs8vlYDHB4uypS33RyXFYC/FpPXAa4qtGLEzMhb6wdqenb
	2/QDxyFWxqn1A6SvpPC4rl15zz9l2GXL62g+1fRXDtaYNixNJSDUjC1WQS0eiQlY
	3JWLYRGrmtD7NXp8TYQZXgAKE99rn7cwH27z7OpJ0npPclSEOWkDAEpbHTDB/zfm
	Zy1xBAmc/Gu2dVSafefO6T9Y74OK1wlzTCucHdmpRhMMy+4Nej7OJY6KkWlRqs9L
	Sa18ZMA//a/bZgp4lWm6iY03VRHioYUfxJ3jEFyQ5H8W5hPrWTKXA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u8xsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JHhYdu030376;
	Mon, 19 Jan 2026 17:43:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u8xsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JGBMqo016636;
	Mon, 19 Jan 2026 17:43:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xrbs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JHhVIb52363674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 17:43:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DBF420043;
	Mon, 19 Jan 2026 17:43:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86A020040;
	Mon, 19 Jan 2026 17:43:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 17:43:28 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] ext4: Allow zeroout when doing written to unwritten split
Date: Mon, 19 Jan 2026 23:13:04 +0530
Message-ID: <326263653b81906881df4cc45c7e5e6e61755721.1768844021.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: DNSPP5izju6hX2v2qOyaSfs0imAW5vmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0NCBTYWx0ZWRfX76j/O55z1HIj
 nJhu2u94BgoI+UWhCL80CFaZjkem1jz46rfS6ZQ9KHJ3eLuVVU8gaKkBoJfA+TTScxwahMR1Eeu
 WOJvE0GJO3FezWNdJlrHXlDMQ/3OcdZvaycWPoM99FqB1fQal0MUlVHrlYozkSCFW2UaXDUgVFE
 2dPf19ua4WYfPyQt03Ps9ElLIA3v+1QCrJAl1sQFwlYTLGuyNzHJCaDZRgIo7vhWmpF8KWWf26y
 kAw7c3yNR9YH65hXnCIvdvu4S/FohCJVjolVTWte8HjWuSsaW30DtDcXGEhAl27U61Pvh3ODQzR
 R0cI2iy2VBA50kGxOXfzbFccy1eeZM0qAex8JUR1N9SlTE1SgbEeOI8Up5CUIK8sUakVZvGoXDK
 k2XQKG2kA2kI1OzZq2OSU05Kxa8N0oYM9cAjuPds15K52Pj+JpA6JDNgenftTmxnQ4fcrn1phad
 yuRKGhqnYX3EnrzXHPw==
X-Proofpoint-ORIG-GUID: NG0zSLyqZQRDvUJirqjCIuThTWsb-Y_N
X-Authority-Analysis: v=2.4 cv=Sp2dKfO0 c=1 sm=1 tr=0 ts=696e6d46 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=kZK9M-q0HhXr2Cl_658A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190144

Currently, when we are doing an extent split and convert operation of
written to unwritten extent (example, as done by ZERO_RANGE), we don't
allow the zeroout fallback in case the extent tree manipulation fails.
This is mostly because zeroout might take unsually long and the fact that
this code path is more tolerant to failures than endio.

Since we have zeroout machinery in place, we might as well use it hence
lift this restriction. To mitigate zeroout taking too long respect the
max zeroout limit here so that the operation finishes relatively fast.

Also, add kunit tests for this case.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents-test.c | 98 +++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/extents.c      | 33 ++++++++++----
 2 files changed, 122 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 7b7ed347e14e..f58f59b7872b 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -611,11 +611,57 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 0 } },
 	  .is_zeroout_test = 1,
 	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X', .off_blk = 1, .len_blk = EX_DATA_LEN - 2 },
+			      { .exp_char = 0, .off_blk = EX_DATA_LEN - 1, .len_blk = 1 } } },
+
+	/* writ to unwrit splits */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = EX_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
 	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
 			      { .exp_char = 'X',
 				.off_blk = 1,
-				.len_blk = EX_DATA_LEN - 2 },
+				.len_blk = EX_DATA_LEN - 1 } } },
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
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
+	{ .desc = "split writ extent to 3 extents and convert 2nd half unwrit (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = EX_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
 			      { .exp_char = 0,
+				.off_blk = 1,
+				.len_blk = EX_DATA_LEN - 2 },
+			      { .exp_char = 'X',
 				.off_blk = EX_DATA_LEN - 1,
 				.len_blk = 1 } } },
 };
@@ -665,6 +711,56 @@ static const struct kunit_ext_test_param test_convert_initialized_params[] = {
 			       .ex_len = 1,
 			       .is_unwrit = 0 } },
 	  .is_zeroout_test = 0 },
+
+	/* writ to unwrit splits (zeroout) */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EX_DATA_LBLK, .m_len = 1 },
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
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit (zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 1 },
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
+	{ .desc = "split writ extent to 3 extents and convert 2nd half unwrit (zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EX_DATA_LBLK + 1, .m_len = EX_DATA_LEN - 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EX_DATA_LBLK,
+			       .ex_len = EX_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0,
+				.off_blk = 1,
+				.len_blk = EX_DATA_LEN - 2 },
+			      { .exp_char = 'X',
+				.off_blk = EX_DATA_LEN - 1,
+				.len_blk = 1 } } },
 };
 
 /* Tests to trigger ext4_ext_map_blocks() -> ext4_ext_handle_unwritten_exntents() */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index fbfe2576d5f4..d55633ddaad0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3466,6 +3466,15 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	if (!(split_flag & EXT4_EXT_MAY_ZEROOUT))
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
@@ -3815,15 +3824,10 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
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
@@ -3945,7 +3949,20 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
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


