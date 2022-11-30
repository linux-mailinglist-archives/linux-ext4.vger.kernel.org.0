Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FDA63DAC6
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiK3QgV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 11:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiK3QgM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 11:36:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B91880F6
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 08:36:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B0AF821B10;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669826169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMnxzDYESOmO1bsI+JVo/ClbyXf7eGdqOyTWrF8ARhk=;
        b=WV2AjZfUaJPPA93O7pzvADWdN1lEVb1I3RHZAS+JL46t4AXX1QiPp+AqMttp2yS8OvNRBL
        fZLQIwxIvcaRz3yn1p+3LbYWzQ0DIRNNT30kRlLwair/b7eCYTq+E8exNe+s0SfuJcHFkY
        +Syxtdk0Z0Wtpm0Kw379evKpLQx4mU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669826169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMnxzDYESOmO1bsI+JVo/ClbyXf7eGdqOyTWrF8ARhk=;
        b=6MeaA6U5jVyrmeua7TECFnhkd60cbT8uzzoREHelYPbibYzL4veeMRKAoeApemMcwHbCDU
        9qmIe5Xe7X4fFqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A462A13A70;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b4ofKHmGh2NeQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BEA49A0719; Wed, 30 Nov 2022 17:36:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/9] ext4: Add support for writepages calls that cannot map blocks
Date:   Wed, 30 Nov 2022 17:35:56 +0100
Message-Id: <20221130163608.29034-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221130162435.2324-1-jack@suse.cz>
References: <20221130162435.2324-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=jack@suse.cz; h=from:subject; bh=1Ip3MZjlyQjO60nkOhMQw/8deboRByYPhqa834ojFow=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjh4ZsQqJ+Yyih4Pr4qSNHh0Qv4DOctXgRNexz81Pr hoXkrZ6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4eGbAAKCRCcnaoHP2RA2TTcB/ 0bIOrYuL+kJoM6060hsDO9oKmw2zfzjBcmbJON3Ags0AsqwUwQN/TUAeALhfEw5Ykw77ZEPeoRSfJV Zzh5ZYFfKngTxi1CxqrGbXnqXP4C8sWOAMgXyGFtO3ULNhb68pzRqFmnM7s/F+leDdkT0g8ZbfIarl ShKFRIxIajhiD8kROLuVbMypvOLE6BZK6Czp3ntgHMwTr+JZjNCngLcVIsM4WE5U56VpGsHRegYL7h nnoHj8OE6gfz0jHcr+jkwVMPH1/WE1ScH7YO9nWmVWS6UyR96I+CpWiXMK6BoCpCi3+cUkfBOdBQ/g Xsddc3+P1IGOaX8zRG6Dnp4SKS2mEw
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

Add support for calls to ext4_writepages() than cannot map blocks. These
will be issued from jbd2 transaction commit code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 43eb175d0c1c..1cde20eb6500 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1557,6 +1557,7 @@ struct mpage_da_data {
 	struct ext4_map_blocks map;
 	struct ext4_io_submit io_submit;	/* IO submission data */
 	unsigned int do_map:1;
+	unsigned int can_map:1;	/* Can writepages call map blocks? */
 	unsigned int scanned_until_end:1;
 };
 
@@ -2549,6 +2550,19 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
 }
 
+/* Return true if the page needs to be written as part of transaction commit */
+static bool ext4_page_nomap_can_writeout(struct page *page)
+{
+	struct buffer_head *bh, *head;
+
+	bh = head = page_buffers(page);
+	do {
+		if (buffer_dirty(bh) && buffer_mapped(bh) && !buffer_delay(bh))
+			return true;
+	} while ((bh = bh->b_this_page) != head);
+	return false;
+}
+
 /*
  * mpage_prepare_extent_to_map - find & lock contiguous range of dirty pages
  * 				 and underlying extent to map
@@ -2651,14 +2665,30 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			if (mpd->map.m_len == 0)
 				mpd->first_page = page->index;
 			mpd->next_page = page->index + 1;
-			/* Add all dirty buffers to mpd */
-			lblk = ((ext4_lblk_t)page->index) <<
-				(PAGE_SHIFT - blkbits);
-			head = page_buffers(page);
-			err = mpage_process_page_bufs(mpd, head, head, lblk);
-			if (err <= 0)
-				goto out;
-			err = 0;
+			/*
+			 * Writeout for transaction commit where we cannot
+			 * modify metadata is simple. Just submit the page.
+			 */
+			if (!mpd->can_map) {
+				if (ext4_page_nomap_can_writeout(page)) {
+					err = mpage_submit_page(mpd, page);
+					if (err < 0)
+						goto out;
+				} else {
+					unlock_page(page);
+					mpd->first_page++;
+				}
+			} else {
+				/* Add all dirty buffers to mpd */
+				lblk = ((ext4_lblk_t)page->index) <<
+					(PAGE_SHIFT - blkbits);
+				head = page_buffers(page);
+				err = mpage_process_page_bufs(mpd, head, head,
+							      lblk);
+				if (err <= 0)
+					goto out;
+				err = 0;
+			}
 			left--;
 		}
 		pagevec_release(&pvec);
@@ -2778,6 +2808,7 @@ static int ext4_writepages(struct address_space *mapping,
 	 */
 	mpd.do_map = 0;
 	mpd.scanned_until_end = 0;
+	mpd.can_map = 1;
 	mpd.io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
 	if (!mpd.io_submit.io_end) {
 		ret = -ENOMEM;
-- 
2.35.3

