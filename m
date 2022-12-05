Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9792B64287B
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiLEM3l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiLEM3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28FA17403
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:31 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29B2521E29;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpQ5pqECC7zfStAichmjNg9JJ5GpSKtsoF3bdTjzvm0=;
        b=ivwJZwumwczJVtNUbt2afLLxe0C1G8BxYHsAkZCT4aby9gGytLte3N7oxhWnu41O0xfOeD
        kRZv2kXvN9yXmUWFcYshEG0zV8FC21u2d07Ab3p4R6nwJVIhBjsq6QHy4mlu0DW+x3Oywm
        2GbpmVOTrJNV6OixVWdhZGYx1JFfxX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpQ5pqECC7zfStAichmjNg9JJ5GpSKtsoF3bdTjzvm0=;
        b=MzI+h1nBTGfkvtgumRe6Vr4D44t2wTyrUI7NAOgOg51wb2ktgCVSAYi2PMNyO0xsrwCitr
        KBcu0k2UvZu+i5Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 12097136A0;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id VVpWBCrkjWMdTgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 650E0A0733; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 07/12] ext4: Move percpu_rwsem protection into ext4_writepages()
Date:   Mon,  5 Dec 2022 13:29:21 +0100
Message-Id: <20221205122928.21959-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=jack@suse.cz; h=from:subject; bh=j0DgcX6U83KV++ws+PacqXTcQBSes8Qh1QV7iXDVXAo=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJJ7nyiaiZyerLRHyUvZec5PkbDXyoneX2p1FzxIvOZmFn2l Kjuyk9GYhYGRg0FWTJFldeRF7WvzjLq2hmrIwAxiZQKZwsDFKQAT8WHnYOhf9LXgnrwhY2P+r8W/6k PsmtuzvjWcWbHs75Q2T0uGKj6Rr3P5TnxmkrpesXfqF/akkzPagOKr5KskCnsPsJ/dfP304W3NmjV8 csICvWECPAlV9loZkz9O1RJ7n7R/h8xTBZuvnz/ahgqw/ppfy2OzZ1ui91c3dt1LHz/6RZnM2ri8MO OC2dTWbCeejyc4FioKdyy43vRs69IVibxFZzdWhVZkts8UOmzZ9sj1teqWMumfU887tfwXNwpqkk5l vi1QXs5ix6I0j0vh3n/Dk/eFDsxnsdO3+Wlufkb02om+5zeu3JfdmrLiAcNEPnn57Rq9z7TeslV5GH JqVZS/cJyg8u+42lJBN8bbws8B
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Move protection by percpu_rwsem from ext4_do_writepages() to
ext4_writepages(). We will not want to grab this protection during
transaction commits as that would be prone to deadlocks and the
protection is not needed. Move the shutdown state checking as well since
we want to be able to complete commit while the shutdown is in progress.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 99c66c768cd0..4f8f4959524c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2720,10 +2720,6 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	struct blk_plug plug;
 	bool give_up_on_write = false;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
-		return -EIO;
-
-	percpu_down_read(&sbi->s_writepages_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	/*
@@ -2933,20 +2929,28 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
 
 static int ext4_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
+	struct super_block *sb = mapping->host->i_sb;
 	struct mpage_da_data mpd = {
 		.inode = mapping->host,
 		.wbc = wbc,
 		.can_map = 1,
 	};
+	int ret;
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
+		return -EIO;
 
-	return ext4_do_writepages(&mpd);
+	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	ret = ext4_do_writepages(&mpd);
+	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+
+	return ret;
 }
 
 static int ext4_dax_writepages(struct address_space *mapping,
-- 
2.35.3

