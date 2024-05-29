Return-Path: <linux-ext4+bounces-2709-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F068D32D5
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 11:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891A51C23830
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CE916C451;
	Wed, 29 May 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rEb4cntR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC716A36F
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974439; cv=none; b=s68wSBgH/wa+rGjJoY0EeymOVvswghbg/PA8EvXXLZZQifdKUpcv1c1rcwHIUYMQ/+6DZ0RVpHSOgA9ryrENjamhM7kZFzUZb58LjyEt49ErOFJ9QfWN6yc3mEb3FV711JQQsyyVf/5J1NewMrZRfb+cZPFyCDcOOWfEANGJIW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974439; c=relaxed/simple;
	bh=viiNCjfXjMsAOVNEQF24ckmVna96BiwliXfQ+Trut98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqpBA4h+OeQV0lncgQyeF1rpCW00ke7ykcmdmwXjnn8ihgSoRzvl9WgvTcQo56UbQXPngH+onZG0t44uduXK4AB86d5Ati30f6orbt13x7ZCcl0p+MXeSg9//yfgrcVLqrLC6UDcyUgt+gAyMPJ7dIiI3tsUIZQRVblCEcM7o2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rEb4cntR; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: adilger@dilger.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716974435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+yIEl13IIwajG/g+ej4zptTHBFXUNxUCGXGrEEsmGE=;
	b=rEb4cntR0bdDWPNR56x/oAfax3NQddk97e7zBgpcfJG0nZFQBKsLbvtrustH0W3EQAJa6q
	WtjmXCJ2Z8M3zXORWWHQmou92/61I3GEJHgW0nH/aDNgkOQw94Jv2SrGc6Hl/IfSoBA1Zr
	0dLVdWLCNncuCVoLutDQZ+i82rCoG2Q=
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
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
Subject: [PATCH v3 2/2] ext4: fix possible tid_t sequence overflows
Date: Wed, 29 May 2024 10:20:30 +0100
Message-ID: <20240529092030.9557-3-luis.henriques@linux.dev>
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

In the fast commit code there are a few places where tid_t variables are
being compared without taking into account the fact that these sequence
numbers may wrap.  Fix this issue by using the helper functions tid_gt()
and tid_geq().

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/fast_commit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 088bd509b116..30d312e16916 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -353,7 +353,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 		read_unlock(&sbi->s_journal->j_state_lock);
 	}
 	spin_lock(&sbi->s_fc_lock);
-	if (sbi->s_fc_ineligible_tid < tid)
+	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
 		sbi->s_fc_ineligible_tid = tid;
 	spin_unlock(&sbi->s_fc_lock);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
@@ -1207,7 +1207,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	if (ret == -EALREADY) {
 		/* There was an ongoing commit, check if we need to restart */
 		if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
-			commit_tid > journal->j_commit_sequence)
+		    tid_gt(commit_tid, journal->j_commit_sequence))
 			goto restart_fc;
 		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0,
 				commit_tid);
@@ -1282,7 +1282,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		if (iter->i_sync_tid <= tid) {
+		if (tid_geq(tid, iter->i_sync_tid)) {
 			ext4_fc_reset_inode(&iter->vfs_inode);
 		} else {
 			/*
@@ -1322,7 +1322,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
 				&sbi->s_fc_q[FC_Q_MAIN]);
 
-	if (tid >= sbi->s_fc_ineligible_tid) {
+	if (tid_geq(tid, sbi->s_fc_ineligible_tid)) {
 		sbi->s_fc_ineligible_tid = 0;
 		ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	}

