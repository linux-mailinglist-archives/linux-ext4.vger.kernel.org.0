Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E37F0356
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 17:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390456AbfKEQow (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 11:44:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390388AbfKEQoo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 11:44:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 118A4B43A;
        Tue,  5 Nov 2019 16:44:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7F8B91E4AC8; Tue,  5 Nov 2019 17:44:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 25/25] jbd2: Fine tune estimate of necessary descriptor blocks
Date:   Tue,  5 Nov 2019 17:44:31 +0100
Message-Id: <20191105164437.32602-25-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently we reserve j_max_transaction_buffers / 32 for transaction
descriptor blocks. Now that revoke descriptors are accounted for
separately this estimate is unnecessarily high and we can actually
compute much tighter estimate. In the common case of 32k journal blocks
and 4k blocksize this actually reduces the amount of reserved descriptor
blocks from 256 to ~25 which allows us to fit more real data into a
transaction.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index a3374c1a3d41..a9d3a2208506 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -63,14 +63,25 @@ void jbd2_journal_free_transaction(transaction_t *transaction)
 }
 
 /*
- * We reserve t_outstanding_credits >> JBD2_CONTROL_BLOCKS_SHIFT for
- * transaction descriptor blocks.
+ * Base amount of descriptor blocks we reserve for each transaction.
  */
-#define JBD2_CONTROL_BLOCKS_SHIFT 5
-
 static int jbd2_descriptor_blocks_per_trans(journal_t *journal)
 {
-	return journal->j_max_transaction_buffers >> JBD2_CONTROL_BLOCKS_SHIFT;
+	int tag_space = journal->j_blocksize - sizeof(journal_header_t);
+	int tags_per_block;
+
+	/* Subtract UUID */
+	tag_space -= 16;
+	if (jbd2_journal_has_csum_v2or3(journal))
+		tag_space -= sizeof(struct jbd2_journal_block_tail);
+	/* Commit code leaves a slack space of 16 bytes at the end of block */
+	tags_per_block = (tag_space - 16) / journal_tag_bytes(journal);
+	/*
+	 * Revoke descriptors are accounted separately so we need to reserve
+	 * space for commit block and normal transaction descriptor blocks.
+	 */
+	return 1 + DIV_ROUND_UP(journal->j_max_transaction_buffers,
+				tags_per_block);
 }
 
 /*
-- 
2.16.4

