Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B7F284C9A
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 15:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFNfr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Oct 2020 09:35:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38434 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725891AbgJFNfr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Oct 2020 09:35:47 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 096DZXt3013005
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Oct 2020 09:35:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 40893420107; Tue,  6 Oct 2020 09:35:33 -0400 (EDT)
Date:   Tue, 6 Oct 2020 09:35:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201006133533.GC5797@mit.edu>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost>
 <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006050306.GA8098@localhost>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 10:03:06PM -0700, Josh Triplett wrote:
> 
> I'm not trying to create a problem here; I'm trying to address a whole
> family of problems. I was generally under the impression that mounting
> existing root filesystems fell under the scope of the kernel<->userspace
> or kernel<->existing-system boundary, as defined by what the kernel
> accepts and existing userspace has used successfully, and that upgrading
> the kernel should work with existing userspace and systems. If there's
> some other rule that applies for filesystems, I'm not aware of that.
> (I'm also not trying to suggest that every random corner case of what
> the kernel *could* accept needs to be the format definition, but rather,
> cases that correspond to existing userspace.)

I'm not opposed to the kernel side change; it's *this time*.  I'm more
interested in killing off the tool that generated the malformed file
system in the first place.  As I keep pointing out, things aren't
going to go well if "e2fsck -E unshare_blocks" is applied to it.  So
users who use this unofficial tool to create this file system is can
run into at least this corner case, if not others, and that will
result in, as the UI designers like to say, "a poor user experience".

We had a similar issue with Android.  Many years ago, Andy Rubin was
originally quite allergic to the GPL, and had tried to promulgate the
rule, "no GPL in Android Userspace".  This is why bionic is used as
libc, and this resulted in Android engineers (I think before the
Google acquisition, but I'm not 100% sure), creating an unofficial,
"unauthorized" make_ext4fs which was a BSD-licensed version of mke2fs.

Unfortuantely, it created file systems which the kernel would never
complain about, but which, 50% of the time, would result in a file
system which under some circumstances, would get corrupted (even more)
when e2fsck attempted to repair the file system.  So if a user had a
bit flip caused by an eMMC hiccup, e2fsck could end up making things
worse.

Worse, make_ext4fs had over time, grown extra functionality, such as
pre-setting the SELinux xattrs, such that you couldn't just replace it
with mke2fs.  It took *years* to fix the problem, and that's why
contrib/e2fsdroid exists today.  We finally, a few years ago, were
able to retire make_ext4fs and replace it with the combination of
mke2fs and e2fsdroid.

So that's why I really don't like it when there are "unauthorized",
unofficial tools creating file systems out there which we are now
obliged to support.  Even if it's OK as far as the kernel is
concerned, unless you're planning on forking and/or reimplementing all
of e2fsprogs, and doing so correctly, that way is going to cause
headaches for file system developers.

As far as I'm concerned, it's not just about on-disk file system
format, it's also about the official user space tools.  If you create
a file system which the kernel is happy with, but which wasn't created
using the official user space tools, file systems are so full of state
and permutations of how things should be done that the opportunities
for mischief are huge.

And what's especially aggravating is when it's done for petty reasons
--- whether it's trying to sae an extra 0.0003% of storage, or because
some VP was allergic to the GPL, it's stupid stuff.

> I don't *want* to rely on what apparently turned out to be an
> undocumented bug in the kernel's validator. That's why I was trying to
> fix the issue in what seemed like the right way, by detecting the
> situation and turning off the validator. That seemed like it would fully
> address the issue. If it would help, I could also supply a tiny filesystem
> image for regression testing.

I'm OK with working around the problem, and we're lucky that it's this
simple.... this time around.

But can we *please* take your custom tool out back and shoot it in the
head?  Like make_ext4fs, it's just going to cause more headaches down
the line.

And perhaps we need to make a policy that makes it clear that for file
systems, it's not just about "whatever the kernel happens to accept".
It should also be, "was it generated using an official version of the
userspace tools", at least as a consideration.  Yes, we can try to
make the kernel more strict, and that's a good thing to do, but
inevitably, as we make the kernel more strict, we can potentially
break other unffocial tools out there, and it's going to make it a lot
harder to be able to do backwards compatible format enhancements to
the file system.

						- Ted
