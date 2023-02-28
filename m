Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07186A5290
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 06:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjB1FNe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 00:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB1FNc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 00:13:32 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E467BB88
        for <linux-ext4@vger.kernel.org>; Mon, 27 Feb 2023 21:13:30 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31S5DOFR002510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 00:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677561205; bh=KnEDW8ilSvhEPOI5cvRVr6i9vSF4QbI3Qm2OGrhLPGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JboRo5+bU7yEs9jGsUljE794ArB4aH/Dxwf1+OKHdvj0Ng9XbjeGsrc4FsKU7Y+nQ
         GnZu0uIZDckmanhj/6yjntgJCZHRJJqHCmKtbtlObp6rMPTEKKRy2qnK1jrRE8bVUh
         /l7WpDA9xtAJj7mwmtn5E/VJPWk6ZfV9ogbOxOyuZKXEVuXSit98iKukl4E3EGzT/C
         GDqjzV+UAve2Nq52snbStReMWRwx1tu+Tmv9WfgdcOTv9TZPXvZdPO5kY5lj52PMNU
         tCm1yV3Md5cijfpGvRsMZvcrkiATZE7OW0TGmCYM0fE6ZiNXSK8gaVh5gMBhZuIal/
         iwL3BdND736PA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2DA1515C5825; Tue, 28 Feb 2023 00:13:24 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/7] ext4: Use nr_to_write directly in mpage_prepare_extent_to_map()
Date:   Tue, 28 Feb 2023 00:13:14 -0500
Message-Id: <20230228051319.4085470-3-tytso@mit.edu>
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

When looking up extent of pages to map in mpage_prepare_extent_to_map()
we count how many pages we still need to find in a copy of
wbc->nr_to_write counter. With more complex page handling for
data=journal mode, it will be easier to use wbc->nr_to_write directly so
that we don't forget to carry over changes back to nr_to_write counter.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 178978484acc..98dd50d7e72a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2580,7 +2580,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	struct address_space *mapping = mpd->inode->i_mapping;
 	struct folio_batch fbatch;
 	unsigned int nr_folios;
-	long left = mpd->wbc->nr_to_write;
 	pgoff_t index = mpd->first_page;
 	pgoff_t end = mpd->last_page;
 	xa_mark_t tag;
@@ -2613,7 +2612,9 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * newly appeared dirty pages, but have not synced all
 			 * of the old dirty pages.
 			 */
-			if (mpd->wbc->sync_mode == WB_SYNC_NONE && left <= 0)
+			if (mpd->wbc->sync_mode == WB_SYNC_NONE &&
+			    mpd->wbc->nr_to_write <=
+			    mpd->map.m_len >> (PAGE_SHIFT - blkbits))
 				goto out;
 
 			/* If we can't merge this page, we are done. */
@@ -2682,7 +2683,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 					goto out;
 				err = 0;
 			}
-			left -= folio_nr_pages(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.31.0

