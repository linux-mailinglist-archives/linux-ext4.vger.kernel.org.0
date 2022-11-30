Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB5963DACA
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiK3Qg1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 11:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiK3QgO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 11:36:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B5880CB
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 08:36:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6C6521B13;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669826169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XUIn2iXXRl5GPSs06a0nbMiHNs3k/kJGcmFMOWzxV4=;
        b=q08L7Rfz0GfBDKHK4ZFGbYmBn1vG4BJU7dTiZwh07lEbjbItuHupNM+MbdETwxRdZUrpFj
        VPWN8CVwRNGJQD98jfNufIc7wbcD2BTgrA4NOI75XULwJfnNE7BK7f/SmuTJxla8MEtsnP
        oVmR7WRe4Wqa/bI+b0NJi2nGtFoOyQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669826169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XUIn2iXXRl5GPSs06a0nbMiHNs3k/kJGcmFMOWzxV4=;
        b=JQpZ4sqz2SNgSpJCVRptZ4lNhFRf5VTc7VSriyx5Q0AvmQuE4/Xjh3ux4Ir5CVAK1aEqYq
        kc3PXSEVQ+QJM6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5CE213A70;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FThaLHmGh2NkQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C5405A071A; Wed, 30 Nov 2022 17:36:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/9] ext4: Provide ext4_do_writepages()
Date:   Wed, 30 Nov 2022 17:35:57 +0100
Message-Id: <20221130163608.29034-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221130162435.2324-1-jack@suse.cz>
References: <20221130162435.2324-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7492; i=jack@suse.cz; h=from:subject; bh=wwP+UPIcACD2cLIUsEpYradw7BcwPJflCl5gq8Aqcxo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjh4Zt9xBajrLWs5ltoQQmoyJmeie89oCXMVJ6sY8X bTKpQg+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4eGbQAKCRCcnaoHP2RA2SACB/ 9+UUduJqIZHEXjcLki+TcFI4jmE7Zaxj4e3fcYdcTyPKQ0flBLjXClOGwyCZi4Kg2sdY29debO+5ag VSu/wJsYhte2ydzhsES1GJnUtf44l72uiakROoBx0NUniXQMznRavbImfAAncUVwiF4T+pjy1ghjsc 03e0xSs1pXtehcRpf48qsOA7u/5dr8kb1fjf1Nl6U7kOOsXVSl4abIMZYuxJ3YdkncDZNVqehS9RPU KJAM3Fi/18QFzG9yYOaSpBKDmsMQ6z6/NAVhOONx1n0HUqzpsjVvPz2n914Lzi/ab3bMFup07M52zt dpfyd2nnDMz60GCbINO3BIBTMgrzGc
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

Provide ext4_do_writepages() function that takes mpage_da_data as an
argument and make ext4_writepages() just a simple wrapper around it. No
functional changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 96 +++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1cde20eb6500..fbea77ab470f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1543,9 +1543,12 @@ void ext4_da_release_space(struct inode *inode, int to_free)
  */
 
 struct mpage_da_data {
+	/* These are input fields for ext4_do_writepages() */
 	struct inode *inode;
 	struct writeback_control *wbc;
+	unsigned int can_map:1;	/* Can writepages call map blocks? */
 
+	/* These are internal state of ext4_do_writepages() */
 	pgoff_t first_page;	/* The first page to write */
 	pgoff_t next_page;	/* Current page to examine */
 	pgoff_t last_page;	/* Last page to examine */
@@ -1557,7 +1560,6 @@ struct mpage_da_data {
 	struct ext4_map_blocks map;
 	struct ext4_io_submit io_submit;	/* IO submission data */
 	unsigned int do_map:1;
-	unsigned int can_map:1;	/* Can writepages call map blocks? */
 	unsigned int scanned_until_end:1;
 };
 
@@ -2701,16 +2703,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	return err;
 }
 
-static int ext4_writepages(struct address_space *mapping,
-			   struct writeback_control *wbc)
+static int ext4_do_writepages(struct mpage_da_data *mpd)
 {
+	struct writeback_control *wbc = mpd->wbc;
 	pgoff_t	writeback_index = 0;
 	long nr_to_write = wbc->nr_to_write;
 	int range_whole = 0;
 	int cycled = 1;
 	handle_t *handle = NULL;
-	struct mpage_da_data mpd;
-	struct inode *inode = mapping->host;
+	struct inode *inode = mpd->inode;
+	struct address_space *mapping = inode->i_mapping;
 	int needed_blocks, rsv_blocks = 0, ret = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
 	struct blk_plug plug;
@@ -2785,19 +2787,18 @@ static int ext4_writepages(struct address_space *mapping,
 		writeback_index = mapping->writeback_index;
 		if (writeback_index)
 			cycled = 0;
-		mpd.first_page = writeback_index;
-		mpd.last_page = -1;
+		mpd->first_page = writeback_index;
+		mpd->last_page = -1;
 	} else {
-		mpd.first_page = wbc->range_start >> PAGE_SHIFT;
-		mpd.last_page = wbc->range_end >> PAGE_SHIFT;
+		mpd->first_page = wbc->range_start >> PAGE_SHIFT;
+		mpd->last_page = wbc->range_end >> PAGE_SHIFT;
 	}
 
-	mpd.inode = inode;
-	mpd.wbc = wbc;
-	ext4_io_submit_init(&mpd.io_submit, wbc);
+	ext4_io_submit_init(&mpd->io_submit, wbc);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, mpd.first_page, mpd.last_page);
+		tag_pages_for_writeback(mapping, mpd->first_page,
+					mpd->last_page);
 	blk_start_plug(&plug);
 
 	/*
@@ -2806,28 +2807,27 @@ static int ext4_writepages(struct address_space *mapping,
 	 * in the block layer on device congestion while having transaction
 	 * started.
 	 */
-	mpd.do_map = 0;
-	mpd.scanned_until_end = 0;
-	mpd.can_map = 1;
-	mpd.io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
-	if (!mpd.io_submit.io_end) {
+	mpd->do_map = 0;
+	mpd->scanned_until_end = 0;
+	mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
+	if (!mpd->io_submit.io_end) {
 		ret = -ENOMEM;
 		goto unplug;
 	}
-	ret = mpage_prepare_extent_to_map(&mpd);
+	ret = mpage_prepare_extent_to_map(mpd);
 	/* Unlock pages we didn't use */
-	mpage_release_unused_pages(&mpd, false);
+	mpage_release_unused_pages(mpd, false);
 	/* Submit prepared bio */
-	ext4_io_submit(&mpd.io_submit);
-	ext4_put_io_end_defer(mpd.io_submit.io_end);
-	mpd.io_submit.io_end = NULL;
+	ext4_io_submit(&mpd->io_submit);
+	ext4_put_io_end_defer(mpd->io_submit.io_end);
+	mpd->io_submit.io_end = NULL;
 	if (ret < 0)
 		goto unplug;
 
-	while (!mpd.scanned_until_end && wbc->nr_to_write > 0) {
+	while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
 		/* For each extent of pages we use new io_end */
-		mpd.io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
-		if (!mpd.io_submit.io_end) {
+		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
+		if (!mpd->io_submit.io_end) {
 			ret = -ENOMEM;
 			break;
 		}
@@ -2851,16 +2851,16 @@ static int ext4_writepages(struct address_space *mapping,
 			       "%ld pages, ino %lu; err %d", __func__,
 				wbc->nr_to_write, inode->i_ino, ret);
 			/* Release allocated io_end */
-			ext4_put_io_end(mpd.io_submit.io_end);
-			mpd.io_submit.io_end = NULL;
+			ext4_put_io_end(mpd->io_submit.io_end);
+			mpd->io_submit.io_end = NULL;
 			break;
 		}
-		mpd.do_map = 1;
+		mpd->do_map = 1;
 
-		trace_ext4_da_write_pages(inode, mpd.first_page, mpd.wbc);
-		ret = mpage_prepare_extent_to_map(&mpd);
-		if (!ret && mpd.map.m_len)
-			ret = mpage_map_and_submit_extent(handle, &mpd,
+		trace_ext4_da_write_pages(inode, mpd->first_page, wbc);
+		ret = mpage_prepare_extent_to_map(mpd);
+		if (!ret && mpd->map.m_len)
+			ret = mpage_map_and_submit_extent(handle, mpd,
 					&give_up_on_write);
 		/*
 		 * Caution: If the handle is synchronous,
@@ -2875,12 +2875,12 @@ static int ext4_writepages(struct address_space *mapping,
 		if (!ext4_handle_valid(handle) || handle->h_sync == 0) {
 			ext4_journal_stop(handle);
 			handle = NULL;
-			mpd.do_map = 0;
+			mpd->do_map = 0;
 		}
 		/* Unlock pages we didn't use */
-		mpage_release_unused_pages(&mpd, give_up_on_write);
+		mpage_release_unused_pages(mpd, give_up_on_write);
 		/* Submit prepared bio */
-		ext4_io_submit(&mpd.io_submit);
+		ext4_io_submit(&mpd->io_submit);
 
 		/*
 		 * Drop our io_end reference we got from init. We have
@@ -2890,11 +2890,11 @@ static int ext4_writepages(struct address_space *mapping,
 		 * up doing unwritten extent conversion.
 		 */
 		if (handle) {
-			ext4_put_io_end_defer(mpd.io_submit.io_end);
+			ext4_put_io_end_defer(mpd->io_submit.io_end);
 			ext4_journal_stop(handle);
 		} else
-			ext4_put_io_end(mpd.io_submit.io_end);
-		mpd.io_submit.io_end = NULL;
+			ext4_put_io_end(mpd->io_submit.io_end);
+		mpd->io_submit.io_end = NULL;
 
 		if (ret == -ENOSPC && sbi->s_journal) {
 			/*
@@ -2914,8 +2914,8 @@ static int ext4_writepages(struct address_space *mapping,
 	blk_finish_plug(&plug);
 	if (!ret && !cycled && wbc->nr_to_write > 0) {
 		cycled = 1;
-		mpd.last_page = writeback_index - 1;
-		mpd.first_page = 0;
+		mpd->last_page = writeback_index - 1;
+		mpd->first_page = 0;
 		goto retry;
 	}
 
@@ -2925,7 +2925,7 @@ static int ext4_writepages(struct address_space *mapping,
 		 * Set the writeback_index so that range_cyclic
 		 * mode will write it back later
 		 */
-		mapping->writeback_index = mpd.first_page;
+		mapping->writeback_index = mpd->first_page;
 
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
@@ -2934,6 +2934,18 @@ static int ext4_writepages(struct address_space *mapping,
 	return ret;
 }
 
+static int ext4_writepages(struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	struct mpage_da_data mpd = {
+		.inode = mapping->host,
+		.wbc = wbc,
+		.can_map = 1,
+	};
+
+	return ext4_do_writepages(&mpd);
+}
+
 static int ext4_dax_writepages(struct address_space *mapping,
 			       struct writeback_control *wbc)
 {
-- 
2.35.3

