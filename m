Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4024B6678DE
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jan 2023 16:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjALPQ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Jan 2023 10:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbjALPPx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Jan 2023 10:15:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3103C3B0
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jan 2023 07:07:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AA7C5BDEB;
        Thu, 12 Jan 2023 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673536030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDIhu2UFwggw6sF5PHJ6YDLluzfTvRiWRT64c684BLA=;
        b=dZGPdIycJry6lLSbcTrjv2D8DVqDG10tM4m1y2x8bwyhOfeo1iA5i7ncrdYh3Yf7XpIfv3
        xAxr2T3dcXqZfH/ZxBeg4W2OztLpYaJX596kgnuJQp6kbIyMRHziGqInrLG4JuNlQQBbTV
        u8lOmbNgsb6Fv2nISUJhlLJdxuFTMZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673536030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDIhu2UFwggw6sF5PHJ6YDLluzfTvRiWRT64c684BLA=;
        b=PkGEiLGQqHQl0FaHtyR9u2UlsBeHg/ftfTy5WoegTB0Ze2pOkB8XQS8c2c9NyaM+dSdspZ
        nfDcEN8XUfMZfKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DB3E13776;
        Thu, 12 Jan 2023 15:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P465Gh4iwGOLGwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 12 Jan 2023 15:07:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EFCECA0744; Thu, 12 Jan 2023 16:07:08 +0100 (CET)
Date:   Thu, 12 Jan 2023 16:07:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ivan Zahariev <famzah@icdsoft.com>, linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <20230112150708.y2ws5q3wu2xxow3p@quack3>
References: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
 <Y45eV/nA2tj8C94W@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bpzfpcwgeemreocg"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y45eV/nA2tj8C94W@mit.edu>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--bpzfpcwgeemreocg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon 05-12-22 16:10:47, Theodore Ts'o wrote:
> On Wed, Nov 23, 2022 at 04:48:01PM +0200, Ivan Zahariev wrote:
> > Hello,
> > 
> > Starting with kernel 5.15 for the past eight months we have a total of 12
> > kernel panics at a fleet of 1000 KVM/Qemu machines which look the following
> > way:
> > 
> >     kernel BUG at fs/ext4/inode.c:1914
> > 
> > Switching from kernel 4.14 to 5.15 almost immediately triggered the problem.
> > Therefore we are very confident that userland activity is more or less the
> > same and is not the root cause. The kernel function which triggers the BUG
> > is __ext4_journalled_writepage(). In 5.15 the code for
> > __ext4_journalled_writepage() in "fs/ext4/inode.c" is the same as the
> > current kernel "master". The line where the BUG is triggered is:
> > 
> >     struct buffer_head *page_bufs = page_buffers(page)
> 	...
> > 
> > Back to the problem! 99% of the difference between 4.14 and the latest
> > kernel for __ext4_journalled_writepage() in "fs/ext4/inode.c" comes from the
> > following commit: https://github.com/torvalds/linux/commit/5c48a7df91499e371ef725895b2e2d21a126e227
> > 
> > Is it safe that we revert this patch on the latest 5.15 kernel, so that we
> > can confirm if this resolves the issue for us?
> 
> No, it's not safe to revert this patch; this fixes a potential
> use-after-free bug identified by Syzkaller (and use-after-frees can
> sometimes be leveraged into security volunerabilities.
> 
> I have not tested this change yet, but looking at the code and the
> change made in patch yet, this *might* be a possible fix:
> 
> 	size = i_size_read(inode);
> -	if (page->mapping != mapping || page_offset(page) > size) {
> +	if (page->mapping != mapping || page_offset(page) >= size) {
> 		/* The page got truncated from under us */
> 		ext4_journal_stop(handle);
> 		ret = 0;
> 		goto out;
> 	}
> 
> Is it fair to say that your workload is using data=journaled and is
> frequently truncating that might have been recently modified (hence
> triggering the race between truncate and journalled writepages)?
> 
> I wonder if you could come up with a more reliable reproducer so we
> can test a particular patch.

So after a bit of thought I agree that the commit 5c48a7df91499 ("ext4: fix
an use-after-free issue about data=journal writeback mode") is broken. The
problem is when we unlock the page in __ext4_journalled_writepage() anybody
else can come, writeout the page, and reclaim page buffers (due to memory
pressure). Previously, bh references were preventing the buffer reclaim to
happen but now there's nothing to prevent it.

My rewrite of data=journal writeback path fixes this problem as a
side-effect but perhaps we need a quickfix for stable kernels? Something
like attached patch?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--bpzfpcwgeemreocg
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-Fix-crash-in-__ext4_journalled_writepage.patch"

From 17ec3d08a7878625c08ab37c45a8dc3c619db7fb Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 12 Jan 2023 14:46:12 +0100
Subject: [PATCH] ext4: Fix crash in __ext4_journalled_writepage()

When __ext4_journalled_writepage() unlocks the page, there's nothing
that prevents another process from finding the page and reclaiming
buffers from it (because we have cleaned the page dirty bit and buffers
needn't have the dirty bit set). When that happens we crash in
__ext4_journalled_writepage() when trying to get the page buffers. Fix
the problem by redirtying the page before unlocking it (so that reclaim
and other users know the page isn't written yet) and by checking the
page is still dirty after reacquiring the page lock. This should also
make sure the page still has buffers.

Fixes: 5c48a7df9149 ("ext4: fix an use-after-free issue about data=journal writeback mode")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d9f414f99fe..9c8866777430 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -136,7 +136,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 						   new_size);
 }
 
-static int __ext4_journalled_writepage(struct page *page, unsigned int len);
 static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 
@@ -1887,8 +1886,8 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static int __ext4_journalled_writepage(struct page *page,
-				       unsigned int len)
+static int __ext4_journalled_writepage(struct writeback_control *wbc,
+				       struct page *page, unsigned int len)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
@@ -1898,8 +1897,6 @@ static int __ext4_journalled_writepage(struct page *page,
 	struct buffer_head *inode_bh = NULL;
 	loff_t size;
 
-	ClearPageChecked(page);
-
 	if (inline_data) {
 		BUG_ON(page->index != 0);
 		BUG_ON(len > ext4_get_max_inline_size(inode));
@@ -1913,6 +1910,7 @@ static int __ext4_journalled_writepage(struct page *page,
 	 * out from under us.
 	 */
 	get_page(page);
+	redirty_page_for_writepage(wbc, page);
 	unlock_page(page);
 
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
@@ -1926,8 +1924,10 @@ static int __ext4_journalled_writepage(struct page *page,
 
 	lock_page(page);
 	put_page(page);
+	ClearPageChecked(page);
 	size = i_size_read(inode);
-	if (page->mapping != mapping || page_offset(page) > size) {
+	if (page->mapping != mapping || page_offset(page) >= size ||
+	    !clear_page_dirty_for_io(page)) {
 		/* The page got truncated from under us */
 		ext4_journal_stop(handle);
 		ret = 0;
@@ -2083,7 +2083,7 @@ static int ext4_writepage(struct page *page,
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
 		 * doesn't seem much point in redirtying the page here.
 		 */
-		return __ext4_journalled_writepage(page, len);
+		return __ext4_journalled_writepage(wbc, page, len);
 
 	ext4_io_submit_init(&io_submit, wbc);
 	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);
-- 
2.35.3


--bpzfpcwgeemreocg--
