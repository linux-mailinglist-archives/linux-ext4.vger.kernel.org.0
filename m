Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAAF91C3F
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2019 07:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfHSFJa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Aug 2019 01:09:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35376 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbfHSFJa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Aug 2019 01:09:30 -0400
Received: from callcc.thunk.org ([12.235.16.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7J59HQU025745
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 01:09:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 75A46420843; Mon, 19 Aug 2019 01:09:17 -0400 (EDT)
Date:   Mon, 19 Aug 2019 01:09:17 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dongyang Li <dongyangli@ddn.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>
Subject: Re: [PATCH 2/2] mke2fs: set overhead in super block for bigalloc
Message-ID: <20190819050917.GD10349@mit.edu>
References: <20190816034834.29439-1-dongyangli@ddn.com>
 <20190816034834.29439-2-dongyangli@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816034834.29439-2-dongyangli@ddn.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 16, 2019 at 03:49:14AM +0000, Dongyang Li wrote:
> Fix a bug in handle_bad_blocks(), don't covert the bad block to
> cluster when marking it as used, the bitmap is still a block bitmap,
> will be coverted to cluster bitmap later.

Please separate the bug fix into a separate commit.

> Note: in kernel the overhead is the s_overhead_clusters field from
> struct ext4_super_block, it's named s_overhead_blocks in e2fsprogs

Please fix up the field name in e2fsprogs, again in a separate commit.

> +errcode_t ext2fs_convert_subcluster_bitmap_overhead(ext2_filsys fs,
> +						    ext2fs_block_bitmap *bitmap,
> +						    badblocks_list bb_list,
> +						    unsigned int *count);

So I really hate this abstraction which you've proposed.  It's very
mke2fs specific, and mixing the bb_list abstraction into bitmap is
just really ugly.

Instead let me suggest the following:

1) Have mke2fs unset the blocks in bb_list from the block bitmap.
2) Then have mke2fs call ext2fs_convert_subcluster_bitmap()
3) Create an abstraction which counts the number of clusters in the
   bitmap, by using find_first_set() and first_first_zero().
4) Let mke2fs call that function defined in (3) above on the
   converted cluster bitmap() to get the overhead in clusters
5) Iterate over the bb_list to set the clusters in the converted
   cluster-granularity allocation map.

The abstraction in (3) is much less mke2fs specific, and if you make
the abstraction take a starting and ending block count, there are
potentially other use cases (for example, counting the number of
clusters in use in a block group).

Cheers,

					- Ted
