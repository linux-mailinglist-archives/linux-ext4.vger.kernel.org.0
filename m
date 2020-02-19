Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3A164DA7
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2020 19:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSS3o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Feb 2020 13:29:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgBSS3o (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Feb 2020 13:29:44 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950D920801;
        Wed, 19 Feb 2020 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582136983;
        bh=GM2tZkBx+Ffxja5cfikINLqzNGEaP4EDD/oYC2S2yco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nzj6HjDvSyT9+H7J/j5P3Yz5GU5CYvT/w1oh5klpZYk0zgkNKLByRU0ly1gLAjFZp
         nIK4rSnqXyXnijvrMpcUAcGWdcuUI6wRhmd+82oj6Y4VfjDYbtKw0Qq/qc6PPkoqZX
         6GBLIxBBeazAXkphlu4wqppkHIoRgpKn0hm42fq4=
Date:   Wed, 19 Feb 2020 10:29:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2] ext4: fix race between writepages and enabling
 EXT4_EXTENTS_FL
Message-ID: <20200219182942.GC2312@sol.localdomain>
References: <20200219053523.87474-1-ebiggers@kernel.org>
 <20200219104422.GN16121@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219104422.GN16121@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 19, 2020 at 11:44:22AM +0100, Jan Kara wrote:
> On Tue 18-02-20 21:35:23, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > If EXT4_EXTENTS_FL is set on an inode while ext4_writepages() is running
> > on it, the following warning in ext4_add_complete_io() can be hit:
> > 
> > WARNING: CPU: 1 PID: 0 at fs/ext4/page-io.c:234 ext4_put_io_end_defer+0xf0/0x120
> > 
> > Here's a minimal reproducer (not 100% reliable) (root isn't required):
> > 
> >         while true; do
> >                 sync
> >         done &
> >         while true; do
> >                 rm -f file
> >                 touch file
> >                 chattr -e file
> >                 echo X >> file
> >                 chattr +e file
> >         done
> > 
> > The problem is that in ext4_writepages(), ext4_should_dioread_nolock()
> > (which only returns true on extent-based files) is checked once to set
> > the number of reserved journal credits, and also again later to select
> > the flags for ext4_map_blocks() and copy the reserved journal handle to
> > ext4_io_end::handle.  But if EXT4_EXTENTS_FL is being concurrently set,
> > the first check can see dioread_nolock disabled while the later one can
> > see it enabled, causing the reserved handle to unexpectedly be NULL.
> > 
> > Since changing EXT4_EXTENTS_FL is uncommon, and there may be other races
> > related to doing so as well, fix this by synchronizing changing
> > EXT4_EXTENTS_FL with ext4_writepages() via the existing
> > s_journal_flag_rwsem -- renamed to s_writepages_rwsem.
> > 
> > This was originally reported by syzbot without a reproducer at
> > https://syzkaller.appspot.com/bug?extid=2202a584a00fffd19fbf,
> > but now that dioread_nolock is the default I also started seeing this
> > when running syzkaller locally.
> > 
> > Reported-by: syzbot+2202a584a00fffd19fbf@syzkaller.appspotmail.com
> > Fixes: 6b523df4fb5a ("ext4: use transaction reservation for extent conversion in ext4_end_io")
> > Cc: stable@kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> The patch looks good to me. Just I'd split out the renaming to a separate
> patch. 
> 

Sure, I'll do that.

- Eric
