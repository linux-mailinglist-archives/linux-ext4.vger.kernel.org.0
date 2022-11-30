Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B78363DAC1
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 17:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiK3QgM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 11:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiK3QgL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 11:36:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BACA5B840
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 08:36:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4985221B0A;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669826169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBKsU6wxR89x5I3rg2s8lp5ksmdLcZEbJRx6brYthgM=;
        b=mll/dFZbtFheRkojsXOCKJg/x/3Bs+vx0EBBjb9IaV5daMn5KTwcTZWm4sFQYsaBSQPMP/
        u+YrKbYMJya36ImpDb6s2ZXgKH+Jg+Ik7p+QK0y5GjBiQhlEia/Ima9wb9xFqC8OdEFOOt
        Cm5bfsF2vmry5tpbGPE1zf6WEWZNUxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669826169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBKsU6wxR89x5I3rg2s8lp5ksmdLcZEbJRx6brYthgM=;
        b=ysVTS7MA2yGDhTgwYDc8709YwJfksISDr708gIm3HadqPTnJx+Fj3vS51myJ6LALJJx16u
        qhZq7FZeOPUZVeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A9E513A70;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jv1KDnmGh2NNQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A89A6A0714; Wed, 30 Nov 2022 17:36:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/9] ext4: Handle redirtying in ext4_bio_write_page()
Date:   Wed, 30 Nov 2022 17:35:52 +0100
Message-Id: <20221130163608.29034-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221130162435.2324-1-jack@suse.cz>
References: <20221130162435.2324-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=jack@suse.cz; h=from:subject; bh=zcjEYbPJjXpKlwPeOZu0KQgMGq+rgIuX59fnDrSfxgM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjh4ZoZDy1ANDhnBCS1k5KlEBWcMiC5MU5BeC2TCum Fjt585KJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4eGaAAKCRCcnaoHP2RA2bJYB/ 9l6QHfc8BCwya5hHoUPiVx7XxiLKZqB1EtUDWUSFaCjf8DdVF7MkXRBSmG9R8j2j3gaPBox6yTus3f LPjUd5Q8Wozw+LdYEpK1jO6PrZUJKvETUzFDdfRyOjHQtjifnYH4Z9LuU/9VrU40sZFPC3xsaOtRo8 /F3eGKLwDCnwFMoRU+6sINMIIFdZhpPIuAjZS/x+YWOAovY9UMzZqjd0Yx5hSioRTnbW/o98TwfcNa yqs8v8ORdk4cQFv0PXF2c5czPDyUTwJsxCGZu+4nQdoHVIDW0JVPE0c2RdH1IDApLErQrk+A76lq5d 3Fm8BN5zSERCbOjIk4oCBf/Wfq725b
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

Since we want to transition transaction commits to use ext4_writepages()
for writing back ordered, add handling of page redirtying into
ext4_bio_write_page(). Also move buffer dirty bit clearing into the same
place other buffer state handling.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/page-io.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 97fa7b4c645f..4e68ace86f11 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -482,6 +482,13 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			/* A hole? We can safely clear the dirty bit */
 			if (!buffer_mapped(bh))
 				clear_buffer_dirty(bh);
+			/*
+			 * Keeping dirty some buffer we cannot write? Make
+			 * sure to redirty the page. This happens e.g. when
+			 * doing writeout for transaction commit.
+			 */
+			if (buffer_dirty(bh) && !PageDirty(page))
+				redirty_page_for_writepage(wbc, page);
 			if (io->io_bio)
 				ext4_io_submit(io);
 			continue;
@@ -489,6 +496,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		if (buffer_new(bh))
 			clear_buffer_new(bh);
 		set_buffer_async_write(bh);
+		clear_buffer_dirty(bh);
 		nr_to_submit++;
 	} while ((bh = bh->b_this_page) != head);
 
@@ -532,7 +540,10 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
 			redirty_page_for_writepage(wbc, page);
 			do {
-				clear_buffer_async_write(bh);
+				if (buffer_async_write(bh)) {
+					clear_buffer_async_write(bh);
+					set_buffer_dirty(bh);
+				}
 				bh = bh->b_this_page;
 			} while (bh != head);
 			goto unlock;
@@ -546,7 +557,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		io_submit_add_bh(io, inode,
 				 bounce_page ? bounce_page : page, bh);
 		nr_submitted++;
-		clear_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
 
 unlock:
-- 
2.35.3

