Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F496CED63
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjC2PuC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjC2Pt7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:49:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FDC4C08
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:49:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1069F1FE03;
        Wed, 29 Mar 2023 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680104996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sS9p0wTn0AoAZRi96rQ6edud8lnjeVCzVSBAhQzhINs=;
        b=z+LUcSZOVVbk8FHbB8Mwj2rSyPqTnWu+XuzghD+8bHbMgY2KI70kUBoI4YVrFIku5YrTxd
        zzK1u0T6x002kNDIrvpv2Nr8Quk9bgYPlj11h7V9pBVDq9PwFaZ6nNPvVy8WvfH3OvU3GN
        81VhtzPyj6BvNXJrFTb55C7YeptNSQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680104996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sS9p0wTn0AoAZRi96rQ6edud8lnjeVCzVSBAhQzhINs=;
        b=300HqkwMos++CK20qtzKHaSIyBI+VwNviZjA19sHS+l94OLfEHVor1fQi0YFnCpQpm9i/j
        c7cZvz+ZgWGE0/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9DEB13A2A;
        Wed, 29 Mar 2023 15:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mdA/MCJeJGQ0YwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:49:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3A155A0732; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/13] ext4: Keep pages with journalled data dirty
Date:   Wed, 29 Mar 2023 17:49:34 +0200
Message-Id: <20230329154950.19720-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; i=jack@suse.cz; h=from:subject; bh=NCZFkjD32UzTWBtRMdaeQU7M3ZxU0fdoytjyRJrOw0Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4OHAYdNyIMlrD8joPFjhGDdnRsPCvlTMokP4Qe DUmaWNuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReDgAKCRCcnaoHP2RA2bmCB/ wLmTi394VTYI7YpupUkAOeopQKgNs7tvMzwqqXrp9fibcVCf6p4HreOAz8SkSQXzuVKmi+2uu1VQRj K5tiVSrtv8OLxzSsHW/7MdS66dF/NNvI/HqTAlgJ2zM8vg6wAFpJC8rTjJDTaDmdNPhpXryA6bdQDS bqRQO2vWKTU8L4+biv377/I1yymp4bFSZK4RqUWlOwhgUM7He3ujonP6blyTmmcdh0XUb8PaiTIXD+ rnTlb0pU3VbHO15Vq5mwWr5NN1EEOJL0QIFR3xJZby0CdPVHS75pwBM3GHKotQxR2tPaVTr1vJX0yD YcwNbqWmrCjP8Dw+6U6PD7qcHVI+Pm
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently we clear page dirty bit when we checkpoint some buffers from a
page with journalled data or when we perform delayed dirtying of a page
in ext4_writepages(). In a quest to simplify handling of journalled data
we want to keep page dirty as long as it has either buffers to
checkpoint or journalled dirty data. So make sure to keep page dirty in
ext4_writepages() if it still has journalled data attached to it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c   | 1 -
 fs/ext4/page-io.c | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 73e24e61fdd2..78e29da70af7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2387,7 +2387,6 @@ static int mpage_journal_page_buffers(handle_t *handle,
 	int len;
 
 	ClearPageChecked(page);
-	clear_page_dirty_for_io(page);
 	mpd->wbc->nr_to_write--;
 
 	if (page->index == size >> PAGE_SHIFT &&
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 8703fd732abb..23b29a50b159 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -484,9 +484,11 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			 * to redirty the page and keep TOWRITE tag so that
 			 * racing WB_SYNC_ALL writeback does not skip the page.
 			 * This happens e.g. when doing writeout for
-			 * transaction commit.
+			 * transaction commit or when journalled data is not
+			 * yet committed.
 			 */
-			if (buffer_dirty(bh)) {
+			if (buffer_dirty(bh) ||
+			    (buffer_jbd(bh) && buffer_jbddirty(bh))) {
 				if (!PageDirty(page))
 					redirty_page_for_writepage(wbc, page);
 				keep_towrite = true;
-- 
2.35.3

