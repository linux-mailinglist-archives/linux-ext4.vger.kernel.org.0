Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3904061091E
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Oct 2022 05:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiJ1D7r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Oct 2022 23:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiJ1D7p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Oct 2022 23:59:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5733E2191;
        Thu, 27 Oct 2022 20:59:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 29S3xG3B011991
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 23:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1666929558; bh=D6n1qJ4LHISPaWhvzP4a8VfLw6tC5tM2tSD7ab37LEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gI48J5zSFKf+VqjM+3o/PzDIn8gHjyxGLM34zwHfFodoRvS4O6U7CjONzWrrBTrWR
         EmYf3OEINVP8SSQV/NA/K9ABBom7ih2Yt4O7vgAiNBdiaV12V2r+XR080azENacClQ
         GqdNfvKtYZ8cJe1kmS+CKFopwHF9ni9b88ks51PAtGgfZjq1RpU1oIgaRXH/rOfM0c
         +joe4kgJTysS6eJIwdsxUbEl2aHYNqBWBbpQXQlwFtwNouGg/16V4zeqfEqdv+jXyL
         4jIr0xEO1BTAb0ScleJlpOH+JaS4yJ5XzoGHq4BihG5k7HGXGTlyCVrynifee20dmm
         IaEz670ZoTMJA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EBCC415C34C3; Thu, 27 Oct 2022 23:59:15 -0400 (EDT)
Date:   Thu, 27 Oct 2022 23:59:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Unterwurzacher, Jakob" <jakob.unterwurzacher@theobroma-systems.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Schulz, Quentin" <quentin.schulz@theobroma-systems.com>
Subject: Re: ext4 online resize -> EXT4-fs error (device loop0) in
 ext4_update_backup_sb:174: Filesystem failed CRC
Message-ID: <Y1tTk5ILKICjJL82@mit.edu>
References: <AM6PR04MB63111922B96138C374A39C68C7309@AM6PR04MB6311.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB63111922B96138C374A39C68C7309@AM6PR04MB6311.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 26, 2022 at 07:49:56PM +0000, Unterwurzacher, Jakob wrote:
> 
> it looks like I am hitting a similar issue as reported by Borislav Petkov
> in April 2022 ( https://lore.kernel.org/lkml/YmqOqGKajOOx90ZY@zn.tnic/ ).
> 
> I'm on kernel 6.0.5 and see this on arm64 as well as x86_64.
> I have a 100% reproducer using a loop mount, here it is:
> 
> 	truncate -s 16g ext4.img
> 	mkfs.ext4 ext4.img 500m
> 	mkdir ext4.mnt
> 	mount ext4.img ext4.mnt
> 	resize2fs ext4.img

Thanks for the reproducer!  The following patch should fix things.

       	       		      		- Ted

From 9a8c5b0d061554fedd7dbe894e63aa34d0bac7c4 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 27 Oct 2022 16:04:36 -0400
Subject: [PATCH] ext4: update the backup superblock's at the end of the online
 resize

When expanding a file system using online resize, various fields in
the superblock (e.g., s_blocks_count, s_inodes_count, etc.) change.
To update the backup superblocks, the online resize uses the function
update_backups() in fs/ext4/resize.c.  This function was not updating
the checksum field in the backup superblocks.  This wasn't a big deal
previously, because e2fsck didn't care about the checksum field in the
backup superblock.  (And indeed, update_backups() goes all the way
back to the ext3 days, well before we had support for metadata
checksums.)

However, there is an alternate, more general way of updating
superblock fields, ext4_update_primary_sb() in fs/ext4/ioctl.c.  This
function does check the checksum of the backup superblock, and if it
doesn't match will mark the file system as corrupted.  That was
clearly not the intent, so avoid to aborting the resize when a bad
superblock is found.

In addition, teach update_backups() to properly update the checksum in
the backup superblocks.  We will eventually want to unify
updapte_backups() with the infrasture in ext4_update_primary_sb(), but
that's for another day.

Note: The problem has been around for a while; it just didn't really
matter until ext4_update_primary_sb() was added by commit bbc605cdb1e1
("ext4: implement support for get/set fs label").  And it became
trivially easy to reproduce after commit 827891a38acc ("ext4: update
the s_overhead_clusters in the backup sb's when resizing") in v6.0.

Cc: stable@kernel.org # 5.17+
Fixes: bbc605cdb1e1 ("ext4: implement support for get/set fs label")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ioctl.c  | 3 +--
 fs/ext4/resize.c | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 4d49c5cfb690..790d5ffe8559 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -145,9 +145,8 @@ static int ext4_update_backup_sb(struct super_block *sb,
 	if (ext4_has_metadata_csum(sb) &&
 	    es->s_checksum != ext4_superblock_csum(sb, es)) {
 		ext4_msg(sb, KERN_ERR, "Invalid checksum for backup "
-		"superblock %llu\n", sb_block);
+		"superblock %llu", sb_block);
 		unlock_buffer(bh);
-		err = -EFSBADCRC;
 		goto out_bh;
 	}
 	func(es, arg);
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 6dfe9ccae0c5..46b87ffeb304 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1158,6 +1158,7 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
 	while (group < sbi->s_groups_count) {
 		struct buffer_head *bh;
 		ext4_fsblk_t backup_block;
+		struct ext4_super_block *es;
 
 		/* Out of journal space, and can't get more - abort - so sad */
 		err = ext4_resize_ensure_credits_batch(handle, 1);
@@ -1186,6 +1187,10 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
 		memcpy(bh->b_data, data, size);
 		if (rest)
 			memset(bh->b_data + size, 0, rest);
+		es = (struct ext4_super_block *) bh->b_data;
+		es->s_block_group_nr = cpu_to_le16(group);
+		if (ext4_has_metadata_csum(sb))
+			es->s_checksum = ext4_superblock_csum(sb, es);
 		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
-- 
2.31.0

