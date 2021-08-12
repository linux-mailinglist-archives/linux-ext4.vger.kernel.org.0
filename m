Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540FE3EA708
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhHLPCF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 11:02:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38233 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234287AbhHLPCE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 11:02:04 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17CF1YOx021949
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 11:01:35 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5AF6B15C37C1; Thu, 12 Aug 2021 11:01:34 -0400 (EDT)
Date:   Thu, 12 Aug 2021 11:01:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/5] ext4: Speedup ext4 orphan inode handling
Message-ID: <YRU3zjcP5hukrsyt@mit.edu>
References: <20210811101006.2033-1-jack@suse.cz>
 <20210811101925.6973-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811101925.6973-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 11, 2021 at 12:19:13PM +0200, Jan Kara wrote:
> +static int ext4_orphan_file_del(handle_t *handle, struct inode *inode)
> +{
> +	struct ext4_orphan_info *oi = &EXT4_SB(inode->i_sb)->s_orphan_info;
> +	__le32 *bdata;
> +	int blk, off;
> +	int inodes_per_ob = ext4_inodes_per_orphan_block(inode->i_sb);
> +	int ret = 0;
> +
> +	if (!handle)
> +		goto out;
> +	blk = EXT4_I(inode)->i_orphan_idx / inodes_per_ob;
> +	off = EXT4_I(inode)->i_orphan_idx % inodes_per_ob;
> +	if (WARN_ON_ONCE(blk >= oi->of_blocks))
> +		goto out;
> +
> +	ret = ext4_journal_get_write_access(handle, inode->i_sb,
> +				oi->of_binfo[blk].ob_bh, EXT4_JTR_ORPHAN_FILE);
> +	if (ret)
> +		goto out;

If ext4_journal_get_write_access() fails, we effectively drop the
inode from the orphan list (as far as the in-memory inode is
concerned), although the inode will still be listed in the orphan
file.  This can be really unfortunate since if the inode gets
reallocated for some other purpose, since its inode number is left in
the orphan block, on the next remount, this could lead to data loss.

In the orphan list code, we leave the inode on the linked list, which
is not great, since that will prevent the inode from being freed, but
at least we're keeping the in-memory and on-disk state in sync and we
avoid the data loss scenario when the inode gets reused.

I'll also note that all or at least most of the callers of
ext4_orphan_del() are doing error checking, which also unfortunate
(although what are we supposed to do in case of a failure here?).

I think keeping things consistent with the existing non-optimal "error
handle" at least makes things no worse than before, but looking at the
error handling, I'm left with a sense of unease.  What do you think?

      		    	      	      - Ted
