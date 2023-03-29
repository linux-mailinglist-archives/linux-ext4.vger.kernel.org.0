Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA806CED6A
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjC2PuT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjC2PuJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:50:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFFE55A8
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:50:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C25C71FE07;
        Wed, 29 Mar 2023 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680105005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YD9RDxtOv+vIKcfu/ZBKjT97w0o22t8fXrtqTrzWcgo=;
        b=k+/gCsToptUKaRxv+DyQO7jiZSzqZKhcZAEtxydwRbzPoJj6gdA3wtSY0c3quuEPWgE8A1
        KeonvfmDAsx+cHEB8Q/Zr3LFk0AA5LIdfZjL8u4sWM5H641hrV8GqGCdHas+Q8OAzYiBR9
        zPr4GOAZQIl6lxcFlYBnCxMv324Scwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680105005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YD9RDxtOv+vIKcfu/ZBKjT97w0o22t8fXrtqTrzWcgo=;
        b=mfV3eurQN/iEuHojOGWEfS0I0vAeV2Sd+dAJwSXwdfPOeqpmO9+mdfNw8APlORtjaevNoC
        l6zdmcyLcu2OsuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAC8613A3A;
        Wed, 29 Mar 2023 15:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B2K9KSxeJGR2YwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:50:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 44B74A0745; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 05/13] ext4: Commit transaction before writing back pages in data=journal mode
Date:   Wed, 29 Mar 2023 17:49:36 +0200
Message-Id: <20230329154950.19720-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4217; i=jack@suse.cz; h=from:subject; bh=htZyJjALC3Xt4nyH8GPy9MruWg2i8rdn6LEZsSWi8/A=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4Q7P1To8fSnq7zeeyAqlyyHxQ0HCL7XUGXOhPU YTKo/zqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReEAAKCRCcnaoHP2RA2YI9B/ 9cbxHwrWTf07dgG7OWUn1rcDMoJ9MOzVeJ905xgrH7+wJVn1mwD8jZ9ZxhybTu/gkEYgd5qAit/NoU hUETU2o0TABAuH7IAUh5nvXGyCudoRay+XYD88PjIZgIVzfvWcd/jUyXYIXYV9Uyv8z/gTsWwq7Vmq NZcuAjNHhb6bdvPf3gZ2+5ugNVYrhjObXYEtWap7vx9XhZQS3xljHe+gy4W8PNxNVxGEnfiveg5+76 d8olWWJy+E97fqks0Tf1LPLMskjKsHckGpXUiQ0YD1lq5jmfLrwqQuPkcoKm2JpNhi28WNRnTuDyly YiSkBTMUN1f/m5/g82FK00Xiz1GezF
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When journalling data we currently just walk over pages, journal those
that are marked for delayed dirtying (only pinned pages dirtied behing
our back these days) and checkpoint other dirty pages. Because some
pages may be part of running transaction the result is that after
filemap_write_and_wait() we are not guaranteed pages are stable on disk.
Thus places that want to flush current pagecache content need to jump
through hoops to make sure journalled data is not lost. This is
manageable in cases completely controlled by ext4 (such as extent
shifting operations or inode eviction) but it gets ugly for stuff like
fsverity. Furthermore it is rather error prone as people often do not
realize journalled data needs special handling.

So change ext4_writepages() to commit transaction with inode's data
before going through the writeback loop in WB_SYNC_ALL mode. As a result
filemap_write_and_wait() is now really getting pages to stable storage
and makes pagecache pages safe to reclaim. Consequently we can remove
the special handling of journalled data from several places in follow up
patches.

Note that this will make fsync(2) for journalled data more expensive as
we will end up not only committing the transaction we need but also
checkpointing the data (which we may have previously skipped if the data
was part of the running transaction). If we really cared, we would need
to introduce special VFS function for writing out & invalidating page
cache for a range, use ->launder_page callback to perform checkpointing,
and use it from all the places that need this functionality. But at this
point I'm not convinced the complexity is worth it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 85299c90b0f7..3ab2d56b6840 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1562,6 +1562,7 @@ struct mpage_da_data {
 	struct ext4_io_submit io_submit;	/* IO submission data */
 	unsigned int do_map:1;
 	unsigned int scanned_until_end:1;
+	unsigned int journalled_more_data:1;
 };
 
 static void mpage_release_unused_pages(struct mpage_da_data *mpd,
@@ -2539,6 +2540,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 						mpd, &folio->page);
 					if (err < 0)
 						goto out;
+					mpd->journalled_more_data = 1;
 				}
 				mpage_page_done(mpd, &folio->page);
 			} else {
@@ -2628,10 +2630,23 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 
 	/*
 	 * data=journal mode does not do delalloc so we just need to writeout /
-	 * journal already mapped buffers
+	 * journal already mapped buffers. On the other hand we need to commit
+	 * transaction to make data stable. We expect all the data to be
+	 * already in the journal (the only exception are DMA pinned pages
+	 * dirtied behind our back) so we commit transaction here and run the
+	 * writeback loop to checkpoint them. The checkpointing is not actually
+	 * necessary to make data persistent *but* quite a few places (extent
+	 * shifting operations, fsverity, ...) depend on being able to drop
+	 * pagecache pages after calling filemap_write_and_wait() and for that
+	 * checkpointing needs to happen.
 	 */
-	if (ext4_should_journal_data(inode))
+	if (ext4_should_journal_data(inode)) {
 		mpd->can_map = 0;
+		if (wbc->sync_mode == WB_SYNC_ALL)
+			ext4_fc_commit(sbi->s_journal,
+				       EXT4_I(inode)->i_datasync_tid);
+	}
+	mpd->journalled_more_data = 0;
 
 	if (ext4_should_dioread_nolock(inode)) {
 		/*
@@ -2812,6 +2827,13 @@ static int ext4_writepages(struct address_space *mapping,
 
 	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
 	ret = ext4_do_writepages(&mpd);
+	/*
+	 * For data=journal writeback we could have come across pages marked
+	 * for delayed dirtying (PageChecked) which were just added to the
+	 * running transaction. Try once more to get them to stable storage.
+	 */
+	if (!ret && mpd.journalled_more_data)
+		ret = ext4_do_writepages(&mpd);
 	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
 
 	return ret;
-- 
2.35.3

