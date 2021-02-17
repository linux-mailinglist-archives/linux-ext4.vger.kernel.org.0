Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6544031D45C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Feb 2021 05:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBQECG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Feb 2021 23:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhBQECD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Feb 2021 23:02:03 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270EFC061574
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 20:01:23 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id y199so13656079oia.4
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 20:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANgvTqrvC4DYjYxx38a/+PMAicbVz5b6Nwaxc/uQPMQ=;
        b=C3t1nILohbrhkHK56M6sxztXLC0ekqKf5XN2B42h4bPgZjFjsLYRlqrX41R0icBFbj
         4frrCwvtcZl93sjX2NYaSX69P4IEgzh1gWH+u2eAhyEwLX/FaJ6TmIZuVLhEiGDmWbw0
         ROSYd3+Uvika7xvhNOielJv6PfZodFHGEzOukBEAY3CDfhGvmqZb/9JTk4lj6ho0aAKJ
         cOMbYTSc6olEX8V+IbX7Qr2M/KVoT6izB/4laj5m/ONpqhjV2DBK3FI0UmeT7vSrG7w4
         mcNn0PxUaIkY2r+slJUPy8KsiUc8EXfM0n8RmJsgiZ+7SsGjeCQc9asLWCqtLG0sDB78
         Lxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANgvTqrvC4DYjYxx38a/+PMAicbVz5b6Nwaxc/uQPMQ=;
        b=TNtOGessoJwUadvg7bG0AIFHhkEFlQlBmRU9vxqIfuFTfmv3yFlKrzgXYSKks4SWXM
         AfXsXREuW4fXCezHLOt0UfdlsWccPceL1RSRYZrpDSH46dwIfgTl+8MWiEHyVMl2/0A/
         qWazeGG/vgCtqvs/CzFeivfajNv9JPbXEsJwzO5IdEFO7eJBttG9oDS2EphfEJyVexmL
         zCjV5Ay0OmU/RdbyV8rj11lNFOZvmcXKroJzJ3pTor/fvVa34OaoduBh1kNqxpphPYED
         TnkyNhh/YwEKRr4LUIbx+TRzTLKukXnYkVO2PYR0dKm9uVkOG3pxFI6FrYiDTeP1W6Hp
         bRNA==
X-Gm-Message-State: AOAM531k9l/hAv0aNOouXUCtLzPyv8MhBy/Ie4f7yRNh1gvIlX1FgMdX
        bU27zPUWs3Pf8Ij02Z7LhuZG/W9+ovddHrUSflhvTQ==
X-Google-Smtp-Source: ABdhPJzt+PsCGGMNvePij/bC62mS3vzVF5T1CaJyFch91VEq5u081INTOdXf/2FCoVKb9I4DFfP4cYezPdgLU9UOO8M=
X-Received: by 2002:aca:2812:: with SMTP id 18mr3477701oix.65.1613534482325;
 Tue, 16 Feb 2021 20:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20210203090745.4103054-2-drosen@google.com> <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca>
 <YBrP4NXAsvveIpwA@mit.edu> <YCMZSjgUDtxaVem3@mit.edu> <42511E9D-3786-4E70-B6BE-D7CB8F524912@dilger.ca>
 <YCNbIdCsAsNcPuAL@mit.edu>
In-Reply-To: <YCNbIdCsAsNcPuAL@mit.edu>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 16 Feb 2021 20:01:11 -0800
Message-ID: <CA+PiJmT2hfdRLztCdp3-tYBqAo+-ibmuyqLvq5nb+asFj4vL7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ext4: Handle casefolding with encryption
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I'm not sure what the conflict is, at least format-wise. Naturally,
there would need to be some work to reconcile the two patches, but my
patch only alters the format for directories which are encrypted and
casefolded, which always must have the additional hash field. In the
case of dirdata along with encryption and casefolding, couldn't we
have the dirdata simply follow after the existing data? Since we
always already know the length, it'd be unambiguous where that would
start. Casefolding can only be altered on an empty directory, and you
can only enable encryption for an empty directory, so I'm not too
concerned there. I feel like having it swapping between the different
methods makes it more prone to bugs, although it would be doable. I've
started rebasing the dirdata patch on my end to see how easy it is to
mix the two. At a glance, they touch a lot of the same areas in
similar ways, so it shouldn't be too hard. It's more of a question of
which way we want to resolve that, and which patch goes first.

I've been trying to figure out how many devices in the field are using
casefolded encryption, but haven't found out yet. The code is
definitely available though, so I would not be surprised if it's being
used, or is about to be.

-Daniel
On Tue, Feb 9, 2021 at 8:03 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Feb 09, 2021 at 08:03:10PM -0700, Andreas Dilger wrote:
> > Depending on the size of the "escape", it probably makes sense to move
> > toward having e2fsck migrate from the current mechanism to using dirdata
> > for all deployments.  In the current implementation, tools don't really
> > know for sure if there is data beyond the filename in the dirent or not.
>
> It's actually quite well defined.  If dirdata is enabled, then we
> follow the dirdata rules.  If dirdata is *not* enabled, then if a
> directory inode has the case folding and encryption flags set, then
> there will be cryptographic data immediately following the filename.
> Otherwise, there is no valid data after the filename.
>
> > For example, what if casefold is enabled on an existing filesystem that
> > already has an encrypted directory?  Does the code _assume_ that there is
> > a hash beyond the name if the rec_len is long enough for this?
>
> No, we will only expect there to be a hash beyond the name if
> EXT4_CASEFOLD_FL and EXT4_ENCRYPT_FL flags are set on the inode.  (And
> if the rec_len is not large enough, then that's a corrupted directory
> entry.)
>
> > I guess it is implicit with the casefold+encryption case for dirents in
> > directories that have the encryption flag set in a filesystem that also
> > has casefold enabled, but it's definitely not friendly to these features
> > being enabled on an existing filesystem.
>
> No, it's fine.  That's because the EXT4_CASEFOLD_FL inode flag can
> only be set if the EXT4_FEATURE_INCOMPAT_CASEFOLD is set in the
> superblock, and EXT4_ENCRYPT_FL inode flag can only be set if
> EXT4_FEATURE_INCOMPAT_ENCRYPT is set in the superblock, this is why it
> will be safe to enable of these features, since merely enabling the
> file system features only allows new directories to be created with
> both CASEFOLD_FL and ENCRYPT_FL set.
>
> The only restriction we would have is a file system has both the case
> folding and encryption features, it will *not* be safe to set the
> dirdata feature flag without first scanning all of the directories to
> see if there are any directories that have both the casefold and
> encrypt flags set on that inode, and if so, to convert all of the
> directory entries to use dirdata.  I don't think this is going to be a
> significant restriction in practice, though.
>
>                                                 - Ted
>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
