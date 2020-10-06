Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152962845C6
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 08:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgJFGDf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Oct 2020 02:03:35 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37625 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgJFGDf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Oct 2020 02:03:35 -0400
X-Greylist: delayed 3620 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 02:03:34 EDT
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 2496B200006;
        Tue,  6 Oct 2020 06:03:29 +0000 (UTC)
Date:   Mon, 5 Oct 2020 23:03:27 -0700
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
Message-ID: <20201006060327.GA9227@localhost>
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

On Mon, Oct 05, 2020 at 10:03:13PM -0700, Josh Triplett wrote:
> On Mon, Oct 05, 2020 at 11:18:34PM -0400, Theodore Y. Ts'o wrote:
> > What Josh is proposing I'm pretty sure would also break "e2fsck -E
> > unshare_blocks", so that's another reason not to accept this as a
> > valid format change.
> 
> The kernel already accepted this as a valid mountable filesystem format,
> without a single error or warning of any kind, and has done so stably
> for years.
> 
> > As far as I'm concerned, contrib/e2fsdroid is the canonical definition
> > of how to create valid file systems with shared_blocks.
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
> 
> It wouldn't be *impossible* to work around this, this time; it may be
> possible to adapt the existing userspace to work on the new and old
> kernels. My concern is, if a filesystem format accepted by previous
> kernels can be rejected by future kernels, what stops a future kernel
> from further changing the format definition or its strictness
> (co-evolving with one specific userspace) and causing further
> regressions?
> 
> I don't *want* to rely on what apparently turned out to be an
> undocumented bug in the kernel's validator. That's why I was trying to
> fix the issue in what seemed like the right way, by detecting the
> situation and turning off the validator. That seemed like it would fully
> address the issue. If it would help, I could also supply a tiny filesystem
> image for regression testing.
> 
> I'm trying to figure out what solution you'd like to see here, as long
> as it isn't "any userspace that isn't e2fsdroid can be broken at will".
> I'd be willing to work to adapt the userspace bits I have to work around
> the regression, but I'd like to get this on the radar so this doesn't
> happen again.

To clarify something further: I'm genuinely not looking to push hard on
the limits or corners of the kernel/userspace boundary here, nor do I
want to create an imposition on development. I'm happy to attempt to be
a little more flexible than most userspace. I'm trying to make
substantial, non-trivial use of the userspace side of a kernel/userspace
boundary, and within reason, I need to rely on the kernel's stability
guarantees. I'm relying on the combination of
Documentation/filesystems/ext4 and fs/ext4 as the format documentation.
The first time I discovered this issue was in doing some "there's about
to be a new kernel release" regression testing for 5.9, in which it
created a debugging adventure to track down what the problem was. I'd
like to find a good way to report and handle this kind of thing going
forward, if another issue like this arises.

- Josh Triplett
