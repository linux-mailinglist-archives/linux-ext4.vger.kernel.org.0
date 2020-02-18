Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28731621B0
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 08:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgBRHtR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 02:49:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:50774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgBRHtR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 18 Feb 2020 02:49:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C130AE06;
        Tue, 18 Feb 2020 07:49:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A2BE51E0CF7; Tue, 18 Feb 2020 08:49:14 +0100 (CET)
Date:   Tue, 18 Feb 2020 08:49:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: fix race between writepages and enabling
 EXT4_EXTENTS_FL
Message-ID: <20200218074914.GD16121@quack2.suse.cz>
References: <20200218002151.1581441-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218002151.1581441-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 17-02-20 16:21:51, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> If EXT4_EXTENTS_FL is set on an inode while ext4_writepages() is running
> on it, the following warning in ext4_add_complete_io() can be hit:
> 
> WARNING: CPU: 1 PID: 0 at fs/ext4/page-io.c:234 ext4_put_io_end_defer+0xf0/0x120
> 
> Here's a minimal reproducer (not 100% reliable) (root isn't required):
> 
> 	while true; do
> 		sync
> 	done &
> 	while true; do
> 		rm -f file
> 		touch file
> 		chattr -e file
> 		echo X >> file
> 		chattr +e file
> 	done
> 
> The problem is that in ext4_writepages(), ext4_should_dioread_nolock()
> (which only returns true on extent-based files) is checked once to set
> the number of reserved journal credits, and also again later to select
> the flags for ext4_map_blocks() and copy the reserved journal handle to
> ext4_io_end::handle.  But if EXT4_EXTENTS_FL is being concurrently set,
> the first check can see dioread_nolock disabled while the later one can
> see it enabled, causing the reserved handle to unexpectedly be NULL.
> 
> Fix this by checking ext4_should_dioread_nolock() only once and storing
> the result in struct mpage_da_data.  This way, each ext4_writepages()
> call uses a consistent dioread_nolock setting.
> 
> This was originally reported by syzbot without a reproducer at
> https://syzkaller.appspot.com/bug?extid=2202a584a00fffd19fbf,
> but now that dioread_nolock is the default I also started seeing this
> when running syzkaller locally.
> 
> Reported-by: syzbot+2202a584a00fffd19fbf@syzkaller.appspotmail.com
> Fixes: 6b523df4fb5a ("ext4: use transaction reservation for extent conversion in ext4_end_io")
> Cc: stable@kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

What you propose is probably enough to stop this particular race but I
think there are other races that can get triggered by inode conversion
to/from extent format. So I think we rather need to make inode
format conversion much more careful (or we could just remove that
functionality because I'm not sure if anybody actually uses it).

WRT making inode format conversion more careful you can have a look at how
ext4_change_inode_journal_flag() works. I uses EXT4_I(inode)->i_mmap_sem to
block page faults, it also uses sbi->s_journal_flag_rwsem to avoid races
with writepages and I belive the migration code should do the same.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
