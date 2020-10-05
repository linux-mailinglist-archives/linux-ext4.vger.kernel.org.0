Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B489D2833E3
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Oct 2020 12:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgJEKQv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 06:16:51 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40039 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEKQt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Oct 2020 06:16:49 -0400
X-Greylist: delayed 7303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 06:16:48 EDT
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3C0DD20009;
        Mon,  5 Oct 2020 10:16:42 +0000 (UTC)
Date:   Mon, 5 Oct 2020 03:16:41 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201005101641.GA516771@localhost>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005094601.GB4225@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005094601.GB4225@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 11:46:01AM +0200, Jan Kara wrote:
> On Mon 05-10-20 01:14:54, Josh Triplett wrote:
> > Ran into an ext4 regression when testing upgrades to 5.9-rc kernels:
> > 
> > Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
> > ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
> > with intentionally overlapping bitmap blocks.
> > 
> > On an always-read-only filesystem explicitly marked with
> > EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
> > point all the block and inode bitmaps to a single block of all 1s,
> > because a read-only filesystem will never allocate or free any blocks or
> > inodes.
> > However, after that commit, the block validity check rejects such
> > filesystems with -EUCLEAN and "failed to initialize system zone (-117)".
> > This causes systems that previously worked correctly to fail when
> > upgrading to v5.9-rc2 or later.
> > 
> > This was obviously a bugfix, and I'm not suggesting that it should be
> > reverted; it looks like this effectively worked by accident before,
> > because the block_validity check wasn't fully functional. However, this
> > does break real systems, and I'd like to get some kind of regression fix
> > in before 5.9 final if possible. I think it would suffice to make
> > block_validity default to false if and only if
> > EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is set.
> > 
> > Does that seem like a reasonable fix?
> 
> Well, but EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is your internal feature
> that's not present in current upstream kernel AFAICS.

It isn't "my" feature; the value for
EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is defined in the headers in the
e2fsprogs tree. The kernel currently does absolutely nothing with it,
nor did it previously need to; it's just an RO_COMPAT feature which
ensures that the kernel can only mount the filesystem read-only. The
point is that an always-read-only filesystem will never change the block
or inode bitmaps, so ensuring they don't overlap is unnecessary (and
harmful).

I only added EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS to the header to
generate the corresponding ext4_has_feature_shared_blocks function.

I have filesystems that previous kernels mounted and worked with just
fine, and new kernels reject. That seems like a regression to me. I'm
suggesting the simplest possible way I can see to fix that regression.

Another approach would be to default block_validity to false for any
read-only filesystem mount (since it won't be written to), but that
seemed like it'd be more invasive; I was going for a more minimal
change.
