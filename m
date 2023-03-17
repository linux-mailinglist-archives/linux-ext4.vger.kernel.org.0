Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0935B6BE98D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 13:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCQMpR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 08:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCQMpQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 08:45:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FCAA54C2;
        Fri, 17 Mar 2023 05:45:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2E3921A57;
        Fri, 17 Mar 2023 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679057113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13wHn270QC2EQIv2STg6ZbJmqaKqLZmBmJiFjnKTwvs=;
        b=Qut3hqc62LhEoqknDZyCmGO2oR93XHZ3JzqRD6vpejnvwODTQcV6jJeK3sasp0abOxdFC/
        PRdjRh0NkBRKNn+biTi/XsseBY//nkxiqSFdrRutvWidOENOs51014KWRYmY+ufwrLunbV
        R7V9tDEqB3j9a4oQ8y5DfhWG9aYUQRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679057113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13wHn270QC2EQIv2STg6ZbJmqaKqLZmBmJiFjnKTwvs=;
        b=q8H+KfiNRWMn9w/fU7d84yvMgpfML13d2YqlfrM54CFcIT80izEqu3difcTYOK7UuCqiCB
        D7WpQry3Ka05QDCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1AB213428;
        Fri, 17 Mar 2023 12:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3wgjM9lgFGS4PgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Mar 2023 12:45:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 57DC4A06FD; Fri, 17 Mar 2023 13:45:13 +0100 (CET)
Date:   Fri, 17 Mar 2023 13:45:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        tudor.ambarus@linaro.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: Fix i_disksize exceeding i_size problem in
 paritally written case
Message-ID: <20230317124513.drx3wywcjnap5jme@quack3>
References: <20230317013553.1009553-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317013553.1009553-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 17-03-23 09:35:53, Zhihao Cheng wrote:
> Following process makes i_disksize exceed i_size:
> 
> generic_perform_write
>  copied = iov_iter_copy_from_user_atomic(len) // copied < len
>  ext4_da_write_end
>  | ext4_update_i_disksize
>  |  new_i_size = pos + copied;
>  |  WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize) // update i_disksize
>  | generic_write_end
>  |  copied = block_write_end(copied, len) // copied = 0
>  |   if (unlikely(copied < len))
>  |    if (!PageUptodate(page))
>  |     copied = 0;
>  |  if (pos + copied > inode->i_size) // return false
>  if (unlikely(copied == 0))
>   goto again;
>  if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
>   status = -EFAULT;
>   break;
>  }
> 
> We get i_disksize greater than i_size here, which could trigger WARNING
> check 'i_size_read(inode) < EXT4_I(inode)->i_disksize' while doing dio:
> 
> ext4_dio_write_iter
>  iomap_dio_rw
>   __iomap_dio_rw // return err, length is not aligned to 512
>  ext4_handle_inode_extension
>   WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize) // Oops
> 
>  WARNING: CPU: 2 PID: 2609 at fs/ext4/file.c:319
>  CPU: 2 PID: 2609 Comm: aa Not tainted 6.3.0-rc2
>  RIP: 0010:ext4_file_write_iter+0xbc7
>  Call Trace:
>   vfs_write+0x3b1
>   ksys_write+0x77
>   do_syscall_64+0x39
> 
> Fix it by putting block_write_end() before i_disksize updating just
> like ext4_write_end() does.
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217209
> Fixes: 64769240bd07f ("ext4: Add delayed allocation support in data=writeback mode")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Good catch (although practically this will hardly have any negative
effect). But rather than opencoding generic_write_end() I'd do:

        if (unlikely(copied < len) && !PageUptodate(page))
                copied = 0;

at the beginning of ext4_da_write_end() and that should solve these
problems as well?

								Honza

> ---
>  fs/ext4/inode.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf0b7dea4900..577dc23f3b78 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3136,6 +3136,8 @@ static int ext4_da_write_end(struct file *file,
>  	loff_t new_i_size;
>  	unsigned long start, end;
>  	int write_mode = (int)(unsigned long)fsdata;
> +	bool i_size_changed = false;
> +	loff_t old_size = inode->i_size;
>  
>  	if (write_mode == FALL_BACK_TO_NONDELALLOC)
>  		return ext4_write_end(file, mapping, pos,
> @@ -3148,6 +3150,8 @@ static int ext4_da_write_end(struct file *file,
>  	    ext4_has_inline_data(inode))
>  		return ext4_write_inline_data_end(inode, pos, len, copied, page);
>  
> +	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
> +
>  	start = pos & (PAGE_SIZE - 1);
>  	end = start + copied - 1;
>  
> @@ -3162,16 +3166,30 @@ static int ext4_da_write_end(struct file *file,
>  	 * check), we need to update i_disksize here as neither
>  	 * ext4_writepage() nor certain ext4_writepages() paths not
>  	 * allocating blocks update i_disksize.
> -	 *
> -	 * Note that we defer inode dirtying to generic_write_end() /
> -	 * ext4_da_write_inline_data_end().
>  	 */
>  	new_i_size = pos + copied;
> -	if (copied && new_i_size > inode->i_size &&
> -	    ext4_da_should_update_i_disksize(page, end))
> -		ext4_update_i_disksize(inode, new_i_size);
> +	if (new_i_size > inode->i_size) {
> +		i_size_write(inode, new_i_size);
> +		i_size_changed = true;
> +		if (copied && ext4_da_should_update_i_disksize(page, end))
> +			ext4_update_i_disksize(inode, new_i_size);
> +	}
> +
> +	unlock_page(page);
> +	put_page(page);
> +
> +	if (old_size < pos)
> +		pagecache_isize_extended(inode, old_size, pos);
> +	/*
> +	 * Don't mark the inode dirty under page lock. First, it unnecessarily
> +	 * makes the holding time of page lock longer. Second, it forces lock
> +	 * ordering of page lock and transaction start for journaling
> +	 * filesystems.
> +	 */
> +	if (i_size_changed)
> +		mark_inode_dirty(inode);
>  
> -	return generic_write_end(file, mapping, pos, len, copied, page, fsdata);
> +	return copied;
>  }
>  
>  /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
