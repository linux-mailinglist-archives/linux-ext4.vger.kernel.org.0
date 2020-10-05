Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED52831D2
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Oct 2020 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJEIWt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 04:22:49 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:57780 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEIWs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Oct 2020 04:22:48 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 3FC4B3B02D9;
        Mon,  5 Oct 2020 08:15:25 +0000 (UTC)
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id EB8B020012;
        Mon,  5 Oct 2020 08:14:58 +0000 (UTC)
Date:   Mon, 5 Oct 2020 01:14:54 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201005081454.GA493107@localhost>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ran into an ext4 regression when testing upgrades to 5.9-rc kernels:

Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
with intentionally overlapping bitmap blocks.

On an always-read-only filesystem explicitly marked with
EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
point all the block and inode bitmaps to a single block of all 1s,
because a read-only filesystem will never allocate or free any blocks or
inodes.

However, after that commit, the block validity check rejects such
filesystems with -EUCLEAN and "failed to initialize system zone (-117)".
This causes systems that previously worked correctly to fail when
upgrading to v5.9-rc2 or later.

This was obviously a bugfix, and I'm not suggesting that it should be
reverted; it looks like this effectively worked by accident before,
because the block_validity check wasn't fully functional. However, this
does break real systems, and I'd like to get some kind of regression fix
in before 5.9 final if possible. I think it would suffice to make
block_validity default to false if and only if
EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is set.

Does that seem like a reasonable fix?

Here's a quick sketch of a patch, which I've tested and confirmed to
work:

----- 8< -----
Subject: [PATCH] Fix ext4 regression in v5.9-rc2 on ro fs with overlapped bitmaps

Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
with intentionally overlapping bitmap blocks.

On an always-read-only filesystem explicitly marked with
EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
point all the block and inode bitmaps to a single block of all 1s,
because a read-only filesystem will never allocate or free any blocks or
inodes.

However, after that commit, the block validity check rejects such
filesystems with -EUCLEAN and "failed to initialize system zone (-117)".
This causes systems that previously worked correctly to fail when
upgrading to v5.9-rc2 or later.

Fix this by defaulting block_validity to off when
EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is set.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Fixes: e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in ext4_setup_system_zone()")
---
 fs/ext4/ext4.h  | 2 ++
 fs/ext4/super.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 523e00d7b392..7874028fa864 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1834,6 +1834,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_RO_COMPAT_METADATA_CSUM	0x0400
 #define EXT4_FEATURE_RO_COMPAT_READONLY		0x1000
 #define EXT4_FEATURE_RO_COMPAT_PROJECT		0x2000
+#define EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS	0x4000
 #define EXT4_FEATURE_RO_COMPAT_VERITY		0x8000
 
 #define EXT4_FEATURE_INCOMPAT_COMPRESSION	0x0001
@@ -1930,6 +1931,7 @@ EXT4_FEATURE_RO_COMPAT_FUNCS(bigalloc,		BIGALLOC)
 EXT4_FEATURE_RO_COMPAT_FUNCS(metadata_csum,	METADATA_CSUM)
 EXT4_FEATURE_RO_COMPAT_FUNCS(readonly,		READONLY)
 EXT4_FEATURE_RO_COMPAT_FUNCS(project,		PROJECT)
+EXT4_FEATURE_RO_COMPAT_FUNCS(shared_blocks,	SHARED_BLOCKS)
 EXT4_FEATURE_RO_COMPAT_FUNCS(verity,		VERITY)
 
 EXT4_FEATURE_INCOMPAT_FUNCS(compression,	COMPRESSION)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea425b49b345..f57a7e966e44 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3954,7 +3954,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	else
 		set_opt(sb, ERRORS_RO);
 	/* block_validity enabled by default; disable with noblock_validity */
-	set_opt(sb, BLOCK_VALIDITY);
+	if (!ext4_has_feature_shared_blocks(sb))
+		set_opt(sb, BLOCK_VALIDITY);
 	if (def_mount_opts & EXT4_DEFM_DISCARD)
 		set_opt(sb, DISCARD);
 
