Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F105C3F745B
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhHYLbD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 07:31:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36736 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhHYLbC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 07:31:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A43E3200F4;
        Wed, 25 Aug 2021 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629891016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6gmlInowAjClrbWyxUK9Cf+moew8eFKOmRP7UR9Er7Y=;
        b=MjRofZmmlCL9c2dszzGs/Wf9/pdDX7fu07kcNYdJMtQQhdALv+/1TTcXw+gSshq+JpV6bv
        cDrC9iGV/TU/zQZqKSG7WunpISLOpXh/cvc52AQdrmdcmenIxAOYgZ3ydFxNhD/4R2GOM4
        WtmRnlKZv9r9zaLuYUoG5Y6ALqiBVNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629891016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6gmlInowAjClrbWyxUK9Cf+moew8eFKOmRP7UR9Er7Y=;
        b=G7WTUc9j6we01DBPlo0rcfV/3MVWLKbsLW75RThdm0EjrNdrpCkk5Mpt9uODZb5sxwARfC
        WZh5mkpUtzvBMxDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 9860BA3B96;
        Wed, 25 Aug 2021 11:30:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 725B01F2BA4; Wed, 25 Aug 2021 13:30:16 +0200 (CEST)
Date:   Wed, 25 Aug 2021 13:30:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/5 v7] ext4: Speedup orphan file handling
Message-ID: <20210825113016.GB14620@quack2.suse.cz>
References: <20210816093626.18767-1-jack@suse.cz>
 <YSUo4TBKjcdX7N/q@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <YSUo4TBKjcdX7N/q@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 24-08-21 13:14:09, Theodore Ts'o wrote:
> I've been running some tests exercising the orphan_file code, and
> there are a number of failures:
> 
> ext4/orphan_file: 512 tests, 3 failures, 25 skipped, 7325 seconds
>   Failures: ext4/044 generic/475 generic/643
> ext4/orphan_file_1k: 524 tests, 6 failures, 37 skipped, 8361 seconds
>   Failures: ext4/033 ext4/044 ext4/045 generic/273 generic/476 generic/643
> 
> generic/643 is the iomap swap failure, and can be ignored.
> generic/475 is a pre-existing test flake that involves simulated disk
> failures, which we can also ignore in the context or orphan_file.
> 
> However, ext4/044 is one that looks... interesting:
> 
> root@kvm-xfstests:~# e2fsck -fn /dev/vdc
> e2fsck 1.46.4-orphan-file (22-Aug-2021)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> Orphan file (inode 12) block 0 is not clean.
> Clear? no
> 
> Failed to initialize orphan file.
> Recreate? no
> 
> This is highly reproducible, and involves using a file system config
> that is probably a little unusual:
> 
> Filesystem features:      has_journal ext_attr resize_inode dir_index orphan_file filetype sparse_super large_file
> 
> (This was created using "mke2fs -t ext3 -O orphan_file".)

Interesting. I don't see how orphan handling code gets used at all for this
test. Hrm. Actually it seems to be a bug in the tools themselves because
just "mke2fs -t ext3 -O orphan_file" and "e2fsck -f" reproduces exactly
this failure. It seems that when I was adding physical block number to
orphan file block checksum, I've broken e2fsck for the situation when
metadata_csum is disabled. I've fixed the bug now (relative diff attached,
I can resend the full series once the other bugs are dealt with as well).

> The orphan_file_1k failures seem to involve running out of space in
> the orphan_file, and the fallback to using the old fashioned orphan
> list seems to return ENOSPC?  For example, from ext4/045:
> 
>     +mkdir: No space left on device
>     +Failed to create directories - 19679
> 
> ext4/045 creates a lot of directories when calls mkdir (ext4/045 tests
> creating more than 65000 subdirectories in a directory), and so this
> seems to be triggering a failure?

Strange. I don't see how ext4/045 load could run out of space in the orphan
file (and in fact I did test that the fallback when we run out of space in
the orphan file works correctly). Anyway, I'll look into it. Thanks for the
reports!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--4Ckj6UjgE2iN1+kY
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="e2fsck-fixup.patch"

diff --git a/e2fsck/super.c b/e2fsck/super.c
index 6964e2ddae39..d1da2c16bb02 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -578,11 +578,9 @@ static int reinit_orphan_block(ext2_filsys fs,
 	e2fsck_t 		ctx;
 	blk64_t			blk = *block_nr;
 	struct problem_context	pctx;
-	struct ext4_orphan_block_tail *tail;
 
 	pd = priv_data;
 	ctx = pd->ctx;
-	tail = ext2fs_orphan_block_tail(fs, pd->buf);
 
 	/* Orphan file must not have holes */
 	if (!blk) {
@@ -597,12 +595,18 @@ return_abort:
 		pd->abort = 1;
 		return BLOCK_ABORT;
 	}
-	/*
-	 * Update checksum to match expected buffer contents with appropriate
-	 * block number.
-	 */
-	tail->ob_checksum = ext2fs_do_orphan_file_block_csum(fs, pd->ino,
-						pd->generation, blk, pd->buf);
+
+	if (ext2fs_has_feature_metadata_csum(fs->super)) {
+		struct ext4_orphan_block_tail *tail;
+
+		tail = ext2fs_orphan_block_tail(fs, pd->buf);
+		/*
+		 * Update checksum to match expected buffer contents with
+		 * appropriate block number.
+		 */
+		tail->ob_checksum = ext2fs_do_orphan_file_block_csum(fs,
+				pd->ino, pd->generation, blk, pd->buf);
+	}
 	if (!pd->clear) {
 		pd->errcode = io_channel_read_blk64(fs->io, blk, 1,
 						    pd->block_buf);

--4Ckj6UjgE2iN1+kY--
