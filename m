Return-Path: <linux-ext4+bounces-7702-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C13CAAB2DB
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 06:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE91188A8E9
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 04:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9EA444403;
	Tue,  6 May 2025 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utuSmrgE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E5372647;
	Mon,  5 May 2025 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485914; cv=none; b=mpu61DSnrj0xSxAWh3kcwgmeySxw9ns/YdDY3UcMrv3AlwD2zZns55/VqY0Qn6A/xcu9RTyv5vvqtSiVPaF9rue3cYIH6o6uSW/b7+cWQtqI3BFTnnIzlPSNfsuH64bYMceDdWCCNVfSPEg2E06kFOwCga4znvbEPhaJ/Tu1uZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485914; c=relaxed/simple;
	bh=jVus77ild6b4J4G5wf7sXwMh9YWpwZopK72uFIBIWYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d05o1V0+ne02mbpkm5z6bM/tiZaQdJ/FnoHB10n07IdlGWA0YXvP0cqWJwUAuh1drKi2Cfp1LfA534DdM0cdOimSDowDxhWuqGmREC4arGQcun6q6e/xvDjNE0TdobKH16qTXxhrY26F8pgbTW75wi+YEhrufIYyxkZ6YOae1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utuSmrgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E88C4CEEE;
	Mon,  5 May 2025 22:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485914;
	bh=jVus77ild6b4J4G5wf7sXwMh9YWpwZopK72uFIBIWYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utuSmrgE7WAz66R3hwC2Kl0vog9B4iDDWRG9AqVkMTvMrG87zTJUZk5F0AGkKGxGt
	 XQ+IN1ZVTgNhUUJmMYc0A4kY1yPed3QlSaKLodtMtyTV1nDfkcLlHg5SKAG5uKwD0w
	 odgr6RaP3VB1trxKBzXPddCADOC/FvleQfz15uFshd7M8MQBaCYVRMipjYrJfy0td8
	 E8EVuqEiUaaNiHOqJN1//IPGm0RzLx87gyYXAH9Tv0N95oKTLKA88fbHST4gpcLM1I
	 7bu/gqSdgShdgwLV5OW+dX7v1mu4KEDakbYAcWTdGycwIRm6B1zwZE4HjP6NJfe5by
	 KZ4BobcY8H+Jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 062/294] jbd2: do not try to recover wiped journal
Date: Mon,  5 May 2025 18:52:42 -0400
Message-Id: <20250505225634.2688578-62-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 421c0d360836e..19ec325374833 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -286,21 +286,22 @@ static int fc_do_one_pass(journal_t *journal,
 int jbd2_journal_recover(journal_t *journal)
 {
 	int			err, err2;
-	journal_superblock_t *	sb;
-
 	struct recovery_info	info;
 	errseq_t		wb_err;
 	struct address_space	*mapping;
 
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


