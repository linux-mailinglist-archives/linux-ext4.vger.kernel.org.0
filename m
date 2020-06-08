Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7120C1F1465
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 10:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgFHIUK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Jun 2020 04:20:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:60068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgFHIUK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 8 Jun 2020 04:20:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19D2CB090;
        Mon,  8 Jun 2020 08:20:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BE0BF1E1283; Mon,  8 Jun 2020 10:20:07 +0200 (CEST)
Date:   Mon, 8 Jun 2020 10:20:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 00/10] ext4: fix inconsistency since reading old metadata
 from disk
Message-ID: <20200608082007.GJ13248@quack2.suse.cz>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526071754.33819-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Yi!

On Tue 26-05-20 15:17:44, zhangyi (F) wrote:
> Background
> ==========
> 
> This patch set point to fix the inconsistency problem which has been
> discussed and partial fixed in [1].
> 
> Now, the problem is on the unstable storage which has a flaky transport
> (e.g. iSCSI transport may disconnect few seconds and reconnect due to
> the bad network environment), if we failed to async write metadata in
> background, the end write routine in block layer will clear the buffer's
> uptodate flag, but the data in such buffer is actually uptodate. Finally
> we may read "old && inconsistent" metadata from the disk when we get the
> buffer later because not only the uptodate flag was cleared but also we
> do not check the write io error flag, or even worse the buffer has been
> freed due to memory presure.
> 
> Fortunately, if the jbd2 do checkpoint after async IO error happens,
> the checkpoint routine will check the write_io_error flag and abort the
> the journal if detect IO error. And in the journal recover case, the
> recover code will invoke sync_blockdev() after recover complete, it will
> also detect IO error and refuse to mount the filesystem.
> 
> Current ext4 have already deal with this problem in __ext4_get_inode_loc()
> and commit 7963e5ac90125 ("ext4: treat buffers with write errors as
> containing valid data"), but it's not enough.

Before we go and complicate ext4 code like this, I'd like to understand
what is the desired outcome which doesn't seem to be mentioned here, in the
commit 7963e5ac90125, or in the discussion you reference. If you have a
flaky transport that gives you IO errors, IMO it is not a bussiness of the
filesystem to try to fix that. I just has to make sure it properly reports
errors to userspace and (depending of errors= configuration) shuts itself
down to limit further damage. This patch seems to try to mask those errors
and that's, in my opinion, rather futile (as in you can hardly ever deal
with all the cases). BTW are you running these systems on flaky iSCSI with
errors=continue so that the errors don't shut the filesystem down
immediately?

								Honza

> [1] https://lore.kernel.org/linux-ext4/20190823030207.GC8130@mit.edu/
> 
> Description
> ===========
> 
> This patch set add and rework 7 wrapper functions of getting metadata
> blocks, replace all sb_bread() / sb_getblk*() / ext4_bread() and
> sb_breadahead*(). Add buffer_write_io_error() checking into them, if
> the buffer isn't uptodate and write_io_error flag was set, which means
> that the buffer has been failed to write out to disk, re-add the
> uptodate flag to prevent subsequent read operation.
> 
>  - ext4_sb_getblk(): works the same as sb_getblk(), use to replace all
>    sb_getblk() used for newly allocated blocks and getting buffers.
>  - ext4_sb_getblk_locked(): works the same as sb_getblk() except check &
>    fix buffer uotpdate flag, use to replace all sb_getblk() used for
>    getting buffers to read.
>  - ext4_sb_getblk_gfp(): gfp version of ext4_sb_getblk().
>  - ext4_sb_getblk_locked_gfp(): gfp version of ext4_sb_getblk_locked().
>  - ext4_sb_bread(): get buffer and submit read bio if buffer is actually
>    not uptodate.
>  - ext4_sb_bread_unmovable(): unmovable version of ext4_sb_bread().
>  - ext4_sb_breadahead_unmovable(): works the same to ext4_sb_bread_unmovable()
>    except skip submit read bio if failed to lock the buffer.
> 
> Patch 1-2: do some small change in ext4 inode eio simulation and add a
> helper in buffer.c, just prepare for below patches.
> Patch 3: add the ext4_sb_*() function to deal with the write_io_error
> flag in buffer.
> Patch 4-8: replace all sb_*() with ext4_sb_*() in ext4.
> Patch 9: deal with the buffer shrinking case, abort jbd2/fs when
> shrinking a buffer with write_io_error flag.
> Patch 10: just do some cleanup.
> 
> After this patch set, we need to use above 7 wrapper functions to
> get/read metadata block instead of invoke sb_*() functions defined in
> fs/buffer.h.
> 
> Test
> ====
> 
> This patch set is based on linux-5.7-rc7 and has been tests by xfstests
> in auto mode.
> 
> Thanks,
> Yi.
> 
> 
> zhangyi (F) (10):
>   ext4: move inode eio simulation behind io completeion
>   fs: pick out ll_rw_one_block() helper function
>   ext4: add ext4_sb_getblk*() wrapper functions
>   ext4: replace sb_getblk() with ext4_sb_getblk_locked()
>   ext4: replace sb_bread*() with ext4_sb_bread*()
>   ext4: replace sb_getblk() with ext4_sb_getblk()
>   ext4: switch to use ext4_sb_getblk_locked() in ext4_getblk()
>   ext4: replace sb_breadahead() with ext4_sb_breadahead()
>   ext4: abort the filesystem while freeing the write error io buffer
>   ext4: remove unused parameter in jbd2_journal_try_to_free_buffers()
> 
>  fs/buffer.c                 |  41 ++++++----
>  fs/ext4/balloc.c            |   6 +-
>  fs/ext4/ext4.h              |  60 ++++++++++++---
>  fs/ext4/extents.c           |  13 ++--
>  fs/ext4/ialloc.c            |   6 +-
>  fs/ext4/indirect.c          |  13 ++--
>  fs/ext4/inline.c            |   2 +-
>  fs/ext4/inode.c             |  53 +++++--------
>  fs/ext4/mmp.c               |   2 +-
>  fs/ext4/resize.c            |  24 +++---
>  fs/ext4/super.c             | 145 +++++++++++++++++++++++++++++++-----
>  fs/ext4/xattr.c             |   4 +-
>  fs/jbd2/transaction.c       |  20 +++--
>  include/linux/buffer_head.h |   1 +
>  include/linux/jbd2.h        |   3 +-
>  15 files changed, 277 insertions(+), 116 deletions(-)
> 
> -- 
> 2.21.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
