Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B36285A08
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Oct 2020 10:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgJGIDT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Oct 2020 04:03:19 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60515 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGIDQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Oct 2020 04:03:16 -0400
X-Originating-IP: 67.5.25.97
Received: from localhost (unknown [67.5.25.97])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 35A5860041;
        Wed,  7 Oct 2020 08:03:07 +0000 (UTC)
Date:   Wed, 7 Oct 2020 01:03:04 -0700
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
Message-ID: <20201007080304.GB1112@localhost>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost>
 <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006133533.GC5797@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 06, 2020 at 09:35:33AM -0400, Theodore Y. Ts'o wrote:
> On Mon, Oct 05, 2020 at 10:03:06PM -0700, Josh Triplett wrote:
> > I'm not trying to create a problem here; I'm trying to address a whole
> > family of problems. I was generally under the impression that mounting
> > existing root filesystems fell under the scope of the kernel<->userspace
> > or kernel<->existing-system boundary, as defined by what the kernel
> > accepts and existing userspace has used successfully, and that upgrading
> > the kernel should work with existing userspace and systems. If there's
> > some other rule that applies for filesystems, I'm not aware of that.
> > (I'm also not trying to suggest that every random corner case of what
> > the kernel *could* accept needs to be the format definition, but rather,
> > cases that correspond to existing userspace.)
>
> I'm not opposed to the kernel side change; it's *this time*.

I appreciate that. (Does that mean you wouldn't object to this patch
going into 5.9, with Jens' Reviewed-by and your ack?)

> I'm more interested in killing off the tool that generated the
> malformed file system in the first place.

It was developed for a reason, and it's not intended for general-purpose
use. It serves its purpose, which has nothing to do with e2fsprogs or
any component of e2fsprogs. It does not simply create filesystem images,
in the way that mke2fs or e2fsdroid does.

If I'd found any existing code that would have worked, or could have
been adapted to work, I would have happily reused it; I don't like
reinventing the wheel.

Also, see below regarding e2fsck.

> As I keep pointing out, things aren't going to go well if "e2fsck -E
> unshare_blocks" is applied to it.

These aren't intended to *ever* become writable. I've ensured that
they're marked with EXT4_FEATURE_RO_COMPAT_READONLY as well, which I
would hope implies that. Would that be sufficient to convince e2fsck
that it should never attempt to apply unshare_blocks to it?

Also, it seems like most of block_validity is trying to carefully avoid
metadata blocks intersecting with the journal, which could cause all
manner of issues; the filesystems I'm working with have no journal
(because they're permanently read-only).

With the sole exception of the shared bitmap block, I have it as a
requirement to pass e2fsck with zero complaints. If you'd be willing to
take a patch to e2fsck along the same lines as this kernel patch, then
I'd be happy to add it to the regression test suite: no filesystem
images that e2fsck is unhappy with. Would that help?

As mentioned before, I'd also be happy to supply some representative
filesystem images.

> We had a similar issue with Android.  Many years ago, Andy Rubin was
> originally quite allergic to the GPL, and had tried to promulgate the
> rule, "no GPL in Android Userspace".  This is why bionic is used as
> libc, and this resulted in Android engineers (I think before the
> Google acquisition, but I'm not 100% sure), creating an unofficial,
> "unauthorized" make_ext4fs which was a BSD-licensed version of mke2fs.

That is indeed a sad reason to develop anything. It's also particularly
sad to develop a different tool to serve exactly the same purpose as an
existing tool.

As opposed to, in this case, developing a different piece of software
to serve different purposes, that happens to make use of ext4 as one
component.

> Unfortuantely, it created file systems which the kernel would never
> complain about, but which, 50% of the time, would result in a file
> system which under some circumstances, would get corrupted (even more)
> when e2fsck attempted to repair the file system.  So if a user had a
> bit flip caused by an eMMC hiccup, e2fsck could end up making things
> worse.

I'd be interested in reading more about that, if you could suggest a
link or the right search terms. I did find
https://bugzilla.kernel.org/show_bug.cgi?id=195561 , which references the
issues in the same way you've done here, but I didn't find any of the
specific details you're mentioning here about what made the images it
created fragile.

I did see you mention, there, the advice of making sure to check
filesystems with e2fsck. That's something I've done from day one: I
didn't stop until e2fsck was happy, not just the kernel.

> So that's why I really don't like it when there are "unauthorized",
> unofficial tools creating file systems out there which we are now
> obliged to support.

ext4 is an incredibly powerful and performant filesystem, with a
reasonably well-documented format and many useful properties. Not all
software that works with ext4 is going to live in e2fsprogs, nor should
it need to.

This would be analogous to the notion that (say) the FreeBSD kernel
belongs in the e2fsprogs repository because it has an ext4 driver. The
tail would be wagging the dog.

> Even if it's OK as far as the kernel is
> concerned, unless you're planning on forking and/or reimplementing all
> of e2fsprogs, and doing so correctly, that way is going to cause
> headaches for file system developers.

I haven't recreated or reimplemented e2fsprogs, and I have no desire to
do so. It seems like, as a result of the make_ext4fs debacle, you're
seeing any other software working with ext4 as an instance of
reinventing the wheel (and failing to make that wheel round, because
hey, it still rolls). That's not the case here.

> > I don't *want* to rely on what apparently turned out to be an
> > undocumented bug in the kernel's validator. That's why I was trying to
> > fix the issue in what seemed like the right way, by detecting the
> > situation and turning off the validator. That seemed like it would fully
> > address the issue. If it would help, I could also supply a tiny filesystem
> > image for regression testing.
> 
> I'm OK with working around the problem, and we're lucky that it's this
> simple.... this time around.
> 
> But can we *please* take your custom tool out back and shoot it in the
> head?

Nope. As mentioned, this isn't about creating ext4 filesystem images,
and it isn't even remotely similar to mke2fs.

> And perhaps we need to make a policy that makes it clear that for file
> systems, it's not just about "whatever the kernel happens to accept".
> It should also be, "was it generated using an official version of the
> userspace tools", at least as a consideration.

I don't think that's a reasonable policy at all, no.

"Should pass e2fsck" would be a relatively reasonable policy, assuming
that e2fsck doesn't ratchet up strictness in a way that breaks existing
filesystems. I think it'd be reasonable to recommend against trying to
push the boundaries of what the kernel accepts but e2fsck doesn't,
without a concrete plan to improve e2fsck and the filesystem
documentation.

- Josh Triplett
