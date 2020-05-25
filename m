Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7051E087F
	for <lists+linux-ext4@lfdr.de>; Mon, 25 May 2020 10:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbgEYIMV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 May 2020 04:12:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:52800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387668AbgEYIMV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 25 May 2020 04:12:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22525AC5F;
        Mon, 25 May 2020 08:12:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A5A461E127C; Mon, 25 May 2020 10:12:18 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Avoid unnecessary transaction starts during writeback
Date:   Mon, 25 May 2020 10:12:15 +0200
Message-Id: <20200525081215.29451-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_writepages() currently works in a loop like:
  start a transaction
  scan inode for pages to write
  map and submit these pages
  stop the transaction

This loop results in starting transaction once more than is needed
because in the last iteration we start a transaction only to scan the
inode and find there are no pages to write. This can be significant
increase in number of transaction starts for single-extent files or
files that have all blocks already mapped. Furthermore we already know
from previous iteration whether there are more pages to write or not. So
propagate the information from mpage_prepare_extent_to_map() and avoid
unnecessary looping in case there are no more pages to write.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a4aae6acdcb..d550514ebf13 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1526,6 +1526,7 @@ struct mpage_da_data {
 	struct ext4_map_blocks map;
 	struct ext4_io_submit io_submit;	/* IO submission data */
 	unsigned int do_map:1;
+	unsigned int scanned_until_end:1;
 };
 
 static void mpage_release_unused_pages(struct mpage_da_data *mpd,
@@ -1541,6 +1542,7 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 	if (mpd->first_page >= mpd->next_page)
 		return;
 
+	mpd->scanned_until_end = 0;
 	index = mpd->first_page;
 	end   = mpd->next_page - 1;
 	if (invalidate) {
@@ -2188,7 +2190,11 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 		if (err < 0)
 			return err;
 	}
-	return lblk < blocks;
+	if (lblk >= blocks) {
+		mpd->scanned_until_end = 1;
+		return 0;
+	}
+	return 1;
 }
 
 /*
@@ -2546,7 +2552,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
 				tag);
 		if (nr_pages == 0)
-			goto out;
+			break;
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
@@ -2601,6 +2607,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 		pagevec_release(&pvec);
 		cond_resched();
 	}
+	mpd->scanned_until_end = 1;
 	return 0;
 out:
 	pagevec_release(&pvec);
@@ -2619,7 +2626,6 @@ static int ext4_writepages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	int needed_blocks, rsv_blocks = 0, ret = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
-	bool done;
 	struct blk_plug plug;
 	bool give_up_on_write = false;
 
@@ -2705,7 +2711,6 @@ static int ext4_writepages(struct address_space *mapping,
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag_pages_for_writeback(mapping, mpd.first_page, mpd.last_page);
-	done = false;
 	blk_start_plug(&plug);
 
 	/*
@@ -2715,6 +2720,7 @@ static int ext4_writepages(struct address_space *mapping,
 	 * started.
 	 */
 	mpd.do_map = 0;
+	mpd.scanned_until_end = 0;
 	mpd.io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
 	if (!mpd.io_submit.io_end) {
 		ret = -ENOMEM;
@@ -2730,7 +2736,7 @@ static int ext4_writepages(struct address_space *mapping,
 	if (ret < 0)
 		goto unplug;
 
-	while (!done && mpd.first_page <= mpd.last_page) {
+	while (!mpd.scanned_until_end && wbc->nr_to_write > 0) {
 		/* For each extent of pages we use new io_end */
 		mpd.io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
 		if (!mpd.io_submit.io_end) {
@@ -2765,20 +2771,9 @@ static int ext4_writepages(struct address_space *mapping,
 
 		trace_ext4_da_write_pages(inode, mpd.first_page, mpd.wbc);
 		ret = mpage_prepare_extent_to_map(&mpd);
-		if (!ret) {
-			if (mpd.map.m_len)
-				ret = mpage_map_and_submit_extent(handle, &mpd,
+		if (!ret && mpd.map.m_len)
+			ret = mpage_map_and_submit_extent(handle, &mpd,
 					&give_up_on_write);
-			else {
-				/*
-				 * We scanned the whole range (or exhausted
-				 * nr_to_write), submitted what was mapped and
-				 * didn't find anything needing mapping. We are
-				 * done.
-				 */
-				done = true;
-			}
-		}
 		/*
 		 * Caution: If the handle is synchronous,
 		 * ext4_journal_stop() can wait for transaction commit
-- 
2.16.4

