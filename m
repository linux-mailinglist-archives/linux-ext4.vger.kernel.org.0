Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318C220786A
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jun 2020 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404601AbgFXQJa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jun 2020 12:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404531AbgFXQJ2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 24 Jun 2020 12:09:28 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA2A206F7;
        Wed, 24 Jun 2020 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593014968;
        bh=1HN+aFFydwUDkXhTMITgOH48yWkTMel06ctBR26YTGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pm03Hm63aOgOvN1SpJ0Apo4gkR95HgkLJr2gv/rspIFOaxEoVyQw3sGRuhoVkuPIc
         ZFdKIOXOzXLHwM1ok8kkPzynkHR56TsU99jdpPQEw0d+OLh8+LEwmHU5cu0+A3eC8u
         cgbJcYT3NkYoPfUMhaLXXaf+rDnPyGYwWyoXo3rE=
Date:   Wed, 24 Jun 2020 09:09:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tune2fs: allow remove VERITY
Message-ID: <20200624160926.GA200774@gmail.com>
References: <20200624023107.182118-1-gwendal@chromium.org>
 <20200624024043.GA844@sol.localdomain>
 <CAPUE2uv0XXv40quqbKmdktgCD18DnSWh=Ekeiq2tAZOfmGmjGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUE2uv0XXv40quqbKmdktgCD18DnSWh=Ekeiq2tAZOfmGmjGw@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 24, 2020 at 12:06:22AM -0700, Gwendal Grignou wrote:
> On Tue, Jun 23, 2020 at 7:40 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Jun 23, 2020 at 07:31:07PM -0700, Gwendal Grignou wrote:
> > > Allow verity flag to be removed from the susperblock:
> > > Tests:
> > > - check the signed file is readable by older kernel after flag
> > > is removed. EXT4_VERITY_FL replaces EXT4_EXT_MIGRATE that has been
> > > removed in 2009.
> > > - when a new kernel is reinstalled, check reenabling verity flag
> > > allow signature to be verified (fsverity measure ...).
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > ---
> > >  misc/tune2fs.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> > > index 314cc0d0..724b8014 100644
> > > --- a/misc/tune2fs.c
> > > +++ b/misc/tune2fs.c
> > > @@ -198,7 +198,8 @@ static __u32 clear_ok_features[3] = {
> > >               EXT4_FEATURE_RO_COMPAT_QUOTA |
> > >               EXT4_FEATURE_RO_COMPAT_PROJECT |
> > >               EXT4_FEATURE_RO_COMPAT_METADATA_CSUM |
> > > -             EXT4_FEATURE_RO_COMPAT_READONLY
> > > +             EXT4_FEATURE_RO_COMPAT_READONLY |
> > > +             EXT4_FEATURE_RO_COMPAT_VERITY
> > >  };
> > >
> >
> > tune2fs doesn't allow removing features like encrypt, casefold, verity, extents,
> > and ea_inode because it doesn't know whether there are any inodes on the
> > filesystem that are using these features.  These features can't be removed if
> > there are any inodes using them.
>
> The verity case is slightly different though: beside metadata,
> encrypted files are useless.
> In the case of fs-verity, the file is still readable, its size is
> correct. Using debugfs, I checked the merkel tree blocks appended at
> the end of the file are still mapped to the file inode, they are
> marked as free when the file is removed.
> Are you concerned about filesystem corruption? When I re-enable the
> features and load a kernel that supports fs-verity, the protected
> files are signed and read-only as expected.

The problem is that the old, non-verity-aware kernel will allow writing to
verity files, because it ignores the verity inode flag.  That will get files'
data out of sync with their Merkle trees, and possibly corrupt their Merkle
trees.

This is why verity is a RO_COMPAT feature rather than a COMPAT one.  This
ensures that if the kernel isn't aware of verity, then the filesystem can only
be mounted read-only.

How about making 'tune2fs -O ^verity' remove the verity flag from all files
that have it and remove their Merkle trees by truncating blocks past i_size?
Would that work for you, or do you really need the verity-ness of files to be
preserved over 'tune2fs -O ^verity; tune2fs -O verity'?

- Eric
