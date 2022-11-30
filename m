Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4763DAC2
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 17:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiK3QgO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 11:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiK3QgL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 11:36:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE5B880CD
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 08:36:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5658D21B0F;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669826169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOQ5HoblPqosB8zrnSf2078lBm3W+qPH5DFGPvE1wao=;
        b=qqLn1rG0NRLGP/uSz8WR0U/U6PfDd8J7RL7WAlNzMJ6i68sOExojzBClkyAV2b/GhQfOOH
        tCRYuUV2jpzF4fTIgtOlzfVEmTz1dOtNmj8TCignuENZ5vF0srHlU0saiJDBYbCMWrB92k
        8TE4Iah50WpNZESusISP6vMCaseE5T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669826169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOQ5HoblPqosB8zrnSf2078lBm3W+qPH5DFGPvE1wao=;
        b=A+4U2iiX3iA9znw37Wdk0a0mstyYVAm4StiFNyvD1IutRCjAHKUAqrXpjK5cA4T8UX0MjL
        Oy3xnlTBuclMKiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AD2013AFB;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RYdKEnmGh2NPQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B2D1AA0716; Wed, 30 Nov 2022 17:36:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/9] ext4: Remove nr_submitted from ext4_bio_write_page()
Date:   Wed, 30 Nov 2022 17:35:54 +0100
Message-Id: <20221130163608.29034-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221130162435.2324-1-jack@suse.cz>
References: <20221130162435.2324-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=jack@suse.cz; h=from:subject; bh=4sUllFtC2A2WUXnDM1O6OgCojKGDPWdm3SmOUTjowkU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjh4Zq+5GbJP2Li05PvA8gb+FiSZ9JCi5skOoAxNjN XBDlVvaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4eGagAKCRCcnaoHP2RA2cRrCA DAjWrq9BCi8bsnWE77YJb/b3PwEfW60+GP70rv78H/XpmS3fb1dlMZY4E4oEoU7souGp0+XnaJHXE0 XX+YHV0D9JMTifowOQ87xlTqFrv5nEfGKJcpo8Pvtgw36RwkA4mYk0JJ2XMEJtkSwC1rpkvVXhyCpm ZjGjrgthbVzS88IK6NPMWAwGtj5Lek3qbhowdL2iz9lPNd8sFc++d4bYAzhjXOEBC8HqkCko95zUsQ /EVG7Qn++0S1T418cmRNPTnFFZXaPOjSi1j06kLkdpctO+Zw8vEBHZu8rJ8EAzX5eSpdO9XzRrTV5r kx0tbxge1DnufN0+B0ZKdUjw/tl2Tr
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

nr_submitted is the same as nr_to_submit. Drop one of them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/page-io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 4f9ecacd10aa..2bdfb8a046d9 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -437,7 +437,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	unsigned block_start;
 	struct buffer_head *bh, *head;
 	int ret = 0;
-	int nr_submitted = 0;
 	int nr_to_submit = 0;
 	struct writeback_control *wbc = io->io_wbc;
 	bool keep_towrite = false;
@@ -566,7 +565,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			continue;
 		io_submit_add_bh(io, inode,
 				 bounce_page ? bounce_page : page, bh);
-		nr_submitted++;
 	} while ((bh = bh->b_this_page) != head);
 unlock:
 	unlock_page(page);
-- 
2.35.3

