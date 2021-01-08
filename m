Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135192EEE82
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 09:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbhAHIWt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 03:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbhAHIWt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 8 Jan 2021 03:22:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD68A23435;
        Fri,  8 Jan 2021 08:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610094128;
        bh=aKhhSLJbUsRGC4fMcTp02dE9hHFZScjJxNbLMJE3gkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hXytD194Jy69L2JDmlax2713HV3WOCa88pAO7u/+CuJ7IDQIDtZ7Z5RPtl5mdO/g3
         mSroVtckkLRy0t6gTIHU4AaLaAXz7WD1uc14VLjEqZu2Oyl0r87hs/Qx7rDeMCYZTB
         QyDBR/QRttg7dpO5kGG9rtA7IfGj27CFu45VAzyTJOTHq/Fnoa9RV4P0oyVGZgfXVc
         zBI+QOlNfy5EcXKbB//ALB9MBKCdHxSUJwdxZSoXb7mveQIXtF6ewRqjcfr8lJazjP
         wbqIMqp3k7GzwD6tg69OamJHVjOa9ms7MAltsfJx6EMc0tR2I27+BqSNG6/EnlIB6j
         WtDk9rNJq04ow==
Received: by mail-ot1-f46.google.com with SMTP id x13so8947011oto.8;
        Fri, 08 Jan 2021 00:22:07 -0800 (PST)
X-Gm-Message-State: AOAM530/YpmcPyqtjwQykZuGn23XgDDc9Rw03k7cAtSHa46hSJ0qBH8F
        KatB0zOwoFBeRnN2KmgCzFyYeJKwiVN4pOsBI3Y=
X-Google-Smtp-Source: ABdhPJyY0Fik9H9OuujWGJjLETr8YNgFz4FTPkiBLiZaqw8gjZl657szkQH2ekulG/18x+ubQSWnc+P6uig+8h1Ebds=
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr1836458oto.90.1610094126878;
 Fri, 08 Jan 2021 00:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20210106135253.GJ1551@shell.armlinux.org.uk> <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk> <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk> <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk> <X/c2aqSvYCaB9sR6@mit.edu>
 <CAK8P3a2svyz1KXSqSUMVeDqdag4f1VcERH9jpECSLsn-FWvZbw@mail.gmail.com>
 <20210107221446.GS1551@shell.armlinux.org.uk> <X/eOC/tj3966kBRH@gmail.com>
In-Reply-To: <X/eOC/tj3966kBRH@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 8 Jan 2021 09:21:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH8nwyf=2hDBMrEi3uFzNS8Dvx-+AYy8DSWq3mO8UibAA@mail.gmail.com>
Message-ID: <CAMj1kXH8nwyf=2hDBMrEi3uFzNS8Dvx-+AYy8DSWq3mO8UibAA@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-toolchains@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 7 Jan 2021 at 23:42, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Jan 07, 2021 at 10:14:46PM +0000, Russell King - ARM Linux admin wrote:
> > On Thu, Jan 07, 2021 at 10:48:05PM +0100, Arnd Bergmann wrote:
> > > On Thu, Jan 7, 2021 at 5:27 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > > >
> > > > On Thu, Jan 07, 2021 at 01:37:47PM +0000, Russell King - ARM Linux admin wrote:
> > > > > > The gcc bugzilla mentions backports into gcc-linaro, but I do not see
> > > > > > them in my git history.
> > > > >
> > > > > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > > > > or just for aarch64?
> > > >
> > > > Russell, Arnd, thanks so much for tracking down the root cause of the
> > > > bug!
> > >
> > > There is one more thing that I wondered about when looking through
> > > the ext4 code: Should it just call the crc32c_le() function directly
> > > instead of going through the crypto layer? It seems that with Ard's
> > > rework from 2018, that can just call the underlying architecture specific
> > > implementation anyway.
> >
> > Yes, I've been wondering about that too. To me, it looks like the
> > ext4 code performs a layering violation by going "under the covers"
> > - there are accessor functions to set the CRC and retrieve it. ext4
> > instead just makes the assumption that the CRC value is stored after
> > struct shash_desc. Especially as the crypto/crc32c code references
> > the value using:
> >
> >       struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
> >
> > Not even crypto drivers are allowed to assume that desc+1 is where
> > the CRC is stored.
>
> It violates how the shash API is meant to be used in general, but there is a
> test that enforces that the shash_desc_ctx for crc32c must be just the single
> u32 crc value.  See alg_test_crc32c() in crypto/testmgr.c.  So it's apparently
> intended to work.
>
> >
> > However, struct shash_desc is already 128 bytes in size on aarch64,
>
> Ard Biesheuvel recently sent a patch to reduce the alignment of struct
> shash_desc to ARCH_SLAB_MINALIGN
> (https://lkml.kernel.org/linux-crypto/20210107124128.19791-1-ardb@kernel.org/),
> since apparently most of the bloat is from alignment for DMA, which isn't
> necessary.  I think that reduces the size by a lot on arm64.
>
> > and the proper way of doing it via SHASH_DESC_ON_STACK() is overkill,
> > being strangely 2 * sizeof(struct shash_desc) + 360 (which looks like
> > another bug to me!)
>
> Are you referring to the '2 * sizeof(struct shash_desc)' rather than just
> 'sizeof(struct shash_desc)'?  As mentioned in the comment above
> HASH_MAX_DESCSIZE, there can be a nested shash_desc due to HMAC.
> So I believe the value is correct.
>
> > So, I agree with you wrt crc32c_le(), especially as it would be more
> > efficient, and as the use of crc32c is already hard coded in the ext4
> > code - not only with crypto_alloc_shash("crc32c", 0, 0) but also with
> > the fixed-size structure in ext4_chksum().
> >
> > However, it's ultimately up to the ext4 maintainers to decide.
>
> As I mentioned in my other response, crc32c_le() isn't a proper library API
> (like some of the newer lib/crypto/ stuff) but rather just a wrapper for the
> shash API, and it doesn't handle modules being dynamically loaded/unloaded.
> So switching to it may cause a performance regression.
>
> What I'd recommend is making crc32c_le() able to call architecture-speccific
> implementations directly, similar to blake2s() and chacha20() in lib/crypto/.
> Then there would be no concern about when modules get loaded, etc...
>

I have looked into this in the past, both for crc32(c) and crc-t10dif,
both of which use a horrid method of wrapping a shash into a library
API. This was before we had static calls, though, and this work kind
of stalled on that. It should be straight-forward to redefine the
crc32c() library function as a static call, and have an optimized
module (or builtin) perform the [conditional] static call update at
module_init() time. The only missing piece is autoloading such
modules, which is tricky with softdeps if the dependency is from the
core kernel.

Currently, we have many users of crc32(c) in the kernel that go via
the shash (or synchronous ahash) layer to perform crc32c, all of which
would be better served by a library API, given that the hash type is a
compile time constant, and only synchronous calls are made.




drivers/infiniband/hw/i40iw/i40iw_utils.c: tfm =
crypto_alloc_shash("crc32c", 0, 0);
drivers/infiniband/sw/rxe/rxe_verbs.c: tfm = crypto_alloc_shash("crc32", 0, 0);
drivers/infiniband/sw/siw/siw_main.c: siw_crypto_shash =
crypto_alloc_shash("crc32c", 0, 0);
drivers/md/dm-crypt.c: tcw->crc32_tfm = crypto_alloc_shash("crc32", 0,
drivers/nvme/host/tcp.c: tfm = crypto_alloc_ahash("crc32c", 0,
CRYPTO_ALG_ASYNC);
drivers/nvme/target/tcp.c: tfm = crypto_alloc_ahash("crc32c", 0,
CRYPTO_ALG_ASYNC);
drivers/scsi/iscsi_tcp.c: tfm = crypto_alloc_ahash("crc32c", 0,
CRYPTO_ALG_ASYNC);
drivers/target/iscsi/iscsi_target_login.c: tfm =
crypto_alloc_ahash("crc32c", 0, CRYPTO_ALG_ASYNC);
fs/ext4/super.c: sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
fs/f2fs/super.c: sbi->s_chksum_driver = crypto_alloc_shash("crc32", 0, 0);
fs/jbd2/journal.c: journal->j_chksum_driver =
crypto_alloc_shash("crc32c", 0, 0);
fs/jbd2/journal.c: journal->j_chksum_driver =
crypto_alloc_shash("crc32c", 0, 0);
lib/libcrc32c.c: tfm = crypto_alloc_shash("crc32c", 0, 0);
