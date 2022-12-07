Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE76458F3
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLGL11 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLGL10 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55BCB485
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:24 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 692D721C9F;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SspSDwMGFZp9+GJ+PU3NYdlATxL+/ipt2vwb+KRN47A=;
        b=LDv3E6FOUqRsiiLjCxHUTevdhPzoKhZC6OvXYAJsy7qpbpr5pb0kKK9YlpxxTVDIBdAbYx
        Z3q2hSZtDrQJj6I1phLlLhBzVF/+7sIgmNFc4Thl3MZJsMr8+8DSLDulZv3VsaB3iz5103
        Zb9iWOthay98TvoLhhn3dxG2/3OKI/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SspSDwMGFZp9+GJ+PU3NYdlATxL+/ipt2vwb+KRN47A=;
        b=tsS81PM7CbnlohVt5DSSQMSeU8TW260x1l9S2CnezVZBppNi2EaMTwcNe6KAxZXhN/eTQN
        xAXCoFckk5WOXCAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5DE231373B;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FpMSFpt4kGM0LAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D90DFA0729; Wed,  7 Dec 2022 12:27:22 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 03/13] ext4: Remove nr_submitted from ext4_bio_write_page()
Date:   Wed,  7 Dec 2022 12:27:06 +0100
Message-Id: <20221207112722.22220-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=jack@suse.cz; h=from:subject; bh=I5XprGJYSB7wwryMlAaQFsXgSNmw077f9dlaAyrTx/Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiKr6nZ8gs2KCn0FvEszZZFlWtjWSqW9iStEO3c uQ5MZciJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4igAKCRCcnaoHP2RA2XvyB/ 9k0FIiXmHeBsa77HQgQ7BmUB2C+AVS10nuXAf/33PDjy5LjiXTwH23L50SDZiXZjBwwLkGq/VjCE4a Pb8utlK1fD4nrabtc14Yy+c34sn+ru+X28OU6uCCot/RvKQ2UVkeNB5khZ9GypBN7j3pyFRfzxkIaH DS8wLB8Es0ne2n08y4BwvbFMbTHBlqDhdVYFlWXrvurngZByY/iq9waecJEnjO6xeHYPZBxD80lalG NDuIH2PnuxiMFLFnAxvOe+JLRujW8YWIBfQJTupV5IjLsmiqa5JIFH2UfataWnBSQpqTVzrIXKH8Sv lNIpEvuFsu+AdSF+7HBbch/f8snx+J
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

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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

