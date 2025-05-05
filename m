Return-Path: <linux-ext4+bounces-7684-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D34AAA163
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 00:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAE4165C1D
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1627E7FA;
	Mon,  5 May 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEyPYI/X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194922BD916;
	Mon,  5 May 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483589; cv=none; b=S1J9iPI1tA9S9L0ois7qYBWz0jfW4YENc6soccG9Zibex7LMikR4scw+w/u4I4/9pWyjGd60s8btnVadsQZldz4Rkm0vyABc5l4HSujRmT3SMV5ZtQ1NVo/7isYkXL3NN4T2j4EsXNNr/XQt400WqE5HGyB8Dp1N88d5CEUGYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483589; c=relaxed/simple;
	bh=goOUvNbS/RQth9KF4WQ0hpR6MLHKqnRLOupGS7yXOq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UA1tgvCNwchv5Ey+l72XINTn87m+xU/nTlq6e2lZ8JFIZtkW3IrffBW9mqGko0t4BStyhws/s3oY8+tRGk9oICRbeyYV/3UT+m4x/4ef2K2RupB7M7vaEqFyAsueNZ1tNZxsyCzVQ6ZRBKKz88RGgUlsS9Atr6yVZIiKwEnMCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEyPYI/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63CDC4CEE4;
	Mon,  5 May 2025 22:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483588;
	bh=goOUvNbS/RQth9KF4WQ0hpR6MLHKqnRLOupGS7yXOq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEyPYI/X0T7X/5r6J7fRSuHcTR8L9VMHd7f+K7KCUGGV1zMoqo+BxRvOUtQ9YDpSd
	 QISo413XfZuWESdx6pqGX96SqYjYd90dVgoK76eKnyQ+XSNsLGL065RddbFrD4MP0a
	 A5q44clRVGY5+jaPIhFWWq7uPQU3YJhcMxJdzNsz7cRylFPm3FGbEoPFi49GtwWC0y
	 N54hwW6fqBqiLaC2b2XgAlNtdNZCBCffR7jE+ktUUT+c2RlmXAKQFVQ57FooEOyF4n
	 9HSz+WA2C8eWWinqEGXBeyOLTxie5Jgf5//sDT4mYynxGD6l5W/QFcfXDkXZr+m2nq
	 kQAKFTa4GPsDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 129/642] jbd2: do not try to recover wiped journal
Date: Mon,  5 May 2025 18:05:45 -0400
Message-Id: <20250505221419.2672473-129-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit a662f3c03b754e1f97a2781fa242e95bdb139798 ]

If a journal is wiped, we will set journal->j_tail to 0. However if
'write' argument is not set (as it happens for read-only device or for
ocfs2), the on-disk superblock is not updated accordingly and thus
jbd2_journal_recover() cat try to recover the wiped journal. Fix the
check in jbd2_journal_recover() to use journal->j_tail for checking
empty journal instead.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250206094657.20865-4-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/recovery.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 9192be7c19d83..23502f1a67c1e 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -287,19 +287,20 @@ static int fc_do_one_pass(journal_t *journal,
 int jbd2_journal_recover(journal_t *journal)
 {
 	int			err, err2;
-	journal_superblock_t *	sb;
-
 	struct recovery_info	info;
 
 	memset(&info, 0, sizeof(info));
-	sb = journal->j_superblock;
 
 	/*
 	 * The journal superblock's s_start field (the current log head)
 	 * is always zero if, and only if, the journal was cleanly
-	 * unmounted.
+	 * unmounted. We use its in-memory version j_tail here because
+	 * jbd2_journal_wipe() could have updated it without updating journal
+	 * superblock.
 	 */
-	if (!sb->s_start) {
+	if (!journal->j_tail) {
+		journal_superblock_t *sb = journal->j_superblock;
+
 		jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
 			  be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
 		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
-- 
2.39.5


