Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5B640D96
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 19:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiLBSls (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 13:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiLBSl2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 13:41:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F504ECA3E
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 10:39:46 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EF9B1FE29;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670006384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hm18Hv66/6zMpvRmwPHrXX9dNDNdkr7Y664OKatfKWs=;
        b=eStTUIYpcCWDruvAkeNX2zEh8sTIb6a4XLsT+aiUmAJrCzv7zpKxSPQcmXPXsV4dv6hInG
        J2IFtM4Cl0FA5a/3S9zR/ZutEr6gA2ZfJGFdE+pTD94QIYXtU9Wue2ihbkYQktMYxvNADx
        pMvqq9ioHpBdj+feve1zVtso1DnfbEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670006384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hm18Hv66/6zMpvRmwPHrXX9dNDNdkr7Y664OKatfKWs=;
        b=sQJFOuz2l1j/7vwZFCmMHAmtOZF5PJ8wB9OYnRZbQQTyFNSx3UvDU/d+lgoVGIRyRKLTDd
        5xrlIGU4FVQo9GDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 522781369C;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IkEMFHBGimPBZAAAGKfGzw
        (envelope-from <jack@suse.cz>); Fri, 02 Dec 2022 18:39:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6FEB3A0722; Fri,  2 Dec 2022 19:39:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 7/11] ext4: Move percpu_rwsem protection into ext4_writepages()
Date:   Fri,  2 Dec 2022 19:39:32 +0100
Message-Id: <20221202183943.22640-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=jack@suse.cz; h=from:subject; bh=eBah4jPa0Fg4SJDGmkrb1bT63ZMOr4rT65nithd3DCY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjikZjkgfc7Uk6AE+u1x+D2nW8GYsuNiJEONprG+Az GnQGcHGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4pGYwAKCRCcnaoHP2RA2Z3XCA Ck5jqzgUU8caa7knODuv6uKWYP3ts62mXFOsHoVDRlcv+4sk8wNrg5nLuD8YbpexKCDmGlTJNP1AXG /G8LYBh6QThg+BgXR7FnOU/lJq19R93FaVbGZcgxEC3NnSb5VESxcIda9Iv6jzOf8BeosVL1YnUzY4 lGSfLYKDR26AxY0qQsUoygxAJMtG+7KB4W53KuCZ26ooeEk2DUoaA3zJ1VQWzJoO8S1a3Sjo2JsL8E 3NRbB+vm3kmwbgus2B/cBCm3NmdQYnEuF87GuexHQ+BWbGN0XDDuw9U5gOJTH8KlOq6sCrIvjtgdCZ 3i81C2wrU6dIU20OR0a7oGZos0x2MA
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
index fa145c6b2630..aeef57d907c6 100644
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
@@ -2932,20 +2928,28 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
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

