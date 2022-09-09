Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2874F5B34D3
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 12:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiIIKIT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Sep 2022 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIIKH4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Sep 2022 06:07:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC39A13866A;
        Fri,  9 Sep 2022 03:07:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 147581F8CC;
        Fri,  9 Sep 2022 10:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662718071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaEFScBMLBkLYBcNzQihUKThBdl/zR6zylgLtwYJqtA=;
        b=ZvC6OllSfSNUYzGZ7dmWufc5DaNSZzNNx3PbFNtRGnDLfEedrjTIfqydQ/L79IT5CdL9sz
        oTMZm27pTL/r6Ld85pBb7xne2lATnQPylYA6CcIfqbxWvF81dqJnXLyGie95Lv8r5FScwG
        i+j/JvLYI0+jynRCBiXHu7SwJ2yQfps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662718071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaEFScBMLBkLYBcNzQihUKThBdl/zR6zylgLtwYJqtA=;
        b=E86DZeHLq5768SlnDe7tB4FIHmk88ys1fIoiUXKMg+U89YFQDhoLAJ9NQtaE63+/BkJKgk
        IpLqiyD8RmEFmmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0150513A93;
        Fri,  9 Sep 2022 10:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f/9EAHcQG2OCcAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 09 Sep 2022 10:07:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8CADCA0684; Fri,  9 Sep 2022 12:07:50 +0200 (CEST)
Date:   Fri, 9 Sep 2022 12:07:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: Fix dir corruption when ext4_dx_add_entry() fails
Message-ID: <20220909100750.nrr3gqvbwjss4yel@quack3>
References: <20220909062736.2929221-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909062736.2929221-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 09-09-22 14:27:36, Zhihao Cheng wrote:
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
> Just like make_indexed_dir() does, update dir inode if error occurs.
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216466
> CC: stable@vger.kernel.org
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks for the analysis and the fix! In principle it looks fine but overall
we seem to be defering directory dirtying too much in ext4 directory
handling code and as a result things are too fragile as you've noticed. By
looking through fs/ext4/namei.c I've found several more places that have
exactly the same problem as you're fixing here. I think that specifically
for these problems with ext4_append() the best solution is to mark inode
dirty directly inside ext4_append(). Sure it will result in more copying of
inode data into the journal but growing directory size is not that
performance critical operation so I think the code simplicity is worth the
extra CPU cycles.

								Honza

> ---
>  fs/ext4/namei.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 3a31b662f661..f04871fa4ead 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2617,6 +2617,13 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  	 */
>  	if (restart && err == 0)
>  		goto again;
> +	/*
> +	 * Even if the dx_add_entry failed, we have to properly write
> +	 * out all the changes we did so far. Otherwise we can end up
> +	 * with corrupted filesystem.
> +	 */
> +	if (err)
> +		ext4_mark_inode_dirty(handle, dir);
>  	return err;
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
