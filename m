Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17048250345
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Aug 2020 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHXQmT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Aug 2020 12:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbgHXQjr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Aug 2020 12:39:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C912622CE3;
        Mon, 24 Aug 2020 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287186;
        bh=gMeAYgdyneqnGJcK2RTzYfoFk5xEZZSV04P8Z9zbVQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcG6CYW2GByAMbe0oro3U+wFHzk+0gpSCLVDqhZEjHBjnvIG8ZW4ZUJwfDgAdqcLz
         g5fkC9ilFAWq+5EfTU5gFiLpYtcjC8WdDqbAF6RPVIP4/Ew2ItTwP+6Yzlf3dVNmxZ
         TdUcBo9l+S77fnCh8Oz7J4hTA9+07WwXwOuVUP6U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 2/6] jbd2: abort journal if free a async write error metadata buffer
Date:   Mon, 24 Aug 2020 12:39:39 -0400
Message-Id: <20200824163943.607406-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163943.607406-1-sashal@kernel.org>
References: <20200824163943.607406-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: "zhangyi (F)" <yi.zhang@huawei.com>

[ Upstream commit c044f3d8360d2ecf831ba2cc9f08cf9fb2c699fb ]

If we free a metadata buffer which has been failed to async write out
in the background, the jbd2 checkpoint procedure will not detect this
failure in jbd2_log_do_checkpoint(), so it may lead to filesystem
inconsistency after cleanup journal tail. This patch abort the journal
if free a buffer has write_io_error flag to prevent potential further
inconsistency.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Link: https://lore.kernel.org/r/20200620025427.1756360-5-yi.zhang@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/transaction.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 622610934c9ad..ce2bf9d74224c 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2000,6 +2000,7 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
+	bool has_write_io_error = false;
 	int ret = 0;
 
 	J_ASSERT(PageLocked(page));
@@ -2024,11 +2025,26 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
 		jbd_unlock_bh_state(bh);
 		if (buffer_jbd(bh))
 			goto busy;
+
+		/*
+		 * If we free a metadata buffer which has been failed to
+		 * write out, the jbd2 checkpoint procedure will not detect
+		 * this failure and may lead to filesystem inconsistency
+		 * after cleanup journal tail.
+		 */
+		if (buffer_write_io_error(bh)) {
+			pr_err("JBD2: Error while async write back metadata bh %llu.",
+			       (unsigned long long)bh->b_blocknr);
+			has_write_io_error = true;
+		}
 	} while ((bh = bh->b_this_page) != head);
 
 	ret = try_to_free_buffers(page);
 
 busy:
+	if (has_write_io_error)
+		jbd2_journal_abort(journal, -EIO);
+
 	return ret;
 }
 
-- 
2.25.1

