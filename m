Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF8B665F92
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 16:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAKPrB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 10:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjAKPq1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 10:46:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646583B924
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 07:44:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C41D4CDF;
        Wed, 11 Jan 2023 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673451820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwczy+UDYj18TbxkAMvC7qrXX4CX2pJuDg23rlJQdPM=;
        b=vZfqua1J1aB7UkB1vojCo5+vp/U3fS6KbIXcHo6QSY4ksAEFO1g1NuEdEiV7JbL1mtyGPE
        F0Bb6XuwfT7uq241EsmLfxYmmFXYofsszaNRUUNFfX/tCKesf/y+oMcp4w3Ee+/qrOVpoZ
        0gdwGXUw/zkUIFEVastbem3DP4psAi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673451820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwczy+UDYj18TbxkAMvC7qrXX4CX2pJuDg23rlJQdPM=;
        b=B0eQZJ0h1jlu7KRyoHORKamEm/jio9g8Zp7LBnShw37L2RMVpU8gxdpRcDh4tAmzMZU46z
        RvU9j4Rw3yb0egBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 035531358A;
        Wed, 11 Jan 2023 15:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sS3NACzZvmPOOwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 15:43:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2D404A074F; Wed, 11 Jan 2023 16:43:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/7] ext4: Move page unlocking out of mpage_submit_page()
Date:   Wed, 11 Jan 2023 16:43:29 +0100
Message-Id: <20230111154338.392-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111152736.9608-1-jack@suse.cz>
References: <20230111152736.9608-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2463; i=jack@suse.cz; h=from:subject; bh=TIislCEYm8JsMX39PpjQA05elqHdpeu+/dFa5UWEXA8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjvtkhWeIvTZ+1zwsmoYXQLVOIZDuOo5IAGspUmIXx uGcdK52JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY77ZIQAKCRCcnaoHP2RA2bSXCA Dlsmcj//cGTZzfF74CXFY1jhKOp/H4J8Kov2fYQ+hL8uQV3J3yk04jNNgg2ihR7OTnlJgBbkOst1WO bkeuNPuS2098qXxnTEVzpamHfBQKd0/hlfODnU8OX2GIC2XfHtDIkWzrOV7eKRIcpXGA91EhuMN2A8 k2NthuW4YooV7/gCRmIxkE+037OXtM/vuVL/z8SBl0M2hUWZSEtjRuVV4RCOMY510XpOgzYLzuqnJD RaG8MQSZGOCGZcqozIdMn2GsAdeq6AKu2pmPdeSyqb25mAyA1UQtTYnp/PurQC1eUD8CRcCTtmBVPQ 6pQkut2zP8znepRgrjn4xCuKufSqf2
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

Move page unlocking during page writeback out of mpage_submit_page()
into the callers. This will allow writeback in data=journal mode to keep
the page locked for a bit longer. Since page unlocking it tightly
connected to increment of mpd->first_page (as that determines cleanup of
locked but unwritten pages), move page unlocking as well as
mpd->first_page handling into a helper function.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 237880f0d406..28b59e078a1d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2083,6 +2083,12 @@ static int ext4_writepage(struct page *page,
 	return ret;
 }
 
+static void mpage_page_done(struct mpage_da_data *mpd, struct page *page)
+{
+	mpd->first_page++;
+	unlock_page(page);
+}
+
 static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
 {
 	int len;
@@ -2111,10 +2117,8 @@ static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
 	else
 		len = PAGE_SIZE;
 	err = ext4_bio_write_page(&mpd->io_submit, page, len);
-	unlock_page(page);
 	if (!err)
 		mpd->wbc->nr_to_write--;
-	mpd->first_page++;
 
 	return err;
 }
@@ -2226,6 +2230,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 	/* So far everything mapped? Submit the page for IO. */
 	if (mpd->map.m_len == 0) {
 		err = mpage_submit_page(mpd, head->b_page);
+		mpage_page_done(mpd, head->b_page);
 		if (err < 0)
 			return err;
 	}
@@ -2357,6 +2362,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 				goto out;
 			/* Page fully mapped - let IO run! */
 			err = mpage_submit_page(mpd, page);
+			mpage_page_done(mpd, page);
 			if (err < 0)
 				goto out;
 		}
@@ -2667,14 +2673,11 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * modify metadata is simple. Just submit the page.
 			 */
 			if (!mpd->can_map) {
-				if (ext4_page_nomap_can_writeout(page)) {
+				if (ext4_page_nomap_can_writeout(page))
 					err = mpage_submit_page(mpd, page);
-					if (err < 0)
-						goto out;
-				} else {
-					unlock_page(page);
-					mpd->first_page++;
-				}
+				mpage_page_done(mpd, page);
+				if (err < 0)
+					goto out;
 			} else {
 				/* Add all dirty buffers to mpd */
 				lblk = ((ext4_lblk_t)page->index) <<
-- 
2.35.3

