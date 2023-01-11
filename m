Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E7F665F93
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 16:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbjAKPrE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 10:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbjAKPq1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 10:46:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648BA3B925
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 07:44:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 384774CDB;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673451819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCzZtTCPysU8XKeIuyFBJEo6DrpX6FUzU7+1VRauqHo=;
        b=pC4qTwbtiEtUzPpIRPnvP4DwVYWlf7nzNl161ntx3qWRpLmE6cOjFIp1bnFiQVmdm6DHC2
        nYEsgMRiFJy9AirZhzsRUsSsqzl5LYJt4yBXtYzsPrH4FJpzfAOWSvQ7wM/9g5o4VcHvRH
        Yotnd0ZPe8iXZ8wxg47gTzJdxjt6pUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673451819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCzZtTCPysU8XKeIuyFBJEo6DrpX6FUzU7+1VRauqHo=;
        b=yU9n5ZFcxfzaC/oI2s344cKtzds9F2ZNOVMh8g4aK6U8CnND8IVrli4YzWCrKtssXalpX/
        jbZdK1lMdTCJoQCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2449F13594;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5xjTCCvZvmO1OwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 15:43:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1C6D3A0746; Wed, 11 Jan 2023 16:43:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/7] ext4: Use nr_to_write directly in mpage_prepare_extent_to_map()
Date:   Wed, 11 Jan 2023 16:43:26 +0100
Message-Id: <20230111154338.392-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111152736.9608-1-jack@suse.cz>
References: <20230111152736.9608-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=jack@suse.cz; h=from:subject; bh=sdcU1RNfO+GxuvDAPMRPuPWdH7mDyZSmSkAT9wazJqc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjvtkeFYDjx0MiVWWsphGGp4qcJpvhUNW7kxPszOCG zGU1jzuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY77ZHgAKCRCcnaoHP2RA2XzmB/ 9l9jR+yXL9Maubb9Edl4l/kNkuuz+BF8U2Vby4PMf/K/xIqIaZxLlUOtFmrvud0u8MDi7fX7FxKH/N p0+pJBLUl6aitQns67lJzkW13nMEK8WF/ACdOQelFJqUP75HS//V7oCx9lB9KlOd6OibJYPz63XmNh ZYwRH1CKtkQ6QFhdxhSxIlZ2bBRTUmkmNuBQGl9Dgi//OHJV9lfCIOuxLR2hQ80b7blywUU5rdy0WJ EhIwWWYOWZHsifVQyyehrqXAiF7KvtG+OzkYucGUVtmb7yYHd4xQW/NdPXHZApSFz31QB+2W3tDs2c DcSke99CYdejk4Iy3bfmlTO1BOJ8nR
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

When looking up extent of pages to map in mpage_prepare_extent_to_map()
we count how many pages we still need to find in a copy of
wbc->nr_to_write counter. With more complex page handling for
data=journal mode, it will be easier to use wbc->nr_to_write directly so
that we don't forget to carry over changes back to nr_to_write counter.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f9201c7d61ad..13cab2a47f99 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2580,7 +2580,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	struct address_space *mapping = mpd->inode->i_mapping;
 	struct pagevec pvec;
 	unsigned int nr_pages;
-	long left = mpd->wbc->nr_to_write;
 	pgoff_t index = mpd->first_page;
 	pgoff_t end = mpd->last_page;
 	xa_mark_t tag;
@@ -2614,7 +2613,9 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * newly appeared dirty pages, but have not synced all
 			 * of the old dirty pages.
 			 */
-			if (mpd->wbc->sync_mode == WB_SYNC_NONE && left <= 0)
+			if (mpd->wbc->sync_mode == WB_SYNC_NONE &&
+			    mpd->wbc->nr_to_write <=
+			    mpd->map.m_len >> (PAGE_SHIFT - blkbits))
 				goto out;
 
 			/* If we can't merge this page, we are done. */
@@ -2683,7 +2684,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 					goto out;
 				err = 0;
 			}
-			left--;
 		}
 		pagevec_release(&pvec);
 		cond_resched();
-- 
2.35.3

