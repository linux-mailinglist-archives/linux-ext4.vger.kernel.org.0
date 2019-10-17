Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96EFCDB127
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2019 17:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbfJQPcV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Oct 2019 11:32:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388925AbfJQPcV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 17 Oct 2019 11:32:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF847B56C;
        Thu, 17 Oct 2019 15:32:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 34CEE1E485F; Thu, 17 Oct 2019 17:32:17 +0200 (CEST)
Date:   Thu, 17 Oct 2019 17:32:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Daegyu Han <hdg9400@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Why doesn't disk io occur to read file system metadata despite
 clearing dentry and inode with drop_cache command?
Message-ID: <20191017153217.GB27576@quack2.suse.cz>
References: <CAARcW+qa7aRbh+BeFWTndGLC8owsy9VPUqcJ-BYN-Yw3jQM-_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAARcW+qa7aRbh+BeFWTndGLC8owsy9VPUqcJ-BYN-Yw3jQM-_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Wed 11-09-19 15:27:07, Daegyu Han wrote:
> I am confused about "echo # >/proc/sys/vm/drop_caches" and blockdev
> --flushbufs.  According to OSStep book written by Remzi,If the target
> inodes are not cached in memory, disk IO should be occur to readthe
> inode, which will make a dentry data structure on memory.  To my
> knowledge, echo 3 >/proc/sys/vm/drop_caches is to drop(clear) page
> cahche, inodes and dentry. I have experimented with blktrace to figure
> out whether disk io is really occurring to read the inode.
> 
> 1. echo 3 > /proc/sys/vm/drop_caches
> However, there is no disk io to read inode. I can only see the disk io
> to read 16KB data block.
> 2. echo 3 > /proc/sys/vm/drop_caches` and `blockdev --flushbufs
> /dev/nvme0n1I found block access (+8(512*8=4KB)) to read inode.
> 
> A quick look at how blockdev --flushbufs works in the kernel code shows
> that it clears the superblock.  Why doesn't disk io occur to read inodes
> with drop_cache alone?  The kernel book called ULK says that inodes and
> superblocks are cached in buffer-cache.Is this the reason for this?  I
> infer as follows:Is the buffer_head data structure not flushed to disk by
> drop_cache alone because the storage device is still mapped in memory?

Yes, I guess that's what happened. Note that drop_caches drop only clean
and unreferenced inodes, dentries & page cache. So if the inode is dirty
(e.g. due to atime update pending), drop caches won't free it. Another
effect may be that something (e.g. the jbd2 journal) holds onto the buffer
caching the inode table block with the inode.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
