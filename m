Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB72642874
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiLEM3c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLEM3b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ABBBC3E
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:30 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 380A52001B;
        Mon,  5 Dec 2022 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWUivoPF8rh6YNbRp12PTNmtUBRknCK4IxKDth2V10Y=;
        b=loh/sGGvX5GEyFlOXQ48XI+lyzwZM7FJNeWbZYnrsroyrI0IaeinLQluZesztsP5ws3ZF/
        URGXOIqyfKVfJpJMwByAj6Qb9ZZ86ZBgusInQ9o1JQgfNZXISiXm58SY8ziWDU4RWro2ZM
        MjmtejF5gZzFLk6FIPfrMEO0DnFadbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWUivoPF8rh6YNbRp12PTNmtUBRknCK4IxKDth2V10Y=;
        b=ee0v18A/pCqGViucPqNYtrmGcHvClMYCxFQpc6AHZzSAsVN1siN2Rlyso6mqWOpgCtzUsl
        OoDSpoiLhtOzLjAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1AFDC1348F;
        Mon,  5 Dec 2022 12:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ZOOQBinkjWP8TQAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 43D90A060E; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 01/12] ext4: Handle redirtying in ext4_bio_write_page()
Date:   Mon,  5 Dec 2022 13:29:15 +0100
Message-Id: <20221205122928.21959-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; i=jack@suse.cz; h=from:subject; bh=vdozeUvfNYyCeixKiAugGlYRgdNUDNkZOW42CdQ7y9I=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjjeQcB+fHKP4nh1IIQZOIeG+ejYx8dHkOZhCuAUNp am41wMCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY43kHAAKCRCcnaoHP2RA2bGLB/ 4rKZ6921BMWuj0gOZWxYg1GU4NKXpImsYj/M8wOp4OEHdTBH+1C/XQnH/IEiIB5kLbRCrpGHRxIVLD OHYQBFYTQnNzE0sfE+FAvE6w+kCJ3x8O7f3I69BIA6IQLKXKOyVh97bLVN1zZcTet2JQ7HXZ2+4ffm pc6VotqlCl3pGr/mlDmeZyVZL8gLo7fU3S3Zn7JUTQ3HJWm71v+kmAKZBZDeZNqrRXDp19WS6Y7CQQ pUydatg7WzHCPgDdQ2YIalygMl9biEbqwG7brN3W1rIQkJAlUSUggEJmlLc8gkObAo2NJ/14ldUiTp 8XvzXFmdIrG7OR6qKoyALbR1znkH80
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

Since we want to transition transaction commits to use ext4_writepages()
for writing back ordered, add handling of page redirtying into
ext4_bio_write_page(). Also move buffer dirty bit clearing into the same
place other buffer state handling.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/page-io.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 97fa7b4c645f..4e68ace86f11 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -482,6 +482,13 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			/* A hole? We can safely clear the dirty bit */
 			if (!buffer_mapped(bh))
 				clear_buffer_dirty(bh);
+			/*
+			 * Keeping dirty some buffer we cannot write? Make
+			 * sure to redirty the page. This happens e.g. when
+			 * doing writeout for transaction commit.
+			 */
+			if (buffer_dirty(bh) && !PageDirty(page))
+				redirty_page_for_writepage(wbc, page);
 			if (io->io_bio)
 				ext4_io_submit(io);
 			continue;
@@ -489,6 +496,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		if (buffer_new(bh))
 			clear_buffer_new(bh);
 		set_buffer_async_write(bh);
+		clear_buffer_dirty(bh);
 		nr_to_submit++;
 	} while ((bh = bh->b_this_page) != head);
 
@@ -532,7 +540,10 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
 			redirty_page_for_writepage(wbc, page);
 			do {
-				clear_buffer_async_write(bh);
+				if (buffer_async_write(bh)) {
+					clear_buffer_async_write(bh);
+					set_buffer_dirty(bh);
+				}
 				bh = bh->b_this_page;
 			} while (bh != head);
 			goto unlock;
@@ -546,7 +557,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		io_submit_add_bh(io, inode,
 				 bounce_page ? bounce_page : page, bh);
 		nr_submitted++;
-		clear_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
 
 unlock:
-- 
2.35.3

