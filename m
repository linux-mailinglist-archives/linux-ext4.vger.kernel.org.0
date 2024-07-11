Return-Path: <linux-ext4+bounces-3193-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD30892E283
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 10:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D03EB273B7
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D15152533;
	Thu, 11 Jul 2024 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HDcbounX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84E13B59F
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686933; cv=none; b=m8vArtmt+LUOElRRvXBUJlalbO0IVrQrMqQenGSzSSNfm6EOKXGt+G2rMrudgYp3Bhl0ypvIyABRUGsWn9Ck4mceFVy2PpkKX9d3TGERgBnnWGdKTVaC4iAQEpl2G5mUeWLG/B/fP8atyain1uIFjvUSAGQqEp2zUFmPxtKeEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686933; c=relaxed/simple;
	bh=9WaGRIRa+CuZVB3aj959sFu6enuiqwvP41svFu0Wzlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKU3ggHIRlYDrEGX2vAlxoNJO+KxrnMKwTSrofVk+jAKpRIfTDL5BZOvGL3GS0WWm/FZU9gVS1kApyIu7wwsLFj0K9mkL9kgINa4nGxgK68Noq+/aEiggqrjq0v3rvFKJGcxVn3IQQgavvjeG3mpnzqHgA/kt7wJkcTthnjEfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HDcbounX; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720686929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xav/vnLrQtAUlJK7pKq3AAhH8e2fERWCjHvfS/fkmdA=;
	b=HDcbounXUexQMgdMw/uq3GC6NqsRgDa2QzCpg43UINoZ06oDSwR5203aYdbY/ODIniixyj
	GBiyRXJrPg5r03vR+NB8v6nsyepv1LK2tMiu7xQ6SWhe/zfHuqeo21V3m0U3/QPZWy4tNW
	qLIViWIS6zUH6/PoocenosDVGGxFBPM=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v4] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Thu, 11 Jul 2024 09:35:20 +0100
Message-ID: <20240711083520.6751-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a full journal commit is on-going, any fast commit has to be enqueued
into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
is done only once, i.e. if an inode is already queued in a previous fast
commit entry it won't be enqueued again.  However, if a full commit starts
_after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
be done into FC_Q_STAGING.  And this is not being done in function
ext4_fc_track_template().

This patch fixes the issue by re-enqueuing an inode into the STAGING queue
during the fast commit clean-up callback if it has a tid (i_sync_tid)
greater than the one being handled.  The STAGING queue will then be spliced
back into MAIN.

This bug was found using fstest generic/047.  This test creates several 32k
bytes files, sync'ing each of them after it's creation, and then shutting
down the filesystem.  Some data may be loss in this operation; for example a
file may have it's size truncated to zero.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
Hi!

v4 of this patch enqueues the inode into STAGING *only* if the current tid
is non-zero.  It will be zero when doing an fc commit, and this would mean
to always re-enqueue the inode.  This fixes the regressions caught by Ted
in v3 with fstests generic/472 generic/496 generic/643.

Also, since 2nd patch of v3 has already been merged, I've rebased this patch
to be applied on top of it.

 fs/ext4/fast_commit.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..facbc8dbbaa2 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 				       EXT4_STATE_FC_COMMITTING);
 		if (tid_geq(tid, iter->i_sync_tid))
 			ext4_fc_reset_inode(&iter->vfs_inode);
+		} else if (tid) {
+			/*
+			 * If the tid is valid (i.e. non-zero) re-enqueue the
+			 * inode into STAGING, which will then be splice back
+			 * into MAIN
+			 */
+			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_STAGING]);
+		}
+
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
 #if (BITS_PER_LONG < 64)

