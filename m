Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF33715EEAD
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2020 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbgBNRmN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Feb 2020 12:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389640AbgBNQD3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 14 Feb 2020 11:03:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B854724680;
        Fri, 14 Feb 2020 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696208;
        bh=HPTBNIgufBhtrErdc5gIbRW4g4btuC/j0cH6+rg11NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wxQbX2q5d/EoZh1Yr5fNrvqlD8AfvyXwQDffrsFoBDfetMLjjtiVpIoHfQApM7cAU
         wDx7Aq42xftGlKq4/04IEYjDGdVKK9IufQbMVcRv47tyUHZJRE1qxFy0MBahuzK2ay
         t2JHcPv2n8UPuW/BmUGav0kooKPox6HwDoNKzFz4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai Li <li.kai4@h3c.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 073/459] jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal
Date:   Fri, 14 Feb 2020 10:55:23 -0500
Message-Id: <20200214160149.11681-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kai Li <li.kai4@h3c.com>

[ Upstream commit a09decff5c32060639a685581c380f51b14e1fc2 ]

If the journal is dirty when the filesystem is mounted, jbd2 will replay
the journal but the journal superblock will not be updated by
journal_reset() because JBD2_ABORT flag is still set (it was set in
journal_init_common()). This is problematic because when a new transaction
is then committed, it will be recorded in block 1 (journal->j_tail was set
to 1 in journal_reset()). If unclean shutdown happens again before the
journal superblock is updated, the new recorded transaction will not be
replayed during the next mount (because of stale sb->s_start and
sb->s_sequence values) which can lead to filesystem corruption.

Fixes: 85e0c4e89c1b ("jbd2: if the journal is aborted then don't allow update of the log tail")
Signed-off-by: Kai Li <li.kai4@h3c.com>
Link: https://lore.kernel.org/r/20200111022542.5008-1-li.kai4@h3c.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/journal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index ef485f892d1b0..389c9be4e7919 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1682,6 +1682,11 @@ int jbd2_journal_load(journal_t *journal)
 		       journal->j_devname);
 		return -EFSCORRUPTED;
 	}
+	/*
+	 * clear JBD2_ABORT flag initialized in journal_init_common
+	 * here to update log tail information with the newest seq.
+	 */
+	journal->j_flags &= ~JBD2_ABORT;
 
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
@@ -1689,7 +1694,6 @@ int jbd2_journal_load(journal_t *journal)
 	if (journal_reset(journal))
 		goto recovery_error;
 
-	journal->j_flags &= ~JBD2_ABORT;
 	journal->j_flags |= JBD2_LOADED;
 	return 0;
 
-- 
2.20.1

