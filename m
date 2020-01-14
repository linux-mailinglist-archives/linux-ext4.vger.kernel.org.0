Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68713A428
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgANJro (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 04:47:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANJro (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Jan 2020 04:47:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0314EAC9A;
        Tue, 14 Jan 2020 09:47:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8689F1E0D0E; Tue, 14 Jan 2020 10:47:41 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:47:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [RFC 2/2] ext4: Fix stale data read issue with DIO read &
 ext4_page_mkwrite path
Message-ID: <20200114094741.GC6466@quack2.suse.cz>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <1c2da3cf5e0d90e8650e81f07976629c7d87e8ca.1578907891.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2da3cf5e0d90e8650e81f07976629c7d87e8ca.1578907891.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-01-20 16:34:22, Ritesh Harjani wrote:
> Currently there is a small race window where ext4 tries to allocate
> a written block for mapped files and if DIO read is in progress, then
> this may result into stale data read exposure problem.
> 
> This patch fixes the mentioned issue by:
> 1. For non-delalloc path, page_mkwrite will use unwritten blocks by
>    default for extent based files.
> 
> 2. For delalloc path, we check if DIO is in progress during writeback.
>    If yes, then we use unwritten blocks method to avoid this race.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/inode.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d035acab5b2a..07f66782335b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1529,6 +1529,7 @@ struct mpage_da_data {
>  	struct ext4_map_blocks map;
>  	struct ext4_io_submit io_submit;	/* IO submission data */
>  	unsigned int do_map:1;
> +	bool dio_in_progress:1;
>  };
>  
>  static void mpage_release_unused_pages(struct mpage_da_data *mpd,
> @@ -2359,7 +2360,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
>  			   EXT4_GET_BLOCKS_IO_SUBMIT;
>  	dioread_nolock = ext4_should_dioread_nolock(inode);
> -	if (dioread_nolock)
> +	if (dioread_nolock || mpd->dio_in_progress)
>  		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
>  	if (map->m_flags & (1 << BH_Delay))
>  		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
> @@ -2367,7 +2368,8 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
>  	if (err < 0)
>  		return err;
> -	if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
> +	if ((dioread_nolock || mpd->dio_in_progress) &&
> +	    (map->m_flags & EXT4_MAP_UNWRITTEN)) {
>  		if (!mpd->io_submit.io_end->handle &&
>  		    ext4_handle_valid(handle)) {
>  			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
> @@ -2626,6 +2628,7 @@ static int ext4_writepages(struct address_space *mapping,
>  	bool done;
>  	struct blk_plug plug;
>  	bool give_up_on_write = false;
> +	bool dio_in_progress = false;
>  
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>  		return -EIO;
> @@ -2680,15 +2683,6 @@ static int ext4_writepages(struct address_space *mapping,
>  		ext4_journal_stop(handle);
>  	}
>  
> -	if (ext4_should_dioread_nolock(inode)) {
> -		/*
> -		 * We may need to convert up to one extent per block in
> -		 * the page and we may dirty the inode.
> -		 */
> -		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
> -						PAGE_SIZE >> inode->i_blkbits);
> -	}
> -
>  	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>  		range_whole = 1;
>  
> @@ -2712,6 +2706,26 @@ static int ext4_writepages(struct address_space *mapping,
>  	done = false;
>  	blk_start_plug(&plug);
>  
> +	/*
> +	 * If DIO is in progress, then we use unwritten blocks for allocation.
> +	 * This is to avoid a small window of race (stale read) with
> +	 * ext4_page_mkwrite path in delalloc case & with DIO read in parallel.
> +	 *
> +	 * Let's check for i_dio_count after we have tagged pages for writeback.
> +	 */
> +	smp_mb__before_atomic();
> +	dio_in_progress = !!atomic_read(&inode->i_dio_count);
> +	mpd.dio_in_progress = dio_in_progress;

Two problems here:

1) smp_mb__before_atomic() does not work with atomic_read(). This kind of
barrier works only with read-modify-write kinds of atomic operations like
atomic_inc(). See Documentation/atomic_t.txt for more details.

2) Even if the barrier worked, this is still too early for the check.
Consider the following race:

Task 1 - flusher		Task 2 - dio read	Task 3 - fault
ext4_writepages()
  atomic_read(&inode->i_dio_count) -> 0
  ...
				iomap_dio_rw()
				  inode_dio_begin()
				  filemap_write_and_wait_range()
				  ...
							ext4_page_mkwrite()
							  fills hole at index I
  ...
  mpage_prepare_extent_to_map()
    finds dirty page at index I - tagging
    not in effect because this is WB_SYNC_NONE
    writeback so we look for PAGECACHE_TAG_DIRTY
    mpage_map_and_submit_extent()
      - allocates block for page I
				  ext4_iomap_begin()
				    finds block under offset I
				  submit_bio()
				    - reads stale data

And what I wanted to use to stop this race is page lock / page writeback
bit on page 'I' because filemap_write_and_wait_range() called from
iomap_dio_rw() ends up waiting for both if the page is seen as dirty. For
this to work, you need to check inode->i_dio_count after you hold the page
locks for written range - i.e., after mpage_prepare_extent_to_map(). And
that means you always have to have rsv_blocks set when starting a
transaction because you don't know in advance whether you'll need them or
not.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
