Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A96A5292
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 06:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjB1FNi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 00:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB1FNc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 00:13:32 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B948BDD4
        for <linux-ext4@vger.kernel.org>; Mon, 27 Feb 2023 21:13:30 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31S5DOLP002515
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 00:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677561205; bh=6Pe4F/L+5ydLysNZG0f6vS8n/MIKOjxYdH+fmh8wGu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BYfZ7W7HvGEwb4Vn9B0y2jAYAL4s0OrkAO01R7XFFf8vJT44agReIU98lTp7sp64Q
         JywPgH1rIKcKccamwUroSezw5nQA0rohCQK0civNA4hmKFrkp6spHTvSL/OwFH96bf
         bclUN4NvlHDoXb+1O5Lg0Emx5xmkwx4KEZPCFPVtsLYx2mIT35DNt6JGKpQh+sN9Iu
         YVMuxtCwBMbJrIkj3SXwpmU8ggQxeiI2U640AhEHrTcNv4UqzqewKgCgM9rJreVk1S
         j+fFSaY0LbNDZV38LPM+ouAFVRxc0UYEebL5ziFZvvWGgHn5sJ8Q8K1zNKqJgGzgxd
         SXlCksLgxTSAA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2C79315C5824; Tue, 28 Feb 2023 00:13:24 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/7] ext4: Update stale comment about write constraints
Date:   Tue, 28 Feb 2023 00:13:13 -0500
Message-Id: <20230228051319.4085470-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230228051319.4085470-1-tytso@mit.edu>
References: <20230228051319.4085470-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

The comment above do_journal_get_write_access() is very stale. Most of
it just does not refer to what the function does today or how jbd2
works. The bit about transaction handling during write(2) is still
correct so just update the function names in that part and move the
comment to a more appropriate place.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d251d705c276..178978484acc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1004,30 +1004,6 @@ int ext4_walk_page_buffers(handle_t *handle, struct inode *inode,
 	return ret;
 }
 
-/*
- * To preserve ordering, it is essential that the hole instantiation and
- * the data write be encapsulated in a single transaction.  We cannot
- * close off a transaction and start a new one between the ext4_get_block()
- * and the commit_write().  So doing the jbd2_journal_start at the start of
- * prepare_write() is the right place.
- *
- * Also, this function can nest inside ext4_writepage().  In that case, we
- * *know* that ext4_writepage() has generated enough buffer credits to do the
- * whole page.  So we won't block on the journal in that case, which is good,
- * because the caller may be PF_MEMALLOC.
- *
- * By accident, ext4 can be reentered when a transaction is open via
- * quota file writes.  If we were to commit the transaction while thus
- * reentered, there can be a deadlock - we would be holding a quota
- * lock, and the commit would never complete if another thread had a
- * transaction open and was blocking on the quota lock - a ranking
- * violation.
- *
- * So what we do is to rely on the fact that jbd2_journal_stop/journal_start
- * will _not_ run commit under these circumstances because handle->h_ref
- * is elevated.  We'll still have enough credits for the tiny quotafile
- * write.
- */
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh)
 {
@@ -1149,6 +1125,13 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 }
 #endif
 
+/*
+ * To preserve ordering, it is essential that the hole instantiation and
+ * the data write be encapsulated in a single transaction.  We cannot
+ * close off a transaction and start a new one between the ext4_get_block()
+ * and the ext4_write_end().  So doing the jbd2_journal_start at the start of
+ * ext4_write_begin() is the right place.
+ */
 static int ext4_write_begin(struct file *file, struct address_space *mapping,
 			    loff_t pos, unsigned len,
 			    struct page **pagep, void **fsdata)
-- 
2.31.0

