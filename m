Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D55B5622
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiILI2A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Sep 2022 04:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiILI1g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Sep 2022 04:27:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE812018B;
        Mon, 12 Sep 2022 01:26:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5AD3B226F4;
        Mon, 12 Sep 2022 08:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662971128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AmLitHuJb9zxnWIayBW40PsD0jUE9DwA8Hdr0sEGwOU=;
        b=DoGJkxDfS8XfTUElxx6PiNjpb2X45CJzrmVQgQyjUfEd8XVON3A+8NBcWMGeMM2qRBvqQB
        m63S5+msQqnbKtyqz92C22+jPNZlb5OmqZjyUW3h/g0CAhil2eOE9RlgXNey0K1QfdUVCo
        0xHKxm+B0SmDb4moMu07E9n/ggHZ6aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662971128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AmLitHuJb9zxnWIayBW40PsD0jUE9DwA8Hdr0sEGwOU=;
        b=kLYQofUgp3PxTc+4vNeRg44Q5h3zZShQ4p9Ua4l1FOg6ZfwdqTghKlP1AeuLG1nuy8qvnw
        0NSodnaIlG5cTQCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 471FF139E0;
        Mon, 12 Sep 2022 08:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kphbEfjsHmNMKAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Sep 2022 08:25:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E889A067E; Mon, 12 Sep 2022 10:25:27 +0200 (CEST)
Date:   Mon, 12 Sep 2022 10:25:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] ext4: Fix dir corruption when ext4_dx_add_entry()
 fails
Message-ID: <20220912082527.36ywlkeie5he6guq@quack3>
References: <20220911045204.516460-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911045204.516460-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 11-09-22 12:52:04, Zhihao Cheng wrote:
> Following process may lead to fs corruption:
> 1. ext4_create(dir/foo)
>  ext4_add_nondir
>   ext4_add_entry
>    ext4_dx_add_entry
>      a. add_dirent_to_buf
>       ext4_mark_inode_dirty
>       ext4_handle_dirty_metadata   // dir inode bh is recorded into journal
>      b. ext4_append    // dx_get_count(entries) == dx_get_limit(entries)
>        ext4_bread(EXT4_GET_BLOCKS_CREATE)
>         ext4_getblk
>          ext4_map_blocks
>           ext4_ext_map_blocks
>             ext4_mb_new_blocks
>              dquot_alloc_block
>               dquot_alloc_space_nodirty
>                inode_add_bytes    // update dir's i_blocks
>             ext4_ext_insert_extent
> 	     ext4_ext_dirty  // record extent bh into journal
>               ext4_handle_dirty_metadata(bh)
> 	      // record new block into journal
>        inode->i_size += inode->i_sb->s_blocksize   // new size(in mem)
>      c. ext4_handle_dirty_dx_node(bh2)
> 	// record dir's new block(dx_node) into journal
>      d. ext4_handle_dirty_dx_node((frame - 1)->bh)
>      e. ext4_handle_dirty_dx_node(frame->bh)
>      f. do_split    // ret err!
>      g. add_dirent_to_buf
> 	 ext4_mark_inode_dirty(dir)  // update raw_inode on disk(skipped)
> 2. fsck -a /dev/sdb
>  drop last block(dx_node) which beyonds dir's i_size.
>   /dev/sdb: recovering journal
>   /dev/sdb contains a file system with errors, check forced.
>   /dev/sdb: Inode 12, end of extent exceeds allowed value
> 	(logical block 128, physical block 3938, len 1)
> 3. fsck -fn /dev/sdb
>  dx_node->entry[i].blk > dir->i_size
>   Pass 2: Checking directory structure
>   Problem in HTREE directory inode 12 (/dir): bad block number 128.
>   Clear HTree index? no
>   Problem in HTREE directory inode 12: block #3 has invalid depth (2)
>   Problem in HTREE directory inode 12: block #3 has bad max hash
>   Problem in HTREE directory inode 12: block #3 not referenced
> 
> Fix it by marking inode dirty directly inside ext4_append().
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216466
> CC: stable@vger.kernel.org
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  v1->v2: mark inode dirty inside ext4_append().
>  fs/ext4/namei.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 3a31b662f661..0d0e41d2dee8 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -85,15 +85,20 @@ static struct buffer_head *ext4_append(handle_t *handle,
>  		return bh;
>  	inode->i_size += inode->i_sb->s_blocksize;
>  	EXT4_I(inode)->i_disksize = inode->i_size;
> +	err = ext4_mark_inode_dirty(handle, inode);
> +	if (err)
> +		goto out;
>  	BUFFER_TRACE(bh, "get_write_access");
>  	err = ext4_journal_get_write_access(handle, inode->i_sb, bh,
>  					    EXT4_JTR_NONE);
> -	if (err) {
> -		brelse(bh);
> -		ext4_std_error(inode->i_sb, err);
> -		return ERR_PTR(err);
> -	}
> +	if (err)
> +		goto out;
>  	return bh;
> +
> +out:
> +	brelse(bh);
> +	ext4_std_error(inode->i_sb, err);
> +	return ERR_PTR(err);
>  }
>  
>  static int ext4_dx_csum_verify(struct inode *inode,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
