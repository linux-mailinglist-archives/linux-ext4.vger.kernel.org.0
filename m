Return-Path: <linux-ext4+bounces-13515-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDtUG3XCgmkpaAMAu9opvQ
	(envelope-from <linux-ext4+bounces-13515-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 04:52:21 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C494BE1628
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 04:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35213301E19F
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 03:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF49287246;
	Wed,  4 Feb 2026 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="EDbmNZhK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic314-22.consmr.mail.ne1.yahoo.com (sonic314-22.consmr.mail.ne1.yahoo.com [66.163.189.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC91A5B84
	for <linux-ext4@vger.kernel.org>; Wed,  4 Feb 2026 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177138; cv=none; b=cL5JvEXLQM3pJvFVLYjlcX2r4X3xt7Oor3E+u/OSf2bOuzm/0ZP+oOrmZPNpu/J0Ixpkh84d3at0nrnUQ0J8NB/aknG6KOkQCCXLAZRH4rwSUFmog3TYKAYpI/inAL3ABZKXcccp+jBYjNYQWS7jq1DHu1q1FdtIhhaRj03VerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177138; c=relaxed/simple;
	bh=eyKM4vTuZw2l0QhGyxjygj4jfsx/A99XMLh7chiAOSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=BUcEUE3Kkcw+GTW8xFM392iekbOEn3AsL36ugtfCu/z6rp/HywJjIFJ005w5P42nb2b7og4D2uTUUnR83vJ7QFEGPASzwatv0aZnZgmH/4KKxYJtGpQ++L2SQPDUzquHRAhIzF77bqG7q6CW6pJshbMhUrcelMrxi+eMOZ7bTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=EDbmNZhK; arc=none smtp.client-ip=66.163.189.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1770177134; bh=wIBNWxFrZKzeBS3/aZ5y2JeYiooBEvHZ4XvKkzkHNfg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=EDbmNZhKP/eH6Ds4bXvGildc7ssVnB44RnI97v7SOTr7bPBegbqcHGyl/avuoyjRcsRx2wth4YOJfjS0ftgCvWt6u2ZXDjJKTmL3ju5Peg7RevJxBn5GBo7ecLvQPcSrIT+eKexJEKjYaF/QtFPNT58W/nj85zAmv51gIJfeXcU4iVJidV32iXCbNR6Bqbx6gDyiTDML74PUGEMKXsigDJxbLD2OZOOp5ZsLIQqttwE4qvn6Bvdu1VDI3+QZDDpFw25XB4icJjqm0AuidSLLlhrHXDVg4SkZ4o6Ya1yWGTL7Tu8tjMiKIU+HvG7+s14LWbxF3ayhkq9sZSb36558KQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770177134; bh=/5Zm33xmWgVSk4IGlf9sqxdXTYl2jqvidadfro7XwXw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WiR+iUx4CLumcV+dXnlX36b8jU4PAfrtZGWb0ywaAOfyGzQtyFtUKxZ3FArppn7++v1auzGQJ5JLGZQLOQafAvzyGXq3GvC0ObjvJKiKBulmXQZ3Hlpz60V7MtJeAdLw6efTfQvFtEnDFG6q3Ukk3y4EVSTlrNDqZdkcKjuMUnKsM96uChTkbqs0xCmkbvQoDRRTkzIZsYP2bza8lOnRVoUvDbbehPbcnqg7Z16loDJTMdlEO1NvzNtsTj7t2ra6Ue/YkooInPB3+aI4URP7af8jPs2Be4fwtHZr1NwujL2cSWZ6xOCin6oapz3Oi7wWJbCbcCoTZBHusfBeD/afMw==
X-YMail-OSG: jKxwkoQVM1khPp8OSg6HYv9VuwqD6qtsKvB7BLnjJIpJiZS4q73cMxT9tHiwAih
 gZq5j6TMosHRUIbakUmW3ZTELeIBWTgdP62c5iPhw7izXd9jQyK6D4wG9TtjSrorLkTwZpzPIHzW
 .UmhNFpFxNLVNjQRsnorC6WCtR62f7mMoQeLoWEtNdsMMNCuNc9At99gV3b8ObpxiEmBs8M7K.Qf
 XNzNzQN5n7XepNXhLnXUkzCH7Pk8e4zGm0tVFCkfgTFCgOj_GJB0lM5lQlclkR5yeTOgcvaN4.yr
 fVgI5Z2CW7ZqRLIecxCe6_WuA_iYlBfGTfo9Zwyil87zpGKLDyiRWruHpvAIDCNtm1lKKIawGmwA
 .R.mnkUNIIh2Zsjk5ELlPFul3N1ooT1nieb2.KYM9n19Qh5WDaxtlb.a7FfTIBtkYyQK0bxwWQSx
 2LToaTGaKIYq0aCsbTXeCX9rOHa2dUWZQCdONlb3_es5VzITWttI6bikqYEXXFUmPZG4o3i8vOoi
 Z1Yp8muKyNPmT1pQ6T_RDHAuvSGcLfP_Hd6QFjqhJ6SVh1dgMRtKhLon62YxWW_V0XI_Qx7e1vrY
 0Bec3opht5UukXSX7DIqf6CKMKydEUlx90IBLGJqbkpuC3XxVe3tgAu9ECZ2R5mcXT1uK9YL0zLq
 NfI5Pnt1NGfjqUp_zwlrNyIFD3.iw9kP92RiwSR4RocTq6famDn9M2567WQqYaqMxdnn3hNicHdw
 nqlX4Fx3vNo21JOTKEDEUKXKuPuJvQsMu76SPgkqm7TWXeqCfEevEc2ckASOp.ngo119vh.kr_K2
 x3h1E087H9LF_2IUrQNg6ZofDWXZucXdrqgWWWndr9w0uiEOShXMJyzajUeINM4xinXIZH5FdGbq
 O_C4IKXYI8lTNIelbhFDSD4AbNSU_A5HyxdN9aJnC_uek7ZVSJtHiwVMeqf1HFBzNuMuBO3HsOkj
 SU4rsvQQd1FD.2Bnn02tSregYtFPI8wu_ekpwlLWeoiWW31cTv5vujalvG.vkubAEf3f3OU_v65.
 tUCSMTVVhgr11eFXfpzQQOBlKO8gTLEa4hNA7bMkZOzIrGrUi7xoduyrWGoqKfynzsyiWMzKe4j_
 2IKaEu7k5KL4FE2XabLovasDRUJ9kqAi.My1cUJOSVFwwZ3uiqI1zXL.1X8w0_BH0qFNPoqUENlt
 1RLoj9LIlIe3S7yDciCr4ikreFFNhLBAXgc6y.OkTj20y3aXDBbnEUVz_3cTaOAtOOuNVQPGNo6_
 IYXG3p5Od_UR4XIXHMelGOPzDlz.5f7ZRhVdFuxlpL5fxjV_QOC14UYGCtIqG05L81XlekHqjwNk
 ad4M8v1UQarvtishXlu1Y9Un00s5BP8CDEt8kBrk9F84RGxYBejeXRcO5JuDVKX_rtxN2LyVgAxW
 wsp8EsYBoAfpdQh1BfFxknR6jADVH4yebCRYfvbV_gA2RMSNUtamJw04oEIRHRPNXETyB2IKEaMz
 p3rtePONOY4HJoqOMZSG2DKiBDOTRhLiiMW.E.5JRZM0g4VuFQr.1yTHBWZ_FbuH5dQteplzFNE5
 giQXKKPQY98q8Kbnlsfk1ksiCx2fHsx1nNw5TahpbCIQXH88ON3KH6lY3mmXuTbN.PJKrmQt9.mt
 lDGJz.gD2cv73TqIyxsXSbt9M158pzqnM7129yCnan08nrc90Ik2yC_E0PkusGdOJZHTlpfqt7sH
 V2EQwp98TDaW4botfM_Vsc2IlffgzFDXrkomi8Xt5WBscSy_yPyl3DCmItKSXXZCpKOHvsqU3ufU
 xitRHX1M1zGabNnaoHcPOzYdW9dldJkk.iwzt_YZVeNdBEoDiVY57TU0ufAdof0JYU2t5MoEH6lI
 .t7jPUq7gVgB.9nlQNLvoqaoPZuwxrYTcErDA4lF0JXeQQEJHOWQJSVZyMEOs.H69K4I1jMxNqlv
 38lgXGnwhJspj7Ln9WsnBKqilhGRfmAVxBPLNN0db5SswwOh3eL5Igmmwr1pZvnTJMsW9mibSZ1Z
 xUhZLPuJ5FWevqDVvp2C_Zhiq.eHDieC5QJPdAu16OFZCo9Z8VoZOIpsr3udDSPeht3Bhl8qiZxl
 M.ENLxCEvcaH5mCGndyhbCePXhU2uUUZNpM.qS0byJ6Qd4NhYsK21TfU4fa6P4I4M7eyBQqCwvED
 p0K8_EeMqRp2IRFE8WkMlu6dpP19h2cbVX8ETy9Lb11122FHWAf5lleNW8M9wPiQPaLN6hfxb9Id
 XG24suQ9qukBy
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: c2851788-8b95-4326-8bee-03ea0a3e6bd9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Feb 2026 03:52:13 +0000
Received: by hermes--production-ir2-6fcf857f6f-52lzv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7151edb1649ab80f6fd6a6adf75398a9;
          Wed, 04 Feb 2026 03:31:47 +0000 (UTC)
From: Mario Lohajner <mario_lohajner@rocketmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Lohajner <mario_lohajner@rocketmail.com>
Subject: [PATCH] ext4: add optional rotating block allocation policy
Date: Wed,  4 Feb 2026 04:31:12 +0100
Message-ID: <20260204033112.406079-1-mario_lohajner@rocketmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	FREEMAIL_CC(0.00)[dilger.ca,vger.kernel.org,rocketmail.com];
	TAGGED_FROM(0.00)[bounces-13515-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C494BE1628
X-Rspamd-Action: no action

Add support for the rotalloc allocation policy as a new mount
option. Policy rotates the starting block group for new allocations.

Changes:
- fs/ext4/ext4.h
	rotalloc policy dedlared, extend sb with cursor, vector & lock

- fs/ext4/mballoc.h
	expose allocator functions for vectoring in super.c

- fs/ext4/super.c
	parse rotalloc mnt opt, init cursor, lock and allocator vector

- fs/ext4/mballoc.c
	add rotalloc allocator, vectored allocator call in new_blocks

The policy is selected via a mount option and does not change the
on-disk format or default allocation behavior. It preserves existing
allocation heuristics within a block group while distributing
allocations across block groups in a deterministic sequential manner.

The rotating allocator is implemented as a separate allocation path
selected at mount time. This avoids conditional branches in the regular
allocator and keeps allocation policies isolated.
This also allows the rotating allocator to evolve independently in the
future without increasing complexity in the regular allocator.

The policy was tested using v6.18.6 stable locally with the new mount
option "rotalloc" enabled, confirmed working as desribed!

Signed-off-by: Mario Lohajner <mario_lohajner@rocketmail.com>
---
 fs/ext4/ext4.h    |   8 +++
 fs/ext4/mballoc.c | 152 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h |   3 +
 fs/ext4/super.c   |  18 +++++-
 4 files changed, 175 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 56112f201cac..cbbb7c05d7a2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -229,6 +229,9 @@ struct ext4_allocation_request {
 	unsigned int flags;
 };
 
+/* expose rotalloc allocator argument pointer type */
+struct ext4_allocation_context;
+
 /*
  * Logical to physical block mapping, used by ext4_map_blocks()
  *
@@ -1230,6 +1233,7 @@ struct ext4_inode_info {
  * Mount flags set via mount options or defaults
  */
 #define EXT4_MOUNT_NO_MBCACHE		0x00001 /* Do not use mbcache */
+#define EXT4_MOUNT_ROTALLOC			0x00002 /* Use rotalloc policy/allocator */
 #define EXT4_MOUNT_GRPID		0x00004	/* Create files with directory's group */
 #define EXT4_MOUNT_DEBUG		0x00008	/* Some debugging messages */
 #define EXT4_MOUNT_ERRORS_CONT		0x00010	/* Continue on errors */
@@ -1559,6 +1563,10 @@ struct ext4_sb_info {
 	unsigned long s_mount_flags;
 	unsigned int s_def_mount_opt;
 	unsigned int s_def_mount_opt2;
+	/* Rotalloc cursor, lock & new_blocks allocator vector */
+	unsigned int s_rotalloc_cursor;
+	spinlock_t s_rotalloc_lock;
+	int (*s_mb_new_blocks)(struct ext4_allocation_context *ac);
 	ext4_fsblk_t s_sb_block;
 	atomic64_t s_resv_clusters;
 	kuid_t s_resuid;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 56d50fd3310b..74f79652c674 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2314,11 +2314,11 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
  *   stop the scan and use it immediately
  *
  * * If free extent found is smaller than goal, then keep retrying
- *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
+ *   up to a max of sbi->s_mb_max_to_scan times (default 200). After
  *   that stop scanning and use whatever we have.
  *
  * * If free extent found is bigger than goal, then keep retrying
- *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
+ *   up to a max of sbi->s_mb_min_to_scan times (default 10) before
  *   stopping the scan and using the extent.
  *
  *
@@ -2981,7 +2981,7 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
 	return ret;
 }
 
-static noinline_for_stack int
+noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
 	ext4_group_t i;
@@ -3012,7 +3012,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	 * is greater than equal to the sbi_s_mb_order2_reqs
 	 * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
 	 * We also support searching for power-of-two requests only for
-	 * requests upto maximum buddy size we have constructed.
+	 * requests up to maximum buddy size we have constructed.
 	 */
 	if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
 		if (is_power_of_2(ac->ac_g_ex.fe_len))
@@ -3101,6 +3101,144 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	return err;
 }
 
+/* Rotating allocator (rotalloc mount option) */
+noinline_for_stack int
+ext4_mb_rotating_allocator(struct ext4_allocation_context *ac)
+{
+	ext4_group_t i, goal;
+	int err = 0;
+	struct super_block *sb = ac->ac_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_buddy e4b;
+
+	BUG_ON(ac->ac_status == AC_STATUS_FOUND);
+
+	/* Set the goal from s_rotalloc_cursor */
+	spin_lock(&sbi->s_rotalloc_lock);
+	goal = sbi->s_rotalloc_cursor;
+	spin_unlock(&sbi->s_rotalloc_lock);
+	ac->ac_g_ex.fe_group = goal;
+
+	/* first, try the goal */
+	err = ext4_mb_find_by_goal(ac, &e4b);
+	if (err || ac->ac_status == AC_STATUS_FOUND)
+		goto out;
+
+	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
+		goto out;
+
+	/*
+	 * ac->ac_2order is set only if the fe_len is a power of 2
+	 * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
+	 * so that we try exact allocation using buddy.
+	 */
+	i = fls(ac->ac_g_ex.fe_len);
+	ac->ac_2order = 0;
+	/*
+	 * We search using buddy data only if the order of the request
+	 * is greater than equal to the sbi_s_mb_order2_reqs
+	 * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
+	 * We also support searching for power-of-two requests only for
+	 * requests up to maximum buddy size we have constructed.
+	 */
+	if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
+		if (is_power_of_2(ac->ac_g_ex.fe_len))
+			ac->ac_2order = array_index_nospec(i - 1,
+							   MB_NUM_ORDERS(sb));
+	}
+
+	/* if stream allocation is enabled, use global goal */
+	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
+		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
+
+		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_groups[hash]);
+		ac->ac_g_ex.fe_start = -1;
+		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
+	}
+
+	/*
+	 * Let's just scan groups to find more-less suitable blocks We
+	 * start with CR_GOAL_LEN_FAST, unless it is power of 2
+	 * aligned, in which case let's do that faster approach first.
+	 */
+	ac->ac_criteria = CR_GOAL_LEN_FAST;
+	if (ac->ac_2order)
+		ac->ac_criteria = CR_POWER2_ALIGNED;
+
+	ac->ac_e4b = &e4b;
+	ac->ac_prefetch_ios = 0;
+	ac->ac_first_err = 0;
+
+	/* Be sure to start scanning with goal from s_rotalloc_cursor! */
+	ac->ac_g_ex.fe_group = goal;
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
+	if (!err) {
+		/* Finally, if no errors, set the currsor to best group! */
+		goal = ac->ac_b_ex.fe_group;
+		spin_lock(&sbi->s_rotalloc_lock);
+		sbi->s_rotalloc_cursor = goal;
+		spin_unlock(&sbi->s_rotalloc_lock);
+	}
+
+	return err;
+}
+
 static void *ext4_mb_seq_groups_start(struct seq_file *seq, loff_t *pos)
 {
 	struct super_block *sb = pde_data(file_inode(seq->file));
@@ -6314,7 +6452,11 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			goto errout;
 repeat:
 		/* allocate space in core */
-		*errp = ext4_mb_regular_allocator(ac);
+		/*
+		 * Use vectored allocator insead of fixed
+		 * ext4_mb_regular_allocator(ac) function
+		 */
+		*errp = sbi->s_mb_new_blocks(ac);
 		/*
 		 * pa allocated above is added to grp->bb_prealloc_list only
 		 * when we were able to allocate some block i.e. when
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 15a049f05d04..309190ce05ae 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -270,4 +270,7 @@ ext4_mballoc_query_range(
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv);
 
+/* Expose rotating & regular allocators for vectoring */
+int ext4_mb_rotating_allocator(struct ext4_allocation_context *ac);
+int ext4_mb_regular_allocator(struct ext4_allocation_context *ac);
 #endif
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d0..f53501bbfb4b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1673,7 +1673,7 @@ enum {
 	Opt_nomblk_io_submit, Opt_block_validity, Opt_noblock_validity,
 	Opt_inode_readahead_blks, Opt_journal_ioprio,
 	Opt_dioread_nolock, Opt_dioread_lock,
-	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
+	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable, Opt_rotalloc,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
 	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
@@ -1797,6 +1797,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_u32	("init_itable",		Opt_init_itable),
 	fsparam_flag	("init_itable",		Opt_init_itable),
 	fsparam_flag	("noinit_itable",	Opt_noinit_itable),
+	fsparam_flag	("rotalloc",	Opt_rotalloc),
 #ifdef CONFIG_EXT4_DEBUG
 	fsparam_flag	("fc_debug_force",	Opt_fc_debug_force),
 	fsparam_u32	("fc_debug_max_replay",	Opt_fc_debug_max_replay),
@@ -1878,6 +1879,7 @@ static const struct mount_opts {
 	{Opt_noauto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_SET},
 	{Opt_auto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_CLEAR},
 	{Opt_noinit_itable, EXT4_MOUNT_INIT_INODE_TABLE, MOPT_CLEAR},
+	{Opt_rotalloc, EXT4_MOUNT_ROTALLOC, MOPT_SET},
 	{Opt_dax_type, 0, MOPT_EXT4_ONLY},
 	{Opt_journal_dev, 0, MOPT_NO_EXT2},
 	{Opt_journal_path, 0, MOPT_NO_EXT2},
@@ -2264,6 +2266,9 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			ctx->s_li_wait_mult = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_li_wait_mult;
 		return 0;
+	case Opt_rotalloc:
+		ctx_set_mount_opt(ctx, EXT4_MOUNT_ROTALLOC);
+		return 0;
 	case Opt_max_dir_size_kb:
 		ctx->s_max_dir_size_kb = result.uint_32;
 		ctx->spec |= EXT4_SPEC_s_max_dir_size_kb;
@@ -5512,6 +5517,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		}
 	}
 
+	/*
+	 * Initialize rotalloc cursor, lock and
+	 * vector new_blocks to rotating^regular allocator
+	 */
+	sbi->s_rotalloc_cursor = 0;
+	spin_lock_init(&sbi->s_rotalloc_lock);
+	if (test_opt(sb, ROTALLOC))
+		sbi->s_mb_new_blocks = ext4_mb_rotating_allocator;
+	else
+		sbi->s_mb_new_blocks = ext4_mb_regular_allocator;
+
 	/*
 	 * Get the # of file system overhead blocks from the
 	 * superblock if present.
-- 
2.52.0


