Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5BF4787D3
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Dec 2021 10:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhLQJft (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Dec 2021 04:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233088AbhLQJfr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 Dec 2021 04:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639733746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmnpl2iegSuF51b6nPRuLZJPWzdNLSMyzB0gc5C1OOk=;
        b=hp9f1duiScT7iGNcaAFbn6d1EeQYxJCsSIizp3XLWxD/u820y4zHMmYwV9axkHlz8urMcP
        sFwPpXPFu7x89nEGXLnEVGQ9GRCZGnTjumJv3jSx3SkXjmPjKG8zEd1lK3cpqbNqWl+2RY
        5sDoxxmpeOHOyM4ps+n//MDCbX1kan4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556--E9jagY6Op-HQLeue0Zbzw-1; Fri, 17 Dec 2021 04:35:42 -0500
X-MC-Unique: -E9jagY6Op-HQLeue0Zbzw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 330D42FD1B;
        Fri, 17 Dec 2021 09:35:41 +0000 (UTC)
Received: from work (unknown [10.40.194.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3A2E7A5C2;
        Fri, 17 Dec 2021 09:35:38 +0000 (UTC)
Date:   Fri, 17 Dec 2021 10:35:34 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <20211217093534.2ug6e5cm37md2c3u@work>
References: <20211214175058.19511-1-lhenriques@suse.de>
 <20211215004945.GD69182@magnolia>
 <20211215112852.GM14044@quack2.suse.cz>
 <20211215141237.lrymhbebgjunh4n2@work>
 <YbuGLsQy6TSM2xOl@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbuGLsQy6TSM2xOl@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 16, 2021 at 01:32:14PM -0500, Theodore Ts'o wrote:
> On Wed, Dec 15, 2021 at 03:12:37PM +0100, Lukas Czerner wrote:
> > > Run fsck of course! And then recover from backups :) I know this is sad but
> > > the situation is that our migration code just is not crash-safe (if we
> > > crash we are going to free blocks that are still used by the migrated
> > > inode) and Luis makes it work in case we do not crash (which should be
> > > hopefully more common) and documents it does not work in case we crash.
> > > So overall I'd call it a win.
> > > 
> > > But maybe we should just remove this online-migration functionality
> > > completely from the kernel? That would be also a fine solution for me. I
> > > was thinking whether we could somehow make the inode migration crash-safe
> > > but I didn't think of anything which would not require on-disk format
> > > change...
> > 
> > Since this is not something that anyone can honestly recommend doing
> > without a prior backup and a word of warning I personaly would be in favor
> > of removing it.
> 
> So there are a couple options that we could pursue:
> 
> 1) We could change the migrate code to stop putting the orphan inode
> on the orphan list.  If we do this, an crash in the middle of the
> migrate will, in the worst case (when the migration isn't completed
> within a single jbd2 transaction) result in a leaked inode.  That's
> not ideal, but it won't lead user data loss, and e2fsck will recover
> the situation by cloning the blocks, and leaving the inode in
> lost+found.
> 
> 2) We could try to ensure migration happens all within a single
> transaction, if they all fit inside a the inode structure, we allocate
> a tmp inode for all of the indirect blocks, attach the blocks to the
> tmp inode, place the tmp inode on the orphan list, and put all of that
> on a single handle, and then in a second handle, truncate the tmp
> inode to release the indirect blocks.  If we need to allocate extent
> tree blocks, then all of that would need to fit in a single
> transaction, and it's a bit more complicated, but it is doable.
> 
> 3) We can simply remove the inode migration feature by removing
> EXT4_EXTENTS_FL from EXT4_FL_USER_MODIFIABLE, and changing the
> implementation of the EXT4_IOC_MIGRATE ioctl to return EOPNOTSUPP, and
> then cleaning up the code paths that are now unreachable.
> 
> The migration feature is clearly less compelling than it was ten years
> ago, when ext4 was first introduced --- and most enterprise distros
> have never supported the feature even when it has existed.  Also on
> the plus side, we've never shipped a program to globally migrate a
> file system by using ioctl interface.
> 
> On the other hand, there may have been user shell scripts that have
> done something like "find /mntpt -type f -print0 | xargs -0 chattr +e {} \;"
> And so option #3 could be construed as "breaking userspace", especially
> without a deprecation window.
> 
> Furthermore, Option #1 is pretty simple to implement, and chances of a
> migration getting spread across two jbd2 commits is not actually
> pretty low.  And if it does happen, there would only be a single inode
> that would get its blocks cloned and attached to lost+found.
> 
> Thats being said, if we *did* option #1, in the long run we'd want to
> land a complete solution, which would either be something like option
> #2, or allocating a flag to give a hint to e2fsprogs that if it does
> find an leaked inode with with the flag set on the on-disk inode, that
> all it needs to do is to zero out the inode and be done with it.
> 
> So the question is, is it worth it to continue supporting the migrate
> feature, or should we just delete all of the migration code, and risk
> users complaining that we've broken their use case?  The chances of
> that happening is admittedly low, and Linus's rule that "it's only
> breaking userspace if a user complains" means we might very well get
> away with it.  :-)

That's a very good summary Ted, thanks.

Our rationale behind not supporting the migration was always the fact
that we felt that backup was absolutely necessary before operation like
this. When you already have up-to-date backup available you might as
well create a fresh ext4 file system with all the advantages it brings
and recover data from said backup. I think this is still a very
reasonable approach.

I have no doubt it was useful featrure in the early days of ext4, but I
think we're well past that. Any attempt to rework or fix the feature
assumes it's still useful and has it's users today and into the future.
I very much doubt that, so let's test it. Let's start a year long
deprecation window.

-Lukas

> 
> 						- Ted
> 

