Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC80671241
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 04:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjARD4V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Jan 2023 22:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjARD4H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Jan 2023 22:56:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561153F8E
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 19:56:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DF30B81B0A
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 03:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8E5C433EF;
        Wed, 18 Jan 2023 03:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674014159;
        bh=vYxUizMb9H1F7Me16ZK87gOXwW9rAMjRLXTEupMCato=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXBysA9dGw3YL3zztZrIgDmE/RDEDYcyz2Gj0CZYEVN2hWopLGxXon0t4ibQbqhB2
         EqNbZ+j3UJJT2VvfkQTA0VCVXVz57//EEOuLUrNLHyByiuQDmx3MPp6OTH07efhXBI
         67KhtFN0LNQmZm8EXJBQyp00RroD6xCKK2Vf0/NREp1P0GoNAVOlVf063DL89U3b/c
         1zol1VptsHTriC+gvDSfk9cKYCFf+57Xxtbg8Vr9xz6Ajp39hy1dQnVMCMN1StX5pl
         fB2DN6M0MEdau3edy7G/bxtMboPissu1E7eLD6+OjL01uMkJXc37aFgIub1igKKISn
         dI5YqFzjqs40Q==
Date:   Tue, 17 Jan 2023 19:55:57 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Detecting default signedness of char in ext4 (despite
 -funsigned-char)
Message-ID: <Y8dtze3ZLGaUi8pi@sol.localdomain>
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[Added some Cc's, and updated subject to reflect what this is really about]

On Tue, Jan 17, 2023 at 05:10:55PM -0700, Andreas Dilger wrote:
> On Jan 17, 2023, at 11:31 AM, Eric Whitney <enwlinux@gmail.com> wrote:
> > 
> > My 6.2-rc1 regression run on the current x86-64 test appliance revealed a new
> > failure for generic/454 on the 4k file system configuration and all other
> > configurations using a 4k block size.  This failure reproduces with 100%
> > reliability and continues to appear as of 6.2-rc4.
> > 
> > The test output indicates that the file system under test is inconsistent.
> 
> There is actually support in the superblock for both signed and unsigned char
> hash calculations, exactly because there was a bug like this in the past.
> It looks like the ext4 code/build is still using the signed hash functions:
> 
> 
> static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> {
> 	:
> 	:
>                 if (i & EXT2_FLAGS_UNSIGNED_HASH)
>                         sbi->s_hash_unsigned = 3;
>                 else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
> #ifdef __CHAR_UNSIGNED__
>                         if (!sb_rdonly(sb))
>                                 es->s_flags |=
>                                         cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
>                         sbi->s_hash_unsigned = 3;
> #else
>                         if (!sb_rdonly(sb))
>                                 es->s_flags |=
>                                         cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
> #endif
>                 }
> 
> It looks like this *should* be detecting the unsigned/signed char type
> automatically based on __CHAR_UNSIGNED__, but that isn't working properly
> in this case.  I have no idea whether this is a compiler or kernel issue,
> just thought I'd point out the background of what ext4 is doing here.
> 
> Cheers, Andreas

Well, since v6.2-rc1 the kernel is always compiled with -funsigned-char, so of
course the above no longer works to detect the "default" signedness of a char.

Below is one very ugly solution.  It seems to work, based on the output of
'make V=1'; fs/ext4/char.c is compiled *without* -funsigned-char, and everything
else is still compiled with -funsigned-char.  Though, I'm not sure that the
trick I'm using with KBUILD_CFLAGS is meant to be supported.

Better ideas would be appreciated.  If the default signedness of 'char' is a
per-arch thing, maybe each arch could explicitly select
ARCH_HAVE_DEFAULT_SIGNED_CHAR or ARCH_HAVE_DEFAULT_UNSIGNED_CHAR?  Or is there
any chance that this code is obsolete and can be removed from ext4?

From 87b77d02c399d684d906832862ad234ec321ff12 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@google.com>
Date: Tue, 17 Jan 2023 19:21:35 -0800
Subject: [PATCH] ext4: fix detection of default char signedness

For strange reasons involving a historical bug in ext4's on-disk format,
ext4 needs to know the default signedness of a char.  Since the kernel
is now always compiled with -funsigned-char, checking __CHAR_UNSIGNED__
no longer works.  To make it work again, check __CHAR_UNSIGNED__ in a
separate translation unit that is compiled without -funsigned-char.

Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/Makefile | 43 +++++++++++++++++++++++++++++++++++++------
 fs/ext4/char.c   | 24 ++++++++++++++++++++++++
 fs/ext4/ext4.h   |  2 ++
 fs/ext4/super.c  | 20 ++++++++++----------
 4 files changed, 73 insertions(+), 16 deletions(-)
 create mode 100644 fs/ext4/char.c

diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 72206a2926765..fa7dc62fa1a2c 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -5,12 +5,43 @@
 
 obj-$(CONFIG_EXT4_FS) += ext4.o
 
-ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
-		extents_status.o file.o fsmap.o fsync.o hash.o ialloc.o \
-		indirect.o inline.o inode.o ioctl.o mballoc.o migrate.o \
-		mmp.o move_extent.o namei.o page-io.o readpage.o resize.o \
-		super.o symlink.o sysfs.o xattr.o xattr_hurd.o xattr_trusted.o \
-		xattr_user.o fast_commit.o orphan.o
+ext4-y	:= balloc.o \
+	   bitmap.o \
+	   block_validity.o \
+	   char.o \
+	   dir.o \
+	   ext4_jbd2.o \
+	   extents.o \
+	   extents_status.o \
+	   fast_commit.o \
+	   file.o \
+	   fsmap.o \
+	   fsync.o \
+	   hash.o \
+	   ialloc.o \
+	   indirect.o \
+	   inline.o \
+	   inode.o \
+	   ioctl.o \
+	   mballoc.o \
+	   migrate.o \
+	   mmp.o \
+	   move_extent.o \
+	   namei.o \
+	   orphan.o \
+	   page-io.o \
+	   readpage.o \
+	   resize.o \
+	   super.o \
+	   symlink.o \
+	   sysfs.o \
+	   xattr.o \
+	   xattr_hurd.o \
+	   xattr_trusted.o \
+	   xattr_user.o
+
+# char.c needs to be compiled with the default char signedness.
+$(obj)/char.o: KBUILD_CFLAGS := $(filter-out -funsigned-char,$(KBUILD_CFLAGS))
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
diff --git a/fs/ext4/char.c b/fs/ext4/char.c
new file mode 100644
index 0000000000000..2a8b3df44262c
--- /dev/null
+++ b/fs/ext4/char.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Detect whether char is signed or unsigned by default on this platform,
+ * disregarding the fact that since v6.2, char is always unsigned in the kernel,
+ * i.e. the kernel is now always built with -funsigned char.
+ *
+ * To do this, check __CHAR_UNSIGNED__ in a translation unit that is compiled
+ * *without* -funsigned-char.
+ *
+ * Do *not* include any headers in this file, since it's no longer being tested
+ * that kernel-internal headers build cleanly without -funsigned-char.
+ */
+
+int ext4_is_char_unsigned(void);
+
+int ext4_is_char_unsigned(void)
+{
+#ifdef __CHAR_UNSIGNED__
+	return 1;
+#else
+	return 0;
+#endif
+}
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 140e1eb300d17..bdadad0b4e7ab 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3675,6 +3675,8 @@ extern int ext4_check_blockref(const char *, unsigned int,
 extern int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
 				ext4_fsblk_t start_blk, unsigned int count);
 
+/* char.c */
+int ext4_is_char_unsigned(void);
 
 /* extents.c */
 struct ext4_ext_path;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 260c1b3e3ef2c..2bd6d1b15d041 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5189,16 +5189,16 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		if (i & EXT2_FLAGS_UNSIGNED_HASH)
 			sbi->s_hash_unsigned = 3;
 		else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
-#ifdef __CHAR_UNSIGNED__
-			if (!sb_rdonly(sb))
-				es->s_flags |=
-					cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
-			sbi->s_hash_unsigned = 3;
-#else
-			if (!sb_rdonly(sb))
-				es->s_flags |=
-					cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
-#endif
+			if (ext4_is_char_unsigned()) {
+				if (!sb_rdonly(sb))
+					es->s_flags |=
+						cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
+				sbi->s_hash_unsigned = 3;
+			} else {
+				if (!sb_rdonly(sb))
+					es->s_flags |=
+						cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
+			}
 		}
 	}
 

base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.39.0

