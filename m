Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA1163C4B
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2020 05:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBSE4x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 23:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgBSE4x (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 18 Feb 2020 23:56:53 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4BB24656;
        Wed, 19 Feb 2020 04:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582088212;
        bh=xFc6OcTuvdGiMRsQCXREU/om/wxR+1L+h7QD0F0PHt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmbrDewhEPgRU39s62+lRWvxOOFM5NqFhHOPHyUKb/FDV2QLIkeuHzJeFvnhczGmA
         0N46enSeEPKwwr6V6uI9n2rMvGqC08LBGaKvLFKq5yxnd3LL1ckBfhv1J99u71Tl07
         G9NZ1k5lw1dkJdhMTLJNUitRSBSVkKPHDOR+3UPY=
Date:   Tue, 18 Feb 2020 20:56:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] ext4: fix race between writepages and enabling
 EXT4_EXTENTS_FL
Message-ID: <20200219045651.GF1075@sol.localdomain>
References: <20200218002151.1581441-1-ebiggers@kernel.org>
 <20200218074914.GD16121@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218074914.GD16121@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 18, 2020 at 08:49:14AM +0100, Jan Kara wrote:
> On Mon 17-02-20 16:21:51, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > If EXT4_EXTENTS_FL is set on an inode while ext4_writepages() is running
> > on it, the following warning in ext4_add_complete_io() can be hit:
> > 
> > WARNING: CPU: 1 PID: 0 at fs/ext4/page-io.c:234 ext4_put_io_end_defer+0xf0/0x120
> > 
> > Here's a minimal reproducer (not 100% reliable) (root isn't required):
> > 
> > 	while true; do
> > 		sync
> > 	done &
> > 	while true; do
> > 		rm -f file
> > 		touch file
> > 		chattr -e file
> > 		echo X >> file
> > 		chattr +e file
> > 	done
> > 
> > The problem is that in ext4_writepages(), ext4_should_dioread_nolock()
> > (which only returns true on extent-based files) is checked once to set
> > the number of reserved journal credits, and also again later to select
> > the flags for ext4_map_blocks() and copy the reserved journal handle to
> > ext4_io_end::handle.  But if EXT4_EXTENTS_FL is being concurrently set,
> > the first check can see dioread_nolock disabled while the later one can
> > see it enabled, causing the reserved handle to unexpectedly be NULL.
> > 
> > Fix this by checking ext4_should_dioread_nolock() only once and storing
> > the result in struct mpage_da_data.  This way, each ext4_writepages()
> > call uses a consistent dioread_nolock setting.
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
> What you propose is probably enough to stop this particular race but I
> think there are other races that can get triggered by inode conversion
> to/from extent format. So I think we rather need to make inode
> format conversion much more careful (or we could just remove that
> functionality because I'm not sure if anybody actually uses it).
> 
> WRT making inode format conversion more careful you can have a look at how
> ext4_change_inode_journal_flag() works. I uses EXT4_I(inode)->i_mmap_sem to
> block page faults, it also uses sbi->s_journal_flag_rwsem to avoid races
> with writepages and I belive the migration code should do the same.

I was looking at that earlier, but I was a bit concerned that people could
complain about a performance regression due to EXTENTS_FL no longer being
settable/clearable on different files concurrently.

But if we think this functionality is rarely used and that no one would care,
then sure, we should go with that solution instead.  I'll probably rename
s_journal_flag_rwsem to s_writepages_rwsem since it will become for both the
EXTENTS and JOURNAL_DATA flags.

- Eric
