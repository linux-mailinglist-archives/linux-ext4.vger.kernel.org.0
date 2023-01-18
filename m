Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091D867292B
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 21:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjARUSh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 15:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjARUSh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 15:18:37 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8064FC25
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 12:18:35 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30IKIGIg017108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 15:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674073099; bh=hT6v01Kvyl5VaP/e4rVb/Bu3j5RLVQoL8QDHJhGvKj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QuKz6hfY/jPof/jhjLYffNl5wzZwSLSbEWgMkg8xuorOCCTXbRPClIlJK5gqrSq4q
         BLNQpjAjakze3TY/x9go3oh/MYVZ9/+TR0QwaVqNUsS9bwaIVcy7eDfAP3WULY6y0s
         ccxdO0eCFXDD28HrFoRDWYxQGOk26NVRJq1EY4vo74MZNdd2NKq64Ue1pi1X9NRadn
         zpr2rZ0Urp+CkChfQRS+TVWhcYqzZDyAojj/7yBpIf2WjsWFkkItV8rMnOE9T6dJTV
         aOCMTuqzcl0ZUkRer1oQcDRjYfLY1HiyZHfGet5YwmAUjxo/8bfT/ZbrVhJG8C4bR8
         2fPpk0FGQ8S8A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C6E1A15C469B; Wed, 18 Jan 2023 15:18:16 -0500 (EST)
Date:   Wed, 18 Jan 2023 15:18:16 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: Detecting default signedness of char in ext4 (despite
 -funsigned-char)
Message-ID: <Y8hUCIVImjqCmEWv@mit.edu>
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
 <Y8dtze3ZLGaUi8pi@sol.localdomain>
 <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
 <Y8eAJIKikCTJrlcr@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8eAJIKikCTJrlcr@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 17, 2023 at 09:14:12PM -0800, Eric Biggers wrote:
> 
> Well, reading the code more carefully, the on-disk ext4 superblock can contain
> EXT2_FLAGS_SIGNED_HASH, EXT2_FLAGS_UNSIGNED_HASH, or neither.  "Neither" is the
> legacy case.  The above existing code in ext4 is handling the "neither" case by
> setting the flag corresponding to the default signedness of char.  So yes, that
> migration code was always broken if you moved the disk from a platform with
> signed char (e.g. x86) to a platform with unsigned char (e.g. arm).  But,
> -funsigned-char breaks it whenever the disk stays on a platform with signed
> char.  That seems much worse.  Though, it's also a migration for legacy
> filesystems, so maybe that code isn't needed often anymore anyway...

The migration code will detect what the current signedness of char,
and then *set* the SIGNED/UNSIGNED flag.  Once we've set the flag,
we'll continue to use it, and modern versions of e2fsprogs will set
the SIGNED/UNSIGNED flag again using the default signedness of char.
Once the signed/unsigned flag is set, then we can freely move the file
system between architectures and it's not a problem.  So if you have a
file system that was created before 2007 (e2fsprogs v1.40), the first
time you mount that file system on a kernel or run e2fsck on a scheme
that understands the new SIGNED/UNSIGNED scheme, then we use whatever
hash variant that had been used on the pre-2007 kernel/e2fsprogs
forever.

commit f77704e416fca7dbe4cc91abba674d2ae3c14f6f
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sat Nov 11 22:32:35 2006 -0500

    Add directory hashed signed/unsigned hint to superblock
    
    The e2fsprogs and kernel implementation of directory hash tree has a
    bug which causes the implementation to be dependent on whether
    characters are signed or unsigned.  Platforms such as the PowerPC,
    Arm, and S/390 have signed characters by default, which means that
    hash directories on those systems are incompatible with hash
    directories on other systems, such as the x86.
    
    To fix this we add a new flags field to the superblock, and define two
    new bits in that field to indicate whether or not the directory should
    be signed or unsigned.  If the bits are not set, e2fsck and fixed
    kernels will set them to the signed/unsigned value of the currently
    running platform, and then respect those bits when calculating the
    directory hash.  This allows compatibility with current filesystems,
    as well as allowing cross-architectural compatibility.
    
    Addresses Debian Bug: #389772
    
    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

So techncially speaking the migration code is probably not needed any
more, but it's not a lot of code (just a few lines of code to set the
flags if neither flag is set), and it's always possible that that you
might try to mount a pre-2006 file system on a 2022 system, so we
might as well keep it.

> Anyway, as I found out after my initial reply, and which you noticed too, the
> thing that actually caused the breakage here is the xattr hash.  The xattr hash
> isn't related to the logic in __ext4_fill_super(), or to EXT2_FLAGS_SIGNED_HASH
> and EXT2_FLAGS_UNSIGNED_HASH.  Those are only for the dirhash.  Unfortunately,
> ext4's xattr hash didn't get fixed years ago when the dirhash did.  The xattr
> hash still just always uses 'char'.

I *think* we're OK, because we only use XOR (^) on the char in the
xattr entry hash:

static __le32 ext4_xattr_hash_entry(char *name, size_t name_len, __le32 *value,
				    size_t value_count)
{
	__u32 hash = 0;

	while (name_len--) {
		hash = (hash << NAME_HASH_SHIFT) ^
		       (hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
		       *name++;
	}
	while (value_count--) {
		hash = (hash << VALUE_HASH_SHIFT) ^
		       (hash >> (8*sizeof(hash) - VALUE_HASH_SHIFT)) ^
		       le32_to_cpu(*value++);
	}
	return cpu_to_le32(hash);
}

And XOR shouldn't matter whether *name is signed or unsigned.  Am I
missing something?

						- Ted
