Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 443A0168705
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 19:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgBUSyE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 13:54:04 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53829 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbgBUSyD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 13:54:03 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01LIrvZF014282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 13:53:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B88524211EF; Fri, 21 Feb 2020 13:53:56 -0500 (EST)
Date:   Fri, 21 Feb 2020 13:53:56 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ext4: fix race between writepages and enabling
 EXT4_EXTENTS_FL
Message-ID: <20200221185356.GC741939@mit.edu>
References: <20200219183047.47417-1-ebiggers@kernel.org>
 <20200219183047.47417-3-ebiggers@kernel.org>
 <20200220091548.GB13232@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220091548.GB13232@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 20, 2020 at 10:15:48AM +0100, Jan Kara wrote:
> On Wed 19-02-20 10:30:47, Eric Biggers wrote:
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
> > s_writepages_rwsem (previously called s_journal_flag_rwsem).
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
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

						- Ted
