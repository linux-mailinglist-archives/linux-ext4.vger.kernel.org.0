Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668986458FF
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiLGL1z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiLGL12 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC3D228
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:27 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0A2721CA3;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Jt80/G+7/RCUqxeB6gSfvGjDRIBgQ7ZhFssA9n8djw=;
        b=s7nC4o2jBXV8GB4z9SIhDPlirCCmRGZdC0zoUxLNpCMUxVHKiOWenVoC/CsAdKMfrQ51LO
        /vCUH6lHaZ3iuCOoPCSWKNhYBKhSFZsj0FpKtVqeYJHM/f3BA+4RhjJQIZT/2i1XbOsZLn
        4ShfNTjsuBtCPBi9WbmrNwIaNSEn5yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Jt80/G+7/RCUqxeB6gSfvGjDRIBgQ7ZhFssA9n8djw=;
        b=9wPiIxrnP09EY9P5f+tWUYsLbQry95PqPh+6/Qjqor+44sUtSD1tFiG8I4fVYnQCkMQ7my
        eiW7mL6ljxsIy4DA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AE71E136B4;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id AKWhKpt4kGNBLAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA6BCA0731; Wed,  7 Dec 2022 12:27:22 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 06/13] ext4: Provide ext4_do_writepages()
Date:   Wed,  7 Dec 2022 12:27:09 +0100
Message-Id: <20221207112722.22220-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7551; i=jack@suse.cz; h=from:subject; bh=qVxMmwcQoBV7FAJZ4j+zE1P1qZ9fDtRqhIqdT/hJtz8=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJInVPTmNs189PLYz5eFzD2T17bcZs1VCki8EBoWya2r1nNY eIJHJ6MxCwMjB4OsmCLL6siL2tfmGXVtDdWQgRnEygQyhYGLUwAmMteKg2E/x/xQDZeom6sPCj831d lzUIfZbHJk7NP1QaEWj9SUu414P6SsN6u1nbnDIfLTVOly11sFUuqsO2e2PH8+X923waXXf5JO0xmB i4xXHn5n3cYy7bqYcvmCsr9zrp5VSvJhZa12DL76cUWYX87iuXfyXYR6nqVW8C3b9bLzj/vhluSKjR EFqnr/r4ts2/hQbYmcfLpkgOvByo7+KJa5Ta2lxS+Nn23n7X5o1Zj2fbuxaE+mvbX8y8MX3T/9+Kry Z23r0nili7u3T9Zdf/Cw5EubMiv25XlNOzM/RqnNm8dTfr3FjP2SMvfv7vW2eVvc7V7o7XLQ33DT0e lpmD3XTqF8oE65pQzLr4fGzpkIAA==
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

Provide ext4_do_writepages() function that takes mpage_da_data as an
argument and make ext4_writepages() just a simple wrapper around it. No
functional changes.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 96 +++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9ba843b7a92c..99c66c768cd0 100644
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
 
@@ -2703,16 +2705,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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
@@ -2787,19 +2789,18 @@ static int ext4_writepages(struct address_space *mapping,
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
@@ -2808,28 +2809,27 @@ static int ext4_writepages(struct address_space *mapping,
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
@@ -2854,16 +2854,16 @@ static int ext4_writepages(struct address_space *mapping,
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
@@ -2878,12 +2878,12 @@ static int ext4_writepages(struct address_space *mapping,
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
@@ -2893,11 +2893,11 @@ static int ext4_writepages(struct address_space *mapping,
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
@@ -2917,8 +2917,8 @@ static int ext4_writepages(struct address_space *mapping,
 	blk_finish_plug(&plug);
 	if (!ret && !cycled && wbc->nr_to_write > 0) {
 		cycled = 1;
-		mpd.last_page = writeback_index - 1;
-		mpd.first_page = 0;
+		mpd->last_page = writeback_index - 1;
+		mpd->first_page = 0;
 		goto retry;
 	}
 
@@ -2928,7 +2928,7 @@ static int ext4_writepages(struct address_space *mapping,
 		 * Set the writeback_index so that range_cyclic
 		 * mode will write it back later
 		 */
-		mapping->writeback_index = mpd.first_page;
+		mapping->writeback_index = mpd->first_page;
 
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
@@ -2937,6 +2937,18 @@ static int ext4_writepages(struct address_space *mapping,
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

