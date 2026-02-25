Return-Path: <linux-ext4+bounces-14011-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFWKKo9Yn2ksagQAu9opvQ
	(envelope-from <linux-ext4+bounces-14011-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 21:16:15 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A55719D1AE
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 21:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5612E301C12E
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 20:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832172DCF55;
	Wed, 25 Feb 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="OBuIfmdV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic316-21.consmr.mail.ne1.yahoo.com (sonic316-21.consmr.mail.ne1.yahoo.com [66.163.187.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745A29B76F
	for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050572; cv=none; b=ZQKGy9xdbVNM9y59Do8CzMV8gxWxbqrLH1ePS0OZUmv+rEJy/f06XRvfIgqiUHh/ERPfezDQu+DFMVaGuteO3eAyIJQwu0KsIYbLM7JribdRFsFOSnc6+wna/76Z8YZ4qeVTsiPgd3aZ5dphw17B3KWebh5iy9QWBVODUXG/SAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050572; c=relaxed/simple;
	bh=7lUoqlmatmpHJsQYT982ei12hR4Jad60ABVD4eFaPts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=gUrKlpLkvWKt1jTCCgIfWoh9BJcSBLn3OSN2KwXcBmc5jBQnFT87rjG/gidWH0EbyXF36DSlHH0Ypvxcb0zNaN1wdQMzvmXeGw+pMZjHGf+2PBtwL8f3Ca0ZqATPgcdmYw0+hUqlZMaN9/91jmnf4XQhG0gv3tHhUXfFr5eBiP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=OBuIfmdV; arc=none smtp.client-ip=66.163.187.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1772050563; bh=GC8mJR0ld2caY23eVx9YMPVfIbfvZCJPT21QTj3a/Fk=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=OBuIfmdVY39xhenpR4uL9zDGZMexPl3SdJic+9hw7UA+yJoQB1yZ+ac8UH8TFpcLNe+dmExvgLNBDDBv9YwZL0cNB8C7EhgVhcqRiPq9LTcShsu/gaqMrSNjBwBHIPbL2FAW+OztM2mZk3YwX/dz2xHCtpshoA6+ANwB5eHnVo0M/YvaIAfDMzYweM474FIMBch/I1xId/DHcB3YG8jgNFlJco8S9wftTPdE844WidfN0QHzDMHGDxDMboTTIUxs5yxaMWwUZoPjrfeiXNdaqwrH0rHDDabJxEAd4VGMSy/VoTP3Qk7S5rR+dNhCU14jvwJMw9hnVd74YOyHSSTNsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772050563; bh=lLUJYgpg6xn2dAzMKCppLAFCTm6391X1X87dVspDLSz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fPYmoJFTAlcfngDeGtOhCouTwNrealFPzTCNmzqU53WMSrmdxZ1N9p5WUHs3d1tapwvKE9yozxF9AZWtMzR/x8NVSWUBPs/fRVjojH1sl7WikcCB8Y/MHTlKeqYLK6+3GCvyILgmC2Iyen2MEU7d0x1RkdPyrr5IzK4sxd4hjq7gdEjVkDDaMhU+QWSYaIJ/OMS45uX9EG9qQpDLG2Bf8alG9dzRAgrJAlHg1uh+qfN0frBXgF2w/SepyX5fGSf98wVFVnR45ySSsDDRQ3R1jBaQkvb1jYNjOq+lMeFfzuJJ7djcSTMY01l/GXH9BHbpYi3CJDfGTTywtKtqmXPfyA==
X-YMail-OSG: qbuiaRUVM1nPgD7f72hX0CeDcVtD5aRjdqdJ15jNoe0cDSW9hatS08UlKRB.IjU
 U7kBlhPqtRh5k3KbaRNV5GeV.AyXoXuvdf9OwPhPLaDNy.gvjIr3_ene2qMSfWyR8afiPE0XJiTO
 WEzaCtPcCDdUQlHB4I4ICRQuewKZp9YFYWp91LFx5Vxjr0PNZr6plHyMPo0L9t5V0WoPdpr4ZCa7
 WuufJDmqh.vUmaSgq3xWXBbifMlaE7XWaISjUMI6Zw_03Gn1IUAHczmWAKCP.bRI3l48ZGKcG941
 jH23yEhoYVSVjPAriG_k_aEyZUgyH4_Kgc02JNLPp8Hp7lK94qPYmfvMKHqctm.pyg0sjI.6xJ7G
 1eMrsGuVKogLOJzBV0CHCeQN03WlvUsgojY3oBCmPYwHgKCZgDk7LuKzKSoUv0Oea6UF1pEpj9wk
 YnTkzURrpo3F1IGnJvA9J_S9kZ2E_6a4onrexaxW7iZgHbXxlkwFkO5iNfbO0NKT6UrZVOLruRMn
 wmrVvyT1vSe4AVHMS8Zzm5QJPEJi0UAII8YwM_e4gBzVEhxP33Cs1uxGX99m_2e2ZvSoBLPRlb_N
 brHn6liGUNPaW74lSlY3vk2GMlFj6CqYt1DK9U4piHEYGRlEEFQrQsptx9MdAHOZp.iAVz1kIxK4
 8qQMqryGJAbktAEkK8zSjEptSrrHByb3KvpKZKg4w6gZNVXAY9.uHqgMyu.9f7MBdGouAxFbbJ0m
 HT6kO0GhIp4rXhU4enDb7uUyWv3Ak_gSDWA_YnUyVHcCTmevMnCMx1KVw3atB.K95U4CahSp.u6q
 Jln.1YtvEO0FjKamkvQyzWwTN25Fn0KGZugVSD8dAFEYs7glxCuePFe9KCLNLj5rgw1chpGXM3ga
 37_A3EbYGI2xuA8Ml5VtozW7epPWbDMAjQ2p2wSuq5R7hLodTIbGb5v_qSA2qxcysJCRsotOvtKC
 rX1_7YxIcMuOaVDtb8otM067q.8imAFmokdAKzdM3bYydptH1HeOl4r9B7opIlXh2QxraPYJDPVU
 oJ9g64P0Tb2lwf1jKS7m_Zl.9v_qRhR_8NkBYuemG6luiHMZTiIGPJ4U6HAjAFLOP8MgTG8GIe4F
 O38P17oh_9mej0Fs0rCRk5fj4Sl5S89xcigVe_hwFdq09m2qSdigLoupdBemspQkE8RB86xQ9keE
 Ej7Ka5uHq7tJPJ02LFzPV.h6ox7zFR0S.DPODIVND8D.rg0Rns7BksgM47JrAYclqIeFbXURspPY
 oTNqZaeNyaPn.hhPDmbfmIwXCSHEQUZzZLqZYDpmHGZkbDPeJ9SgZjt5birfbVhLpzHIqZy_fUNR
 bG_2Neq1TutC_DOku0wyL.V5U8qUK8SYudDDSHSCSU4jA7UF8Yn66QBuH0zQ2ipFTbkMi8Xnyoq9
 u.4PMDFFk48iYi6wrERshj1N8lrytWHg3omjmHTgTh3o8sOg_G_wLytQ8Z0bVYreoazSpWnaiqyd
 wup45iOAAZ44dd_O_PcQxhEDBTti.0iYzOChaxGAkTqZc.wtkkgqNRph_GdtEeQVSn8ZVSviOqnW
 Gmqhc6GhiaLXj04ND10aMo7BBP2te0OhGBJXjZxlMcdh_hwo23jPyBIJKp9qpOqpNEpqznLqjICv
 3hO8UYg08R72UVhzA8rSb6eFPJnAAb8dtqKWPUmKrR_cgZdDJGBCC5a7ITUj2_6J5pYKjRmhzKdg
 uGZ9s5Zg2XiSIt6nKjXJn5gzG.ceZH4sB9WEoisowsChjrrGEZsLGFU4KK6BPCmKs0s97GufHWBb
 6UqoyxqLNFqGrkSgO4SQdR287i00Ep5PqqcYjBGee.L9g4UlqL5kyTT3ZPmzOZisBJwR5uBz05TO
 wTBeIbciDFHjDIdxRlGDMX3_I8oW9BQ5DR_hOV63DvMvebQ2sD2FWSxtl93pH53OidEdQ.93OG50
 euvnIvIQcmpUaje9P7QllpwsCdCMKB3Oq8SqOOUc_SCpTKcGhhs3aK83qeCPtOqTxoZ4mXq79k9w
 E9K9JhOsChbHvxqjjpu_tCBwBsC1DwcSt9XvpHgJWtkDDkag2NttB_Vj_UCEocSNu0M9NdhsAIZC
 5FK3tKnBN2pT_cKRKHAggIU2Pg3kzkU_TwLiwcCeElSXcNul4uqARPYr8xwHanyhR_pmCGrvcBC2
 Kdg8s6D7r7Q9ygesRmQBzpcUZPevopVY.QPnkZwKTucNnQLgV.MLcfhTxXi2YiOQg0LQOhV22Rgi
 xeq050ca7A8ar
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: 34fad04e-f40e-4bf7-b329-d25a2225e193
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Feb 2026 20:16:03 +0000
Received: by hermes--production-ir2-bbcfb4457-f49j6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa0c1fcc802b66ba0a1ca6c6e8ff9cb1;
          Wed, 25 Feb 2026 20:15:59 +0000 (UTC)
From: Mario Lohajner <mario_lohajner@rocketmail.com>
To: tytso@mit.edu
Cc: libaokun1@huawei.com,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	libaokun9@gmail.com,
	Mario Lohajner <mario_lohajner@rocketmail.com>
Subject: [PATCH] ext4: rralloc - (former rotalloc) improved round-robin allocation policy
Date: Wed, 25 Feb 2026 21:15:20 +0100
Message-ID: <20260225201520.220071-1-mario_lohajner@rocketmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260225201520.220071-1-mario_lohajner.ref@rocketmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com,rocketmail.com];
	TAGGED_FROM(0.00)[bounces-14011-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rocketmail.com:mid,rocketmail.com:dkim,rocketmail.com:email]
X-Rspamd-Queue-Id: 9A55719D1AE
X-Rspamd-Action: no action

V2 patch incorporating feedback from previous discussion:

- per-inode atomic cursors to enforce stream sequentiality
- per-CPU starting points to reduce contention
- allocator isolation maintained; regular allocator untouched
- name changed to rralloc to avoid confusion with "rotational"
- preliminary tests confirm expected performance

Files modified:
- fs/ext4/ext4.h
	rralloc policy declared, per-CPU cursors & allocator vector

- fs/ext4/ialloc.c
	initialize (zero) per-inode cursor

- fs/ext4/mballoc.h
	expose allocator functions for vectoring in super.c

- fs/ext4/super.c
	parse rralloc option, init per-CPU cursors and allocator vector

- fs/ext4/mballoc.c
	add rotating allocator, vectored allocator

Signed-off-by: Mario Lohajner <mario_lohajner@rocketmail.com>
---
 fs/ext4/ext4.h    |  10 +++-
 fs/ext4/ialloc.c  |   3 +-
 fs/ext4/mballoc.c | 115 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h |   3 ++
 fs/ext4/super.c   |  33 ++++++++++++-
 5 files changed, 157 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 293f698b7042..210332affd47 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -229,6 +229,9 @@ struct ext4_allocation_request {
 	unsigned int flags;
 };
 
+/* rralloc show pointer type to compiler */
+struct ext4_allocation_context;
+
 /*
  * Logical to physical block mapping, used by ext4_map_blocks()
  *
@@ -1032,7 +1035,8 @@ struct ext4_inode_info {
 	__le32	i_data[15];	/* unconverted */
 	__u32	i_dtime;
 	ext4_fsblk_t	i_file_acl;
-
+	/* rralloc per inode cursor */
+	atomic_t	cursor;
 	/*
 	 * i_block_group is the number of the block group which contains
 	 * this file's inode.  Constant across the lifetime of the inode,
@@ -1217,6 +1221,7 @@ struct ext4_inode_info {
  * Mount flags set via mount options or defaults
  */
 #define EXT4_MOUNT_NO_MBCACHE		0x00001 /* Do not use mbcache */
+#define EXT4_MOUNT_RRALLOC			0x00002 /* Use round-robin policy/allocator */
 #define EXT4_MOUNT_GRPID		0x00004	/* Create files with directory's group */
 #define EXT4_MOUNT_DEBUG		0x00008	/* Some debugging messages */
 #define EXT4_MOUNT_ERRORS_CONT		0x00010	/* Continue on errors */
@@ -1546,6 +1551,9 @@ struct ext4_sb_info {
 	unsigned long s_mount_flags;
 	unsigned int s_def_mount_opt;
 	unsigned int s_def_mount_opt2;
+	/* rralloc per-cpu cursors and allocator vector */
+	ext4_group_t __percpu *s_rralloc_cursor;
+	int (*s_vectored_allocator)(struct ext4_allocation_context *ac);
 	ext4_fsblk_t s_sb_block;
 	atomic64_t s_resv_clusters;
 	kuid_t s_resuid;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b20a1bf866ab..c72cee642eca 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -962,7 +962,8 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	ei = EXT4_I(inode);
-
+	/* Zero the rralloc per-inode cursor */
+	atomic_set(&ei->cursor, 0);
 	/*
 	 * Initialize owners and quota early so that we don't have to account
 	 * for quota initialization worst case in standard inode creating
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 20e9fdaf4301..df3805bb4a2f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2266,9 +2266,19 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	folio_get(ac->ac_buddy_folio);
 	/* store last allocated for subsequent stream allocation */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
+		/* update global goals */
+		if (!test_opt(ac->ac_sb, RRALLOC)) {
+			int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
+
+			WRITE_ONCE(sbi->s_mb_last_groups[hash], ac->ac_f_ex.fe_group);
+		} else {
+			/* update inode cursor and current per-cpu cursor */
+			ext4_group_t cursor = ac->ac_f_ex.fe_group;
+			struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 
-		WRITE_ONCE(sbi->s_mb_last_groups[hash], ac->ac_f_ex.fe_group);
+			atomic_set(&ei->cursor, cursor);
+			*this_cpu_ptr(sbi->s_rralloc_cursor) = cursor;
+		}
 	}
 
 	/*
@@ -2991,7 +3001,7 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
 	return ret;
 }
 
-static noinline_for_stack int
+noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
 	ext4_group_t i;
@@ -3111,6 +3121,102 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	return err;
 }
 
+/* Rotating allocator (round-robin) */
+noinline_for_stack int
+ext4_mb_rotating_allocator(struct ext4_allocation_context *ac)
+{
+	ext4_group_t goal;
+	int err = 0;
+	struct super_block *sb = ac->ac_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_buddy e4b;
+	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
+	ext4_group_t start = *this_cpu_ptr(sbi->s_rralloc_cursor);
+
+	/* if inode cursor=0, use per-cpu cursor */
+	goal = atomic_cmpxchg(&ei->cursor, 0, start);
+	if (!goal)
+		goal = start;
+
+	ac->ac_g_ex.fe_group = goal;
+
+	/* first, try the goal */
+	err = ext4_mb_find_by_goal(ac, &e4b);
+	if (err || ac->ac_status == AC_STATUS_FOUND)
+		goto out;
+
+	/* RRallocation promotes stream behavior */
+	ac->ac_flags |= EXT4_MB_STREAM_ALLOC;
+	ac->ac_flags |= EXT4_MB_HINT_FIRST;
+	ac->ac_flags &= ~EXT4_MB_HINT_GOAL_ONLY;
+	ac->ac_g_ex.fe_group = goal;
+	ac->ac_g_ex.fe_start = -1;
+	ac->ac_2order = 0;
+	ac->ac_criteria = CR_ANY_FREE;
+	ac->ac_e4b = &e4b;
+	ac->ac_prefetch_ios = 0;
+	ac->ac_first_err = 0;
+repeat:
+	while (ac->ac_criteria < EXT4_MB_NUM_CRS) {
+		err = ext4_mb_scan_groups(ac);
+		if (err)
+			goto out;
+
+		if (ac->ac_status != AC_STATUS_CONTINUE)
+			break;
+	}
+
+	if (ac->ac_b_ex.fe_len > 0 && ac->ac_status != AC_STATUS_FOUND &&
+	    !(ac->ac_flags & EXT4_MB_HINT_FIRST)) {
+		/*
+		 * We've been searching too long. Let's try to allocate
+		 * the best chunk we've found so far
+		 */
+		ext4_mb_try_best_found(ac, &e4b);
+		if (ac->ac_status != AC_STATUS_FOUND) {
+			int lost;
+
+			/*
+			 * Someone more lucky has already allocated it.
+			 * The only thing we can do is just take first
+			 * found block(s)
+			 */
+			lost = atomic_inc_return(&sbi->s_mb_lost_chunks);
+			mb_debug(sb, "lost chunk, group: %u, start: %d, len: %d, lost: %d\n",
+				 ac->ac_b_ex.fe_group, ac->ac_b_ex.fe_start,
+				 ac->ac_b_ex.fe_len, lost);
+
+			ac->ac_b_ex.fe_group = 0;
+			ac->ac_b_ex.fe_start = 0;
+			ac->ac_b_ex.fe_len = 0;
+			ac->ac_status = AC_STATUS_CONTINUE;
+			ac->ac_flags |= EXT4_MB_HINT_FIRST;
+			ac->ac_criteria = CR_ANY_FREE;
+			goto repeat;
+		}
+	}
+
+	if (sbi->s_mb_stats && ac->ac_status == AC_STATUS_FOUND) {
+		atomic64_inc(&sbi->s_bal_cX_hits[ac->ac_criteria]);
+		if (ac->ac_flags & EXT4_MB_STREAM_ALLOC &&
+		    ac->ac_b_ex.fe_group == ac->ac_g_ex.fe_group)
+			atomic_inc(&sbi->s_bal_stream_goals);
+	}
+
+out:
+	if (!err && ac->ac_status != AC_STATUS_FOUND && ac->ac_first_err)
+		err = ac->ac_first_err;
+
+	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
+		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
+		 ac->ac_flags, ac->ac_criteria, err);
+
+	if (ac->ac_prefetch_nr)
+		ext4_mb_prefetch_fini(sb, ac->ac_prefetch_grp, ac->ac_prefetch_nr);
+
+	return err;
+}
+
 static void *ext4_mb_seq_groups_start(struct seq_file *seq, loff_t *pos)
 {
 	struct super_block *sb = pde_data(file_inode(seq->file));
@@ -6313,7 +6419,8 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			goto errout;
 repeat:
 		/* allocate space in core */
-		*errp = ext4_mb_regular_allocator(ac);
+		/* use vector separation for rralloc allocator */
+		*errp = sbi->s_vectored_allocator(ac);
 		/*
 		 * pa allocated above is added to grp->bb_prealloc_list only
 		 * when we were able to allocate some block i.e. when
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 15a049f05d04..27d7a7dd7044 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -270,4 +270,7 @@ ext4_mballoc_query_range(
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv);
 
+/* Expose rotating & regular allocator for vectoring */
+int ext4_mb_rotating_allocator(struct ext4_allocation_context *ac);
+int ext4_mb_regular_allocator(struct ext4_allocation_context *ac);
 #endif
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 43f680c750ae..1e4cf6a40c88 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1284,6 +1284,10 @@ static void ext4_put_super(struct super_block *sb)
 	int aborted = 0;
 	int err;
 
+	/* free per cpu cursors */
+	if (sbi->s_rralloc_cursor)
+		free_percpu(sbi->s_rralloc_cursor);
+
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
 	 * Since we could still access attr_journal_task attribute via sysfs
@@ -1683,7 +1687,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
+	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan, Opt_rralloc,
 	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
@@ -1805,6 +1809,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_u32	("init_itable",		Opt_init_itable),
 	fsparam_flag	("init_itable",		Opt_init_itable),
 	fsparam_flag	("noinit_itable",	Opt_noinit_itable),
+	fsparam_flag	("rralloc",	Opt_rralloc),
 #ifdef CONFIG_EXT4_DEBUG
 	fsparam_flag	("fc_debug_force",	Opt_fc_debug_force),
 	fsparam_u32	("fc_debug_max_replay",	Opt_fc_debug_max_replay),
@@ -1886,6 +1891,7 @@ static const struct mount_opts {
 	{Opt_noauto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_SET},
 	{Opt_auto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_CLEAR},
 	{Opt_noinit_itable, EXT4_MOUNT_INIT_INODE_TABLE, MOPT_CLEAR},
+	{Opt_rralloc, EXT4_MOUNT_RRALLOC, MOPT_SET},
 	{Opt_dax_type, 0, MOPT_EXT4_ONLY},
 	{Opt_journal_dev, 0, MOPT_NO_EXT2},
 	{Opt_journal_path, 0, MOPT_NO_EXT2},
@@ -2272,6 +2278,9 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			ctx->s_li_wait_mult = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_li_wait_mult;
 		return 0;
+	case Opt_rralloc:
+		ctx_set_mount_opt(ctx, EXT4_MOUNT_RRALLOC);
+		return 0;
 	case Opt_max_dir_size_kb:
 		ctx->s_max_dir_size_kb = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_max_dir_size_kb;
@@ -5311,6 +5320,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	struct ext4_fs_context *ctx = fc->fs_private;
 	int silent = fc->sb_flags & SB_SILENT;
 
+	/* Unconditional default regular allocator (rralloc separation) */
+	sbi->s_vectored_allocator = ext4_mb_regular_allocator;
+
 	/* Set defaults for the variables that will be set during parsing */
 	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
 		ctx->journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
@@ -5522,6 +5534,25 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		}
 	}
 
+	/* rralloc: initialize per-cpu cursors and rotational allocator */
+	if (test_opt(sb, RRALLOC)) {
+		sbi->s_rralloc_cursor = alloc_percpu(ext4_group_t);
+		if (!sbi->s_rralloc_cursor)
+			return -ENOMEM;
+
+		int ncpus = num_possible_cpus();
+		ext4_group_t total_groups = ext4_get_groups_count(sb);
+		ext4_group_t groups_per_cpu = total_groups / ncpus;
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			*per_cpu_ptr(sbi->s_rralloc_cursor, cpu) = cpu * groups_per_cpu;
+		}
+
+		/* Vectored allocator to round-robin allocator */
+		sbi->s_vectored_allocator = ext4_mb_rotating_allocator;
+	}
+
 	/*
 	 * Get the # of file system overhead blocks from the
 	 * superblock if present.
-- 
2.53.0


