Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE3718135
	for <lists+linux-ext4@lfdr.de>; Wed, 31 May 2023 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjEaNPv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 May 2023 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjEaNPu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 May 2023 09:15:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66772129;
        Wed, 31 May 2023 06:15:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0B2F218E0;
        Wed, 31 May 2023 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685538946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JzhCJIVx/2jH02q83blCa9Jh9JBbp+Y0GxesRAy+SOg=;
        b=KbFmvWNdcjTiMOfVc3MYd8X+bYfZl+t1IrbSrDZTFEFT6nZbXvvS0TfP+Xws/6e7GDnDX/
        udakcpmbRoryfuIXO94bUqpf6LM97oI3D9ViZ5BLwmqmQBy+qoSQQyihhqVfVvMDL68IP5
        KpD7yfNjhARfwn+drO8Oo/iPjmGOabk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685538946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JzhCJIVx/2jH02q83blCa9Jh9JBbp+Y0GxesRAy+SOg=;
        b=PJCaEL2L3bjzPTnHOLZjS38mtG/VCkGD/WchkCI1kxdh3tD3pfKklhhPqq4bqmrBdKJC3G
        yOjl6EK8qPe71UBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF0C613488;
        Wed, 31 May 2023 13:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EWGEMoJId2StAwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 May 2023 13:15:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 60C34A0754; Wed, 31 May 2023 15:15:46 +0200 (CEST)
Date:   Wed, 31 May 2023 15:15:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, jun.nie@linaro.org,
        ebiggers@kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
        yukuai3@huawei.com,
        syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Message-ID: <20230531131546.ugrsvh66wqyl3roh@quack3>
References: <20230530134405.322194-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530134405.322194-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-05-23 21:44:05, Baokun Li wrote:
> Syzbot reported a BUG_ON:
> ==================================================================
> EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
> EXT4-fs error (device loop0): ext4_mb_generate_buddy:1098: group 0, block
>      bitmap and bg descriptor inconsistent: 25 vs 150994969 free clusters
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/ext4_jbd2.c:53!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 494 Comm: syz-executor.0 6.1.0-rc7-syzkaller-ga4412fdd49dc #0
> RIP: 0010:__ext4_journal_stop+0x1b3/0x1c0
>  [...]
> Call Trace:
>  ext4_write_inline_data_end+0xa39/0xdf0
>  ext4_da_write_end+0x1e2/0x950
>  generic_perform_write+0x401/0x5f0
>  ext4_buffered_write_iter+0x35f/0x640
>  ext4_file_write_iter+0x198/0x1cd0
>  vfs_write+0x8b5/0xef0
>  [...]
> ==================================================================
> 
> The above BUG_ON is triggered by the following race:
> 
>            cpu1                    cpu2
> ________________________|________________________
> ksys_write
>  vfs_write
>   new_sync_write
>    ext4_file_write_iter
>     ext4_buffered_write_iter
>      generic_perform_write
>       ext4_da_write_begin
>                           do_fault
>                            do_page_mkwrite
>                             ext4_page_mkwrite
>                              ext4_convert_inline_data
>                               ext4_convert_inline_data_nolock
>                                ext4_destroy_inline_data_nolock
>                                 //clear EXT4_STATE_MAY_INLINE_DATA
>                                ext4_map_blocks --> return error
>        ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)
>        ext4_block_write_begin
>                                ext4_restore_inline_data
>                                 // set EXT4_STATE_MAY_INLINE_DATA
>       ext4_da_write_end
>        ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)
>        ext4_write_inline_data_end
>         handle=NULL
>         ext4_journal_stop(handle)
>          __ext4_journal_stop
>           ext4_put_nojournal(handle)
>            ref_cnt = (unsigned long)handle
>            BUG_ON(ref_cnt == 0)  ---> BUG_ON
> 
> The root cause of this problem is that the ext4_convert_inline_data() in
> ext4_page_mkwrite() does not grab i_rwsem, so it may race with
> ext4_buffered_write_iter() and cause the write_begin() and write_end()
> functions to be inconsistent and trigger BUG_ON.
> 
> To solve the above issue, we can not add inode_lock directly to
> ext4_page_mkwrite(), which would not only cause performance degradation but
> also ABBA deadlock (see Link). Hence we move ext4_convert_inline_data() to
> ext4_file_mmap(), and only when inline_data is enabled and mmap a writeable
> file in shared mode, we hold the lock to convert, which avoids the above
> problems.
> 
> Link: https://lore.kernel.org/r/20230530102804.6t7np7om6tczscuo@quack3/
> Reported-by: Jun Nie <jun.nie@linaro.org>
> Closes: https://lore.kernel.org/lkml/63903521.5040307@huawei.com/t/
> Reported-by: syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=899b37f20ce4072bcdfecfe1647b39602e956e36
> Fixes: 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map")
> CC: stable@vger.kernel.org # 4.12+
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c  | 24 +++++++++++++++++++++++-
>  fs/ext4/inode.c |  4 ----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index d101b3b0c7da..9df82d72eb90 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -795,7 +795,8 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
>  static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct inode *inode = file->f_mapping->host;
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	struct super_block *sb = inode->i_sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct dax_device *dax_dev = sbi->s_daxdev;
>  
>  	if (unlikely(ext4_forced_shutdown(sbi)))
> @@ -808,6 +809,27 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!daxdev_mapping_supported(vma, dax_dev))
>  		return -EOPNOTSUPP;
>  
> +	/*
> +	 * Writing via mmap has no logic to handle inline data, so we
> +	 * need to call ext4_convert_inline_data() to convert the inode
> +	 * to normal format before doing so, otherwise a BUG_ON will be
> +	 * triggered in ext4_writepages() due to the
> +	 * EXT4_STATE_MAY_INLINE_DATA flag. Moreover, we need to grab
> +	 * i_rwsem during conversion, since clearing and setting the
> +	 * inline data flag may race with ext4_buffered_write_iter()
> +	 * to trigger a BUG_ON.
> +	 */
> +	if (ext4_has_feature_inline_data(sb) &&
> +	    vma->vm_flags & VM_SHARED && vma->vm_flags & VM_MAYWRITE) {
> +		int err;
> +
> +		inode_lock(inode);
> +		err = ext4_convert_inline_data(inode);
> +		inode_unlock(inode);
> +		if (err)
> +			return err;
> +	}
> +
>  	file_accessed(file);
>  	if (IS_DAX(file_inode(file))) {
>  		vma->vm_ops = &ext4_dax_vm_ops;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ce5f21b6c2b3..31844c4ec9fe 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6043,10 +6043,6 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  
>  	filemap_invalidate_lock_shared(mapping);
>  
> -	err = ext4_convert_inline_data(inode);
> -	if (err)
> -		goto out_ret;
> -
>  	/*
>  	 * On data journalling we skip straight to the transaction handle:
>  	 * there's no delalloc; page truncated will be checked later; the
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
