Return-Path: <linux-ext4+bounces-12719-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB7D133C2
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 15:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA0E53008740
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C211E1E16;
	Mon, 12 Jan 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhA6XUvC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC02236E8
	for <linux-ext4@vger.kernel.org>; Mon, 12 Jan 2026 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228621; cv=none; b=IJ5ILDXaBxlykhFvu5ImHogZBuS1HGRcPbmB42+TFjKfL75unUoN/aUZLm8Ml2d+BTOmTzEmDK/I4RLhJdehLKDTrgS4Ggv7YuzRp0MeFbD8Yg4xjrheiVdCPYd2pJo0K7E/LEHgxnEIL871BxLDgfpP5Tx4aif8Otkmmg8SvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228621; c=relaxed/simple;
	bh=NOXNpr+veNZ3w+W1EaQej6dMqv7vo7eYUDi1UM2fuSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GywL25ont9IVlveSCqq7LSmdhtrTpCGNnJ0NlQGG2cm6ZNrF41RN3v3omQ+ZVYeHmnezYPGW6CkIX6eNMoXAyLwaqrYBu6kMwN9MWOvwcGN+abLdcarUSw9TwkSyzGaB5BNNhy4vpxEidSt3TIgUtjNlwuHmj6k0g3GJXo3qxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhA6XUvC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768228618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8fyZO6SMIkSovJJo1An6UJRIOobMaKu0KJq1LKoziaw=;
	b=BhA6XUvCHjQ/pMPBUEYqgtw5ibn3MXrYgCq6O9DQTvh5DdEMV4m15cYcajPBQnhoNO9aRJ
	mv2IJq67fUD+xal8PTC2XcvOS9PzhPbXbgkk8WRVkU9Cl7ptjvJzIWuP0tiA82urF+KuWS
	KGnUgNxB6hFIYfCN9uO5H10AR3jrzMU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-u-7qApM1OY6PfBu2oSbGJg-1; Mon,
 12 Jan 2026 09:36:54 -0500
X-MC-Unique: u-7qApM1OY6PfBu2oSbGJg-1
X-Mimecast-MFC-AGG-ID: u-7qApM1OY6PfBu2oSbGJg_1768228613
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79DA51956046;
	Mon, 12 Jan 2026 14:36:53 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.146])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9A281800665;
	Mon, 12 Jan 2026 14:36:52 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-ext4@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2] ext4: fix dirtyclusters double decrement on fs shutdown
Date: Mon, 12 Jan 2026 09:36:52 -0500
Message-ID: <20260112143652.8085-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
---

v2:
- Condense counter update logic instead of modifying return flow.
- Added Fixes: tag.
v1: https://lore.kernel.org/linux-ext4/20251212154735.512651-1-bfoster@redhat.com/

 fs/ext4/mballoc.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 56d50fd3310b..b31d7ddc52a9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4185,8 +4185,7 @@ ext4_mb_mark_context(handle_t *handle, struct super_block *sb, bool state,
  * Returns 0 if success or error code
  */
 static noinline_for_stack int
-ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
-				handle_t *handle, unsigned int reserv_clstrs)
+ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac, handle_t *handle)
 {
 	struct ext4_group_desc *gdp;
 	struct ext4_sb_info *sbi;
@@ -4241,13 +4240,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
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
@@ -6332,7 +6324,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ext4_mb_pa_put_free(ac);
 	}
 	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
-		*errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
+		*errp = ext4_mb_mark_diskspace_used(ac, handle);
 		if (*errp) {
 			ext4_discard_allocated_blocks(ac);
 			goto errout;
@@ -6363,12 +6355,9 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 out:
 	if (inquota && ar->len < inquota)
 		dquot_free_block(ar->inode, EXT4_C2B(sbi, inquota - ar->len));
-	if (!ar->len) {
-		if ((ar->flags & EXT4_MB_DELALLOC_RESERVED) == 0)
-			/* release all the reserved blocks if non delalloc */
-			percpu_counter_sub(&sbi->s_dirtyclusters_counter,
-						reserv_clstrs);
-	}
+	/* release all the reserved blocks if non delalloc */
+	if ((ar->flags & EXT4_MB_DELALLOC_RESERVED) == 0)
+		percpu_counter_sub(&sbi->s_dirtyclusters_counter, reserv_clstrs);
 
 	trace_ext4_allocate_blocks(ar, (unsigned long long)block);
 
-- 
2.52.0


