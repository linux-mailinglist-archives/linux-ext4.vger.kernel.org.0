Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162051F3A86
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jun 2020 14:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgFIMTZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Jun 2020 08:19:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:43324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgFIMTY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 9 Jun 2020 08:19:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94662AF76;
        Tue,  9 Jun 2020 12:19:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A7A771E1283; Tue,  9 Jun 2020 14:19:20 +0200 (CEST)
Date:   Tue, 9 Jun 2020 14:19:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 00/10] ext4: fix inconsistency since reading old metadata
 from disk
Message-ID: <20200609121920.GB12551@quack2.suse.cz>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
 <20200608082007.GJ13248@quack2.suse.cz>
 <cc834f50-95f0-449a-0ace-c55c41d2be1c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc834f50-95f0-449a-0ace-c55c41d2be1c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Yi!

On Mon 08-06-20 22:39:31, zhangyi (F) wrote:
> > On Tue 26-05-20 15:17:44, zhangyi (F) wrote:
> >> Background
> >> ==========
> >>
> >> This patch set point to fix the inconsistency problem which has been
> >> discussed and partial fixed in [1].
> >>
> >> Now, the problem is on the unstable storage which has a flaky transport
> >> (e.g. iSCSI transport may disconnect few seconds and reconnect due to
> >> the bad network environment), if we failed to async write metadata in
> >> background, the end write routine in block layer will clear the buffer's
> >> uptodate flag, but the data in such buffer is actually uptodate. Finally
> >> we may read "old && inconsistent" metadata from the disk when we get the
> >> buffer later because not only the uptodate flag was cleared but also we
> >> do not check the write io error flag, or even worse the buffer has been
> >> freed due to memory presure.
> >>
> >> Fortunately, if the jbd2 do checkpoint after async IO error happens,
> >> the checkpoint routine will check the write_io_error flag and abort the
> >> the journal if detect IO error. And in the journal recover case, the
> >> recover code will invoke sync_blockdev() after recover complete, it will
> >> also detect IO error and refuse to mount the filesystem.
> >>
> >> Current ext4 have already deal with this problem in __ext4_get_inode_loc()
> >> and commit 7963e5ac90125 ("ext4: treat buffers with write errors as
> >> containing valid data"), but it's not enough.
> > 
> > Before we go and complicate ext4 code like this, I'd like to understand
> > what is the desired outcome which doesn't seem to be mentioned here, in the
> > commit 7963e5ac90125, or in the discussion you reference. If you have a
> > flaky transport that gives you IO errors, IMO it is not a bussiness of the
> > filesystem to try to fix that. I just has to make sure it properly reports
> 
> If we meet some IO errors due to the flaky transport, IMO the desired outcome
> is 1) report IO error; 2) ext4 filesystem act as the "errors=xxx" configuration
> specified, if we set "errors=read-only || panic", we expect ext4 could remount
> to read-only or panic immediately to avoid inconsistency. In brief, the kernel
> should try best to guarantee the filesystem on disk is consistency, this will
> reduce fsck's work (AFAIK, the fsck cannot fix those inconsistent in auto mode
> for most cases caused by the async error problem I mentioned), so we could
> recover the fs automatically in next boot.

Good, so I fully agree with your goals. Let's now talk about how to achieve
them :)

> But now, in the case of metadata async writeback, (1) is done in
> end_buffer_async_write(), but (2) is not guaranteed, because ext4 cannot detect
> metadata write error, and it also cannot remount the filesystem or invoke panic
> immediately. Finally, if we read the metadata on disk and re-write again, it
> may lead to on-disk filesystem inconsistency.

Ah, I see. This was the important bit I was missing. And I think the
real problem here is that ext4 cannot detect metadata write error from
async writeback. So my plan would be to detect metadata write errors early
and abort the journal and do appropriate errors=xxx handling. And a
relatively simple way how to do that these days would be to use errseq in
the block device's mapping - sb->s_bdev->bd_inode->i_mapping->wb_err - that
gets incremented whenever there's writeback error in the block device
mapping so (probably in ext4_journal_check_start()) we could check whether
wb_err is different from the original value we sampled at mount time an if
yes, we know metadata writeback error has happened and we trigger the error
handling. What do you think?

> > errors to userspace and (depending of errors= configuration) shuts itself
> > down to limit further damage. This patch seems to try to mask those errors
> > and that's, in my opinion, rather futile (as in you can hardly ever deal
> > with all the cases). BTW are you running these systems on flaky iSCSI with
> > errors=continue so that the errors don't shut the filesystem down
> > immediately?
> > 
> Yes, I run ext4 filesystem on a flaky iSCSI(it is stable most of the time)
> with errors=read-only, in the cases mentioned above, the fs will not be
> remount to read-only immediately or remount after it has already been
> inconsistency.
> 
> Thinking about how to fix this, one method is to invoke ext4_error() or
> jbd2_journal_abort() when we detect write error to prevent further use of
> the filesystem. But after looking at __ext4_get_inode_loc() and 7963e5ac90125,
> I think although the metadata buffer was failed to write back to the disk due
> to the occasional unstable network environment, but the data in the buffer
> is actually uptodate, the filesystem could self-healing after the network
> recovery. In the worst case, if the network is broken for a long time, the
> jbd2's checkpoint routing will detect the error, or jbd2 will failed to write
> the journal to disk, both will abort the filesystem. So I think we could
> re-set the uptodate flag when we read buffer again as 7963e5ac90125 does.

Yeah, but I'm actually against such self-healing logic. IMHO it is too
fragile and also fairly intrusive as your patches show. If we wanted
something like this, we'd need to put a hard thought into whether a
functionality like this belongs to ext4 or to some layer below it (e.g.
think how multipath handles temporary path failures). And even if we
decided it's worth the trouble in the filesystem, I'd rather go and change
how fs/buffer.c deals with buffer writeback errors than resetting uptodate
bits on buffers which just seems dangerous to me...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
