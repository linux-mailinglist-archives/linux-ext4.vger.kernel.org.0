Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF0A1F11B6
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 05:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgFHDcW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 23:32:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbgFHDcV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 7 Jun 2020 23:32:21 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 72B11F343B1D7C55C030;
        Mon,  8 Jun 2020 11:32:19 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.198) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 11:32:11 +0800
Subject: Re: [PATCH 00/10] ext4: fix inconsistency since reading old metadata
 from disk
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <zhangxiaoxu5@huawei.com>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <9404b417-73ea-c80c-5313-30f159378675@huawei.com>
Date:   Mon, 8 Jun 2020 11:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200526071754.33819-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.198]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi，Ted and Jan, any suggestions of this patch set?

Thanks,
Yi.

On 2020/5/26 15:17, zhangyi (F) wrote:
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
> 
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

