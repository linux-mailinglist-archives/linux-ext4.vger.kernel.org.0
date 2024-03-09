Return-Path: <linux-ext4+bounces-1577-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B62876E0F
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 01:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B29BB221F1
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1220627;
	Sat,  9 Mar 2024 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iBb+UMdR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D736E
	for <linux-ext4@vger.kernel.org>; Sat,  9 Mar 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709943062; cv=none; b=sdaZxpll4NyY+cDQcUzFFeD/AGky5ySYOQKDdJumHfKlWuHFIEvOkQ2yGZrHuv5AQ5ywaefH5KMG/qz0Q3SVN2laL1gV58yQ2u+GZbTHrlFHd7rFPpk30vL/Puh0eayYcuMRObjr5+NzlimO+2z7wDED4o79uEA6XvA77KYgqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709943062; c=relaxed/simple;
	bh=RHEdZdrVo+YM356gV9vCdrE9WkWiKBsJOhOyMIyK9aE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cxCNDEzbAmJQ3PgBbuCfGXgCFnQfRNyUXbGlOoRcYpqlVrl/GzIQ6YihUwnVFv14keUiBygR3D2EODeyu5X7b5civDjMu7SLcSaKCHAGnGjr6rnucOkwmMauitAFXGSa1cILeLWXfJZc+Rxx+YWAKI4+BuT0ernEAshPEOBjhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iBb+UMdR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428N0T8P002912
	for <linux-ext4@vger.kernel.org>; Fri, 8 Mar 2024 16:10:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=6udChvsJI7Z+HUNWq4D1EHrNhJnHUNQ8hivVq1BuE9M=;
 b=iBb+UMdRp7WaHwalhhSTLxlK2Aus/IRXrOt7UsSHTMZITzLoRO3o8RtR+q4jsz7QoLdb
 3yA0mphBcOR90MGUTQlGaMOuk+2ezVOEYiMi2mOp0no//TD+uIPfkE7yQg++Yw/iHntO
 C6hiWNMjNO1ZKmGn/NT76HuNrjRpExjlHRpsd8L7dLszAfavMwOA1CDVFA6+ACvLQ0mW
 oyBP4Imp28Gb8Z6cIb2iofVJS0i4KEex/gzOjeOs/ghEFGfJPBGFMkALaB/GF95bDqKx
 kUf69SKhrGkV2cFjqEg6szauLgG0SB5dcXbGT662hGATYIWMHAb34NjXIW9rvrZKGNVR ow== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wrby888c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-ext4@vger.kernel.org>; Fri, 08 Mar 2024 16:10:59 -0800
Received: from twshared28280.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 16:10:58 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 9C03D25F46246; Fri,  8 Mar 2024 16:09:44 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] ext4: remove unreachable discard code
Date: Fri, 8 Mar 2024 16:09:43 -0800
Message-ID: <20240309000943.1400879-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kiLEu_OyuDEVYXOVVgj_pwLZsYSE434S
X-Proofpoint-ORIG-GUID: kiLEu_OyuDEVYXOVVgj_pwLZsYSE434S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

There are no more ext4_issue_discard() users that track their own bio.
Remove the unused parameter and the dead code that handles it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/ext4/mballoc.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e4f7cf9d89c45..6314a2b000fd8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3829,8 +3829,7 @@ void ext4_mb_release(struct super_block *sb)
 }
=20
 static inline int ext4_issue_discard(struct super_block *sb,
-		ext4_group_t block_group, ext4_grpblk_t cluster, int count,
-		struct bio **biop)
+		ext4_group_t block_group, ext4_grpblk_t cluster, int count)
 {
 	ext4_fsblk_t discard_block;
=20
@@ -3839,13 +3838,7 @@ static inline int ext4_issue_discard(struct super_=
block *sb,
 	count =3D EXT4_C2B(EXT4_SB(sb), count);
 	trace_ext4_discard_blocks(sb,
 			(unsigned long long) discard_block, count);
-	if (biop) {
-		return __blkdev_issue_discard(sb->s_bdev,
-			(sector_t)discard_block << (sb->s_blocksize_bits - 9),
-			(sector_t)count << (sb->s_blocksize_bits - 9),
-			GFP_NOFS, biop);
-	} else
-		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
+	return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
 }
=20
 static void ext4_free_data_in_buddy(struct super_block *sb,
@@ -6487,7 +6480,7 @@ static void ext4_mb_clear_bb(handle_t *handle, stru=
ct inode *inode,
 	} else {
 		if (test_opt(sb, DISCARD)) {
 			err =3D ext4_issue_discard(sb, block_group, bit,
-						 count_clusters, NULL);
+						 count_clusters);
 			if (err && err !=3D -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%u block:%d count:%lu failed"
@@ -6738,7 +6731,7 @@ __acquires(bitlock)
 	 */
 	mb_mark_used(e4b, &ex);
 	ext4_unlock_group(sb, group);
-	ret =3D ext4_issue_discard(sb, group, start, count, NULL);
+	ret =3D ext4_issue_discard(sb, group, start, count);
 	ext4_lock_group(sb, group);
 	mb_free_blocks(NULL, e4b, start, ex.fe_len);
 	return ret;
--=20
2.34.1


