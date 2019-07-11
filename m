Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C053465A49
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2019 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfGKPXa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jul 2019 11:23:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:58150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728026AbfGKPX3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Jul 2019 11:23:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDEDEAF57;
        Thu, 11 Jul 2019 15:23:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2D2A41E43CB; Thu, 11 Jul 2019 17:23:28 +0200 (CEST)
Date:   Thu, 11 Jul 2019 17:23:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>
Cc:     'Jan Kara' <jack@suse.cz>,
        Thomas Walker <Thomas.Walker@twosigma.com>,
        "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "'tytso@mit.edu'" <tytso@mit.edu>
Subject: Re: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Message-ID: <20190711152328.GB2449@quack2.suse.cz>
References: <9abbdde6145a4887a8d32c65974f7832@exmbdft5.ad.twosigma.com>
 <20181108184722.GB27852@magnolia>
 <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com>
 <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
 <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-07-19 14:40:43, Geoffrey Thomas wrote:
> On Thursday, July 11, 2019 5:23 AM, Jan Kara <jack@suse.cz> wrote: 
> > On Wed 26-06-19 11:17:54, Thomas Walker wrote:
> > > Sorry to revive a rather old thread, but Elana mentioned that there might
> > > have been a related fix recently?  Possibly something to do with
> > > truncate?  A quick scan of the last month or so turned up
> > > https://www.spinics.net/lists/linux-ext4/msg65772.html but none of these
> > > seemed obviously applicable to me.  We do still experience this phantom
> > > space usage quite frequently (although the remount workaround below has
> > > lowered the priority).
> > 
> > I don't recall any fix for this. But seeing that remount "fixes" the issue
> > for you can you try whether one of the following has a similar effect?
> > 
> > 1) Try "sync"
> > 2) Try "fsfreeze -f / && fsfreeze -u /"
> > 3) Try "echo 3 >/proc/sys/vm/drop_caches"
> > 
> > Also what is the contents of
> > /sys/fs/ext4/<problematic-device>/delayed_allocation_blocks
> > when the issue happens?
> 
> We just had one of these today, and no luck from any of those.
> delayed_allocation_blocks is 1:

...

This is very strange because failed remount read-only (with EBUSY) doesn't
really do more than what "sync; echo 3 >/proc/sys/vm/drop_caches" does. I
suspect there's really some userspace taking up space and cleaning up on
umount. Anyway once this happens again, can you do:

fsfreeze -f /
e2image -r /dev/disk/by-uuid/523c8243-5a25-40eb-8627-f3bbf98ec299 - | \
  xz >some_storage.xz
fsfreeze -u /

some_storage.xz can be on some usb stick or so. It will dump ext4 metadata
to the file. Then please provide some_storage.xz for download somewhere.
Thanks! BTW I'll be on vacation next two weeks so it will take a while to
get to this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
