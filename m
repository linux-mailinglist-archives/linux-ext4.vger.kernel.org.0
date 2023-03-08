Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A766B0AFC
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 15:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCHOZi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Mar 2023 09:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjCHOZh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Mar 2023 09:25:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC325F6D4
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 06:25:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2A9F1FE3C;
        Wed,  8 Mar 2023 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678285534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kbyKTOCIJaIs3nMkztoywrm2p8LU1om8qNJeOZWct+M=;
        b=W0+SXqvQxn+escvIAmWBd+IAnXaogdAugDys5LRA2errG65LefSSdsqpcEyXVp/XBIEOgo
        A/dJR9TJpTpeefZP53t3nLJZHZGJtHK3ES48gV8tdobPQ+2QYlIZrAd3dJBIQYSiJ6o+td
        q5YpFNCYFTkQe/w8o5M71+61oJSEdF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678285534;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kbyKTOCIJaIs3nMkztoywrm2p8LU1om8qNJeOZWct+M=;
        b=c18gfdCgHPDvYMRgbZ8mdLCVKrG5ZWqyV+ZKLQfQm1B7CRqG8vgPoffRk5Wzb6+NsBoGQ+
        IP1KIzyesl7hXJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5E701391B;
        Wed,  8 Mar 2023 14:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4jgNON2aCGSbawAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Mar 2023 14:25:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6FC39A0707; Wed,  8 Mar 2023 15:25:33 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Fix warnings when freezing filesystem with journaled data
Date:   Wed,  8 Mar 2023 15:25:28 +0100
Message-Id: <20230308142528.12384-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3699; i=jack@suse.cz; h=from:subject; bh=2t2ld6kW446slRowLyS8lWr11bl98grDPZsfdsdB/aU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkCJrCFmWQuOllJswFvgUK+J/Yb/NYZXUoJUFhD5f2 ETJdCe2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZAiawgAKCRCcnaoHP2RA2TCOCA C97pxCBwyQr7nqVll4ahTKW4NkTUaM6tyml/jfcrJCA9Eo2h6WvICEEQ7r37EEbd81/uAvbG2E9yUi CYQ3pUVJLEjQDfKawkfpvDHzf9zE9hincki0ZYoh0rVtGG1VRN1f0V3YanWTWDuJ0Lpk1KORfrjXmy WqCoX3MAc6BO1Hug21tNmqm40zFXUwShHYSGm6E8zLYrEICn29sFyhdJJQHdD2R3XsylBCocuzXZ2y QgisqFC1lbHAm5ubyosDhvBuI0/VNAHa9c4EpdFV3x8tm3PPfIXwiLSdEkrwKyzZUX89yEIUgdakmc 1VWbUXtEGYiFUHdmqLj61DAkzlVFTM
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Test generic/390 in data=journal mode often triggers a warning that
ext4_do_writepages() tries to start a transaction on frozen filesystem.
This happens because although all dirty data is properly written, jbd2
checkpointing code writes data through submit_bh() and as a result only
buffer dirty bits are cleared but page dirty bits stay set. Later when
the filesystem is frozen, writeback code comes, tries to write
supposedly dirty pages and the warning triggers. Fix the problem by
calling sync_filesystem() once more after flushing the whole journal to
clear stray page dirty bits.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 15 ++++++++++++++-
 fs/ext4/super.c | 11 +++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

  This patch fixes warnings for generic/390 test. Admittedly it is a bit of a
hack and the right fix is to change jbd2 code to avoid leaving stray page dirty
bits but that is actually surprisingly difficult to do due to locking
constraints without regressing metadata intensive workloads. Applies on top of
my data=journal cleanup series.

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4a45d320fda8..d86efa3d959d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2410,6 +2410,7 @@ static int mpage_journal_page_buffers(handle_t *handle,
 static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 {
 	struct address_space *mapping = mpd->inode->i_mapping;
+	struct super_block *sb = mpd->inode->i_sb;
 	struct folio_batch fbatch;
 	unsigned int nr_folios;
 	pgoff_t index = mpd->first_page;
@@ -2427,7 +2428,15 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	else
 		tag = PAGECACHE_TAG_DIRTY;
 
-	if (ext4_should_journal_data(mpd->inode)) {
+	/*
+	 * Start a transaction for writeback of journalled data. We don't start
+	 * start the transaction if the filesystem is frozen. In that case we
+	 * should not have any dirty data to write anymore but possibly there
+	 * are stray page dirty bits left by the checkpointing code so this
+	 * loop clears them.
+	 */
+	if (ext4_should_journal_data(mpd->inode) &&
+	    sb->s_writers.frozen >= SB_FREEZE_FS) {
 		handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
 					    bpp);
 		if (IS_ERR(handle))
@@ -2520,12 +2529,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 */
 			if (!mpd->can_map) {
 				if (ext4_page_nomap_can_writeout(&folio->page)) {
+					WARN_ON_ONCE(sb->s_writers.frozen ==
+						     SB_FREEZE_COMPLETE);
 					err = mpage_submit_page(mpd, &folio->page);
 					if (err < 0)
 						goto out;
 				}
 				/* Pending dirtying of journalled data? */
 				if (PageChecked(&folio->page)) {
+					WARN_ON_ONCE(sb->s_writers.frozen >=
+						     SB_FREEZE_FS);
 					err = mpage_journal_page_buffers(handle,
 						mpd, &folio->page);
 					if (err < 0)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 88f7b8a88c76..8cdf1a4e0011 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6259,6 +6259,17 @@ static int ext4_freeze(struct super_block *sb)
 		if (error < 0)
 			goto out;
 
+		/*
+		 * Do another sync. We really should not have any dirty data
+		 * anymore but our checkpointing code does not clear page dirty
+		 * bits due to locking constraints so writeback still can get
+		 * started for inodes with journalled data which triggers
+		 * annoying warnings.
+		 */
+		error = sync_filesystem(sb);
+		if (error < 0)
+			goto out;
+
 		/* Journal blocked and flushed, clear needs_recovery flag. */
 		ext4_clear_feature_journal_needs_recovery(sb);
 		if (ext4_orphan_file_empty(sb))
-- 
2.35.3

