Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497E8653B3
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2019 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfGKJXS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jul 2019 05:23:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728121AbfGKJXS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Jul 2019 05:23:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BE18ADF1;
        Thu, 11 Jul 2019 09:23:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E07FB1E3C3B; Thu, 11 Jul 2019 11:23:15 +0200 (CEST)
Date:   Thu, 11 Jul 2019 11:23:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thomas Walker <Thomas.Walker@twosigma.com>
Cc:     "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "'tytso@mit.edu'" <tytso@mit.edu>,
        Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>
Subject: Re: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Message-ID: <20190711092315.GA10473@quack2.suse.cz>
References: <9abbdde6145a4887a8d32c65974f7832@exmbdft5.ad.twosigma.com>
 <20181108184722.GB27852@magnolia>
 <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com>
 <20190626151754.GA2789@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626151754.GA2789@twosigma.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 26-06-19 11:17:54, Thomas Walker wrote:
> Sorry to revive a rather old thread, but Elana mentioned that there might
> have been a related fix recently?  Possibly something to do with
> truncate?  A quick scan of the last month or so turned up
> https://www.spinics.net/lists/linux-ext4/msg65772.html but none of these
> seemed obviously applicable to me.  We do still experience this phantom
> space usage quite frequently (although the remount workaround below has
> lowered the priority). 

I don't recall any fix for this. But seeing that remount "fixes" the issue
for you can you try whether one of the following has a similar effect?

1) Try "sync"
2) Try "fsfreeze -f / && fsfreeze -u /"
3) Try "echo 3 >/proc/sys/vm/drop_caches"

Also what is the contents of
/sys/fs/ext4/<problematic-device>/delayed_allocation_blocks
when the issue happens?

								Honza

> 
> On Wed, Jan 23, 2019 at 02:59:22PM -0500, Thomas Walker wrote:
> > Unfortunately this still continues to be a persistent problem for us.  On another example system:
> > 
> > # uname -a
> > Linux <hostname> 4.14.67-ts1 #1 SMP Wed Aug 29 13:28:25 UTC 2018 x86_64 GNU/Linux
> > 
> > # df -h /
> > Filesystem                                              Size  Used Avail Use% Mounted on
> > /dev/disk/by-uuid/<uuid>                                 50G   46G  1.1G  98% /
> > 
> > # df -hi /
> > Filesystem                                             Inodes IUsed IFree IUse% Mounted on
> > /dev/disk/by-uuid/<uuid>                                 3.2M  306K  2.9M   10% /
> > 
> > # du -hsx  /
> > 14G     /
> > 
> > And confirmed not to be due to sparse files or deleted but still open files.
> > 
> > The most interesting thing that I've been able to find so far is this:
> > 
> > # mount -o remount,ro /
> > mount: / is busy
> > # df -h /
> > Filesystem                                              Size  Used Avail Use% Mounted on
> > /dev/disk/by-uuid/<uuid>                                 50G   14G   33G  30% /
> > 
> > Something about attempting (and failing) to remount read-only frees up all of the phantom space usage.
> > Curious whether that sparks ideas in anyone's mind?
> > 
> > I've tried all manner of other things without success.  Unmounting all of the overlays.  Killing off virtually all of usersapce (dropping to single user).  Dropping page/inode/dentry caches.Nothing else (short of a reboot) seems to give us the space back.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
