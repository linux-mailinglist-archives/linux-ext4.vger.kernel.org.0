Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B521F6A728
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2019 13:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbfGPLPx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Jul 2019 07:15:53 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37015 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733200AbfGPLPx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 16 Jul 2019 07:15:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TX2nRfs_1563275742;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TX2nRfs_1563275742)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jul 2019 19:15:43 +0800
Subject: Re: [Ocfs2-devel] [PATCH 1/2] ocfs2: use jbd2_inode dirty range
 scoping
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Ross Zwisler <zwisler@google.com>,
        linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <1562977611-8412-1-git-send-email-joseph.qi@linux.alibaba.com>
Message-ID: <1a6e9c7b-b5ac-d745-17f2-7ef2073e9e8b@linux.alibaba.com>
Date:   Tue, 16 Jul 2019 19:15:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562977611-8412-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andrew,
Could you please pick up these 2 patches?

Thanks,
Joseph

On 19/7/13 08:26, Joseph Qi wrote:
> commit 6ba0e7dc64a5 ("jbd2: introduce jbd2_inode dirty range scoping")
> allow us scoping each of the inode dirty ranges associated with a given
> transaction, and ext4 already does this way.
> Now let's also use the newly introduced jbd2_inode dirty range scoping
> to prevent us from waiting forever when trying to complete a journal
> transaction in ocfs2.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Ross Zwisler <zwisler@google.com>
> ---
> v1 -> v2:
>   rename ocfs2_jbd2_file_inode() to ocfs2_jbd2_inode_add_write() to keep
>   consistent with ext4.
>   wrap several long lines.
> 
>  fs/ocfs2/alloc.c   |  5 ++++-
>  fs/ocfs2/aops.c    | 13 ++++++++++---
>  fs/ocfs2/file.c    | 10 +++++++---
>  fs/ocfs2/journal.h | 11 +++++++----
>  4 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index d1348fc..54f72ad 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -6792,6 +6792,8 @@ void ocfs2_map_and_dirty_page(struct inode *inode, handle_t *handle,
>  			      struct page *page, int zero, u64 *phys)
>  {
>  	int ret, partial = 0;
> +	loff_t start_byte = ((loff_t)page->index << PAGE_SHIFT) + from;
> +	loff_t length = to - from;
>  
>  	ret = ocfs2_map_page_blocks(page, phys, inode, from, to, 0);
>  	if (ret)
> @@ -6811,7 +6813,8 @@ void ocfs2_map_and_dirty_page(struct inode *inode, handle_t *handle,
>  	if (ret < 0)
>  		mlog_errno(ret);
>  	else if (ocfs2_should_order_data(inode)) {
> -		ret = ocfs2_jbd2_file_inode(handle, inode);
> +		ret = ocfs2_jbd2_inode_add_write(handle, inode,
> +						 start_byte, length);
>  		if (ret < 0)
>  			mlog_errno(ret);
>  	}
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index a4c905d..8de1c9d 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -942,7 +942,8 @@ static void ocfs2_write_failure(struct inode *inode,
>  
>  		if (tmppage && page_has_buffers(tmppage)) {
>  			if (ocfs2_should_order_data(inode))
> -				ocfs2_jbd2_file_inode(wc->w_handle, inode);
> +				ocfs2_jbd2_inode_add_write(wc->w_handle, inode,
> +							   user_pos, user_len);
>  
>  			block_commit_write(tmppage, from, to);
>  		}
> @@ -2023,8 +2024,14 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
>  		}
>  
>  		if (page_has_buffers(tmppage)) {
> -			if (handle && ocfs2_should_order_data(inode))
> -				ocfs2_jbd2_file_inode(handle, inode);
> +			if (handle && ocfs2_should_order_data(inode)) {
> +				loff_t start_byte =
> +					((loff_t)tmppage->index << PAGE_SHIFT) +
> +					from;
> +				loff_t length = to - from;
> +				ocfs2_jbd2_inode_add_write(handle, inode,
> +							   start_byte, length);
> +			}
>  			block_commit_write(tmppage, from, to);
>  		}
>  	}
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index 4435df3..efe9988 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -706,7 +706,9 @@ static int ocfs2_extend_allocation(struct inode *inode, u32 logical_start,
>   * Thus, we need to explicitly order the zeroed pages.
>   */
>  static handle_t *ocfs2_zero_start_ordered_transaction(struct inode *inode,
> -						struct buffer_head *di_bh)
> +						      struct buffer_head *di_bh,
> +						      loff_t start_byte,
> +						      loff_t length)
>  {
>  	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>  	handle_t *handle = NULL;
> @@ -722,7 +724,7 @@ static handle_t *ocfs2_zero_start_ordered_transaction(struct inode *inode,
>  		goto out;
>  	}
>  
> -	ret = ocfs2_jbd2_file_inode(handle, inode);
> +	ret = ocfs2_jbd2_inode_add_write(handle, inode, start_byte, length);
>  	if (ret < 0) {
>  		mlog_errno(ret);
>  		goto out;
> @@ -761,7 +763,9 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
>  	BUG_ON(abs_to > (((u64)index + 1) << PAGE_SHIFT));
>  	BUG_ON(abs_from & (inode->i_blkbits - 1));
>  
> -	handle = ocfs2_zero_start_ordered_transaction(inode, di_bh);
> +	handle = ocfs2_zero_start_ordered_transaction(inode, di_bh,
> +						      abs_from,
> +						      abs_to - abs_from);
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		goto out;
> diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
> index c0fe6ed..f37473c 100644
> --- a/fs/ocfs2/journal.h
> +++ b/fs/ocfs2/journal.h
> @@ -232,8 +232,8 @@ static inline void ocfs2_checkpoint_inode(struct inode *inode)
>   *                          ocfs2_journal_access_*() unless you intend to
>   *                          manage the checksum by hand.
>   *  ocfs2_journal_dirty    - Mark a journalled buffer as having dirty data.
> - *  ocfs2_jbd2_file_inode  - Mark an inode so that its data goes out before
> - *                           the current handle commits.
> + *  ocfs2_jbd2_inode_add_write  - Mark an inode with range so that its data goes
> + *                                out before the current handle commits.
>   */
>  
>  /* You must always start_trans with a number of buffs > 0, but it's
> @@ -603,9 +603,12 @@ static inline int ocfs2_calc_tree_trunc_credits(struct super_block *sb,
>  	return credits;
>  }
>  
> -static inline int ocfs2_jbd2_file_inode(handle_t *handle, struct inode *inode)
> +static inline int ocfs2_jbd2_inode_add_write(handle_t *handle, struct inode *inode,
> +					     loff_t start_byte, loff_t length)
>  {
> -	return jbd2_journal_inode_add_write(handle, &OCFS2_I(inode)->ip_jinode);
> +	return jbd2_journal_inode_ranged_write(handle,
> +					       &OCFS2_I(inode)->ip_jinode,
> +					       start_byte, length);
>  }
>  
>  static inline int ocfs2_begin_ordered_truncate(struct inode *inode,
> 
