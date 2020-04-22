Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4591B49EB
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDVQMQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 12:12:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgDVQMQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Apr 2020 12:12:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EF4EAAC52;
        Wed, 22 Apr 2020 16:12:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2A9C01E0E56; Wed, 22 Apr 2020 18:12:14 +0200 (CEST)
Date:   Wed, 22 Apr 2020 18:12:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 1/2] ext4: remove EXT4_GET_BLOCKS_KEEP_SIZE flag
Message-ID: <20200422161214.GE20756@quack2.suse.cz>
References: <20200415203140.30349-1-enwlinux@gmail.com>
 <20200415203140.30349-2-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415203140.30349-2-enwlinux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-04-20 16:31:39, Eric Whitney wrote:
> The eofblocks code was removed in the 5.7 release by "ext4: remove
> EOFBLOCKS_FL and associated code" (4337ecd1fe99).  The ext4_map_blocks()
> flag used to trigger it can now be removed as well.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/ext4.h              |  2 --
>  fs/ext4/extents.c           |  4 ----
>  fs/ext4/inode.c             | 12 ++++--------
>  include/trace/events/ext4.h |  1 -
>  4 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 91eb4381cae5..c8d060627448 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -609,8 +609,6 @@ enum {
>  #define EXT4_GET_BLOCKS_METADATA_NOFAIL		0x0020
>  	/* Don't normalize allocation size (used for fallocate) */
>  #define EXT4_GET_BLOCKS_NO_NORMALIZE		0x0040
> -	/* Request will not result in inode size update (user for fallocate) */
> -#define EXT4_GET_BLOCKS_KEEP_SIZE		0x0080
>  	/* Convert written extents to unwritten */
>  #define EXT4_GET_BLOCKS_CONVERT_UNWRITTEN	0x0100
>  	/* Write zeros to newly created written extents */
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 031752cfb6f7..18ede2f9e4ad 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4507,8 +4507,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	}
>  
>  	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
> -	if (mode & FALLOC_FL_KEEP_SIZE)
> -		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
>  
>  	/* Wait all existing dio workers, newcomers will block on i_mutex */
>  	inode_dio_wait(inode);
> @@ -4647,8 +4645,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  
>  	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
>  	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
> -	if (mode & FALLOC_FL_KEEP_SIZE)
> -		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
>  
>  	inode_lock(inode);
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e416096fc081..97562c51c1c9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -432,11 +432,9 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
>  	 */
>  	down_read(&EXT4_I(inode)->i_data_sem);
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		retval = ext4_ext_map_blocks(handle, inode, map, flags &
> -					     EXT4_GET_BLOCKS_KEEP_SIZE);
> +		retval = ext4_ext_map_blocks(handle, inode, map, 0);
>  	} else {
> -		retval = ext4_ind_map_blocks(handle, inode, map, flags &
> -					     EXT4_GET_BLOCKS_KEEP_SIZE);
> +		retval = ext4_ind_map_blocks(handle, inode, map, 0);
>  	}
>  	up_read((&EXT4_I(inode)->i_data_sem));
>  
> @@ -541,11 +539,9 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  	 */
>  	down_read(&EXT4_I(inode)->i_data_sem);
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		retval = ext4_ext_map_blocks(handle, inode, map, flags &
> -					     EXT4_GET_BLOCKS_KEEP_SIZE);
> +		retval = ext4_ext_map_blocks(handle, inode, map, 0);
>  	} else {
> -		retval = ext4_ind_map_blocks(handle, inode, map, flags &
> -					     EXT4_GET_BLOCKS_KEEP_SIZE);
> +		retval = ext4_ind_map_blocks(handle, inode, map, 0);
>  	}
>  	if (retval > 0) {
>  		unsigned int status;
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 19c87661eeec..40ff8a2fc763 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -45,7 +45,6 @@ struct partial_cluster;
>  	{ EXT4_GET_BLOCKS_CONVERT,		"CONVERT" },		\
>  	{ EXT4_GET_BLOCKS_METADATA_NOFAIL,	"METADATA_NOFAIL" },	\
>  	{ EXT4_GET_BLOCKS_NO_NORMALIZE,		"NO_NORMALIZE" },	\
> -	{ EXT4_GET_BLOCKS_KEEP_SIZE,		"KEEP_SIZE" },		\
>  	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" })
>  
>  /*
> -- 
> 2.11.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
