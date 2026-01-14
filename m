Return-Path: <linux-ext4+bounces-12834-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6DED1F940
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 15:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0CC33016A9C
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542731354C;
	Wed, 14 Jan 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F4Hh5yx9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125D312828;
	Wed, 14 Jan 2026 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402704; cv=none; b=c5hAbCKm9xfqFFmgr3WS4OKsJ9LjnbXu7gusccpBxnN9qAcwAaYwZTq0rQaVMkreSVMDGpASu6z729E1x3PZ5kRL1k2EQZ1x3zD4suNMetr+TgYgq8+k6u9QG0t7hi2povqoifirEmGGwdHU7OcGyQPrfhjednHb7ghFDhUs300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402704; c=relaxed/simple;
	bh=RmA8Mn2UEy6nXNNHpi8bVXfvVtr/LrgDeCXh16ash1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmX8kLw4qb5yqOrtUprcI4RGyeqjwH8VhCDpp7bx14PtIgiJce8L6uQsLC3h/D5+i7/wD42ohqcX5QAbjulquYkmxA3ehNLeZ8aZ5h2+VPVKvlLljaiVfzU5VXcmjjVotB3qAqxa915qh5iRPE3X4RNb2sE04wZPbo4ZwN7f+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F4Hh5yx9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60EEOEQT021152;
	Wed, 14 Jan 2026 14:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xRYBouOhqGZBxg7oJ
	Obe+wXppfTxeBtfhLanfa4N3Pk=; b=F4Hh5yx9yggy+LMR6AtaeA5TqWAufVOX0
	eE618CogN8ahkR2mOqoesKr4DRU/ohcXM6NnG42+r9lReKD8VchJ1tnEJNIftgcI
	bJ8Cohfjpv8+DHEfR2ky9wA5vY+uh+IGdrH1MydMVXtnvTtR80COQFaFPHy7fHin
	B1EXqFkW6c0LaD28RdSwjTff74k3gIEoetb7AobOj/2h+9nHLH4277bCJ88WUWOf
	1MEGwTpbBge2Q3XuQgmUMwmmT4HDafyFmMWqgp/jX/DZOYur/duQAY1Ch4bHMxaX
	v0MxCoFVU+iEI2fm+ItwHwCTIoby9JaJvKvvhJD6lUqa+Eknc0XXA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4hvr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EEltu6010979;
	Wed, 14 Jan 2026 14:58:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4hvqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EDIkeO002493;
	Wed, 14 Jan 2026 14:58:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sttbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EEw89J45875672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 14:58:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8D520043;
	Wed, 14 Jan 2026 14:58:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F228020040;
	Wed, 14 Jan 2026 14:58:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 14:58:05 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] ext4: propagate flags to ext4_convert_unwritten_extents_endio()
Date: Wed, 14 Jan 2026 20:27:49 +0530
Message-ID: <91a23f1c21837277b1ba24db359fe928380aa979.1768402426.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfX3Rf54nmhtVMi
 bpuqy2n3J1KUXAZgv4lfSC/q8rWGKXnOI7jv0gd4L8S16LCNAb8TCqbX4f8NWgBzRDMb+TUcyjm
 tB/8xj6sab1zJIdx/yJ09t24qqYIDvh8L1H9oyBjM65+aJ0xGIWoxTCSoWUF0f2Fh/anaL0QvCi
 1XPnZ2uptEjxhdHF6dqNAQyw/gLb4gd7xz1nDALAoCna50TdAkPaOCtYWVcVzoD/0fiSKw9vwYN
 6NekJCFxFhXGe2Q+EZ4HygW0t57LP8DFvQSGJmWa5PCx8w/FZdykkNVS2yaB6uQ4K1ulsjXUMSL
 NBQ59ntGHWvznU3d38ux9mhrO4JbkQGxw6UX+yOxhRMINFvjdidye9pcRMAef+PgPNj5iHOHwzO
 zT+LustxYBEcMqk6dgGRKgaG0v5dnbv+h7zfH4/nNgt7ub8yJ+LpncBT4iXXjZBbFpitM/FTsPy
 fNVDYVwdjTiRrKflFWw==
X-Proofpoint-ORIG-GUID: Esf3C-K6sEN6bD928rckew5eAEchYVNN
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=6967af03 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=3Hmr0KNDBfcQ3tpqrfAA:9
X-Proofpoint-GUID: Ll49jOsHKzuLc6-NvDoU4AXMOKfx0ri_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601140123

Currently, callers like ext4_convert_unwritten_extents() pass
EXT4_EX_NOCACHE flag to avoid caching extents however this is not
respected by ext4_convert_unwritten_extents_endio(). Hence, modify it to
accept flags from the caller and to pass the flags on to other extent
manipulation functions it calls. This makes sure the NOCACHE flag is
respected throughout the code path.

Also, since the caller already passes METADATA_NOFAIL and CONVERT flags
we don't need to explicitly pass it anymore.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3d45abfb13cd..54f45b40fe73 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3784,7 +3784,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 static struct ext4_ext_path *
 ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 				     struct ext4_map_blocks *map,
-				     struct ext4_ext_path *path)
+				     struct ext4_ext_path *path, int flags)
 {
 	struct ext4_extent *ex;
 	ext4_lblk_t ee_block;
@@ -3801,15 +3801,12 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
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
@@ -3942,7 +3939,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
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


