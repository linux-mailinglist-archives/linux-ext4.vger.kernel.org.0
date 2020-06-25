Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9020A4F0
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jun 2020 20:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406263AbgFYS05 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Jun 2020 14:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406256AbgFYS04 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Jun 2020 14:26:56 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668DCC08C5C1
        for <linux-ext4@vger.kernel.org>; Thu, 25 Jun 2020 11:26:56 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so7129771iow.7
        for <linux-ext4@vger.kernel.org>; Thu, 25 Jun 2020 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l62Z2a5PgiAq4ZmUBVqvCwQq3DajUH3St1Ba8gfiGw=;
        b=l6lKuv8JmIROX/wfwjDmzDFqcWgbkFGctMKwkyh1+FkbUWI/gE2NjwFeTWn4yt4BOr
         lSw+4pa0TuDZ/ed1dI/SU7EslwffsoMFX66aJlnrMERvEVGmx1jzNbIhzSW41PQki6YJ
         iW0sOaDM31DwKbF2d6q/83n9IEHkctR7EV1+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l62Z2a5PgiAq4ZmUBVqvCwQq3DajUH3St1Ba8gfiGw=;
        b=K/9iooG+xOwuo1CGKLceIklYMiMMqqEh72PzWMbhoAq8jDbVCPCJBLE6BVYFzUO2e6
         /kkTTJJh1rpPTCPzl1UfbMW41DU6f6WGh4c97INL6aVlLNzTlv+LC6t9yICot7L3p6Kl
         H5zppeu1y6WnZpyUX+ofiPkVYUzjOZmY6VIw3aJN5R+DImUWAKHnY57mjbD2/GYQXT3s
         ibC0pculUt2LhcGTLKgh7UutnPREIBHJZw7NHhgZuwTh/KtNBnT6Jknp/p1jM+j2LnlS
         85Usmu/U+8/UVApoIHbtSGVMdnKOmFrv1UMoz7pHdQD2/9ai5wOLCS+LrR+GRq8nz3KR
         Ja6w==
X-Gm-Message-State: AOAM533mk3lN7pS+UlSwikHnMLdr1BPEzSDxa/22ixM2fiWDVU/bHyK6
        hN60FjmUEesNC21FrA/u28ByAnfyoHQpuXYnUcRRLw==
X-Google-Smtp-Source: ABdhPJwXGBiBHqCPzWzUoJ8z/nYw/qdX1KAMCRUSDJ/tDRYcvKgl1knbdGcUZeSqBQOGoyvOndCC81l5ebKBsWGpKpc=
X-Received: by 2002:a05:6602:15ca:: with SMTP id f10mr39349040iow.52.1593109615636;
 Thu, 25 Jun 2020 11:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200624023107.182118-1-gwendal@chromium.org> <20200624024043.GA844@sol.localdomain>
 <CAPUE2uv0XXv40quqbKmdktgCD18DnSWh=Ekeiq2tAZOfmGmjGw@mail.gmail.com> <20200624160926.GA200774@gmail.com>
In-Reply-To: <20200624160926.GA200774@gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 25 Jun 2020 11:26:44 -0700
Message-ID: <CAPUE2utgfH2K=dVZ8o1QivjbFpq89G4sD4AgO+sBL8ZLF6f4=w@mail.gmail.com>
Subject: Re: [PATCH] tune2fs: allow remove VERITY
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 24, 2020 at 9:09 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jun 24, 2020 at 12:06:22AM -0700, Gwendal Grignou wrote:
> > On Tue, Jun 23, 2020 at 7:40 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Tue, Jun 23, 2020 at 07:31:07PM -0700, Gwendal Grignou wrote:
> > > > Allow verity flag to be removed from the susperblock:
> > > > Tests:
> > > > - check the signed file is readable by older kernel after flag
> > > > is removed. EXT4_VERITY_FL replaces EXT4_EXT_MIGRATE that has been
> > > > removed in 2009.
> > > > - when a new kernel is reinstalled, check reenabling verity flag
> > > > allow signature to be verified (fsverity measure ...).
> > > >
> > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > > ---
> > > >  misc/tune2fs.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> > > > index 314cc0d0..724b8014 100644
> > > > --- a/misc/tune2fs.c
> > > > +++ b/misc/tune2fs.c
> > > > @@ -198,7 +198,8 @@ static __u32 clear_ok_features[3] = {
> > > >               EXT4_FEATURE_RO_COMPAT_QUOTA |
> > > >               EXT4_FEATURE_RO_COMPAT_PROJECT |
> > > >               EXT4_FEATURE_RO_COMPAT_METADATA_CSUM |
> > > > -             EXT4_FEATURE_RO_COMPAT_READONLY
> > > > +             EXT4_FEATURE_RO_COMPAT_READONLY |
> > > > +             EXT4_FEATURE_RO_COMPAT_VERITY
> > > >  };
> > > >
> > >
> > > tune2fs doesn't allow removing features like encrypt, casefold, verity, extents,
> > > and ea_inode because it doesn't know whether there are any inodes on the
> > > filesystem that are using these features.  These features can't be removed if
> > > there are any inodes using them.
> >
> > The verity case is slightly different though: beside metadata,
> > encrypted files are useless.
> > In the case of fs-verity, the file is still readable, its size is
> > correct. Using debugfs, I checked the merkel tree blocks appended at
> > the end of the file are still mapped to the file inode, they are
> > marked as free when the file is removed.
> > Are you concerned about filesystem corruption? When I re-enable the
> > features and load a kernel that supports fs-verity, the protected
> > files are signed and read-only as expected.
>
> The problem is that the old, non-verity-aware kernel will allow writing to
> verity files, because it ignores the verity inode flag.  That will get files'
> data out of sync with their Merkle trees, and possibly corrupt their Merkle
> trees.
You're right, an older kernel modifying the verity file corrupts the
merkel tree and creates inconsistency between the blocks where the
merkel tree was and the inode information.
We could mark the file (not just the inode) as read only in
fsverity_ioctl_enable() but that's a layering violation.
>
> This is why verity is a RO_COMPAT feature rather than a COMPAT one.  This
> ensures that if the kernel isn't aware of verity, then the filesystem can only
> be mounted read-only.
It is indeed safe, but having the whole filesystem read-only is very
restrictive.

>
> How about making 'tune2fs -O ^verity' remove the verity flag from all files
> that have it and remove their Merkle trees by truncating blocks past i_size?
> Would that work for you, or do you really need the verity-ness of files to be
> preserved over 'tune2fs -O ^verity; tune2fs -O verity'?
The latter would be better. Another use case would be a filesystem on
an external device, shared by machines with different kernels. Even if
there are no fs-verity files, the older kernel can not mount it
read-write.
Removing the verity feature would break the trust in the filesystem
when the device is plugged in the original machine.

As long as the verified files are not extended (remove is fine), the
option flag can be removed. No solutions are satisfactory, but for
security sake, the current behavior is the safest.

Gwendal.

>
> - Eric
