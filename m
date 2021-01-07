Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64C2EE8EF
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 23:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbhAGWl7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 17:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbhAGWl6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 7 Jan 2021 17:41:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5026A235FA;
        Thu,  7 Jan 2021 22:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610059277;
        bh=RrltNzlgbjw2VTWo8+4kW5qEZ5zQwk2osOimDdL5Xqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S06AW/ZQGGF/S0ua6x1I1Z3SMBRubGARQ/uGd3YxWOM8sNL40EFlKcTKCZ0RD3xhh
         h6O4AQTFSrzL6vZkTpF/Ed5H3dyPItHx6iFDJmZJMD4Zgoi5VAXVtz+c5IQo7Tj4WW
         1SA+iB9R3UB5TqNijdFovW3Y5jz9crmZvCkBfQFx9u5dNvqbhjWrrhi0+hCQDX/AZd
         SgcplrkGkj6Goa914r6XKMbhvA5O1cbEUl1YT4ua8GklmBWX4BFs6XvNIbuIgMOZEy
         1PTvPJmJwJy1auTuBNV3QV10vRHtvtmXwFwuY08l7cr8lgDBypF8uQp7sAc9jw8+KI
         MLg3Aco6nNgQw==
Date:   Thu, 7 Jan 2021 14:41:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <X/eOC/tj3966kBRH@gmail.com>
References: <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
 <X/c2aqSvYCaB9sR6@mit.edu>
 <CAK8P3a2svyz1KXSqSUMVeDqdag4f1VcERH9jpECSLsn-FWvZbw@mail.gmail.com>
 <20210107221446.GS1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107221446.GS1551@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 07, 2021 at 10:14:46PM +0000, Russell King - ARM Linux admin wrote:
> On Thu, Jan 07, 2021 at 10:48:05PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 7, 2021 at 5:27 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > >
> > > On Thu, Jan 07, 2021 at 01:37:47PM +0000, Russell King - ARM Linux admin wrote:
> > > > > The gcc bugzilla mentions backports into gcc-linaro, but I do not see
> > > > > them in my git history.
> > > >
> > > > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > > > or just for aarch64?
> > >
> > > Russell, Arnd, thanks so much for tracking down the root cause of the
> > > bug!
> > 
> > There is one more thing that I wondered about when looking through
> > the ext4 code: Should it just call the crc32c_le() function directly
> > instead of going through the crypto layer? It seems that with Ard's
> > rework from 2018, that can just call the underlying architecture specific
> > implementation anyway.
> 
> Yes, I've been wondering about that too. To me, it looks like the
> ext4 code performs a layering violation by going "under the covers"
> - there are accessor functions to set the CRC and retrieve it. ext4
> instead just makes the assumption that the CRC value is stored after
> struct shash_desc. Especially as the crypto/crc32c code references
> the value using:
> 
> 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
> 
> Not even crypto drivers are allowed to assume that desc+1 is where
> the CRC is stored.

It violates how the shash API is meant to be used in general, but there is a
test that enforces that the shash_desc_ctx for crc32c must be just the single
u32 crc value.  See alg_test_crc32c() in crypto/testmgr.c.  So it's apparently
intended to work.

> 
> However, struct shash_desc is already 128 bytes in size on aarch64,

Ard Biesheuvel recently sent a patch to reduce the alignment of struct
shash_desc to ARCH_SLAB_MINALIGN
(https://lkml.kernel.org/linux-crypto/20210107124128.19791-1-ardb@kernel.org/),
since apparently most of the bloat is from alignment for DMA, which isn't
necessary.  I think that reduces the size by a lot on arm64.

> and the proper way of doing it via SHASH_DESC_ON_STACK() is overkill,
> being strangely 2 * sizeof(struct shash_desc) + 360 (which looks like
> another bug to me!)

Are you referring to the '2 * sizeof(struct shash_desc)' rather than just
'sizeof(struct shash_desc)'?  As mentioned in the comment above
HASH_MAX_DESCSIZE, there can be a nested shash_desc due to HMAC.
So I believe the value is correct.

> So, I agree with you wrt crc32c_le(), especially as it would be more
> efficient, and as the use of crc32c is already hard coded in the ext4
> code - not only with crypto_alloc_shash("crc32c", 0, 0) but also with
> the fixed-size structure in ext4_chksum().
> 
> However, it's ultimately up to the ext4 maintainers to decide.

As I mentioned in my other response, crc32c_le() isn't a proper library API
(like some of the newer lib/crypto/ stuff) but rather just a wrapper for the
shash API, and it doesn't handle modules being dynamically loaded/unloaded.
So switching to it may cause a performance regression.

What I'd recommend is making crc32c_le() able to call architecture-speccific
implementations directly, similar to blake2s() and chacha20() in lib/crypto/.
Then there would be no concern about when modules get loaded, etc...

- Eric
