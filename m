Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558506CED64
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjC2PuE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC2Pt7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:49:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E25469C
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:49:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 103551FE02;
        Wed, 29 Mar 2023 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680104996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Thhq6nwM/21CbXNXp69ncnfJKSCf/bPOZknFshjPbQ8=;
        b=cmP6w9AeIbtPZk6X11AmTyqTDagi3Ae8u/BwAiZhu/PadWOWxnutzn22jyzsOrHoAORfPq
        PmsPxidng6kTTb4R6ZJJGTckzww+OokQrvavDa9wgDu1YxKUURlZkUttilvuYI5Y6AJH23
        SDYrCdcPvzYfooS0pH+320LR5/Y7qak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680104996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Thhq6nwM/21CbXNXp69ncnfJKSCf/bPOZknFshjPbQ8=;
        b=3Eihzv/oeEpNQA182IAheBC3xN+DjNyLv2LQMIEBdXKeK3gftvSNGWhxBPC4pL/hmVMmED
        NB7vGfohDUH6ZqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCAED13A3A;
        Wed, 29 Mar 2023 15:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6PoEMSJeJGQ3YwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:49:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3F84FA0735; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 04/13] ext4: Clear dirty bit from pages without data to write
Date:   Wed, 29 Mar 2023 17:49:35 +0200
Message-Id: <20230329154950.19720-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=jack@suse.cz; h=from:subject; bh=615TyBLgzeP3gyxMjfOLmB1DE1pIuuHs8koGXQI3RTQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4Ph6AhIF8YeljGnrFrBt+nIPmwq81c5EW7HwYf L5PTrSOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReDwAKCRCcnaoHP2RA2XtnB/ 9f1MllocnUMYk5SbDZaoL5j1PA0tEj8bQgfMONwu5YiYvNHgOYqM/CgoOdEY/Zt02iZFtzl0bPDKpv T3fH9zjZZ2CnnqQAUClwFfsycO+CICvQomEWAWfZwqsXC2+X5EBZxTKxQASrSK1vpu9jmp+yab534B QSqCF1lguSSyASyI3abQsYMWOkZSRsC/1sYeej7XM8mPi1iahkipIrCmtxeEoTComVKfaexisUP2tM HR9t7c3/Nq4yqwega+5ALcKjlAYbbUPAEqJ2qQP4+/nQVZsZ1JVlAmZrI9qGYkwxNaotnZASJr47iX B8bGlx312J2R6oHJnfifLvCdlbLS3A
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

With journalled data it can happen that checkpointing code will write
out page contents without clearing the page dirty bit. The logic in
ext4_page_nomap_can_writeout() then results in us never calling
mpage_submit_page() and thus clearing the dirty bit. Drop the
optimization with ext4_page_nomap_can_writeout() and just always call to
mpage_submit_page(). ext4_bio_write_page() knows when to redirty the
page and the additional clearing & setting of page dirty bit for ordered
mode writeout is not that expensive to jump through the hoops for it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 78e29da70af7..85299c90b0f7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2342,19 +2342,6 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
 }
 
-/* Return true if the page needs to be written as part of transaction commit */
-static bool ext4_page_nomap_can_writeout(struct page *page)
-{
-	struct buffer_head *bh, *head;
-
-	bh = head = page_buffers(page);
-	do {
-		if (buffer_dirty(bh) && buffer_mapped(bh) && !buffer_delay(bh))
-			return true;
-	} while ((bh = bh->b_this_page) != head);
-	return false;
-}
-
 static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
 				     int len)
 {
@@ -2539,13 +2526,11 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * range operations before discarding the page cache.
 			 */
 			if (!mpd->can_map) {
-				if (ext4_page_nomap_can_writeout(&folio->page)) {
-					WARN_ON_ONCE(sb->s_writers.frozen ==
-						     SB_FREEZE_COMPLETE);
-					err = mpage_submit_page(mpd, &folio->page);
-					if (err < 0)
-						goto out;
-				}
+				WARN_ON_ONCE(sb->s_writers.frozen ==
+					     SB_FREEZE_COMPLETE);
+				err = mpage_submit_page(mpd, &folio->page);
+				if (err < 0)
+					goto out;
 				/* Pending dirtying of journalled data? */
 				if (PageChecked(&folio->page)) {
 					WARN_ON_ONCE(sb->s_writers.frozen >=
-- 
2.35.3

