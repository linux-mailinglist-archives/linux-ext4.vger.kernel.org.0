Return-Path: <linux-ext4+bounces-12459-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C31AFCD49FB
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Dec 2025 04:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E7533007943
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Dec 2025 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EBB324B0C;
	Mon, 22 Dec 2025 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="qi/yPHSD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1721A5B9D;
	Mon, 22 Dec 2025 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766374027; cv=pass; b=AdwG5JyI9bFgpBndWbfpmJJrsXdzDT0bvEqFcNzKlkGihwJJhWHTIrQ2ABay3nwPCp7KYcMTwzA6hpB6z1SXZwfUdDrdhgyoR34G8EUK1X+uF89D83Z3DIF4gBJ5CKwMFm5CDtTNmUHrsRBZBorFZuVH3wBYkdZ/+6+wnmN3xXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766374027; c=relaxed/simple;
	bh=NXld0KXoy39NzNCnlQMPzjj9GC/599xNaFD96TgRzOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfrN1ARmsFJjpFStBYM89BfEmY46Fo63Il1zyccK4JGqOcMaCxbPtWLBYAy1BGANPLMk/oaGplMT4peV+4Eip1rfJFZ4Ku91y+eu5evfkTBsEXFL1eKTyY24+nihTZe2F3Uc8ITJr1x0+BLFq1gSYkNnYVb0JJ2VhlnpIsugMxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=qi/yPHSD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1766374021; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cDkQax5ehDG0Osa2l+5bdRcFJ641j8Lo2DCe0xHs8+uVpGj32NlsSjyyZhDGYAHqlqDuSBSY68blduMpr54Hf+L6S22kAJ9621LLdkWbEA0500hpbPm/DzgIkhiCiGBV0ThAQ3p/V2pVDEae94m0806Mqe8+Xb9G37zO6DrEksU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766374021; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ql3xDkB3yHy4T0gxRBEXXol7cFPLqrSkEe44L0Wxhtw=; 
	b=CAzx99J7d270bk1MPCFbR6RLvqfZxSlgqTH27HpjqgRA5gpLj3ZmXuYO7au2QCKV2WCbD+5Ns2WaYyciwKNsDwGruw6BIkFOBbv9QSaB0fFQ/www1i+9jaVY04GLSXXfWpXYGo5KRwbFemAPcUAVbM4bKzqF/Io/HRgROaiqGK4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766374021;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ql3xDkB3yHy4T0gxRBEXXol7cFPLqrSkEe44L0Wxhtw=;
	b=qi/yPHSDQHizrQvzus5bW1RrDqNeH8LFPnBO2eDspBJpNW2i4wPQESmj+/+8LhE+
	O6l1ID5dkwhKSEFDCws5iosymEG9W+K2fGY/9ex4xiRorcmesyZ35nFwkJietmbJBmQ
	rH7dr3U2LCOyatwWXRN7DXew9C/IStaeFZ44sToY=
Received: by mx.zohomail.com with SMTPS id 176637401933171.06925102177786;
	Sun, 21 Dec 2025 19:26:59 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH] ext4: fast_commit: assert i_data_sem only before sleep
Date: Mon, 22 Dec 2025 11:26:54 +0800
Message-ID: <20251222032655.87056-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ext4_fc_track_inode() may enter the wait loop with
EXT4_STATE_FC_COMMITTING set but then observe it cleared before it
actually sleeps. Asserting i_data_sem not held unconditionally triggers
false lockdep warnings from paths that hold i_data_sem (e.g. fallocate)
but never reach schedule().

Move lockdep_assert_not_held(&ei->i_data_sem) onto the schedule() path
so it only fires when we are really going to sleep.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f3914f46bcf6..f24b4fea7421 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -577,8 +577,6 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 	 * commit. We shouldn't be holding i_data_sem when we go to sleep since
 	 * the commit path needs to grab the lock while committing the inode.
 	 */
-	lockdep_assert_not_held(&ei->i_data_sem);
-
 	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
 #if (BITS_PER_LONG < 64)
 		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
@@ -592,8 +590,10 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 				   EXT4_STATE_FC_COMMITTING);
 #endif
 		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
-		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
+		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+			lockdep_assert_not_held(&ei->i_data_sem);
 			schedule();
+		}
 		finish_wait(wq, &wait.wq_entry);
 	}
 
-- 
2.51.0


