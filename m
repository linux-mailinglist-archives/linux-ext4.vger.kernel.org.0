Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6138E642878
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiLEM3h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiLEM3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE80517065
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:30 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 573E21FEAB;
        Mon,  5 Dec 2022 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SspSDwMGFZp9+GJ+PU3NYdlATxL+/ipt2vwb+KRN47A=;
        b=JJ9ZVQmF3Vpv4VJ/Cu+GQDv0bHAinKmWOkMr7WnVhAzHefG4ZI3MErivM5QQNWtDn25XRV
        2SATfaIkfvX3TgTGTliPm+QijAlvAptKJNUmuRm6of8YDOuQGw+h/pXk/rphocSbTdxyMF
        uFkTDtkxf/y9ZuRFXFsZy6aucjLHz4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SspSDwMGFZp9+GJ+PU3NYdlATxL+/ipt2vwb+KRN47A=;
        b=qu2t/IpS3lHmzQEwQ45wuY4jOvo4lYq47vdsYPPj4E8x+AytortAgXyTgoPSBSLkf+rOTB
        cwayrK3fhgvgyZBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3891613722;
        Mon,  5 Dec 2022 12:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Cj7MDSnkjWMFTgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4F180A072B; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 03/12] ext4: Remove nr_submitted from ext4_bio_write_page()
Date:   Mon,  5 Dec 2022 13:29:17 +0100
Message-Id: <20221205122928.21959-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=jack@suse.cz; h=from:subject; bh=I5XprGJYSB7wwryMlAaQFsXgSNmw077f9dlaAyrTx/Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjjeQdr6nZ8gs2KCn0FvEszZZFlWtjWSqW9iStEO3c uQ5MZciJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY43kHQAKCRCcnaoHP2RA2cR3B/ 9TvJFshuVpMi8jR4gCtpWqcHhu6j8XmW80odv3GKXr2P2wj1ub3C0sl/ewONr456j8fArm/Ka5YdJl izEznshcM8c3T9sQnwGg4OFF1c2VgcqSJfjKvDaumIJffkkL9EpN+5qKwlX3uEIh/g3ul5FOMb+PXL x7Q8ykmUoUZGsfCqfJ3CKoCyfZ19u3mfbUAIRq5qF3PWpn0DYox8wgmtzcEYnPNxtx7jexcTwPmJhw rtanGwZSSSP11PSPu7nlipLlyUj+oIAT7t4B55Y9fOJLVEga+JJSEZA4PDpzN9DxAWAJYrtCg2e5Ud XUpW9zmmestLFc6QN7gCUZSgmizv3a
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

