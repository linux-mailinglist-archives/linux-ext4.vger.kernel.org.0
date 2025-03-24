Return-Path: <linux-ext4+bounces-6960-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC13A6D530
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F0C7A2FAB
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2B02580D1;
	Mon, 24 Mar 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bPJ3s+AT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E325745F;
	Mon, 24 Mar 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801854; cv=none; b=WE+yzzsI0wgY1jvZzuYoej68HB3j9sjd49DZcHTqVBBTpKMowCDyc2Pd/BNUJjQE/Uu5MuB3/bYA3CND9dMCygddc6/X152XgXvOenOnA8BOR9FHMUunVrKwL3dQThFpnTXZCGA1LWnsaZLSsBeCr3P4+DMnr6NYGuJzaAz+tEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801854; c=relaxed/simple;
	bh=2XU2J/cF/uPfYjnOvZO41yMCM5m3yb83jy8T1WkNx1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZCF2BeTYUMoDEuBGUZV91iVeM7QaAhiifT6uhCygxxv6o4B9GOycyueYdm9imIEEYrogJXw13yENDJKEuhq1/ygPkl2POGqGPmmGE/kZ2J7fpWX9zoo53ZNaY/TkroikCXhOzoKHgXI6SbsRW+uvkjWfC5cQsbe+Kcjwwu9c/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bPJ3s+AT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NJuQrR018057;
	Mon, 24 Mar 2025 07:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2XY78IMwdLPq/JPKZ
	0RA0zFV6cCBSiCJzmpVNNgdHXg=; b=bPJ3s+ATSRbUGA9SkRGARlIJ6Lw8O4hrj
	d8YRcG7bcNarXLUFjXmxZO1yGr8RYncBAMRzKg/p6GfjVqGMtfJNlgrq2iCkiWVr
	ELREDJZegVXCZMRAl1IAj/z1+XZnBQTHBdovV6Sow8IXMxNhoLhb/JUY6mMdYa2b
	mfBQ1Zam1XOrEnVgTQmIp8BlpyBYC0c8KmAtPAFmanl52rpj9CEtNQq7jxwoMQ70
	3dXcasKdV5WCOg4r9YCyYSGKa3N0OaSVMNWRTuflPZz/7M3fzfwQhsnCw+336ui/
	7/8n+Vx4evRd7d/n4kE5zkWHjEaXGoD8CaPe7c/ek3Gyp4noH8ZIQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwthe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7bJA0029853;
	Mon, 24 Mar 2025 07:37:19 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwthe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O4mCG8009709;
	Mon, 24 Mar 2025 07:37:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkcxfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bGLO35520962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB7492004B;
	Mon, 24 Mar 2025 07:37:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D12B020040;
	Mon, 24 Mar 2025 07:37:14 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:14 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 02/11] ext4: allow inode preallocation for aligned alloc
Date: Mon, 24 Mar 2025 13:07:00 +0530
Message-ID: <083378fa1d7114228d30b84d453e975a9da06751.1742800203.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 0EFk0Bu6XOlFvW00zx5rkJ0biGH1fQXi
X-Proofpoint-GUID: aSe7iD4tG6MW9yA1WSI5ICNOFLxaGRVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240053

Enable inode preallocation support for aligned allocations. Inode
preallocation will only be used if the preallocated blocks are able to
satisfy the length and alignment requirements of the allocations, else
we disable preallocation for this particular allocation and proceed as
usual. Disabling inode preallocation is required otherwise we might end
up with overlapping preallocated ranges which can trigger a BUG() later.

Further, during normalizing, we usually try to round it up to a power of
2 which can still give us aligned allocation. We also make sure not
change the goal start so aligned allocation is more straightforward. If for
whatever reason the goal is not power of 2 or doesn't contain the original
request, then we throw a warning and proceed as normal.

For now, group preallocation is disabled for aligned allocations.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 96 +++++++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index ca51581573e3..db7c593873a9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2178,8 +2178,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 * space in a special descriptor.
 	 */
 	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len) {
-		/* Aligned allocation doesn't have preallocation support */
-		WARN_ON(ac->ac_flags & EXT4_MB_HINT_ALIGNED);
 		ext4_mb_new_preallocation(ac);
 	}
 
@@ -3027,8 +3025,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 		WARN_ON_ONCE(!is_power_of_2(len));
 		WARN_ON_ONCE(start % len);
-		/* We don't support preallocation yet */
-		WARN_ON_ONCE(ac->ac_b_ex.fe_len != ac->ac_o_ex.fe_len);
+		WARN_ON_ONCE(ac->ac_b_ex.fe_len < ac->ac_o_ex.fe_len);
 	}
 
  exit:
@@ -4479,13 +4476,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	if (ac->ac_flags & EXT4_MB_HINT_NOPREALLOC)
 		return;
 
-	/*
-	 * caller may have strict alignment requirements. In this case, avoid
-	 * normalization since it is not alignment aware.
-	 */
-	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED)
-		return;
-
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC) {
 		ext4_mb_normalize_group_request(ac);
 		return ;
@@ -4542,6 +4532,21 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		size	  = (loff_t) EXT4_C2B(sbi,
 					      ac->ac_o_ex.fe_len) << bsbits;
 	}
+
+	/*
+	 * For aligned allocations, we need to ensure 2 things:
+	 *
+	 * 1. The start should remain same as original start so that finding
+	 * aligned physical blocks for it is straight forward.
+	 *
+	 * 2. The new_size should not be less than the original len. This
+	 * can sometimes happen due to the way we predict size above.
+	 */
+	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED) {
+		start_off = ac->ac_o_ex.fe_logical << bsbits;
+		size = max_t(loff_t, size,
+				 EXT4_C2B(sbi, ac->ac_o_ex.fe_len) << bsbits);
+	}
 	size = size >> bsbits;
 	start = start_off >> bsbits;
 
@@ -4792,32 +4797,46 @@ ext4_mb_check_group_pa(ext4_fsblk_t goal_block,
 }
 
 /*
- * check if found pa meets EXT4_MB_HINT_GOAL_ONLY
+ * check if found pa meets EXT4_MB_HINT_GOAL_ONLY or EXT4_MB_HINT_ALIGNED
  */
 static bool
-ext4_mb_pa_goal_check(struct ext4_allocation_context *ac,
+ext4_mb_pa_check(struct ext4_allocation_context *ac,
 		      struct ext4_prealloc_space *pa)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	ext4_fsblk_t start;
 
-	if (likely(!(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY)))
+	if (likely(!(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY ||
+		     ac->ac_flags & EXT4_MB_HINT_ALIGNED)))
 		return true;
 
-	/*
-	 * If EXT4_MB_HINT_GOAL_ONLY is set, ac_g_ex will not be adjusted
-	 * in ext4_mb_normalize_request and will keep same with ac_o_ex
-	 * from ext4_mb_initialize_context. Choose ac_g_ex here to keep
-	 * consistent with ext4_mb_find_by_goal.
-	 */
-	start = pa->pa_pstart +
-		(ac->ac_g_ex.fe_logical - pa->pa_lstart);
-	if (ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex) != start)
-		return false;
+	if (ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY) {
+		/*
+		 * If EXT4_MB_HINT_GOAL_ONLY is set, ac_g_ex will not be adjusted
+		 * in ext4_mb_normalize_request and will keep same with ac_o_ex
+		 * from ext4_mb_initialize_context. Choose ac_g_ex here to keep
+		 * consistent with ext4_mb_find_by_goal.
+		 */
+		start = pa->pa_pstart +
+			(ac->ac_g_ex.fe_logical - pa->pa_lstart);
+		if (ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex) != start)
+			return false;
 
-	if (ac->ac_g_ex.fe_len > pa->pa_len -
-	    EXT4_B2C(sbi, ac->ac_g_ex.fe_logical - pa->pa_lstart))
-		return false;
+		if (ac->ac_g_ex.fe_len >
+		    pa->pa_len - EXT4_B2C(sbi, ac->ac_g_ex.fe_logical -
+						       pa->pa_lstart))
+			return false;
+	} else if (ac->ac_flags & EXT4_MB_HINT_ALIGNED) {
+		start = pa->pa_pstart +
+			(ac->ac_g_ex.fe_logical - pa->pa_lstart);
+		if (start % EXT4_C2B(sbi, ac->ac_g_ex.fe_len))
+			return false;
+
+		if (EXT4_C2B(sbi, ac->ac_g_ex.fe_len) >
+		    (EXT4_C2B(sbi, pa->pa_len) -
+		     (ac->ac_g_ex.fe_logical - pa->pa_lstart)))
+			return false;
+	}
 
 	return true;
 }
@@ -4840,10 +4859,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
-	/* using preallocated blocks is not alignment aware. */
-	if (ac->ac_flags & EXT4_MB_HINT_ALIGNED)
-		return false;
-
 	/*
 	 * first, try per-file preallocation by searching the inode pa rbtree.
 	 *
@@ -4949,7 +4964,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		goto try_group_pa;
 	}
 
-	if (tmp_pa->pa_free && likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
+	if (tmp_pa->pa_free && likely(ext4_mb_pa_check(ac, tmp_pa))) {
 		atomic_inc(&tmp_pa->pa_count);
 		ext4_mb_use_inode_pa(ac, tmp_pa);
 		spin_unlock(&tmp_pa->pa_lock);
@@ -4984,6 +4999,19 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		 * pa_free == 0.
 		 */
 		WARN_ON_ONCE(tmp_pa->pa_free == 0);
+
+		/*
+		 * If, for any reason, we reach here then we need to disable PA
+		 * because otherwise ext4_mb_normalize_request() will try to
+		 * allocate a new PA for this logical range where another PA
+		 * already exists. This is not allowed and will trigger BUG_ONs.
+		 * Hence, as a workaround we disable PA.
+		 *
+		 * NOTE: ideally we would want to have some logic to take care
+		 * of the unusable PA. Maybe a more fine grained discard logic
+		 * that could allow us to discard only specific PAs.
+		 */
+		ac->ac_flags |= EXT4_MB_HINT_NOPREALLOC;
 	}
 	spin_unlock(&tmp_pa->pa_lock);
 try_group_pa:
@@ -5790,6 +5818,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	int bsbits = ac->ac_sb->s_blocksize_bits;
 	loff_t size, isize;
 	bool inode_pa_eligible, group_pa_eligible;
+	bool is_aligned = (ac->ac_flags & EXT4_MB_HINT_ALIGNED);
 
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return;
@@ -5797,7 +5826,8 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		return;
 
-	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
+	/* Aligned allocation does not support group pa */
+	group_pa_eligible = (!is_aligned && sbi->s_mb_group_prealloc > 0);
 	inode_pa_eligible = true;
 	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
-- 
2.48.1


