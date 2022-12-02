Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF1640D97
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 19:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiLBSlr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 13:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiLBSl1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 13:41:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67343842
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 10:39:45 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECB8121C4A;
        Fri,  2 Dec 2022 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670006383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77G42jyCLCxqHXtKUfKLyfMpUWH1ePC4gHzKYHeOcPM=;
        b=UJV7/zFkCVTV13lpRzyW2fH6SOgRevfgHQcYopaOk+rGoWRVbUSdSBe/johg3JSseIaXCf
        uFl/Tku2ynVnSWJfzUNILh9s9HC2Z/Esffv0zr4kEmdkcMP9mx19jL09ySsttLCUnKncuf
        ClrASGZFvvStnRJEVc8stTayGaAh2OY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670006383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77G42jyCLCxqHXtKUfKLyfMpUWH1ePC4gHzKYHeOcPM=;
        b=k5ukntSYaoNnPR7ZcG3vs25QSnAuRB7ckEQrmXIK19aiNA6p6k7ZCQH6NVM8Ta+eLcwRW7
        GyM4AZEuqBiZt8BA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CAF9C13644;
        Fri,  2 Dec 2022 18:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xdB9MG9GimOkZAAAGKfGzw
        (envelope-from <jack@suse.cz>); Fri, 02 Dec 2022 18:39:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5485BA0716; Fri,  2 Dec 2022 19:39:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/11] ext4: Move keep_towrite handling to ext4_bio_write_page()
Date:   Fri,  2 Dec 2022 19:39:27 +0100
Message-Id: <20221202183943.22640-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5311; i=jack@suse.cz; h=from:subject; bh=4BEBMuubTi6wzu1p0dUteVLsznv1GLCDItrtKTNYI5E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjikZfkEjDDlFxxdvGxblAV29RSyx82jUQUUJxApPT AwBuFt6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4pGXwAKCRCcnaoHP2RA2WwwCA CXe6Y/a1tEuvGJuHfBiRvSPexreDVnpxJVpVODVHCSjz9vsAoW/Es+3yqdENnScNVIqwdprekrj3m9 Y39ilDZbyAMGjaF1HcXcPVGGrKqj48eTs9OW/+xj2sFGspFFuBvkR7G4lIjxQkU95a/Rcj2172DhjL +XdSggikVGNzrCbObelT6F3mRqRv7BD0PtSHBwxa7kHZ1tFojILlw5fqiJDyL2kH9PiDISq+SaxeP/ Eq0MMpcoZ8JnthcJwpMsGVJqVu3/OJp5FzZSRICmpT50zSratmiNcJ+Jfr/48knGO08y6zTJ7CwVvR Z/hT/aVKOUiYaoV3jj8fX/Xy50JriN
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

When we are writing back page but we cannot for some reason write all
its buffers (e.g. because we cannot allocate blocks in current context) we
have to keep TOWRITE tag set in the mapping as otherwise racing
WB_SYNC_ALL writeback that could write these buffers can skip the page
and result in data loss. We will need this logic for writeback during
transaction commit so move the logic from ext4_writepage() to
ext4_bio_write_page().

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    |  3 +--
 fs/ext4/inode.c   |  6 ++----
 fs/ext4/page-io.c | 36 +++++++++++++++++++++---------------
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8d5453852f98..1b3bffc04fd0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3756,8 +3756,7 @@ extern void ext4_end_io_rsv_work(struct work_struct *work);
 extern void ext4_io_submit(struct ext4_io_submit *io);
 extern int ext4_bio_write_page(struct ext4_io_submit *io,
 			       struct page *page,
-			       int len,
-			       bool keep_towrite);
+			       int len);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2b5ef1b64249..43eb175d0c1c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2009,7 +2009,6 @@ static int ext4_writepage(struct page *page,
 	struct buffer_head *page_bufs = NULL;
 	struct inode *inode = page->mapping->host;
 	struct ext4_io_submit io_submit;
-	bool keep_towrite = false;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
 		folio_invalidate(folio, 0, folio_size(folio));
@@ -2067,7 +2066,6 @@ static int ext4_writepage(struct page *page,
 			unlock_page(page);
 			return 0;
 		}
-		keep_towrite = true;
 	}
 
 	if (PageChecked(page) && ext4_should_journal_data(inode))
@@ -2084,7 +2082,7 @@ static int ext4_writepage(struct page *page,
 		unlock_page(page);
 		return -ENOMEM;
 	}
-	ret = ext4_bio_write_page(&io_submit, page, len, keep_towrite);
+	ret = ext4_bio_write_page(&io_submit, page, len);
 	ext4_io_submit(&io_submit);
 	/* Drop io_end reference we got from init */
 	ext4_put_io_end_defer(io_submit.io_end);
@@ -2118,7 +2116,7 @@ static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
 		len = size & ~PAGE_MASK;
 	else
 		len = PAGE_SIZE;
-	err = ext4_bio_write_page(&mpd->io_submit, page, len, false);
+	err = ext4_bio_write_page(&mpd->io_submit, page, len);
 	if (!err)
 		mpd->wbc->nr_to_write--;
 	mpd->first_page++;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 4e68ace86f11..4f9ecacd10aa 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -430,8 +430,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 
 int ext4_bio_write_page(struct ext4_io_submit *io,
 			struct page *page,
-			int len,
-			bool keep_towrite)
+			int len)
 {
 	struct page *bounce_page = NULL;
 	struct inode *inode = page->mapping->host;
@@ -441,14 +440,11 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	int nr_submitted = 0;
 	int nr_to_submit = 0;
 	struct writeback_control *wbc = io->io_wbc;
+	bool keep_towrite = false;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
 
-	if (keep_towrite)
-		set_page_writeback_keepwrite(page);
-	else
-		set_page_writeback(page);
 	ClearPageError(page);
 
 	/*
@@ -483,12 +479,17 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			if (!buffer_mapped(bh))
 				clear_buffer_dirty(bh);
 			/*
-			 * Keeping dirty some buffer we cannot write? Make
-			 * sure to redirty the page. This happens e.g. when
-			 * doing writeout for transaction commit.
+			 * Keeping dirty some buffer we cannot write? Make sure
+			 * to redirty the page and keep TOWRITE tag so that
+			 * racing WB_SYNC_ALL writeback does not skip the page.
+			 * This happens e.g. when doing writeout for
+			 * transaction commit.
 			 */
-			if (buffer_dirty(bh) && !PageDirty(page))
-				redirty_page_for_writepage(wbc, page);
+			if (buffer_dirty(bh)) {
+				if (!PageDirty(page))
+					redirty_page_for_writepage(wbc, page);
+				keep_towrite = true;
+			}
 			if (io->io_bio)
 				ext4_io_submit(io);
 			continue;
@@ -500,6 +501,10 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		nr_to_submit++;
 	} while ((bh = bh->b_this_page) != head);
 
+	/* Nothing to submit? Just unlock the page... */
+	if (!nr_to_submit)
+		goto unlock;
+
 	bh = head = page_buffers(page);
 
 	/*
@@ -550,6 +555,11 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		}
 	}
 
+	if (keep_towrite)
+		set_page_writeback_keepwrite(page);
+	else
+		set_page_writeback(page);
+
 	/* Now submit buffers to write */
 	do {
 		if (!buffer_async_write(bh))
@@ -558,11 +568,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 				 bounce_page ? bounce_page : page, bh);
 		nr_submitted++;
 	} while ((bh = bh->b_this_page) != head);
-
 unlock:
 	unlock_page(page);
-	/* Nothing submitted - we have to end page writeback */
-	if (!nr_submitted)
-		end_page_writeback(page);
 	return ret;
 }
-- 
2.35.3

