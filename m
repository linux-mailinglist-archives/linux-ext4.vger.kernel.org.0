Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB463BD692
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhGFMhw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 08:37:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40880 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhGFMOC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 08:14:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7340D22412;
        Tue,  6 Jul 2021 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625573483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWXvyYv2eT4KQL9xiRg7Um3y1C9KsUTcou6JRoRkEPs=;
        b=1SgSdU03UvWbo5imvpXb4iWeRgVrq4sWSP1gi3EjYMJRiv1UFuR4G6We42AxgfGFh/KQMC
        1v6MunLljoqPE5p5rj4jE0Vobm1goSQPkNGicKWuyhg12b/zMOft0c2i7RA76uHsxWFjo3
        GIs9zjau1m3anZ4u8phFhWhydOq414M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625573483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWXvyYv2eT4KQL9xiRg7Um3y1C9KsUTcou6JRoRkEPs=;
        b=Q+o+OpKcutQ1y72QVBPl2EUeF4l8g/gxpAJCoex5KYNTUUTSFUGLgckkXYQnCAFtNQOVkA
        it8w28XnWLISUICQ==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 358B5A3CBF;
        Tue,  6 Jul 2021 12:11:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0CD271F2C9A; Tue,  6 Jul 2021 14:11:23 +0200 (CEST)
Date:   Tue, 6 Jul 2021 14:11:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH 1/4] ext4: check and update i_disksize properly
Message-ID: <20210706121123.GB7922@quack2.suse.cz>
References: <20210706024210.746788-1-yi.zhang@huawei.com>
 <20210706024210.746788-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706024210.746788-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-07-21 10:42:07, Zhang Yi wrote:
> After commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <=
> isize"), i_disksize could always be updated to i_size in ext4_setattr(),
> and it seems that there is no other way that could appear
> i_disksize < i_size besides the delalloc write. In the case of delay

Well, there are also direct IO writes which have temporarily i_disksize <
i_size but when you hold i_rwsem, you're right that delalloc is the only
reason why you can see i_disksize < i_size AFAIK.

> alloc write, ext4_writepages() could update i_disksize for the new delay
> allocated blocks properly. So we could switch to check i_size instead
> of i_disksize in ext4_da_write_end() when write to the end of the file.

I agree that since ext4_da_should_update_i_disksize() needs to return true
for us to touch i_disksize, writeback has to have already allocated block
underlying the end of write (new_i_size position) and thus we are
guaranteed that writeback will also soon update i_disksize after the
new_i_size position. So I agree that your switch to testing i_size instead
of i_disksize should not have any bad effect... Thinking about this some
more why do we need i_disksize update in ext4_da_write_end() at all? The
page will be dirtied and when writeback will happen we will update
i_disksize to i_size. Updating i_disksize earlier brings no benefit - the user
will see zeros instead of valid data if we crash before the writeback
happened. Am I missing something guys?

								Honza

> we also could remove ext4_mark_inode_dirty() together because
> generic_write_end() will dirty the inode.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d8de607849df..6f6a61f3ae5f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3087,32 +3087,27 @@ static int ext4_da_write_end(struct file *file,
>  	 * generic_write_end() will run mark_inode_dirty() if i_size
>  	 * changes.  So let's piggyback the i_disksize mark_inode_dirty
>  	 * into that.
> +	 *
> +	 * Check i_size not i_disksize here because ext4_writepages() could
> +	 * update i_disksize from i_size for delay allocated blocks properly.
>  	 */
>  	new_i_size = pos + copied;
> -	if (copied && new_i_size > EXT4_I(inode)->i_disksize) {
> +	if (copied && new_i_size > inode->i_size) {
>  		if (ext4_has_inline_data(inode) ||
> -		    ext4_da_should_update_i_disksize(page, end)) {
> +		    ext4_da_should_update_i_disksize(page, end))
>  			ext4_update_i_disksize(inode, new_i_size);
> -			/* We need to mark inode dirty even if
> -			 * new_i_size is less that inode->i_size
> -			 * bu greater than i_disksize.(hint delalloc)
> -			 */
> -			ret = ext4_mark_inode_dirty(handle, inode);
> -		}
>  	}
>  
>  	if (write_mode != CONVERT_INLINE_DATA &&
>  	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
>  	    ext4_has_inline_data(inode))
> -		ret2 = ext4_da_write_inline_data_end(inode, pos, len, copied,
> +		ret = ext4_da_write_inline_data_end(inode, pos, len, copied,
>  						     page);
>  	else
> -		ret2 = generic_write_end(file, mapping, pos, len, copied,
> +		ret = generic_write_end(file, mapping, pos, len, copied,
>  							page, fsdata);
>  
> -	copied = ret2;
> -	if (ret2 < 0)
> -		ret = ret2;
> +	copied = ret;
>  	ret2 = ext4_journal_stop(handle);
>  	if (unlikely(ret2 && !ret))
>  		ret = ret2;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
