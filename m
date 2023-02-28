Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0D6A5294
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 06:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjB1FNk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 00:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjB1FNc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 00:13:32 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFDFBDE7
        for <linux-ext4@vger.kernel.org>; Mon, 27 Feb 2023 21:13:30 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31S5DPJF002551
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 00:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677561207; bh=nIqDDJlP/55t2Zh3A5TLNxymYe1cGWvGgESNNjAeMTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SgNF1C6NeEx19ZboMFZwAZnYfZPo+UcgQAJ8ZlId5e6Xqa2M9/FpKhVDrI3nLeRiG
         S3uRyYgAKute9Bmre6CJuwC+XDSzg/0/68vvePsjSyNsRVqRKYoNSm5Z39srRZ4j0P
         QkjDY4scMLpiyb1GchBworEslvb/IHk5yTpR9MKNmT4/eMm84I42MonF+1f7woid38
         k7pkU9x1x1BM23uR2Qd2B9NFWZxHEegYnhjvOKiXKDu0wpvumtPTnmiZfv+K+Mznj+
         YVP4SsbYmGD2pt/5hqIg/VrZsiS5ZIUXjLhNXC8mZ3hPcY9rY/y0OyfNgX82WITSXy
         2EnRtwC1BEhzA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 35ADB15C5829; Tue, 28 Feb 2023 00:13:24 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 6/7] ext4: Move mpage_page_done() calls after error handling
Date:   Tue, 28 Feb 2023 00:13:18 -0500
Message-Id: <20230228051319.4085470-7-tytso@mit.edu>
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

In case mpage_submit_page() returns error, it doesn't really matter
whether we call mpage_page_done() and then return error or whether we
return directly because in that case page cleanup will be done by
mpage_release_unused_pages() instead. Logically, it makes more sense to
leave the cleanup to mpage_release_unused_pages() because we didn't
succeed in writing the page. So move mpage_page_done() calls after the
error handling.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a1fe5e3e7697..e6c453bf953e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2230,9 +2230,9 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 	/* So far everything mapped? Submit the page for IO. */
 	if (mpd->map.m_len == 0) {
 		err = mpage_submit_page(mpd, head->b_page);
-		mpage_page_done(mpd, head->b_page);
 		if (err < 0)
 			return err;
+		mpage_page_done(mpd, head->b_page);
 	}
 	if (lblk >= blocks) {
 		mpd->scanned_until_end = 1;
@@ -2362,9 +2362,9 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 				goto out;
 			/* Page fully mapped - let IO run! */
 			err = mpage_submit_page(mpd, page);
-			mpage_page_done(mpd, page);
 			if (err < 0)
 				goto out;
+			mpage_page_done(mpd, page);
 		}
 		folio_batch_release(&fbatch);
 	}
@@ -2672,11 +2672,12 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * modify metadata is simple. Just submit the page.
 			 */
 			if (!mpd->can_map) {
-				if (ext4_page_nomap_can_writeout(&folio->page))
+				if (ext4_page_nomap_can_writeout(&folio->page)) {
 					err = mpage_submit_page(mpd, &folio->page);
+					if (err < 0)
+						goto out;
+				}
 				mpage_page_done(mpd, &folio->page);
-				if (err < 0)
-					goto out;
 			} else {
 				/* Add all dirty buffers to mpd */
 				lblk = ((ext4_lblk_t)folio->index) <<
-- 
2.31.0

