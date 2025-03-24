Return-Path: <linux-ext4+bounces-6959-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43965A6D532
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF653AA355
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932D257AC3;
	Mon, 24 Mar 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z2YBvfly"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD57257438;
	Mon, 24 Mar 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801852; cv=none; b=dH8lz99VI40nkEGtMFvjUBlt7gVnf5zDKaYGKW2DALZVwTuDqNjQgDKHghzgURFNnJswZWBxJ7gpL2XQNEuoWE8XKLMHiNtxaK1YVB0CmHnBo7N+i3UbwIX096g6eqOaJsx6G05JdGmbj6QrC9Kpgtty6JtOqxxK5DzyHW+XCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801852; c=relaxed/simple;
	bh=VD+PwGe5tmvrGlAfNJro4FDnmcFwJtTakB63Kd/xTQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfTd869zWNDL+UF6LOyItffnBTrLFkLV436KBfGNPHGlLzzct81ZX/s0xJg0ekOy07cayoVkYOMHx0M6QYJHUBlgSLi2UIAaFDMCdrSN6XjK89bZ46CDltjCwDWeALBbRqZjgF1KtyfDGr3bzNupbMDMlB9/0fpaT1NhBtnjsDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z2YBvfly; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5K7gk023160;
	Mon, 24 Mar 2025 07:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5ZpwIYnRwKDFz/DfW
	xShmUTTGBe9YrODk96vZraZ31s=; b=Z2YBvflyGjwZSgUcGJVlHmUvbbalP53VD
	a1ktXn5PonYnlvaUwwkDz7RJ/LtWQOgpF1xG13cWXbGVlhhvjr9NfNXgxtOQSbgr
	ke9i5FOlA+rLZ3n/8T+YC68KIm0ksVqDUxE72qjDmSIoh5gz2JbznL57j2cPkg+w
	MwygyGHEYMdeNQ78JowVboDwwHpwDekK+f5t1IGc27JYZtbiXpTYY3OmpLmBsNud
	E5PzSjy3okylKo6fvIK1hPXg7MnraV3524xchoYg2iYi/SZrz2hO16gDsCyx/YPN
	P1f4ra/Ex3OTI3Q36AL/5GYVZbK9GzDLSx/9pzCVZltE65uegCArw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jjb4ueg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7X8Tr013752;
	Mon, 24 Mar 2025 07:37:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jjb4ueg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O3bFX9020029;
	Mon, 24 Mar 2025 07:37:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnn5ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bE6Q38470060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DB4720040;
	Mon, 24 Mar 2025 07:37:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E437D20043;
	Mon, 24 Mar 2025 07:37:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:12 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 01/11] ext4: add aligned allocation hint in mballoc
Date: Mon, 24 Mar 2025 13:06:59 +0530
Message-ID: <70fcaa59709f4fc30223b9d0e33b5cbda74209c6.1742800203.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: 1ftvGmEpYbtbILO8xybkKSnkLtFXyiq_
X-Proofpoint-ORIG-GUID: 5KwNZUzYxxhRIUfXpFSvhnrP3LCDqg0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240053

Add support in mballoc for allocating blocks that are aligned
to a certain power-of-2 offset.

1. We define a new flag EXT4_MB_ALIGNED_HINT to indicate that we want
an aligned allocation. This is just a hint, mballoc tries its best to
provide aligned blocks but if it can't then it'll fallback to normal
allocation

2. The alignment is determined by the length of the allocation, for
example if we ask for 8192 bytes, then the alignment of physical blocks
will also be 8192 bytes aligned (ie 2 blocks aligned on 4k blocksize).

3. We dont yet support arbitrary alignment. For aligned writes, the
length/alignment must be power of 2 in blocks, ie for 4k blocksize we
can get 4k byte aligned, 8k byte aligned, 16k byte aligned ...
allocation but not 12k byte aligned.

4. We use CR_POWER2_ALIGNED criteria for aligned allocation which by
design allocates in an aligned manner. Since CR_POWER2_ALIGNED needs the
ac->ac_g_ex.fe_len to be power of 2, thats where the restriction in
point 3 above comes from. Since right now aligned allocation support is
added mainly for atomic writes use case, this restriction should be fine
since atomic write capable devices usually support only power of 2
alignments

5. For ease of review enabling inode preallocation support is done in
upcoming patches and is disabled in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h              |  2 ++
 fs/ext4/mballoc.c           | 60 +++++++++++++++++++++++++++++++++----
 include/trace/events/ext4.h |  1 +
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7184..2c83275d2ad4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -222,6 +222,8 @@ enum criteria {
 /* Avg fragment size rb tree lookup succeeded at least once for
  * CR_BEST_AVAIL_LEN */
 #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
+/* mballoc will try to align physical start to length (aka natural alignment) */
+#define EXT4_MB_HINT_ALIGNED	      	0x40000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0d523e9fb3d5..ca51581573e3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2177,8 +2177,11 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 * user requested originally, we store allocated
 	 * space in a special descriptor.
 	 */
-	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len)
+	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len) {
+		/* Aligned allocation doesn't have preallocation support */
+		WARN_ON(ac->ac_flags & EXT4_MB_HINT_ALIGNED);
 		ext4_mb_new_preallocation(ac);
+	}
 
 }
 
@@ -2814,10 +2817,15 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	BUG_ON(ac->ac_status == AC_STATUS_FOUND);
 
-	/* first, try the goal */
-	err = ext4_mb_find_by_goal(ac, &e4b);
-	if (err || ac->ac_status == AC_STATUS_FOUND)
-		goto out;
+	/*
+	 * first, try the goal. Skip trying goal for aligned allocations since
+	 * goal determination logic is not alignment aware (yet)
+	 */
+	if (!(ac->ac_flags & EXT4_MB_HINT_ALIGNED)) {
+		err = ext4_mb_find_by_goal(ac, &e4b);
+		if (err || ac->ac_status == AC_STATUS_FOUND)
+			goto out;
+	}
 
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		goto out;
@@ -2858,9 +2866,22 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	 */
 	if (ac->ac_2order)
 		cr = CR_POWER2_ALIGNED;
+	else
+		WARN_ON_ONCE(ac->ac_g_ex.fe_len > 1 &&
+			     ac->ac_flags & EXT4_MB_HINT_ALIGNED);
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
+
+		if (ac->ac_criteria > CR_POWER2_ALIGNED &&
+		    ac->ac_flags & EXT4_MB_HINT_ALIGNED &&
+		    ac->ac_g_ex.fe_len > 1) {
+			ext4_warning_inode(
+				ac->ac_inode,
+				"Aligned allocation not possible, using unaligned allocation");
+			ac->ac_flags &= ~EXT4_MB_HINT_ALIGNED;
+		}
+
 		/*
 		 * searching for the right group start
 		 * from the goal value specified
@@ -2993,6 +3014,24 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
 		err = first_err;
 
+	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED && ac->ac_status == AC_STATUS_FOUND) {
+		ext4_fsblk_t start = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
+		ext4_grpblk_t len = EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+
+		if (!len) {
+			ext4_warning_inode(ac->ac_inode,
+					   "Expected a non zero len extent");
+			ac->ac_status = AC_STATUS_BREAK;
+			goto exit;
+		}
+
+		WARN_ON_ONCE(!is_power_of_2(len));
+		WARN_ON_ONCE(start % len);
+		/* We don't support preallocation yet */
+		WARN_ON_ONCE(ac->ac_b_ex.fe_len != ac->ac_o_ex.fe_len);
+	}
+
+ exit:
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, cr, err);
@@ -4440,6 +4479,13 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	if (ac->ac_flags & EXT4_MB_HINT_NOPREALLOC)
 		return;
 
+	/*
+	 * caller may have strict alignment requirements. In this case, avoid
+	 * normalization since it is not alignment aware.
+	 */
+	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED)
+		return;
+
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC) {
 		ext4_mb_normalize_group_request(ac);
 		return ;
@@ -4794,6 +4840,10 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
+	/* using preallocated blocks is not alignment aware. */
+	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED)
+		return false;
+
 	/*
 	 * first, try per-file preallocation by searching the inode pa rbtree.
 	 *
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 156908641e68..79cc4224fbbd 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -36,6 +36,7 @@ struct partial_cluster;
 	{ EXT4_MB_STREAM_ALLOC,		"STREAM_ALLOC" },	\
 	{ EXT4_MB_USE_ROOT_BLOCKS,	"USE_ROOT_BLKS" },	\
 	{ EXT4_MB_USE_RESERVED,		"USE_RESV" },		\
+	{ EXT4_MB_HINT_ALIGNED,		"HINT_ALIGNED" }, \
 	{ EXT4_MB_STRICT_CHECK,		"STRICT_CHECK" })
 
 #define show_map_flags(flags) __print_flags(flags, "|",			\
-- 
2.48.1


