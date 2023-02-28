Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032A86A5293
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 06:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjB1FNj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 00:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjB1FNc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 00:13:32 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C276C149
        for <linux-ext4@vger.kernel.org>; Mon, 27 Feb 2023 21:13:31 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31S5DPox002546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 00:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677561207; bh=1mFhtS5WcStUC2XoEd1vbLLcu9CGq0pjvMByAmu2nio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jUYPHNEsBsh5UlN32QOi0eNyrtPq4glLJ0zhxiAw1E1qTri5YQDWWJHtS2YaHDd/B
         HW12FHVmypYrLLcIpCNZ6MqqiHR5t9nODz6ZAUVdljJOzdvdWIfzlnD/TYs6CXa1/3
         FOres4MvaqOf5o+bZ37SF0PGFYGeT8Hr6LXfbgRmX1M5wJfbuj7r9Op8RvG3aRTNCU
         A3R7VoDSJn21dvxu9yuPYR/X95V+LmjFr6+XANXBo/NaWongYqXYqwuzVEvFCm+Yny
         WpeHS+ZjVVD8iaOfdhzk5XAU6pt2Ewn5+eUF4wEZB/074+q4OUX9sRZZb5NusBJh0Q
         HOoBe05Pz/yhg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3360115C5828; Tue, 28 Feb 2023 00:13:24 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 5/7] ext4: Move page unlocking out of mpage_submit_page()
Date:   Tue, 28 Feb 2023 00:13:17 -0500
Message-Id: <20230228051319.4085470-6-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230228051319.4085470-1-tytso@mit.edu>
References: <20230228051319.4085470-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

Move page unlocking during page writeback out of mpage_submit_page()
into the callers. This will allow writeback in data=journal mode to keep
the page locked for a bit longer. Since page unlocking it tightly
connected to increment of mpd->first_page (as that determines cleanup of
locked but unwritten pages), move page unlocking as well as
mpd->first_page handling into a helper function.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 27a11bed897e..a1fe5e3e7697 100644
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
@@ -2666,14 +2672,11 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * modify metadata is simple. Just submit the page.
 			 */
 			if (!mpd->can_map) {
-				if (ext4_page_nomap_can_writeout(&folio->page)) {
+				if (ext4_page_nomap_can_writeout(&folio->page))
 					err = mpage_submit_page(mpd, &folio->page);
-					if (err < 0)
-						goto out;
-				} else {
-					folio_unlock(folio);
-					mpd->first_page += folio_nr_pages(folio);
-				}
+				mpage_page_done(mpd, &folio->page);
+				if (err < 0)
+					goto out;
 			} else {
 				/* Add all dirty buffers to mpd */
 				lblk = ((ext4_lblk_t)folio->index) <<
-- 
2.31.0

