Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014CD2687A4
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Sep 2020 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgINIya (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Sep 2020 04:54:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:57386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgINIy3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Sep 2020 04:54:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE7AEAC46;
        Mon, 14 Sep 2020 08:54:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F0BDF1E12ED; Mon, 14 Sep 2020 10:54:27 +0200 (CEST)
Date:   Mon, 14 Sep 2020 10:54:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Constantine Sapuntzakis <costa@purestorage.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: Fix superblock checksum calculation race
Message-ID: <20200914085427.GC4863@quack2.suse.cz>
References: <20200911211603.5653-1-costa@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911211603.5653-1-costa@purestorage.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 11-09-20 15:16:03, Constantine Sapuntzakis wrote:
> The race condition could cause the persisted superblock checksum
> to not match the contents of the superblock, causing the
> superblock to be considered corrupt.
> 
> An example of the race follows.  A first thread is interrupted in the
> middle of a checksum calculation. Then, another thread changes the
> superblock, calculates a new checksum, and sets it. Then, the first
> thread resumes and sets the checksum based on the older superblock.
> 
> To fix, serialize the superblock checksum calculation using the buffer
> header lock. While a spinlock is sufficient, the buffer header is
> already there and there is precedent for locking it (e.g. in
> ext4_commit_super).
> 
> Tested the patch by booting up a kernel with the patch, creating
> a filesystem and some files (including some orphans), and then
> unmounting and remounting the file system.
> 
> Suggested-by: Jan Kara <jack@suse.cz>

Thanks for the patch!  Please add your Signed-off-by line to the patch to
certify that you've written the patch and agree with it being included in
the kernel (see "Developer's Certificate of Origin 1.1" in
Documentation/process/submitting-patches.rst for more details). Without it
the patch cannot be included. Otherwise it looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Thanks
									Honza

> ---
>  fs/ext4/super.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ea425b49b345..3f7fdce5ab05 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -201,7 +201,18 @@ void ext4_superblock_csum_set(struct super_block *sb)
>  	if (!ext4_has_metadata_csum(sb))
>  		return;
>  
> +	/*
> +	 * Locking the superblock prevents the scenario
> +	 * where:
> +	 *  1) a first thread pauses during checksum calculation.
> +	 *  2) a second thread updates the superblock, recalculates
> +	 *     the checksum, and updates s_checksum
> +	 *  3) the first thread resumes and finishes its checksum calculation
> +	 *     and updates s_checksum with a potentially stale or torn value.
> +	 */
> +	lock_buffer(EXT4_SB(sb)->s_sbh);
>  	es->s_checksum = ext4_superblock_csum(sb, es);
> +	unlock_buffer(EXT4_SB(sb)->s_sbh);
>  }
>  
>  ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
