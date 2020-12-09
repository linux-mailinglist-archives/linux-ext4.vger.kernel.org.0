Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1702D39FA
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Dec 2020 05:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgLIE4F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 23:56:05 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53735 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727421AbgLIE4F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 23:56:05 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B94tFNa025393
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Dec 2020 23:55:16 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BEF19420136; Tue,  8 Dec 2020 23:55:15 -0500 (EST)
Date:   Tue, 8 Dec 2020 23:55:15 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/8] ext4: add a helper function to validate metadata
 block
Message-ID: <20201209045515.GH52960@mit.edu>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-6-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604764698-4269-6-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Nov 07, 2020 at 11:58:16PM +0800, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> There is a need to check whether a block or a segment overlaps
> with metadata, since information of system_zone is incomplete,
> we need a more accurate function. Now we check whether it
> overlaps with block bitmap, inode bitmap, and inode table.
> Perhaps it is better to add a check of super_block and block
> group descriptor and provide a helper function.

The original code was valid only for file systems that are not using
flex_bg.  I suspect the Lustre folks who implemented mballoc.c did so
before flex_bg, and fortunately, on flex_bg we the check is simply
going to have more false negaties, but not any false positives, so no
one noticed.

> +/*
> + * Returns 1 if the passed-in block region (block, block+count)
> + * overlaps with some other filesystem metadata blocks. Others,
> + * return 0.
> + */
> +int ext4_metadata_block_overlaps(struct super_block *sb,
> +				 ext4_group_t block_group,
> +				 ext4_fsblk_t block,
> +				 unsigned long count)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_group_desc *gdp;
> +	int gd_first = ext4_group_first_block_no(sb, block_group);
> +	int itable, gd_blk;
> +	int ret = 0;
> +
> +	gdp = ext4_get_group_desc(sb, block_group, NULL);
> +	// check block bitmap and inode bitmap
> +	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
> +	    in_range(ext4_inode_bitmap(sb, gdp), block, count))

We are only checking a single block group descriptor; this is fine if
the allocation bitmaps and inode table are guaranteed to be located in
their own block group.  But this is no longer true when flex_bg is
enabled.

I think what we should do is to rely on the rb tree maintained by
block_validity.c (if the inode number is zero, then the entry refers
to blocks in the "system zone"); that's going to be a much more
complete check.

What do you think?

						- Ted
