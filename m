Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB02C6727EA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 20:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjARTOH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 14:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjARTOG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 14:14:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E3353571
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 11:14:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B78F761866
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 19:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC44C433D2;
        Wed, 18 Jan 2023 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674069244;
        bh=byx/eV+Q57bP3Zpxdisdtr4qUD+PKvqCbGp2zZxgMas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rd7x7bhhan6Z3VbN+0fyuWctMZntV+0Jg2i5v0fTsf2gLai5de5xXuAEPcVl7AQtD
         inwrpPgu6eCioRM9LPZrKy+4p64VHRpTUT5Ejxh8vqviSaLFMLjLusa4KmZAPRGt/0
         he29w/qXpk4vzQ6r5XzBrXPjgEXvSbxM1cZJ0pIJRJw8P/XMWUutcz/Hn5ZxbGEntK
         zgZFg6fudm8DGQ+KGc1ek7Tqk358YvOwrM/S1jlyTrN5yGA67GVyvfOzbkAT6KN9ls
         eX86401F2JBwaz30i71BZIuxI/wBwiVtvktkdbIvlbu1sunjO9o65IBybEKB+V8ua0
         KpmVqmRQVBVww==
Date:   Wed, 18 Jan 2023 11:14:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: Detecting default signedness of char in ext4 (despite
 -funsigned-char)
Message-ID: <Y8hE+uwHkilxThDT@sol.localdomain>
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
 <Y8dtze3ZLGaUi8pi@sol.localdomain>
 <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
 <Y8eAJIKikCTJrlcr@sol.localdomain>
 <CAHk-=wg7SkJZeAJ-KMKxsA7m9cs7MJoSDpu0aYKVm=bAwhcqjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7SkJZeAJ-KMKxsA7m9cs7MJoSDpu0aYKVm=bAwhcqjA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 18, 2023 at 07:48:06AM -0800, Linus Torvalds wrote:
> On Tue, Jan 17, 2023 at 9:14 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Well, reading the code more carefully, the on-disk ext4 superblock can contain
> > EXT2_FLAGS_SIGNED_HASH, EXT2_FLAGS_UNSIGNED_HASH, or neither.  "Neither" is the
> > legacy case.  The above existing code in ext4 is handling the "neither" case by
> > setting the flag corresponding to the default signedness of char.  So yes, that
> > migration code was always broken if you moved the disk from a platform with
> > signed char (e.g. x86) to a platform with unsigned char (e.g. arm).  But,
> > -funsigned-char breaks it whenever the disk stays on a platform with signed
> > char.  That seems much worse.  Though, it's also a migration for legacy
> > filesystems, so maybe that code isn't needed often anymore anyway...
> 
> The xattr hash is also broken if it stays on one single machine, but
> is accessed two different ways.
> 
> Example: about half our architectures are mainly tested inside qemu,
> so if you ever end up using the same disk image across two emulated
> environments, you'll hit the exact same thing.
> 
> Basically, any filesystem that depends on host byte order, or on
> host-specific data sizes - or on host signedness rules - is simply
> completely and utterly broken (unless it's something like 'tmpfs' that
> doesn't have any existence outside of that machine).
> 
> So ext4 has been broken from day one when it comes to xattr hashing.
> 
> And nobody ever noticed, because very few people use xattrs to begin
> with, and when they do it tends to be very limited. And they seldom
> mix architectures.
> 
> But "nobody noticed" doesn't mean it wasn't broken. It was always
> completely and unambiguously buggy.
> 
> > >  (a) just admit that ext4 was buggy, and say "char is now unsigned",
> > > and know that generic/454 will fail when you switch from a buggy
> > > kernel to a new one that no longer has this signedness bug.
> >
> > It seems kind of crazy to intentionally break xattrs with non-ASCII names upon a
> > kernel upgrade...
> 
> I really don't think they happen very much, and if we can fix a bug
> without doing anything about it, and nobody notices, that would be
> fine by me.
> 
> But:
> 
> > I think that what your patch does is allow filesystems to contain both signed
> > and unsigned xattr hashes, and write out new ones as unsigned.
> 
> Right. Nobody seems to actually care about the hash, as far as I can tell.
> 
> It's used for that corruption check. And it is used by
> ext4_xattr_block_cache_find() to basically reuse a cached entry, but
> it has no actual semantic meaning.
> 
> >  That might work,
> > though e2fsprogs would need to be fixed too, and old versions of e2fsck would
> > corrupt xattrs unless a new ext4 filesystem feature flag was added.
> 
> The thing is, ef2progs NEEDS TO BE FIXED REGARDLESS!
> 
> You don't seem to realize that this is a fundamental filesystem bug.
> 
> It was not introduced by "-funsigned-char". It's been there for decades.
> 
> Re-introducing the "let's try to hide this bug" logic like your patch
> does is disgusting and actively wrong.
> 
> This bug needs to be *fixed*.
> 
> And since we don't seem to have a "this filesystem uses stupid signed
> hash arithmetic" flag (the EXT2_FLAGS_SIGNED_HASH only covers the
> filename case), and since nobody actually cares, the best option seems
> to be to just do what the code should have done originally, ie not
> rely on 'char' being sign-extended.
> 
> A simpler patch would be to actually just entirely remove the check of
> the e_hash value entiely, ie just this:
> 
> -               if (e_hash != entry->e_hash)
> -                       return -EFSCORRUPTED;
> 
> and just say that the hash was always broken and the test for a random
> value is not worth it.
> 

Of course I understand there's a fundamental filesystem bug.  The question is
what to *do* about it.  The patches I suggested were *only* intended to make the
ext4 code work the way it did in v6.1 as a workaround, and to start a discussion
about how to detect the platform's default signedness of a char, since it does
seem that's still going to be needed regardless, even though it of course never
should have been needed in the first place.  I'm glad that you're interested in
helping with a more fundamental fix as well.

Now, the options for that are:

For the dirhash:

1a.) When mounting a filesystem that doesn't have the signedness of the dirhash
     explicitly stored, assume it's the platform's default signedness, and
     explicitly store that.  (Behavior in v6.1 and earlier.)

1b.) When mounting a filesystem that doesn't have the signedness of the dirhash
     explicitly stored, assume it's unsigned, and explicitly store that on-disk.
     (Behavior in v6.2-rc4.)

For the xattr hash:

2a.) When mounting a filesystem that doesn't have the signedness of the xattr
     hash explicitly stored, assume it's the platform's default signedness, and
     explicitly store that.  (Like how the dirhash worked.)

2b.) Change the xattr hash to always be unsigned.  (Behavior in v6.2-rc4.)

2c.) Write new xattr hashes as unsigned, and allow the filesystem to contain
     both unsigned and signed xattr hashes, without any explicit indication.  If
     the hash fails to verify as unsigned, try verifying it as signed too.

(1a) and (2a) would be the least likely to break users.  [(2a) instead of (2c),
since (2c) would make old versions of e2fsck break filesystems on platforms with
signed char.]  And those solutions require being able to detect the platform's
default signedness, however much we hate it.

Now, we seem to have gotten the "let's break userspace, lol" version of Linus
today, not the "SHUT THE FUCK UP, WE DO NOT BREAK USERSPACE" version of Linus
(https://lore.kernel.org/r/CA+55aFy98A+LJK4+GWMcbzaa1zsPBRo76q+ioEjbx-uaMKH6Uw@mail.gmail.com).
So sure, if we're extremely confident that no one, or at least no one we care
about, is mounting very old filesystems that haven't been mounted in a long
time, or using non-ASCII xattr names, then sure we could break those cases.
These cases were indeed already broken if a filesystem moved between platforms
with different char signedness, so that could be a reason not to care, although
"moving between platforms" is *much* less common than "same platform".

- Eric
