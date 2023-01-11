Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27D9665F91
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 16:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbjAKPqv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 10:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbjAKPq1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 10:46:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6603B920
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 07:44:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47D644CDC;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673451819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vKk+UjtaYyTgUG5kRPuE6Dux62abObV4tz4J0MHgHc=;
        b=bSecToR501v6G84ByahV5p/clH4tFTdAd0yjpsPG7c0xYmLbcUalpfhrSUWBsM7K3hD5Ow
        DD6qbqqMFBtmE3H+e/eh4rM7avN6C1Uij+uc01nH62KCdlALgj3DNMFkVPJxM9xdxugXa4
        Db5VnPOLjdr7hQ5DkZPfw6f7Vk0JB+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673451819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vKk+UjtaYyTgUG5kRPuE6Dux62abObV4tz4J0MHgHc=;
        b=+R9eCOzZMSuRHVA3D0clEyras8YQkq6kwCegJf+K0zZTRpJXbGO5Qy61zcaXw2xKt8UPYX
        KtA/Ve9qehBmUMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3434013677;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +ES1DCvZvmO6OwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 15:43:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 28001A074D; Wed, 11 Jan 2023 16:43:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/7] ext4: Don't unlock page in ext4_bio_write_page()
Date:   Wed, 11 Jan 2023 16:43:28 +0100
Message-Id: <20230111154338.392-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111152736.9608-1-jack@suse.cz>
References: <20230111152736.9608-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=jack@suse.cz; h=from:subject; bh=J/YYy9kOGvXtlg3KxCeHOp+Rgo+fGGYk65kMXfU15NM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjvtkgAAryq3r3xYhzCIPiQrIy00tr8a95O6b5WPBg p5euuk+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY77ZIAAKCRCcnaoHP2RA2TTFB/ wOPDZH85o/u8fJmbEsVA3swMNB4M8a9jyo6FGc92VgqFfpv407392OO/1RrS4JJf1wADH14eC03QLm SflxdDZgNTfANF/TquH2XdEmZUep6CqBsed14N9S8IIWTpmt/N/CNM+1XEFpQAVG7pbXv7uWj3RIWR JoiJjN0bc7Cbn4QILshHf407E5swF/FcEbdK/K2HjFhQ/IIlQyx+VN/lM4go0pPpP1jOZD/5dBtj87 1vl+f4E4mjCm8Cj2T8zAqfLgG6MYS2AUOjMl9Q39nEmtTp1SyzOEENn9opwLKF1plw3iWNo+F2Lg1c zZcCmoe8Wn7YpHzIjuIwrO6G8CywlR
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

Do not unlock the written page in ext4_bio_write_page(). Instead leave
the page locked and unlock it in the callers. We'll need to keep the
page locked for data=journal writeback for a bit longer.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c   |  2 ++
 fs/ext4/page-io.c | 10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4c14aa1b9152..237880f0d406 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2076,6 +2076,7 @@ static int ext4_writepage(struct page *page,
 		return -ENOMEM;
 	}
 	ret = ext4_bio_write_page(&io_submit, page, len);
+	unlock_page(page);
 	ext4_io_submit(&io_submit);
 	/* Drop io_end reference we got from init */
 	ext4_put_io_end_defer(io_submit.io_end);
@@ -2110,6 +2111,7 @@ static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
 	else
 		len = PAGE_SIZE;
 	err = ext4_bio_write_page(&mpd->io_submit, page, len);
+	unlock_page(page);
 	if (!err)
 		mpd->wbc->nr_to_write--;
 	mpd->first_page++;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index beaec6d81074..3bc7c7c5b99d 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -500,7 +500,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 
 	/* Nothing to submit? Just unlock the page... */
 	if (!nr_to_submit)
-		goto unlock;
+		return 0;
 
 	bh = head = page_buffers(page);
 
@@ -548,7 +548,8 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 				}
 				bh = bh->b_this_page;
 			} while (bh != head);
-			goto unlock;
+
+			return ret;
 		}
 	}
 
@@ -564,7 +565,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		io_submit_add_bh(io, inode,
 				 bounce_page ? bounce_page : page, bh);
 	} while ((bh = bh->b_this_page) != head);
-unlock:
-	unlock_page(page);
-	return ret;
+
+	return 0;
 }
-- 
2.35.3

