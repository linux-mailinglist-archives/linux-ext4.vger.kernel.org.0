Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7E665F8C
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 16:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbjAKPqB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 10:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbjAKPpc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 10:45:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0340739FA5
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 07:43:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 456918B8D2;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673451819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52itqBs8IMZtBoJrtv/loJtQZkbIh02hK584OTuk6n4=;
        b=x9RcRNLhgw+6fIFdUH5wootU4VHuCbtV28FW/u/Ne+g8i0g7Kqx7xba4nDgG5g8Td4Elgu
        ufoR8/r2aRD1d/veJ4b9cB9cansQcw8X8RLDR9REVppddcJQdFoHLszcsYGLC7qjSsVXUJ
        rH+ttL+GVXtf0mml9MG7shT3g19PGq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673451819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52itqBs8IMZtBoJrtv/loJtQZkbIh02hK584OTuk6n4=;
        b=tLPbO6dLawQ1Hwbf6NgC3vX5jiQt4helZSh3kSdwKMPtqXos1SUmk3QCGA2L9KAsSSSKEc
        wq9T9UzJNw74o3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F3B713595;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5YotCyvZvmO3OwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 15:43:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1818CA0745; Wed, 11 Jan 2023 16:43:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/7] ext4: Update stale comment about write constraints
Date:   Wed, 11 Jan 2023 16:43:25 +0100
Message-Id: <20230111154338.392-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111152736.9608-1-jack@suse.cz>
References: <20230111152736.9608-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2737; i=jack@suse.cz; h=from:subject; bh=CIyzQqdP55rWTUKA4pnB3wd3eEgA6ZuDKeMzISlJGRU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjvtkdBAaI3HkXn92jd0cdwZT3hZfluriqz2N6txYH fpsXs/6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY77ZHQAKCRCcnaoHP2RA2XYJB/ wOYanaiGNvPyYw+noHzrgwim0nM/xAmsf2qaQ6ZGG9ER4O09BbRFfITRFYpkRQaFspJG0mWSM2Bqaa DKEHCyAb2yau7xJkX3RFinZmsUWSgE99ssI6T0CB3oCoOLAE+6SQtIuJO6pCu1GU7Gbl0ggDoTxMzT /2XeVatn5azFztKOOTEGEeeRiyuCd6jHF+uNGqk2mMYhJTJcYjqkjEwGffksmQzf5CIh0O9CUknegD 1bZEXCNhAAI+wGzcqLX8eL1hp+dHmKVAk6lfWjdtcjVb5JmY7s9+l9EqU/FaL5iBnYY1KIvHub/ZLI Yc0zLui3dExipHstvCKfHeXLkL/poS
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The comment above do_journal_get_write_access() is very stale. Most of
it just does not refer to what the function does today or how jbd2
works. The bit about transaction handling during write(2) is still
correct so just update the function names in that part and move the
comment to a more appropriate place.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d9f414f99fe..f9201c7d61ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1005,30 +1005,6 @@ int ext4_walk_page_buffers(handle_t *handle, struct inode *inode,
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
2.35.3

