Return-Path: <linux-ext4+bounces-13259-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E8xK+EVc2l3sAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13259-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:32:01 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3296371028
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C03EA307BB22
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5F38A724;
	Fri, 23 Jan 2026 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jYkn8eSj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664436AB47;
	Fri, 23 Jan 2026 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149576; cv=none; b=trcxkwpj0gt1q8YlXUXJ/xA2caTLDxKmE5I7bQAwm+pzrDqsm+Y8vUFF5MqWcIdgTzpqFpEVoHUJWStscAFDT2tZgz83id9nTCciSEXB/hRHPwyhXXojrXyGFlnvRWLskaynOGFmaHwNR90PHuShMgN+GEqTLQa/3aLtTd66Duc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149576; c=relaxed/simple;
	bh=Ne9Og/NKADuc//8Ut+/1aozADufGWbHaGdFLUgehmNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8HgQnRx/HgVnbkEgZMB5l+ktN6YHS5EdIpFoLm6PWWGi5ztjXQ+Dr96aFF9ClcXD1UHq+EYmJuyM+x0UBWTBba0CxJk1gTEYtkw8bSNiHxJAwAlkd+swe8AVS9SfVYilMbiZUWzSxxPGc5el9+z8QbrDlGWc9UkN93Ua/dB+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jYkn8eSj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N010GZ020784;
	Fri, 23 Jan 2026 06:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GkGcSgiruMdMKbeXa
	c3R3h1XOdGbXjApmqmEjRTvb6I=; b=jYkn8eSjs1HXyzisjW7B3vmDAMBN1CiFA
	pMcTKmY25AaQbewLLaCFdFsVZagUXWessPzbMfFFixHb7k+rZzMkC7hvhtKVk7F1
	2FOvS02Ug1g5opLepTlYSvTs4jSSbOAYZ7vwO0CHF5dRJHZrJdqLgSxwwdKE9NsI
	QPmXV4crdpeoV40Yz3yIwBkCLmUFaBxmta+UexOdV9TvMAU+UzKeJmZ0WOIHeh+1
	/y3fHtyZ3EZ4olsZWb6s/ozHjh90HRYdmNH+V7EpvBN3DgixxJMkG+l4AsH9+rkL
	Cst4RjjzAolY8Sf/WTknQpphijQwnlXzSbG7QVRIj/LDhnD7PMVCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256ea95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N6Pffk022007;
	Fri, 23 Jan 2026 06:25:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256ea92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N44MUX024652;
	Fri, 23 Jan 2026 06:25:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxas5tgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N6PsB744499428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 06:25:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06B5B2004B;
	Fri, 23 Jan 2026 06:25:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A23120040;
	Fri, 23 Jan 2026 06:25:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 06:25:51 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] ext4: propagate flags to ext4_convert_unwritten_extents_endio()
Date: Fri, 23 Jan 2026 11:55:36 +0530
Message-ID: <7c2139e0ad32c49c19b194f72219e15d613de284.1769149131.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA0NiBTYWx0ZWRfX3HSnZkIiFcPN
 VjWTIg3uQCAhlLj66XFYIbv2qRFP7a84H5BYMUjiBcM0s8bLPU+bqV2N8a5BIkXQd7Qldexi8uP
 yggP5qR+gPuIvY76Rto+6cXFlkLH6uZgS4rI6ku3o2MGIqIXkr6ti0UWEGobRM7KueOH0yB0vGY
 Y0DPN6iS2OevV9idvA8u2gQnhC3I6eni+erM3Ru+NzmohKP2qUOBiTVFGExH3HPyAe33oguOCJB
 TgEwzvwaVxqnyOzKM/fp/YZL9Uw2WFi844mJLxaJyACgVPheNqJGad2tERRq3s+OMqob0L9+48k
 P/zUR+dRphuIw7080zYNfxM61w4CYIGb5X+VVVtoHD65+rG0fkrIXGVPn3VVlIKmtDKd2Qj2BeX
 lUzV5RLu4yth8u8jR5/KCKUtRihoJbojQXl2Jcaj0g515+TEf2487d9MKom/p44l9nOmXs6n59F
 e+7As0ADHFTUI/ePJvA==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69731475 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=s5sEB8iLFlBga5WgvCgA:9
X-Proofpoint-GUID: 4SvAm28hZ7VGp2N7zhFO-WINByT_RXIH
X-Proofpoint-ORIG-GUID: nF1wgPl9jf8iO_mmYgpuoSYKDj9dqvOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
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
	TAGGED_FROM(0.00)[bounces-13259-lists,linux-ext4=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 3296371028
X-Rspamd-Action: no action

Currently, callers like ext4_convert_unwritten_extents() pass
EXT4_EX_NOCACHE flag to avoid caching extents however this is not
respected by ext4_convert_unwritten_extents_endio(). Hence, modify it to
accept flags from the caller and to pass the flags on to other extent
manipulation functions it calls. This makes sure the NOCACHE flag is
respected throughout the code path.

Also, since the caller already passes METADATA_NOFAIL and CONVERT flags
we don't need to explicitly pass it anymore.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2747af91e78e..20939b5526b8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3780,7 +3780,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 static struct ext4_ext_path *
 ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 				     struct ext4_map_blocks *map,
-				     struct ext4_ext_path *path)
+				     struct ext4_ext_path *path, int flags)
 {
 	struct ext4_extent *ex;
 	ext4_lblk_t ee_block;
@@ -3797,15 +3797,12 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 		  (unsigned long long)ee_block, ee_len);
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		int flags = EXT4_GET_BLOCKS_CONVERT |
-			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
-
 		path = ext4_split_convert_extents(handle, inode, map, path,
 						  flags, NULL);
 		if (IS_ERR(path))
 			return path;
 
-		path = ext4_find_extent(inode, map->m_lblk, path, 0);
+		path = ext4_find_extent(inode, map->m_lblk, path, flags);
 		if (IS_ERR(path))
 			return path;
 		depth = ext_depth(inode);
@@ -3938,7 +3935,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
 		path = ext4_convert_unwritten_extents_endio(handle, inode,
-							    map, path);
+							    map, path, flags);
 		if (IS_ERR(path))
 			return path;
 		ext4_update_inode_fsync_trans(handle, inode, 1);
-- 
2.52.0


