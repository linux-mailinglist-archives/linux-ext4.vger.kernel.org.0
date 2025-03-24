Return-Path: <linux-ext4+bounces-6964-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3507AA6D540
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535B63AC039
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058A2594BD;
	Mon, 24 Mar 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iPob3KuQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F5258CEC;
	Mon, 24 Mar 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801860; cv=none; b=LMz7sKpMa7sVz9dm7/BNf5zCfm1tQklJacHXRgt3FCAWEVCSXx/mRKmPId9KQmzzoK2tYtqvvORhQOUF8/DLwqhqvk3XeD8OHtoqHHrSAflvvB8Ipio/8F250OWzJf1Zq5WDOfprFb8XrBdUq1HUuHCyCGL3it4+MWL12bY9JG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801860; c=relaxed/simple;
	bh=kH61CPjbgKcGvY1o1zLfjh8znxrdW5cGRb6BU60sqCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSvqsuDgqisErKqW7o75bidJj1tEbj6rkJnEonEM8UaCvojAUn6JrpOMc49wqzPOcOq+g4Yjqzz8B1Fp6sUh3Va5jQEF3Dx88OEsFouAueGMUmaDpUgMfXrKBU+VOCDEWifA89h0yksyaM0rlcb8geS6P21bkLCAXh920/0QblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iPob3KuQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NKcp3E012293;
	Mon, 24 Mar 2025 07:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ypHI+ECkAQMnukI0Y
	JmyEWA3haJeto49RvcUtRAkQNc=; b=iPob3KuQH3UVqdGOEc78HvalTENyB/Zgb
	MsKzW8OmDKvWVVyooXZzBgTmFAslxi3Q1qmamwpWhjtSk/a3ObiOYJ3GxMpbfmG1
	e76ky/Q62LlVZr2kHuMQQ2PqDZhY2AAZr9nqkHucOSstNKTM2ItyUSyYCrw+cuf8
	AXN7lHNYYl/+BmYN7U0g4LwQX1kmyXh2v6Z5cXaesNha3pWVUMSDRJfegIfyNFEN
	s3cTmsWxxbko0/NlvCES+ZM2XggTwp5gAoyqvIRT18SBdN16ivBc22/fAwnRvVfD
	Rk5R4Fozq46nZbcvW1Luib5C1u20J7wLaKLcXgP6ODVW492NiJXkA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsh021f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7a7DB002400;
	Mon, 24 Mar 2025 07:37:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsh021f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O3fJDe012240;
	Mon, 24 Mar 2025 07:37:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91kw3ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bSGP30540248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75C0A2004B;
	Mon, 24 Mar 2025 07:37:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8196220040;
	Mon, 24 Mar 2025 07:37:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:26 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 07/11] ext4: add ext4_map_blocks_extsize() wrapper to handle overwrites
Date: Mon, 24 Mar 2025 13:07:05 +0530
Message-ID: <af58d609f48c66de1e04638e419a8a56afa2640b.1742800203.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742800203.git.ojaswin@linux.ibm.com>
References: <cover.1742800203.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 43qNZqCoDqESOMDw0yAQGywdvwu4dvtM
X-Proofpoint-GUID: QoPWFJVpQXh1pivmJitXEEPXafZu5vo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240053

Currently, with the extsize hints, if we consider a scenario where
the hint is is set to 16k and we do a write of (0,4k) we get the below
mapping:

[  4k written ] [       12k unwritten      ]

Now, if we do a (4k,4k) write, ext4_map_blocks will again try for a
extsize aligned write, adjust the range to (0, 16k) and then run into
issues since the new range is already has a mapping in it. Although this
does not lead to a failure since we eventually fallback to a non extsize
allocation, this is not a good approach.

Hence, implement a wrapper over ext4_map_blocks() which detects if a
mapping already exists for an extsize based allocation and then reuses
the same mapping.

In case the mapping completely covers the original request we simply
disable extsize allocation and call map_blocks to correctly process the
mapping and set the map flags. Otherwise, if there is a hole or partial
mapping, then we just let ext4_map_blocks() handle the allocation.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/inode.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf19b9f99cea..e41c97584f35 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -678,6 +678,42 @@ static inline void ext4_extsize_reset_map(struct ext4_map_blocks *map,
 	map->m_flags = 0;
 }
 
+static int ext4_map_blocks_extsize(handle_t *handle, struct inode *inode,
+		    struct ext4_map_blocks *map, int flags)
+{
+	int orig_mlen = map->m_len;
+	int ret = 0;
+	int tmp_flags;
+
+	WARN_ON(!ext4_inode_get_extsize(EXT4_I(inode)));
+	WARN_ON(!(flags | EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT));
+
+	/*
+	 * First check if there are any existing allocations
+	 */
+	ret = ext4_map_blocks(handle, inode, map, 0);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * the present mapping fully covers the requested range. In this
+	 * case just go for a non extsize based allocation. Note that we won't
+	 * really be allocating new blocks but the call to ext4_map_blocks is
+	 * important to ensure things like extent splitting and proper map flags
+	 * are taken care of. For all other cases, just let ext4_map_blocks handle
+	 * the allocations
+	 */
+	if (ret > 0 && map->m_len == orig_mlen)
+		tmp_flags = flags & ~(EXT4_GET_BLOCKS_EXTSIZE |
+					  EXT4_GET_BLOCKS_FORCEALIGN);
+	else
+		tmp_flags = flags;
+
+	ret = ext4_map_blocks(handle, inode, map, tmp_flags);
+
+	return ret;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -1028,8 +1064,12 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 	map.m_lblk = iblock;
 	map.m_len = orig_mlen;
 
-	ret = ext4_map_blocks(ext4_journal_current_handle(), inode, &map,
-			      flags);
+	if ((flags & EXT4_GET_BLOCKS_CREATE) && ext4_should_use_extsize(inode))
+		ret = ext4_map_blocks_extsize(ext4_journal_current_handle(), inode,
+				      &map, flags);
+	else
+		ret = ext4_map_blocks(ext4_journal_current_handle(), inode,
+				      &map, flags);
 	if (ret > 0) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		ext4_update_bh_state(bh, map.m_flags);
@@ -3647,7 +3687,10 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 			m_flags |= EXT4_GET_BLOCKS_EXTSIZE;
 	}
 
-	ret = ext4_map_blocks(handle, inode, map, m_flags);
+	if (ext4_should_use_extsize(inode))
+		ret = ext4_map_blocks_extsize(handle, inode, map, m_flags);
+	else
+		ret = ext4_map_blocks(handle, inode, map, m_flags);
 
 	/*
 	 * We cannot fill holes in indirect tree based inodes as that could
-- 
2.48.1


