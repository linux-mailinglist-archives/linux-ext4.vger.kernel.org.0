Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7EA640D98
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 19:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiLBSlv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 13:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiLBSl2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 13:41:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA79ECA38
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 10:39:46 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F077A21C5F;
        Fri,  2 Dec 2022 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670006383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SspSDwMGFZp9+GJ+PU3NYdlATxL+/ipt2vwb+KRN47A=;
        b=GxZPuyxKr0zwFKXG0lPZ3yI7fM13+s0QrW4Gpz1yJ7OOmzt111nWuv8LmGXPEsGe+urABJ
        YsNIK9NIX4J7fJdrkbKvB4LxzO+u7a3QjO8M/fJf5mXLiDRjgRBZC5l9blQ2VKZp/d3lo3
        qnEkzQVzeh0p/Po0o4A7vX8gEv6UALU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670006383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SspSDwMGFZp9+GJ+PU3NYdlATxL+/ipt2vwb+KRN47A=;
        b=hkI2Y69bmfrqZuJ5GroT54idxC+uUiAO9hNLtFVNMGpo7x3t/5URKsVb4WIAq87ebaHkc/
        XAqALRcgzZ/Sw0Bw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D8AF31369C;
        Fri,  2 Dec 2022 18:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YGtaNG9GimOnZAAAGKfGzw
        (envelope-from <jack@suse.cz>); Fri, 02 Dec 2022 18:39:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5A5C0A0718; Fri,  2 Dec 2022 19:39:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 3/11] ext4: Remove nr_submitted from ext4_bio_write_page()
Date:   Fri,  2 Dec 2022 19:39:28 +0100
Message-Id: <20221202183943.22640-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=jack@suse.cz; h=from:subject; bh=I5XprGJYSB7wwryMlAaQFsXgSNmw077f9dlaAyrTx/Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjikZgr6nZ8gs2KCn0FvEszZZFlWtjWSqW9iStEO3c uQ5MZciJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4pGYAAKCRCcnaoHP2RA2YggCA CdpJHPKnoOT9cn9ySU1Jzydje48Jvw5aG8WP2Unnv8nmGVMwXpEmfqRKs727CgqnnIce1QdhXMUcPL dSHsM3E9oIPkHt0yOHlE1MiURXH+W4lIyp4fkzNtmC7HCkMuOjqkTqmWAXjSZgTTk2JAo+s+v/oBfr 7Z1Q5cM6XUPg18WE7529ndVEjkf5uhEkG6Fl5wrV+hYnyGz6/1iqbM+5AuQshq4mTbyoCvpdCfK39/ 44RlRWPYcwRpfqO8HE0Bazkh24xUo3KPVjWlSGfkWN2ADT7/DMTot2K1DKGF/OBu1/Kyi9ojtF8xIm mjExX/4YxXnbHhTe+nAzDjukXQCO5z
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

