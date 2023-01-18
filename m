Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D6671305
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 06:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjARFOT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 00:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjARFOS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 00:14:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B221553566
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 21:14:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F185CB81B18
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 05:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A22AC433EF;
        Wed, 18 Jan 2023 05:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674018854;
        bh=uuv7wwlO3+jz4UKP2c3bWavfeinTvcIeMzT8Uy6expw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQhrjpOr8S4ll1UgW0eBUhKXx+1dOp2tjp5Pi/Vub6LjkhsN1IPFxcF1cwSnMXtZ+
         yE9sFNptgbi2UA8lrkVpdpgWy0rzyBLNpg0Y087UAf9YjHCn+oQCsKw8B43sezCQor
         8cn9IDOQC38VaApbQBhmcdTQr01dBBimfyQkRn6oKp/RiepOdYG5yiu7BhQFR3ZC3X
         FrFeWoUD5qvqeB3z7tFDCZXin+5hReYNSW5725Q1Z+WEPR2GRZdawgmp9BUbTGaPhh
         BkYIHqhVvA9QEOOPTtDXFFU8vSNGc6ht570JShaxE0UC3L71cQfUHL36O12HLPFLjF
         jAxU2cHH+Ez4Q==
Date:   Tue, 17 Jan 2023 21:14:12 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: Detecting default signedness of char in ext4 (despite
 -funsigned-char)
Message-ID: <Y8eAJIKikCTJrlcr@sol.localdomain>
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
 <Y8dtze3ZLGaUi8pi@sol.localdomain>
 <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 17, 2023 at 08:27:23PM -0800, Linus Torvalds wrote:
> On Tue, Jan 17, 2023 at 7:56 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > [Added some Cc's, and updated subject to reflect what this is really about]
> 
> Hmm.
> 
> I really hate this.
> 
> > On Tue, Jan 17, 2023 at 05:10:55PM -0700, Andreas Dilger wrote:
> > > >
> > > > My 6.2-rc1 regression run on the current x86-64 test appliance revealed a new
> > > > failure for generic/454 on the 4k file system configuration and all other
> > > > configurations using a 4k block size.  This failure reproduces with 100%
> > > > reliability and continues to appear as of 6.2-rc4.
> > > >
> > > > The test output indicates that the file system under test is inconsistent.
> > >
> > > There is actually support in the superblock for both signed and unsigned char
> > > hash calculations, exactly because there was a bug like this in the past.
> > > It looks like the ext4 code/build is still using the signed hash functions:
> 
> So clearly ext4 is completely buggy in this respect, but this is
> exactly what would happen if you just mount a disk that was written to
> on (old, pre-funsigned-char) x86, and then mount it on, say, an arm
> machine that has always been unsigned-char.
> 
> That was always supposed to work.
> 
> So switching to a new kernel really should just be *exactly* the same
> as moving the disk to a different machine.
> 
> And that's still "supposed to just work".
> 
> And this whole "let's get it wrong, and make x86 act as if 'char' is
> signed, even when it isn't" seems entirely the wrong way around.
> 
> So the bug here is that __ext4_fill_super() seems to not look at the
> actual on-disk thing, but instead do
> 
> > > static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> > > {
> ...
> > >                 else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
> > > #ifdef __CHAR_UNSIGNED__
> 
> but at the same time this code is *exactly* the code that is trying to
> deal with "oh, you moved the disk from a signed architecture to an
> unsigned one".
> 
> So the above code is literally what should fix up that movement -
> taking the *actual* new signedness (or lack thereof, in this case)
> into account.
>
> Now, it apparently doesn't work very well, and I suspect the reason it
> doesn't work is that the xattr code doesn't actually test these
> EXT2_FLAGS_SIGNED_HASH bits (and the s_hash_unsigned field value that
> goes along with it).
> 
> But we should *fix* that.

Well, reading the code more carefully, the on-disk ext4 superblock can contain
EXT2_FLAGS_SIGNED_HASH, EXT2_FLAGS_UNSIGNED_HASH, or neither.  "Neither" is the
legacy case.  The above existing code in ext4 is handling the "neither" case by
setting the flag corresponding to the default signedness of char.  So yes, that
migration code was always broken if you moved the disk from a platform with
signed char (e.g. x86) to a platform with unsigned char (e.g. arm).  But,
-funsigned-char breaks it whenever the disk stays on a platform with signed
char.  That seems much worse.  Though, it's also a migration for legacy
filesystems, so maybe that code isn't needed often anymore anyway...

Anyway, as I found out after my initial reply, and which you noticed too, the
thing that actually caused the breakage here is the xattr hash.  The xattr hash
isn't related to the logic in __ext4_fill_super(), or to EXT2_FLAGS_SIGNED_HASH
and EXT2_FLAGS_UNSIGNED_HASH.  Those are only for the dirhash.  Unfortunately,
ext4's xattr hash didn't get fixed years ago when the dirhash did.  The xattr
hash still just always uses 'char'.

>  (a) just admit that ext4 was buggy, and say "char is now unsigned",
> and know that generic/454 will fail when you switch from a buggy
> kernel to a new one that no longer has this signedness bug.

It seems kind of crazy to intentionally break xattrs with non-ASCII names upon a
kernel upgrade...

> 
>  (b) fix ext4_xattr_hash_entry() to actually see "oh, this filesystem was
>  created with signed chars, and so we'll use that algorithm even though our
>  chars are always unsigned".
> 
> Honestly, the only actual case of breakage I have heard of is that test, so I
> was hoping that (a) is simply the acceptable and simplest solution. It
> basically says "nobody really cares, we're now always unsigned, real people
> didn't use non-ASCII xattr names".
> 
> Anyway, here's a TOTALLY UNTESTED patch to do (b). Maybe it's entirely broken,
> but I think you can see what I'm aiming for.
> 
> Comments?
> 
>                      Linus
>  fs/ext4/xattr.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7decaaf27e82..69a1b8c6a2ec 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -81,6 +81,8 @@ ext4_xattr_block_cache_find(struct inode *, struct ext4_xattr_header *,
>  			    struct mb_cache_entry **);
>  static __le32 ext4_xattr_hash_entry(char *name, size_t name_len, __le32 *value,
>  				    size_t value_count);
> +static __le32 ext4_xattr_hash_entry_signed(char *name, size_t name_len, __le32 *value,
> +				    size_t value_count);
>  static void ext4_xattr_rehash(struct ext4_xattr_header *);
>  
>  static const struct xattr_handler * const ext4_xattr_handler_map[] = {
> @@ -470,8 +472,21 @@ ext4_xattr_inode_verify_hashes(struct inode *ea_inode,
>  		tmp_data = cpu_to_le32(hash);
>  		e_hash = ext4_xattr_hash_entry(entry->e_name, entry->e_name_len,
>  					       &tmp_data, 1);
> -		if (e_hash != entry->e_hash)
> -			return -EFSCORRUPTED;
> +		/* All good? */
> +		if (e_hash == entry->e_hash)
> +			return 0;
> +
> +		/*
> +		 * Not good. Maybe the entry hash was calculated
> +		 * using the buggy signed char version?
> +		 */
> +		e_hash = ext4_xattr_hash_entry_signed(entry->e_name, entry->e_name_len,
> +							&tmp_data, 1);
> +		if (e_hash == entry->e_hash)
> +			return 0;
> +
> +		/* Still no match - bad */
> +		return -EFSCORRUPTED;
>  	}
>  	return 0;
>  }
> @@ -3091,6 +3106,28 @@ static __le32 ext4_xattr_hash_entry(char *name, size_t name_len, __le32 *value,
>  	return cpu_to_le32(hash);
>  }
>  
> +/*
> + * ext4_xattr_hash_entry_signed()
> + *
> + * Compute the hash of an extended attribute incorrectly.
> + */
> +static __le32 ext4_xattr_hash_entry_signed(char *name, size_t name_len, __le32 *value, size_t value_count)
> +{
> +	__u32 hash = 0;
> +
> +	while (name_len--) {
> +		hash = (hash << NAME_HASH_SHIFT) ^
> +		       (hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
> +		       (signed char)*name++;
> +	}
> +	while (value_count--) {
> +		hash = (hash << VALUE_HASH_SHIFT) ^
> +		       (hash >> (8*sizeof(hash) - VALUE_HASH_SHIFT)) ^
> +		       le32_to_cpu(*value++);
> +	}
> +	return cpu_to_le32(hash);
> +}
> +

I think that what your patch does is allow filesystems to contain both signed
and unsigned xattr hashes, and write out new ones as unsigned.  That might work,
though e2fsprogs would need to be fixed too, and old versions of e2fsck would
corrupt xattrs unless a new ext4 filesystem feature flag was added.

Maybe using the solution that the dirhash uses, where the signedness of the hash
is explicitly stored in the superblock on-disk, would be better.  ext4 would
still need to know the default signedness of a char in order to set the on-disk
flag in the first place, though, unless it assumes that the correct value is
already conveyed by the filesystem having either EXT2_FLAGS_SIGNED_HASH or
EXT2_FLAGS_UNSIGNED_HASH set.  (But those are currently meant for the dirhash,
not the xattr hash, and apparently they aren't set on legacy filesystems.)

- Eric
