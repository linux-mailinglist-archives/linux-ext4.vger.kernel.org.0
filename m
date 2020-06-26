Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F63820B8DA
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jun 2020 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgFZS4T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Jun 2020 14:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgFZS4S (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 26 Jun 2020 14:56:18 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBFF820836;
        Fri, 26 Jun 2020 18:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593197778;
        bh=XvHTWsyDoBDHwHQUyFs9hcitEJU67Zn4oKDZcCgFe+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNEcp9Fcco6NTvUVsyCt/OP0Mjzu3VT5un7LPFrtNw0Val2WiiEtPa27kmirmDpOx
         tMFsOeGgdp1PZUW+0GNaDOBT4IANT/8VDuJnHCk7ETbBTQYDM9ZYFHxBtv1Eyu2Cxt
         2SYhd+m3FWG48Fb1rVZufu7yCC+xcheWSiPzSXy0=
Date:   Fri, 26 Jun 2020 11:56:16 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tune2fs: allow remove VERITY
Message-ID: <20200626185616.GC211634@gmail.com>
References: <20200624023107.182118-1-gwendal@chromium.org>
 <20200624024043.GA844@sol.localdomain>
 <CAPUE2uv0XXv40quqbKmdktgCD18DnSWh=Ekeiq2tAZOfmGmjGw@mail.gmail.com>
 <20200624160926.GA200774@gmail.com>
 <CAPUE2utgfH2K=dVZ8o1QivjbFpq89G4sD4AgO+sBL8ZLF6f4=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUE2utgfH2K=dVZ8o1QivjbFpq89G4sD4AgO+sBL8ZLF6f4=w@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 25, 2020 at 11:26:44AM -0700, Gwendal Grignou wrote:
> On Wed, Jun 24, 2020 at 9:09 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, Jun 24, 2020 at 12:06:22AM -0700, Gwendal Grignou wrote:
> > > On Tue, Jun 23, 2020 at 7:40 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > On Tue, Jun 23, 2020 at 07:31:07PM -0700, Gwendal Grignou wrote:
> > > > > Allow verity flag to be removed from the susperblock:
> > > > > Tests:
> > > > > - check the signed file is readable by older kernel after flag
> > > > > is removed. EXT4_VERITY_FL replaces EXT4_EXT_MIGRATE that has been
> > > > > removed in 2009.
> > > > > - when a new kernel is reinstalled, check reenabling verity flag
> > > > > allow signature to be verified (fsverity measure ...).
> > > > >
> > > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > ---
> > > > >  misc/tune2fs.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> > > > > index 314cc0d0..724b8014 100644
> > > > > --- a/misc/tune2fs.c
> > > > > +++ b/misc/tune2fs.c
> > > > > @@ -198,7 +198,8 @@ static __u32 clear_ok_features[3] = {
> > > > >               EXT4_FEATURE_RO_COMPAT_QUOTA |
> > > > >               EXT4_FEATURE_RO_COMPAT_PROJECT |
> > > > >               EXT4_FEATURE_RO_COMPAT_METADATA_CSUM |
> > > > > -             EXT4_FEATURE_RO_COMPAT_READONLY
> > > > > +             EXT4_FEATURE_RO_COMPAT_READONLY |
> > > > > +             EXT4_FEATURE_RO_COMPAT_VERITY
> > > > >  };
> > > > >
> > > >
> > > > tune2fs doesn't allow removing features like encrypt, casefold, verity, extents,
> > > > and ea_inode because it doesn't know whether there are any inodes on the
> > > > filesystem that are using these features.  These features can't be removed if
> > > > there are any inodes using them.
> > >
> > > The verity case is slightly different though: beside metadata,
> > > encrypted files are useless.
> > > In the case of fs-verity, the file is still readable, its size is
> > > correct. Using debugfs, I checked the merkel tree blocks appended at
> > > the end of the file are still mapped to the file inode, they are
> > > marked as free when the file is removed.
> > > Are you concerned about filesystem corruption? When I re-enable the
> > > features and load a kernel that supports fs-verity, the protected
> > > files are signed and read-only as expected.
> >
> > The problem is that the old, non-verity-aware kernel will allow writing to
> > verity files, because it ignores the verity inode flag.  That will get files'
> > data out of sync with their Merkle trees, and possibly corrupt their Merkle
> > trees.
> You're right, an older kernel modifying the verity file corrupts the
> merkel tree and creates inconsistency between the blocks where the
> merkel tree was and the inode information.
> We could mark the file (not just the inode) as read only in
> fsverity_ioctl_enable() but that's a layering violation.

Even if we had enforced that verity files never have any writable mode bits set
(mode & 0222), it wouldn't matter because old kernels could just chmod() the
file back to writable.  Similarly for the immutable flag.

> >
> > This is why verity is a RO_COMPAT feature rather than a COMPAT one.  This
> > ensures that if the kernel isn't aware of verity, then the filesystem can only
> > be mounted read-only.
> It is indeed safe, but having the whole filesystem read-only is very
> restrictive.

Unfortunately there's no concept of ro_compat-ness for ext4 inode flags.
If there was, we would have used that instead.

Only the filesystem feature flags have the notion of compat/ro_compat/incompat.

> >
> > How about making 'tune2fs -O ^verity' remove the verity flag from all files
> > that have it and remove their Merkle trees by truncating blocks past i_size?
> > Would that work for you, or do you really need the verity-ness of files to be
> > preserved over 'tune2fs -O ^verity; tune2fs -O verity'?
> The latter would be better. Another use case would be a filesystem on
> an external device, shared by machines with different kernels. Even if
> there are no fs-verity files, the older kernel can not mount it
> read-write.
> Removing the verity feature would break the trust in the filesystem
> when the device is plugged in the original machine.
> 
> As long as the verified files are not extended (remove is fine), the
> option flag can be removed. No solutions are satisfactory, but for
> security sake, the current behavior is the safest.

I just don't think verity files existing with the verity feature disabled can be
a supported filesystem state, for the reasons I mentioned.

Can't you just re-enable verity on the files when re-enabling the feature flag?
Userspace must know which files are supposed to have verity enabled anyway.

- Eric
