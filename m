Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF12EEE4F
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 09:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbhAHIGD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 03:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbhAHIGD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 8 Jan 2021 03:06:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30460235DD;
        Fri,  8 Jan 2021 08:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610093122;
        bh=P36UVH/CUAeBjA9gTkQLitbCYT2ZLHNDXD3BeV+yI4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gWHFzvWuWmNCfsnKnc6T/S6G34vE8qYUtFjmNeYnp1jnjo16fvudG1HnfBsuJrBF7
         TCufIA+BDIkfbQ7bSY98pSWj14WI0105nFocr481oUEL9xxTbt3IVBJ9vJt4VxyjAD
         ZbARfVu12hohbp8SMpptiP40ocGFQDC0n8fWyVMU5OMyHl9zAL9W/507x4jiS+cnlW
         2QUu29wllnx41Gr2U9VqdKlMx/DFIbNATkj1iQqDah2+e2fWwwTMCYEfFOyOZLftFh
         9bXDqANZOOSL5Sa1BlwWbKS72/YL57og4UQzheOIOL/UixzTQ9CuVE1RPwPWHGPheA
         z+/NkVSShIZWA==
Received: by mail-ot1-f44.google.com with SMTP id d20so8966994otl.3;
        Fri, 08 Jan 2021 00:05:22 -0800 (PST)
X-Gm-Message-State: AOAM5325aqReyvJ/yHcGbQ4mzTFBZ2zuTdeaI8rL2VSKiQirmS60Nn/p
        JeN7PcmYSF9PVF8a0I3zCeHkQmss/a/0zgW5kLU=
X-Google-Smtp-Source: ABdhPJzh+E/E3Pp5RtGMDM3xjtbLFnjN1MKG3E6aJ9LKXBT5t6PzGI2THP92k76xgd+IFvH4Sw9CgjVX9Vr7Wrp4baQ=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr1797775otr.210.1610093121351;
 Fri, 08 Jan 2021 00:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20210106135253.GJ1551@shell.armlinux.org.uk> <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk> <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk> <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk> <X/c2aqSvYCaB9sR6@mit.edu>
 <CAK8P3a2svyz1KXSqSUMVeDqdag4f1VcERH9jpECSLsn-FWvZbw@mail.gmail.com>
 <X/eK5xIMK5yZ2/tl@gmail.com> <20210107235328.GI6908@magnolia>
In-Reply-To: <20210107235328.GI6908@magnolia>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 8 Jan 2021 09:05:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a24jhd13FrQsvt9kryRwn6p4bVxCn3LtGBUhO8a-q75iQ@mail.gmail.com>
Message-ID: <CAK8P3a24jhd13FrQsvt9kryRwn6p4bVxCn3LtGBUhO8a-q75iQ@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 8, 2021 at 12:53 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Jan 07, 2021 at 02:27:51PM -0800, Eric Biggers wrote:
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
> > >
> >
> > It looks like that would work, although note that crc32c_le() uses the shash API
> > too, so it isn't any more "direct" than what ext4 does now.
>
> Yes.

Ah, I see. I had only noticed the architecture specific overrides for
__crc32c_le(),
and the global __weak crc32_le() function in lib/crc32.c, but failed to notice
the crc32c_le() macro that redirects to crc32c().

> > Also, a potential issue is that the implementation of crc32c that crc32c_le()
> > uses might be chosen too early if the architecture-specific implementation of
> > crc32c is compiled as a module (e.g. crc32c-intel.ko).
>
> This was the primary reason I chose to do it this way for ext4.
>
> The other is that ext4 didn't use crc32c before metadata_csum, so
> there's no point in pulling in the crypto layer if you're only going to
> use older ext2 or ext3 filesystems.  That was 2010, maybe people have
> stopped doing that?

The per-architecture overrides for __crc32c_le() are from 2018. With that
it should be possible to just always have the fastest implementation
(forcing them to be built-in normally), but not all architectures do this.

> > There are two ways this
> > could be fixed -- either by making it a proper library API like blake2s() that
> > can call the architecture-specific code directly, or by reconfiguring things
> > when a new crypto module is loaded (like what lib/crc-t10dif.c does).
>
> Though I would like to see the library functions gain the ability to use
> whatever is the fastest mechanism available once we can be reasonably
> certain that all the platform-specific drivers have been loaded.
>
> That said, IIRC most distros compile all of them into their
> (increasingly large) vmlinuz files so maybe this isn't much of practical
> concern?

I recently made checked the missing dependencies of drivers that
fail to 'select CRC32' but do call it directly. With those added, there
are now around 200 drivers that include it, and in practice you would
hardly find any kernel that doesn't have it built-in already. Most notably,
jbd2 already calls crc32_be(), so it is impossible to build an EXT4
without it. For memory-constrained embedded devices, it would probably
be more valuable to build without the crypto layer than without crc32.

       Arnd
