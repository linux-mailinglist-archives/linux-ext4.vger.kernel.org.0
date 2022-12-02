Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9F640D93
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 19:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiLBSlo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 13:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbiLBSl1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 13:41:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E4ECA15
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 10:39:45 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01AF221C68;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670006384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWUivoPF8rh6YNbRp12PTNmtUBRknCK4IxKDth2V10Y=;
        b=2kL7raW+SPkFBv8gz5t6EC4wW8Wqm8cqpszodC9bnuJzkUFfLOaGxnaH21MK8AN2meqbKc
        AmMQepaloKMP3pvKOjglxFhABrqbxyctf05l+kNzUJyFQSFzmZDU5dLw9K+2PdXvmHy5Gc
        TpPaEwXtEALmAf7UiXDwYp4Ty6oRY54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670006384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWUivoPF8rh6YNbRp12PTNmtUBRknCK4IxKDth2V10Y=;
        b=S5Tt6Cqf3Bo7wwizx1ATIvRSl4iT7R4G+pj4Lg6CzRDl5haFIA9CJmaoG89LPmzAcImkY+
        sbRXdjgHXcDwuQDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E0D58136ED;
        Fri,  2 Dec 2022 18:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Vq3aNm9GimOqZAAAGKfGzw
        (envelope-from <jack@suse.cz>); Fri, 02 Dec 2022 18:39:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 505A8A070F; Fri,  2 Dec 2022 19:39:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/11] ext4: Handle redirtying in ext4_bio_write_page()
Date:   Fri,  2 Dec 2022 19:39:26 +0100
Message-Id: <20221202183943.22640-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; i=jack@suse.cz; h=from:subject; bh=vdozeUvfNYyCeixKiAugGlYRgdNUDNkZOW42CdQ7y9I=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjikZeB+fHKP4nh1IIQZOIeG+ejYx8dHkOZhCuAUNp am41wMCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4pGXgAKCRCcnaoHP2RA2fn2CA CFg3lSYH7DlOSyBzsuuKPbbqFUf1G/UZ65FiJ7+CRwcsOLRpVX6GPoVrLs/7O4j5LB2K3qdWXKsYFr RgF9n7EYubEaeYgEbq9QjAYuDUpFIq5IVqdlACy5XI0uISq5YkH1hZdVZ5CYzi76pMwiTYNnd7hUJo 7Ch/S/AnD+g1qmNpjZfYE70CyeZUWtKQr4t8WHxApahcbhIy6j0Rh58xvm0b06wROOi18lZKLyQWrL plKZdVPfo0ZkDlL9xfTvhUqt8bkmUV/eOa+7xHbS7bkxlkNtDzAFjBTZ+BF+czK1AcuQHp5Vhb/P3o GDFoPq8nJtS5YkKOclhZgwFm9KDY/5
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since we want to transition transaction commits to use ext4_writepages()
for writing back ordered, add handling of page redirtying into
ext4_bio_write_page(). Also move buffer dirty bit clearing into the same
place other buffer state handling.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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

