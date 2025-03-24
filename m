Return-Path: <linux-ext4+bounces-6963-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D04FA6D533
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F15C1892B42
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3116258CE9;
	Mon, 24 Mar 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q5TcCno4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B92586FB;
	Mon, 24 Mar 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801858; cv=none; b=DBl2OF00WvQxkfRDnslvWEBJeoBtcwXQBSWG51Q0LLEKIAgeAsV2+8OBmlWyUJeZZerN2Qn4i75EcWu4MMJUpU+3e22u4n2UJmY7oM/5MawxjAInnfOtXOyYRCEv85TqCdJgK/2/cfBxguOHHpJQZvAKPI2tSjx+mZ3fDqKANm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801858; c=relaxed/simple;
	bh=PgiRgsauRzLuz9ExWPwjx57t3tHOS9kM81k8WTIHAeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKFgxW2Z95e/Mw5rh5Q8/v6rmyZb0gPRBk3TiRAJm7xKZuGexSCDLzBRNxdTvNCe12JRUo3EVCoShRJIgs5Fq3xS/1gRR1v59FNoeiMQE0WN6IX46UVabfh0Nt8Q2Fur0ClVmwrAXcvbJ+uRY7lQakKRGzTlmyCv6I9X+4WhWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q5TcCno4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NKxkAe030463;
	Mon, 24 Mar 2025 07:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Dj21oKUFOE54gMtT4
	Frv2frqo4ju3Azg5xQNW3+iVM0=; b=Q5TcCno45jgfs2n3zWtszp0/ce2vQSvPL
	vmOGAjudLWZtEwR/xk8xjZljVRCHQY438gfUto/sc3ivwuwljhLj2YPLXEl6mqYH
	uw9nLQZNfc04eWqYOdyzHewSjSOTyzEC56xku3SRpL42u98I7YbVjKmEr/z7Epnx
	x2D5mygkmr0B/N1cL4EtpZ60/2ZC3MR5+rxHdPicwGsBAZF8KgaPxKZAaJKnxVx4
	Xu98S0UewrZ2MWFCSINsDJfAG97YP4+jLXTSomQrSR3DHRfgouxSQnQdENnycNaT
	UhP9PF5qU+3aVGKr6g3fOPzUznZgZQzsS9v4ut3TS0qBy4XL2Tjzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwthfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:29 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7X7Jf021329;
	Mon, 24 Mar 2025 07:37:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwthfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O7KaK3025462;
	Mon, 24 Mar 2025 07:37:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7wywadn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bQIB49676772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DDB02004F;
	Mon, 24 Mar 2025 07:37:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F11D82004B;
	Mon, 24 Mar 2025 07:37:23 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:23 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 06/11] ext4: make extsize work with EOF allocations
Date: Mon, 24 Mar 2025 13:07:04 +0530
Message-ID: <c5169040ac2616a0e57df7d09cf2083a86def6ca.1742800203.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QvFb7SeG8riVOzBAlHTAjR-J00FJ8thl
X-Proofpoint-GUID: q9ciTaUdCVrYDjiOAvv2llhlueOmI1Ks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240053

Make extsize hints work with EOF allocations. We deviate from XFS here
because in case we have blocks left past EOF, we don't truncate them.
There are 2 main reasons:

1. Since the user is opting for extsize allocations, chances are
that they will use the blocks in future.

2. If we start truncating all EOF blocks in ext4_release_file like
XFS, then we will have to always truncate blocks even if they
have been intentionally preallocated using fallocate w/ KEEP_SIZE
which might cause confusion for users. This is mainly because
ext4 doesn't have a way to distinguish if the blocks beyond EOF
have been allocated intentionally. We can work around this by
using an ondisk inode flag like XFS (XFS_DIFLAG_PREALLOC) but
that would be an overkill. It's much simpler to just let the EOF
blocks stick around.

NOTE:
One thing that changes in this patch is that for direct IO we need to
pass the EXT4_GET_BLOCKS_IO_CREATE_EXT even if we are allocating beyond
i_size.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/inode.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 53724b7cb9e0..bf19b9f99cea 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -757,7 +757,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		 * ext4_extents.h here?
 		 */
 		int max_unwrit_len = ((1UL << 15) - 1);
-		loff_t end;
 
 		align = orig_map->m_lblk % extsize;
 		len = orig_map->m_len + align;
@@ -766,18 +765,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		extsize_map.m_len =
 			max_t(unsigned int, roundup_pow_of_two(len), extsize);
 
-		/*
-		 * For now allocations beyond EOF don't use extsize hints so
-		 * that we can avoid dealing with extra blocks allocated past
-		 * EOF. We have inode lock since extsize allocations are
-		 * non-delalloc so i_size can be accessed safely
-		 */
-		end = (extsize_map.m_lblk + (loff_t)extsize_map.m_len) << inode->i_blkbits;
-		if (end > inode->i_size) {
-			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
-			goto set_map;
-		}
-
 		/* Fallback to normal allocation if we go beyond max len */
 		if (extsize_map.m_len >= max_unwrit_len) {
 			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
@@ -3645,10 +3632,13 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	 * i_disksize out to i_size. This could be beyond where direct I/O is
 	 * happening and thus expose allocated blocks to direct I/O reads.
 	 *
-	 * NOTE for extsize hints: We only support it for writes inside
-	 * EOF (for now) to not have to deal with blocks past EOF
+	 * NOTE: For extsize hint based EOF allocations, we still need
+	 * IO_CREATE_EXT flag because we will be allocating more than the write
+	 * hence the extra blocks need to be marked unwritten and split before
+	 * the I/O.
 	 */
-	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
+	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode) &&
+		 !ext4_should_use_extsize(inode))
 		m_flags = EXT4_GET_BLOCKS_CREATE;
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
-- 
2.48.1


