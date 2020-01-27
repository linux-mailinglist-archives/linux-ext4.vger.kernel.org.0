Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6920149EFF
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2020 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgA0G3X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jan 2020 01:29:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50874 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725763AbgA0G3X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jan 2020 01:29:23 -0500
Received: from callcc.thunk.org (170.sub-174-194-206.myvzw.com [174.194.206.170])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00R6TDhu004369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 01:29:17 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8283A420324; Sun, 26 Jan 2020 23:15:49 -0500 (EST)
Date:   Sun, 26 Jan 2020 23:15:49 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Li Dongyang <dongyangli@ddn.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>
Subject: Re: [PATCH v3 4/5] mke2fs: set overhead in super block
Message-ID: <20200127041549.GC115399@mit.edu>
References: <20191120043448.249988-1-dongyangli@ddn.com>
 <20191120043448.249988-4-dongyangli@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120043448.249988-4-dongyangli@ddn.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 20, 2019 at 04:35:27AM +0000, Li Dongyang wrote:
> If overhead is not recorded in the super block, it is caculated
> during mount in kernel, for bigalloc file systems the it takes
> O(groups**2) in time.
> For a 1PB deivce with 32K cluste size it takes ~12 mins to
> mount, with most of the time spent on figuring out overhead.
> 
> While we can not improve the overhead algorithm in kernel
> due to the nature of bigalloc, we can work out the overhead
> during mke2fs and set it in the super block, avoiding calculating
> it every time when it mounts.
> 
> Overhead is s_first_data_block plus internal journal blocks plus
> the block and inode bitmaps, inode table, super block backups and
> group descriptor blocks for every group. This patch introduces
> ext2fs_count_used_clusters(), which calculates the clusters used
> in the block bitmap for the given range.
> 
> When bad blocks are involved, it gets tricky because the blocks
> counted as overhead and the bad blocks can end up in the same
> allocation cluster. In this case we will unmark the bad blocks from
> the block bitmap, convert to cluster bitmap and get the overhead,
> then mark the bad blocks back in the cluster bitmap.
> 
> Reset the overhead to zero when resizing, we can not simplly count
> the used blocks as overhead like we do when mke2fs. The overhead
> can be calculated by kernel side during mount.
> 
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

Applied, but I had to fix up a number of spelling errors in the commit
description, and fix up a large number of test failures caused by this
change.

	     	     	  	       	  - Ted
