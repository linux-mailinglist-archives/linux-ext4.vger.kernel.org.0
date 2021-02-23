Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1CF322E9B
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhBWQTa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 11:19:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:58262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhBWQT3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 23 Feb 2021 11:19:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CC53AB95;
        Tue, 23 Feb 2021 16:18:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4578C1E14EF; Tue, 23 Feb 2021 17:18:45 +0100 (CET)
Date:   Tue, 23 Feb 2021 17:18:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] ext4: reset retry counter when
 ext4_alloc_file_blocks() makes progress
Message-ID: <20210223161845.GC30433@quack2.suse.cz>
References: <20210219172519.2117-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219172519.2117-1-enwlinux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 19-02-21 12:25:19, Eric Whitney wrote:
> Change the retry policy in ext4_alloc_file_blocks() to allow for a full
> retry cycle whenever a portion of an allocation request has been
> fulfilled.  A large allocation request often results in multiple calls
> to ext4_map_blocks(), each of which is potentially subject to a
> temporary ENOSPC condition and retry cycle.  The current code only
> allows for a single retry cycle.
> 
> This patch does not address a known bug or reported complaint.
> However, it should make block allocation for fallocate and zero range
> more robust.
> 
> In addition, simplify the conditional controlling the allocation while
> loop, where testing len alone is sufficient.  Remove the assignment to
> ret2 in the error path after the call to ext4_map_blocks() since its
> value isn't subsequently used.
> 
> v2: Silence smatch warning by initializing ret.
> 
> For smatch warning:
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
 

> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> ---
>  fs/ext4/extents.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3960b7ec3ab7..77c84d6f1af6 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4382,8 +4382,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
>  {
>  	struct inode *inode = file_inode(file);
>  	handle_t *handle;
> -	int ret = 0;
> -	int ret2 = 0, ret3 = 0;
> +	int ret = 0, ret2 = 0, ret3 = 0;
>  	int retries = 0;
>  	int depth = 0;
>  	struct ext4_map_blocks map;
> @@ -4408,7 +4407,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
>  	depth = ext_depth(inode);
>  
>  retry:
> -	while (ret >= 0 && len) {
> +	while (len) {
>  		/*
>  		 * Recalculate credits when extent tree depth changes.
>  		 */
> @@ -4430,9 +4429,13 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
>  				   inode->i_ino, map.m_lblk,
>  				   map.m_len, ret);
>  			ext4_mark_inode_dirty(handle, inode);
> -			ret2 = ext4_journal_stop(handle);
> +			ext4_journal_stop(handle);
>  			break;
>  		}
> +		/*
> +		 * allow a full retry cycle for any remaining allocations
> +		 */
> +		retries = 0;
>  		map.m_lblk += ret;
>  		map.m_len = len = len - ret;
>  		epos = (loff_t)map.m_lblk << inode->i_blkbits;
> @@ -4450,11 +4453,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
>  		if (unlikely(ret2))
>  			break;
>  	}
> -	if (ret == -ENOSPC &&
> -			ext4_should_retry_alloc(inode->i_sb, &retries)) {
> -		ret = 0;
> +	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>  		goto retry;
> -	}
>  
>  	return ret > 0 ? ret2 : ret;
>  }
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
