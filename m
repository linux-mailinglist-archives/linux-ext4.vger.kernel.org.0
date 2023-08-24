Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3D787911
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbjHXUGH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 16:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbjHXUGC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 16:06:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30AE4E
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 13:05:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F2CB21980;
        Thu, 24 Aug 2023 20:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692907556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75FJFmYab97pES7cYCbqQV6omLJTiv2CbKDErVl1Ukw=;
        b=nBcXyYAmn1T8YNioYaicqQfM2Ys8AtBos3O54KpvNgxuK6SD1x2LUhNUn3TsBGAj4veQ1N
        8V2h8rVLAxwZ0fjTjwcIsiTMnUSPlXxcrxOVz7lPClix1Mm63HCktGMYNtfsjMPM8Oi3fi
        jnUCPMcGuRBd3X+sbnDtAkGWhLXDYHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692907556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75FJFmYab97pES7cYCbqQV6omLJTiv2CbKDErVl1Ukw=;
        b=i5Jj0OgZi8Spja1MPlNdSp89rymr4kIDjNIIO5bBR4aRe/C6BUxSqLuuTrNijw5a42LYcg
        XEsU/1w6ssD1YSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A8C81336F;
        Thu, 24 Aug 2023 20:05:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XXvGESS452RgOAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Aug 2023 20:05:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BAD1AA0774; Thu, 24 Aug 2023 22:05:55 +0200 (CEST)
Date:   Thu, 24 Aug 2023 22:05:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Sven =?utf-8?Q?Z=C3=BChlsdorf?= <sven.zuehlsdorf@vigem.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: [BUG+PATCH] mke2fs: Inode checksum does not match inode while
 creating orphan file
Message-ID: <20230824200555.wap6k2fd2jazsmwj@quack3>
References: <dd2ed10e-b0c5-bf8e-ee50-bb73a2ccb5a5@vigem.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lb4xj7yvjm2imfbm"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd2ed10e-b0c5-bf8e-ee50-bb73a2ccb5a5@vigem.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--lb4xj7yvjm2imfbm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu 24-08-23 14:29:50, Sven Zühlsdorf wrote:
> Hi,
> 
> using version 1.7.0 (commit 25ad8a43) I encountered a bug in mke2fs, as
> creating new filesystems now fails on some devices:
> > # mke2fs -t ext4 /dev/nvme0n1p2
> > mke2fs 1.47.0 (5-Feb-2023)
> > Discarding device blocks: done
> > Creating filesystem with 4194304 4k blocks and 1048576 inodes
> > Filesystem UUID: d379784e-c92d-431f-b527-c4088299a914
> > Superblock backups stored on blocks:
> > 	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> > 	4096000
> > 
> > Allocating group tables: done
> > Writing inode tables: done
> > Creating journal (32768 blocks): done
> > mke2fs: Inode checksum does not match inode while creating orphan file
> 
> As a workaround, disabling the new orphan_file feature (i.e. `mke2fs -O
> ^orphan_file ...') allows mke2fs to succeed.
> 
> I could trace this to ext2fs_create_orphan_file's call to ext2fs_read_inode
> which reads the inode from disk, disregarding that the inode may have just
> been created and not written to disk yet.
> On devices where discarding produces NULs this isn't an issue, since
> ext2fs_read_inode will read a zeroed-out struct inode and the checksum
> verification function has a special case for the checksum still being zero.
> I assume enabling orphan_file after a file system has been in use for some
> time could run into this bug as well, but I haven't verified that.
> On some of the devices we use, however, discard results in random looking
> data, leading to above checksum failure.
> 
> From other places creating inodes I cobbled together the attached patch,
> allowing mke2fs to succceed; a subsequent forced fsck succeeds with no
> issues as well.

Thanks for the analysis and the fix! It looks good, I've just somewhat
fixed up whitespace (end of lines got somehow garbled for me) and also
removed the pointless inode reading in ext2fs_create_orphan_file(). The
result is attached.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--lb4xj7yvjm2imfbm
Content-Type: text/x-patch; charset=iso-8859-1
Content-Disposition: attachment;
	filename="0001-ext2fs-Fix-initialization-of-orphan-file.patch"
Content-Transfer-Encoding: 8bit

From aafde8a3ce496f06fcb33909631bbe72a5e8d84e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Sven=20Z=C3=BChlsdorf?= <sven.zuehlsdorf@vigem.de>
Date: Thu, 24 Aug 2023 21:56:29 +0200
Subject: [PATCH] ext2fs: Fix initialization of orphan file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On block devices where discard produces random looking data instead of
NULs, creating a file system fails:

mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done
Creating filesystem with 4194304 4k blocks and 1048576 inodes
Filesystem UUID: d379784e-c92d-431f-b527-c4088299a914
Superblock backups stored on blocks:
      32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
      4096000

Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks): done
mke2fs: Inode checksum does not match inode while creating orphan file

This is caused by ext2fs_create_orphan_file's call to
ext2fs_read_inode() which is reading effectively uninitialized data, as
the inode created just above hasn't been written to disk yet.  Devices
where discarding produces NULs are not affected as ext2fs_read_inode()
returns a zeroed-out struct ext2_inode, for which the checksum
calculation has a special case masking this bug.

Make sure the inode is not read when it is not yet written.

Fixes: 1d551c68 ("libext2fs: Support for orphan file feature")
Signed-off-by: Sven Zühlsdorf <sven.zuehlsdorf@vigem.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/ext2fs/orphan.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
index e25f20ca247c..be27a086679b 100644
--- a/lib/ext2fs/orphan.c
+++ b/lib/ext2fs/orphan.c
@@ -134,24 +134,23 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
 			return err;
 		ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
 		ext2fs_mark_ib_dirty(fs);
-	}
-
-	err = ext2fs_read_inode(fs, ino, &inode);
-	if (err)
-		return err;
-	if (EXT2_I_SIZE(&inode)) {
-		err = ext2fs_truncate_orphan_file(fs);
+	} else {
+		err = ext2fs_read_inode(fs, ino, &inode);
 		if (err)
 			return err;
+		if (EXT2_I_SIZE(&inode)) {
+			err = ext2fs_truncate_orphan_file(fs);
+			if (err)
+				return err;
+		}
 	}
 
 	memset(&inode, 0, sizeof(struct ext2_inode));
-	if (ext2fs_has_feature_extents(fs->super)) {
+	if (ext2fs_has_feature_extents(fs->super))
 		inode.i_flags |= EXT4_EXTENTS_FL;
-		err = ext2fs_write_inode(fs, ino, &inode);
-		if (err)
-			return err;
-	}
+	err = ext2fs_write_new_inode(fs, ino, &inode);
+	if (err)
+		return err;
 
 	err = ext2fs_get_mem(fs->blocksize, &buf);
 	if (err)
@@ -194,7 +193,7 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
 			(unsigned long long)fs->blocksize * num_blocks);
 	if (err)
 		goto out;
-	err = ext2fs_write_new_inode(fs, ino, &inode);
+	err = ext2fs_write_inode(fs, ino, &inode);
 	if (err)
 		goto out;
 
-- 
2.35.3


--lb4xj7yvjm2imfbm--
