Return-Path: <linux-ext4+bounces-2708-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56458D32D2
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 11:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F8C1F22C4D
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFEB16ABF2;
	Wed, 29 May 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lahw4Chd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618216A361
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974438; cv=none; b=GZNeJdfddSR/XLcerzl8Jid+++Dv2QVcdrOsYFieYQpE0nJ8vcMXskC8vzgPzJ2BlRnNjKVkbfqRm01I+LlYXaKZ+3jmJMyGOGE2PqQV335OiTa/xX9AUFTw1ruWmA9+61WIMsEoI5UrdTjCdvuM2mKl4+M087io2JLtsK/zn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974438; c=relaxed/simple;
	bh=mRgqrVV+g3RFcPQAIieiLKcKV0KvYVsDDyfVTzietbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLI/JqTLkSeDLK6oE1JY6cu7oZzAA2hS/mPlA5+dZ/c0vVxjfaBtrU+P/9xn5lo7F4Zm1vXTyaG2LrqWtQQZpshJFiXXgqfSYLs7cij1wO+zuYWf9PysWxhoFrHLDPxh9k79jN5FBhRL3nhoG2BRxABcNYGQ9DNCTGY92kxMyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lahw4Chd; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: adilger@dilger.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716974434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/oRQ9r3IxZKTM7rfHJfMbi3eQrNuT4jysuESWyn5dE=;
	b=lahw4ChdjfdeXzVOf5FlqhplAIZCPNNFUFyJNeMMai9YY5GJKP3l7cmCMrDv/Zk3BGlL8X
	lhM3kxU/PuxQJ8BxqZ13vjBy15UMOv6SJh8awQd31Z+H5GkmmkwwyMWruqvrc2dFWjPNWp
	4zkr1Pkt9UeS+bZTjtYhvSJXzIUFcCY=
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: tytso@mit.edu
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v3 1/2] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Wed, 29 May 2024 10:20:29 +0100
Message-ID: <20240529092030.9557-2-luis.henriques@linux.dev>
In-Reply-To: <20240529092030.9557-1-luis.henriques@linux.dev>
References: <20240529092030.9557-1-luis.henriques@linux.dev>
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
 fs/ext4/fast_commit.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..088bd509b116 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1282,8 +1282,17 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		if (iter->i_sync_tid <= tid)
+		if (iter->i_sync_tid <= tid) {
 			ext4_fc_reset_inode(&iter->vfs_inode);
+		} else {
+			/*
+			 * re-enqueue inode into STAGING, which later will be
+			 * splice back into MAIN
+			 */
+			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_STAGING]);
+		}
+
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
 #if (BITS_PER_LONG < 64)

