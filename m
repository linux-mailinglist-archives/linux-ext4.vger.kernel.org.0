Return-Path: <linux-ext4+bounces-13261-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPdzONQUc2l3sAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13261-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:27:32 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E270F6C
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A426B3025F68
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 06:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A28339E6E1;
	Fri, 23 Jan 2026 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LEiDmTs0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1538946E;
	Fri, 23 Jan 2026 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149586; cv=none; b=Jwidxlm037Ue/1r5zvGa1V71sws+B6oe80/dxqYlGx63D4fZY1Y98BgqKmmgxc4E47uCvCvziQtjadlKmjiyRxrRJvVWUEQv+bNl07FcQwuEdwVbjUK9uU9+MrVw0U+pzbC850ndpElkcuhug/BexVp21bv4sjxc9Vqm18DYmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149586; c=relaxed/simple;
	bh=SDPrmZkaloj1OviWw6+W6I5u87D/L8PHs4zs09hNsXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9BGSuVPTrZTTwcL5+hdusWIzrbbHNHOGQJxzgMQOg5+jP1VtRPfthx3CReT6eE2kwo2cwLxWbCUo9ayE5n/SfHtgS2hXHP13IB7CGjJXHlPoF/jCtMc1dkTt4vvzm5BAoSqgjp6iu5Ofvp7OMfq3QRR3oSY+RUMuLozOhAiZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LEiDmTs0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MLlSvG021326;
	Fri, 23 Jan 2026 06:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4ADFMMHAXiKaIiNR6
	vBP9uCUmbxSmzucAMe3Fj04WOo=; b=LEiDmTs0Zb7M/Z4ViYIiatE01LhV/aHs3
	LvpXFSK6rQcp2fR0C5SBodDNz5ofZADdgbNRO5kRt5pxEpS0H4LhzOqW4q1tkIsX
	50dS/TdYrjJdpjI7q9h3gcIy4mrnFUyWOTrbkJHP1cCuTSCuumQz4Xfpb5/f0Kyc
	Ct6cwBjQPf8HcvkHULTQWrxL1b7FGYV8e2wy0Qe3LXlGWrYZ8qb5w6+56fyZPuZZ
	5xNt0NONK+0W4niGS4DEJfslDsRWeE4HfhS6TY8Ie8zmm+latOl2IkxPSDu7fu9D
	Sjc4EUfZIPB+8qw/DFlJjep2+hLcgjnjfldoPJwFCb9Fw1jl2qr9w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612h1ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:26:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N6PbbR005279;
	Fri, 23 Jan 2026 06:26:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612h1cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:26:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N4n0L0006451;
	Fri, 23 Jan 2026 06:26:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1y6hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:26:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N6Q0Vh16581038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 06:26:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA27B2004B;
	Fri, 23 Jan 2026 06:26:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF5F20040;
	Fri, 23 Jan 2026 06:25:58 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 06:25:58 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] ext4: Allow zeroout when doing written to unwritten split
Date: Fri, 23 Jan 2026 11:55:39 +0530
Message-ID: <1c3349020b8e098a63f293b84bc8a9b56011cef4.1769149131.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: I9z7CTj-u72IjC0T-o7si2BHoXvdmbP_
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=6973147c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=kZK9M-q0HhXr2Cl_658A:9
X-Proofpoint-ORIG-GUID: 4AdbEr1IgerHfGUAiJDAGuAW75nYRANQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA0NiBTYWx0ZWRfX6RGiokzR+3Kr
 +i4AfjRbii8x5MZOK/Bl64jiFjURJItbYwb7o4HsZPkejOaiP0yp3c6Rm6xoDhvrfEsIxfUO3vK
 /1XI07+sX4hLed/PBKT1OUlBXlVSGAmhWuiJLOyNngUK8AMj+RfO/SEWovvI0O3DbDMMWfa4yPE
 28CfPjk0LibBP5AzldmthCPMhZsxgiZolkqsD7HVNS7PwClJ99b6xJuhkM3qKAxj95JLqnd1MSK
 wgg/wwhYBfjSKcvScZa4ZOspJb7hV2aQ/lKVTupPdgpSrIhWVftSumMz6ajChFsDYXXeo5gF2tx
 zmcqM+ucKV261SX+uFlfFzZFJxzUWdEAdERKTyvpRpFmAOqlnnqbJyDOcllIgMkR2jaVVbjTPdj
 E67KNeJSwNcq0mnu0Hrtcmj2pewdlzxT+DEmkXavGsInJvwMHYwjOrB2WKDP0LUawlH3K7sskOY
 X0UdOWynuUxVku8KnKg==
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
	TAGGED_FROM(0.00)[bounces-13261-lists,linux-ext4=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:email,linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B9E270F6C
X-Rspamd-Action: no action

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
index 3176bf7686b5..4879e68e465d 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -613,11 +613,57 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
 			       .is_unwrit = 0 } },
 	  .is_zeroout_test = 1,
 	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X', .off_blk = 1, .len_blk = EXT_DATA_LEN - 2 },
+			      { .exp_char = 0, .off_blk = EXT_DATA_LEN - 1, .len_blk = 1 } } },
+
+	/* writ to unwrit splits */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
 	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
 			      { .exp_char = 'X',
 				.off_blk = 1,
-				.len_blk = EXT_DATA_LEN - 2 },
+				.len_blk = EXT_DATA_LEN - 1 } } },
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
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
+	{ .desc = "split writ extent to 3 extents and convert 2nd half unwrit (zeroout)",
+	  .type = TEST_SPLIT_CONVERT,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
 			      { .exp_char = 0,
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 2 },
+			      { .exp_char = 'X',
 				.off_blk = EXT_DATA_LEN - 1,
 				.len_blk = 1 } } },
 };
@@ -667,6 +713,56 @@ static const struct kunit_ext_test_param test_convert_initialized_params[] = {
 			       .ex_len = 1,
 			       .is_unwrit = 0 } },
 	  .is_zeroout_test = 0 },
+
+	/* writ to unwrit splits (zeroout) */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
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
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit (zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
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
+	{ .desc = "split writ extent to 3 extents and convert 2nd half unwrit (zeroout)",
+	  .type = TEST_CREATE_BLOCKS,
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0,
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 2 },
+			      { .exp_char = 'X',
+				.off_blk = EXT_DATA_LEN - 1,
+				.len_blk = 1 } } },
 };
 
 /* Tests to trigger ext4_ext_map_blocks() -> ext4_ext_handle_unwritten_exntents() */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 14f38b3cda27..3630b27e4fd7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3462,6 +3462,15 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
@@ -3811,15 +3820,10 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
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
@@ -3941,7 +3945,20 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
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


