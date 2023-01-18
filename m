Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B74671289
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 05:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjAREVU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Jan 2023 23:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAREVP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Jan 2023 23:21:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B694B54134
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 20:21:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5340261620
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 04:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E4AC433D2;
        Wed, 18 Jan 2023 04:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674015673;
        bh=2UuzWQetif+LzzdHmM0qb4Jd0klt0aO7rFegMtQW6N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jReOJXRh1CJbN3Cb8yULnO/m0XTYNOQNT3wvVdURRLN8tCWXQOGWd1GHwIM1qWYpZ
         eHRmkBy2VWud3gnN3+Z8p54KsRabZjODhIjWKuR0I0zYVh5xTZNXa6YNIGBMcpg/VS
         TYmqK78xGwQTpY3yDyIShCMIGU0EHBL0bB95K9v3w+tC49MC459v8Gh/7yUSeLuEhm
         8ju9ad551D3iLZ75OFxJMCGf3BcBUGa59Wkjf2F5m8pm0AHXkz4A53FtOf75UBXNi6
         ILtqSQ8zNy2sEqepcQWq1FLCQgiFjTU84VY/X/Af3FgnyA9WCX4NhRJCBZdG9HgeDU
         iB6Itu71ZU2rg==
Date:   Tue, 17 Jan 2023 20:21:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Detecting default signedness of char in ext4 (despite
 -funsigned-char)
Message-ID: <Y8dzt485zZBCSVL9@sol.localdomain>
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
 <Y8dtze3ZLGaUi8pi@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8dtze3ZLGaUi8pi@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 17, 2023 at 07:55:57PM -0800, Eric Biggers wrote:
> [Added some Cc's, and updated subject to reflect what this is really about]
> 
> On Tue, Jan 17, 2023 at 05:10:55PM -0700, Andreas Dilger wrote:
> > On Jan 17, 2023, at 11:31 AM, Eric Whitney <enwlinux@gmail.com> wrote:
> > > 
> > > My 6.2-rc1 regression run on the current x86-64 test appliance revealed a new
> > > failure for generic/454 on the 4k file system configuration and all other
> > > configurations using a 4k block size.  This failure reproduces with 100%
> > > reliability and continues to appear as of 6.2-rc4.
> > > 
> > > The test output indicates that the file system under test is inconsistent.
> > 
> > There is actually support in the superblock for both signed and unsigned char
> > hash calculations, exactly because there was a bug like this in the past.
> > It looks like the ext4 code/build is still using the signed hash functions:
> > 
> > 
> > static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> > {
> > 	:
> > 	:
> >                 if (i & EXT2_FLAGS_UNSIGNED_HASH)
> >                         sbi->s_hash_unsigned = 3;
> >                 else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
> > #ifdef __CHAR_UNSIGNED__
> >                         if (!sb_rdonly(sb))
> >                                 es->s_flags |=
> >                                         cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
> >                         sbi->s_hash_unsigned = 3;
> > #else
> >                         if (!sb_rdonly(sb))
> >                                 es->s_flags |=
> >                                         cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
> > #endif
> >                 }
> > 
> > It looks like this *should* be detecting the unsigned/signed char type
> > automatically based on __CHAR_UNSIGNED__, but that isn't working properly
> > in this case.  I have no idea whether this is a compiler or kernel issue,
> > just thought I'd point out the background of what ext4 is doing here.
> > 
> > Cheers, Andreas
> 
> Well, since v6.2-rc1 the kernel is always compiled with -funsigned-char, so of
> course the above no longer works to detect the "default" signedness of a char.
> 
> Below is one very ugly solution.  It seems to work, based on the output of
> 'make V=1'; fs/ext4/char.c is compiled *without* -funsigned-char, and everything
> else is still compiled with -funsigned-char.  Though, I'm not sure that the
> trick I'm using with KBUILD_CFLAGS is meant to be supported.
> 
> Better ideas would be appreciated.  If the default signedness of 'char' is a
> per-arch thing, maybe each arch could explicitly select
> ARCH_HAVE_DEFAULT_SIGNED_CHAR or ARCH_HAVE_DEFAULT_UNSIGNED_CHAR?  Or is there
> any chance that this code is obsolete and can be removed from ext4?
> 

... and ext4's xattr hashing also depends on the signedness of char, so the
following would be needed too:

From 2b47d4ab7fa6aefe81e851417b298372a2e9f391 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@google.com>
Date: Tue, 17 Jan 2023 20:13:01 -0800
Subject: [PATCH] ext4: make ext4_xattr_hash_entry() use default char
 signedness

Annoyingly, ext4 uses different xattr hash algorithms depending on the
default signedness of 'char'.  Since 'char' is now always unsigned in
the kernel, ext4 now needs to explicitly check the default signedness of
'char' in order to decide which algorithm to use.

This fixes handling of xattrs whose names contain characters outside the
ASCII range, including xfstest generic/454 which tests that case.

Reported-by: Eric Whitney <enwlinux@gmail.com>
Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/xattr.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7decaaf27e82b..b96d134786b71 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -3078,10 +3078,18 @@ static __le32 ext4_xattr_hash_entry(char *name, size_t name_len, __le32 *value,
 {
 	__u32 hash = 0;
 
-	while (name_len--) {
-		hash = (hash << NAME_HASH_SHIFT) ^
-		       (hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
-		       *name++;
+	if (ext4_is_char_unsigned()) {
+		while (name_len--) {
+			hash = (hash << NAME_HASH_SHIFT) ^
+				(hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
+				*(unsigned char *)name++;
+		}
+	} else {
+		while (name_len--) {
+			hash = (hash << NAME_HASH_SHIFT) ^
+				(hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
+				*(signed char *)name++;
+		}
 	}
 	while (value_count--) {
 		hash = (hash << VALUE_HASH_SHIFT) ^

base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
prerequisite-patch-id: e2b312341ee6de27e940ca5470787f3a0dde4541
-- 
2.39.0

