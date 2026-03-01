Return-Path: <linux-ext4+bounces-14265-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCamCoypo2nfJQUAu9opvQ
	(envelope-from <linux-ext4+bounces-14265-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 03:50:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE51CDF6C
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 03:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E357131D41C1
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AE32C1788;
	Sun,  1 Mar 2026 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU7bR8C9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875AA29D270;
	Sun,  1 Mar 2026 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329367; cv=none; b=iZ3eGFJzEmDKxF+Q7qW+4SKXo4YAdJ0TxGSL45OjFTozKYs9so1H1Grr+p8SCaf2D6lqDf9oVAGjmZa27DGv5zFAYXKKe1aZwSnJ3bIa5MRTrsixGT95+Jaq2FoTYOtygATYuIoX9nyp/oQdFBlKqgLPaHUFhJGnZWR5UHiy4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329367; c=relaxed/simple;
	bh=6U1FvJh5WHVD/RM0zog/F1OfcH6s5pkl+NCM475cytc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMaeXFKLGm7wtaEECqky1jj2+9xh88VSEFKs1i+4ThsNivV2wiGMsKCs3T2V8uf7bOJyMDMl21u3hJJYR1ylRD2ZowKm8sZDNntf6n7UsodskYxramOvfDwAjGhrmAdwzRLAVB/mTS1vVBhhXobQlfjsOBezUajyJ7DRq+9jPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU7bR8C9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8131DC2BC86;
	Sun,  1 Mar 2026 01:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329367;
	bh=6U1FvJh5WHVD/RM0zog/F1OfcH6s5pkl+NCM475cytc=;
	h=From:To:Cc:Subject:Date:From;
	b=gU7bR8C9db/M9E8k0oqYsYgOTi/5CvzXPYKv1U7ih0xRPJiZ2F1bpZ26nEsk4cTyC
	 2h8b0dboea9ZvMNuW2L5XCX2gpWlbnW0uD6+6Suh1+0LTkjbQrz9K2w1KppxQQD4Lm
	 U0iz83wLVhRC8RSANNExPwqNThCbPptmzLJgWe71bG8JN5Rd7MKzrOxMmgb/40cH9k
	 xMrbb1l6lBzcb12qpqrcdQHxQhYa0vlxykSDKVCdbyUiSANrma1kufdWeZcSXIbZmQ
	 77VIsG/93cXckBJFM2NLabFixt37ZAktEobqf0cvj9iDGFGid8bWe19agijioqIUMl
	 RtTmXfoN1cn4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bfoster@redhat.com
Cc: Baokun Li <libaokun1@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: fix dirtyclusters double decrement on fs shutdown" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:42:45 -0500
Message-ID: <20260301014245.1704679-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14265-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 85BE51CDF6C
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 94a8cea54cd935c54fa2fba70354757c0fc245e3 Mon Sep 17 00:00:00 2001
From: Brian Foster <bfoster@redhat.com>
Date: Tue, 13 Jan 2026 12:19:05 -0500
Subject: [PATCH] ext4: fix dirtyclusters double decrement on fs shutdown

fstests test generic/388 occasionally reproduces a warning in
ext4_put_super() associated with the dirty clusters count:

  WARNING: CPU: 7 PID: 76064 at fs/ext4/super.c:1324 ext4_put_super+0x48c/0x590 [ext4]

Tracing the failure shows that the warning fires due to an
s_dirtyclusters_counter value of -1. IOW, this appears to be a
spurious decrement as opposed to some sort of leak. Further tracing
of the dirty cluster count deltas and an LLM scan of the resulting
output identified the cause as a double decrement in the error path
between ext4_mb_mark_diskspace_used() and the caller
ext4_mb_new_blocks().

First, note that generic/388 is a shutdown vs. fsstress test and so
produces a random set of operations and shutdown injections. In the
problematic case, the shutdown triggers an error return from the
ext4_handle_dirty_metadata() call(s) made from
ext4_mb_mark_context(). The changed value is non-zero at this point,
so ext4_mb_mark_diskspace_used() does not exit after the error
bubbles up from ext4_mb_mark_context(). Instead, the former
decrements both cluster counters and returns the error up to
ext4_mb_new_blocks(). The latter falls into the !ar->len out path
which decrements the dirty clusters counter a second time, creating
the inconsistency.

To avoid this problem and simplify ownership of the cluster
reservation in this codepath, lift the counter reduction to a single
place in the caller. This makes it more clear that
ext4_mb_new_blocks() is responsible for acquiring cluster
reservation (via ext4_claim_free_clusters()) in the !delalloc case
as well as releasing it, regardless of whether it ends up consumed
or returned due to failure.

Fixes: 0087d9fb3f29 ("ext4: Fix s_dirty_blocks_counter if block allocation failed with nodelalloc")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20260113171905.118284-1-bfoster@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/mballoc-test.c |  2 +-
 fs/ext4/mballoc.c      | 21 +++++----------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index a9416b20ff64c..4abb40d4561ce 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -567,7 +567,7 @@ test_mark_diskspace_used_range(struct kunit *test,
 
 	bitmap = mbt_ctx_bitmap(sb, TEST_GOAL_GROUP);
 	memset(bitmap, 0, sb->s_blocksize);
-	ret = ext4_mb_mark_diskspace_used(ac, NULL, 0);
+	ret = ext4_mb_mark_diskspace_used(ac, NULL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	max = EXT4_CLUSTERS_PER_GROUP(sb);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index de4cacb740b33..dd29558ad753b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4186,8 +4186,7 @@ ext4_mb_mark_context(handle_t *handle, struct super_block *sb, bool state,
  * Returns 0 if success or error code
  */
 static noinline_for_stack int
-ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
-				handle_t *handle, unsigned int reserv_clstrs)
+ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac, handle_t *handle)
 {
 	struct ext4_group_desc *gdp;
 	struct ext4_sb_info *sbi;
@@ -4242,13 +4241,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 	BUG_ON(changed != ac->ac_b_ex.fe_len);
 #endif
 	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
-	/*
-	 * Now reduce the dirty block count also. Should not go negative
-	 */
-	if (!(ac->ac_flags & EXT4_MB_DELALLOC_RESERVED))
-		/* release all the reserved blocks if non delalloc */
-		percpu_counter_sub(&sbi->s_dirtyclusters_counter,
-				   reserv_clstrs);
 
 	return err;
 }
@@ -6333,7 +6325,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ext4_mb_pa_put_free(ac);
 	}
 	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
-		*errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
+		*errp = ext4_mb_mark_diskspace_used(ac, handle);
 		if (*errp) {
 			ext4_discard_allocated_blocks(ac);
 			goto errout;
@@ -6364,12 +6356,9 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 out:
 	if (inquota && ar->len < inquota)
 		dquot_free_block(ar->inode, EXT4_C2B(sbi, inquota - ar->len));
-	if (!ar->len) {
-		if ((ar->flags & EXT4_MB_DELALLOC_RESERVED) == 0)
-			/* release all the reserved blocks if non delalloc */
-			percpu_counter_sub(&sbi->s_dirtyclusters_counter,
-						reserv_clstrs);
-	}
+	/* release any reserved blocks */
+	if (reserv_clstrs)
+		percpu_counter_sub(&sbi->s_dirtyclusters_counter, reserv_clstrs);
 
 	trace_ext4_allocate_blocks(ar, (unsigned long long)block);
 
-- 
2.51.0





