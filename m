Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692D16CED68
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjC2PuQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjC2PuH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:50:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF225559A
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:50:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A61681FE03;
        Wed, 29 Mar 2023 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680105003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4DIoPMv9rLre5dgayQysn7d9vDSW7uTz8Vra+IiADY=;
        b=g5fOidQxdNi43o5rpTwDvS2hFqYeQz8In1n+EuomhLITaLx9vbXTKfSYh7uDQewt5pzFT9
        AcwNBkMs0TkKxXAmGO62UX7BuzVQ0zm2JD3mkHieMHN1MLgLxlX1EnfgBMFxsdW8rz1PF1
        C3fFehUsQuVMBNzvUkCl4D5JpFItLNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680105003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4DIoPMv9rLre5dgayQysn7d9vDSW7uTz8Vra+IiADY=;
        b=NlWNYDpvtqbK70tmAXddS5oFH6YlpkSz8wdJNM0ftq7giYqPanonHvfLp/obU/PTzvSGtT
        gf9DjkI2BPwCJ8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE6EC13A3A;
        Wed, 29 Mar 2023 15:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ylhiMipeJGRkYwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:50:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6FF54A0757; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 13/13] Revert "ext4: Fix warnings when freezing filesystem with journaled data"
Date:   Wed, 29 Mar 2023 17:49:44 +0200
Message-Id: <20230329154950.19720-13-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2894; i=jack@suse.cz; h=from:subject; bh=pXDe2OP0DMg78hYFHta38ZhTBTzs3hYpRX3y0ylVQx8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4XNsB9bVBApU3vfxbsPCAHRHwRpsS2DmpwP217 QQKuateJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReFwAKCRCcnaoHP2RA2TfyCA De5cbMo5obAAt0PkFqdRRlONZasTgtUdj4w9kMQRmnD29b42lbRbF4M+8igMZzs0cNrw1jrgZYxJ7h Sn5MbC+UIO64ce+M6HMT6y245ASqCJSBawG+th/oHKIH6plkZH3voEKSSOuUA+2mgRV1dIRuQ0rhNh pp/eG5PEoHeJfZeDUBBtpkiyMVmae20yXhhfc4XZAE4VOMuLD46MBzzdx90yjApU9ZkLsUYNmrvx6p AHD/gzg0mjUcys6a7W9OCSf9veHDAnHENundjcDV2UZntz5VL9wVXcA0no9/eY9ADsYHpfL05TtCoO 2+ccv5rMN4iVPMZZoZynr4ae233Hpt
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

After making ext4_writepages() properly clean all pages there is no need
for special treatment of filesystem freezing. Revert commit
e6c28a26b799c7640b77daff3e4a67808c74381c.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 15 +--------------
 fs/ext4/super.c | 11 -----------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 25a9e7586c50..5161221193f9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2379,7 +2379,6 @@ static int mpage_journal_page_buffers(handle_t *handle,
 static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 {
 	struct address_space *mapping = mpd->inode->i_mapping;
-	struct super_block *sb = mpd->inode->i_sb;
 	struct folio_batch fbatch;
 	unsigned int nr_folios;
 	pgoff_t index = mpd->first_page;
@@ -2399,15 +2398,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 
 	mpd->map.m_len = 0;
 	mpd->next_page = index;
-	/*
-	 * Start a transaction for writeback of journalled data. We don't start
-	 * the transaction if the filesystem is frozen. In that case we
-	 * should not have any dirty data to write anymore but possibly there
-	 * are stray page dirty bits left by the checkpointing code so this
-	 * loop clears them.
-	 */
-	if (ext4_should_journal_data(mpd->inode) &&
-	    sb->s_writers.frozen < SB_FREEZE_FS) {
+	if (ext4_should_journal_data(mpd->inode)) {
 		handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
 					    bpp);
 		if (IS_ERR(handle))
@@ -2496,15 +2487,11 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * through a pin.
 			 */
 			if (!mpd->can_map) {
-				WARN_ON_ONCE(sb->s_writers.frozen ==
-					     SB_FREEZE_COMPLETE);
 				err = mpage_submit_page(mpd, &folio->page);
 				if (err < 0)
 					goto out;
 				/* Pending dirtying of journalled data? */
 				if (PageChecked(&folio->page)) {
-					WARN_ON_ONCE(sb->s_writers.frozen >=
-						     SB_FREEZE_FS);
 					err = mpage_journal_page_buffers(handle,
 						mpd, &folio->page);
 					if (err < 0)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9f8dd0d6e46..b5b4734fc1b7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6293,17 +6293,6 @@ static int ext4_freeze(struct super_block *sb)
 		if (error < 0)
 			goto out;
 
-		/*
-		 * Do another sync. We really should not have any dirty data
-		 * anymore but our checkpointing code does not clear page dirty
-		 * bits due to locking constraints so writeback still can get
-		 * started for inodes with journalled data which triggers
-		 * annoying warnings.
-		 */
-		error = sync_filesystem(sb);
-		if (error < 0)
-			goto out;
-
 		/* Journal blocked and flushed, clear needs_recovery flag. */
 		ext4_clear_feature_journal_needs_recovery(sb);
 		if (ext4_orphan_file_empty(sb))
-- 
2.35.3

