Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6134F289199
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbgJITJJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 15:09:09 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:62387 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJITJA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 15:09:00 -0400
X-Originating-IP: 67.5.25.97
Received: from localhost (unknown [67.5.25.97])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A1360240004;
        Fri,  9 Oct 2020 19:08:52 +0000 (UTC)
Date:   Fri, 9 Oct 2020 12:08:48 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201009190848.GB4649@localhost>
References: <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008175448.GA6532@magnolia>
 <20201008223858.GC45658@localhost>
 <20201009025409.GB6532@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009025409.GB6532@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 08, 2020 at 07:54:09PM -0700, Darrick J. Wong wrote:
> On Thu, Oct 08, 2020 at 03:38:58PM -0700, Josh Triplett wrote:
> > On Thu, Oct 08, 2020 at 10:54:48AM -0700, Darrick J. Wong wrote:
> > > > > the head", and continued with the notion that anything other than
> > > > > e2fsprogs making something to be mounted by mount(2) and handled by
> > > > > fs/ext4 is being "inflicted", and if the goal didn't still seem to be
> > > > > "how do we make it go away so that only e2fsprogs and the kernel ever
> > > > > touch ext4". I started this thread because I'd written some userspace
> > > > > code, a new version of the kernel made that userspace code stop working,
> > > > > so I wanted to report that the moment I'd discovered that, along with a
> > > > > potential way to address it with as little disrupton to ext4 as
> > > > > possible.
> > > 
> > > Ted: I don't think it's a good idea to make SHARED_BLOCKS disable block
> > > validity checking by default.  You could someday enable users to write
> > > to block-sharing files by teaching ext4 how to COW, at which point you'd
> > > need correct bitmaps and block validity to prevent accidental overwrite
> > > of critical metadata.  At that point you'd either be stuck with the
> > > precedent that SHARED_BLOCKS implies noblock_validity, or you'd end up
> > > breaking Josh's images again.
> > 
> > That's a fair point (though I think a writable COW version of
> > SHARED_BLOCKS would need a different flag). It'd make more sense to key
> > this logic off of RO_COMPAT_READONLY or similar. But even better:
> 
> It wouldn't require a new flag -- "rocompat" features bits mean that
> "it's safe to allow userspace to read files off the disk if software
> doesn't recognize this feature bit".

Sure; I was more thinking that if that involved adding some data
structures to track shared blocks and the need to COW, whatever
mechanism that used might potentially need an incompat flag.

> If someone /did/ add the code to write to files safely in the presence
> of shared blocks, all they'd have to do to light up the functionality is
> add it to the _SUPP define.  Also, it's strange that the kernel source
> doesn't even know of SHARED_BLOCKS, but that's also on Ted...

It would be nice if the kernel's ext4.h header and e2fsprogs were fully
in sync, yes.

- Josh Triplett
