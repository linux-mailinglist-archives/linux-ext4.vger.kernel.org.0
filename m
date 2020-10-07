Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49132868DC
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Oct 2020 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgJGUOf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Oct 2020 16:14:35 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55565 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGUOf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Oct 2020 16:14:35 -0400
X-Originating-IP: 67.5.25.97
Received: from localhost (unknown [67.5.25.97])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A2D4060002;
        Wed,  7 Oct 2020 20:14:27 +0000 (UTC)
Date:   Wed, 7 Oct 2020 13:14:24 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201007201424.GB15049@localhost>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost>
 <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007143211.GA235506@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 07, 2020 at 10:32:11AM -0400, Theodore Y. Ts'o wrote:
> On Wed, Oct 07, 2020 at 01:03:04AM -0700, Josh Triplett wrote:
> > > But can we *please* take your custom tool out back and shoot it in the
> > > head?
> > 
> > Nope. As mentioned, this isn't about creating ext4 filesystem images,
> > and it isn't even remotely similar to mke2fs.
> 
> Can you please tell us what your tool is for, then?  Why are you doing
> this?  Why are you inflicting this on us?

That sounds like a conversation that would have been a lot more
interesting and enjoyable if it hadn't started with "can we shoot it in
the head", and continued with the notion that anything other than
e2fsprogs making something to be mounted by mount(2) and handled by
fs/ext4 is being "inflicted", and if the goal didn't still seem to be
"how do we make it go away so that only e2fsprogs and the kernel ever
touch ext4". I started this thread because I'd written some userspace
code, a new version of the kernel made that userspace code stop working,
so I wanted to report that the moment I'd discovered that, along with a
potential way to address it with as little disruption to ext4 as
possible.

I'm not looking to be an alternative userspace, or an alternative
anything; that implies serving more-or-less the same function
differently. I have no interest in supplanting mke2fs or any other part
of e2fsprogs; I'm using those for many of the purposes they already
serve.

The short version is that I needed a library to rapidly turn
dynamically-obtained data into a set of disk blocks to be served
on-the-fly as a software-defined disk, and then mounted on the other
side of that interface by the Linux kernel. Turns out that's *many
orders of magnitude* faster than any kind of network filesystem like
NFS. It's slightly similar to a vvfat for ext4. The less blocks it can
generate and account for and cache, the faster it can run, and
microseconds matter.

ext4 has *incredible* compatibility guarantees. I'd already understood
the whole compat/ro_compat mechanism when I read through the on-disk
format documentation and the code. RO_COMPAT_SHARED_BLOCKS *seemed* like
the right semantic description of "don't ever try to write to this
filesystem because there are deduplicated blocks", and
RO_COMPAT_READONLY seemed like the right semantic description for "don't
ever try to write this, it's permanently read-only for unspecified
reasons".

If those aren't the right way to express that, I could potentially
adapt. I had a similar such conversation on linux-ext4 already (about
inline data with 128-bit inodes), which led to me choosing to abandon
128-byte inodes rather than try to get ext4 to support what I wanted
with them, because I didn't want to be disruptive to ext4 for a niche
use case. In the particular case that motivated this thread, what I was
doing already worked in previous kernels, and it seemed reasonable to
ask for it to continue to work in new kernels, while preserving the
newly added checks in the new kernels.

If the response here had been more along the lines of "could we create
and use a *different* compat flag for shared metadata and have
RO_COMPAT_SHARED_BLOCKS only mean shared data blocks", I'd be fine with
that.

If at some point I'm looking to make ext4 support more than it already
does (e.g. a way to omit bitmaps entirely, or a way to express
contiguous files with smaller extent maps, or other enhancements for
read-only filesystems), I'd be coming with architectural discussions
first, patches second, and at no point would I have the expectation that
ext4 folks need to do extra work on my behalf. I'm happy to do the work.
The *only* thing I'm asking, here, is "don't break things that worked".
And after this particular item, I'd be happy to narrow that to "don't
break things that e2fsck was previously happy with".

- Josh Triplett
