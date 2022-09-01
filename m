Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9978A5A922C
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Sep 2022 10:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiIAIhM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiIAIhL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 04:37:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81C12CB04;
        Thu,  1 Sep 2022 01:37:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B12181FA04;
        Thu,  1 Sep 2022 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662021426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2c6QoUdgqmtPVprcXKHyH77WV/2UBMCQL92w39HdYIU=;
        b=jnErPsT9u9SIp0mJNlx7d9/zaIhBPgxbSkf8xrF/VPlkJ2j9TQlXAzdn3zEF9R8TH7nSYL
        gSKSxTYhc4CwYHj3hOHTUf3woN8twpDHeIIPbYHr25FsaZRZTpfJBo7oPbFyxTifK1AnNi
        K24GBDc/Yk7nDlIO9+Ubbhz7t2pErLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662021426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2c6QoUdgqmtPVprcXKHyH77WV/2UBMCQL92w39HdYIU=;
        b=Qm//5sSU9PvLkRyinC2c0DYth/MQTFq7CzsEoggZphCrAJy6SxYsElZ4Iy7Cr3wDexsZjm
        iIQuPWbRZRo+g8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A159113A79;
        Thu,  1 Sep 2022 08:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B3NXJzJvEGNkNwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Sep 2022 08:37:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0EE79A067C; Thu,  1 Sep 2022 10:37:06 +0200 (CEST)
Date:   Thu, 1 Sep 2022 10:37:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: ensure data forced to disk when rename
Message-ID: <20220901083706.mjewb45dufzxcfdk@quack3>
References: <20220901062657.1192732-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901062657.1192732-1-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 01-09-22 14:26:57, Ye Bin wrote:
> There is issue that data lost when rename new file. Reason is dioread_nolock is
> enabled default now, which map blocks will mark extent unwritten. But inode
> size is changed after submit io. Then read file will return zero if extent is
> unwritten.
> To solve above isuue, wait all data force to disk before rename when enable
> dioread_nolock and enable delay allocate.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Well, but it was always like that. We do not guarantee that the data is
securely on disk before rename - userspace is responsible for that if it
needs this guarantee. We just want to make the time window shorter and so
start data writeback because lot of userspace is careless. But waiting for
data writeback before rename will significantly slow down some workloads
and IMHO without a good reason.

								Honza

> ---
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/inode.c | 16 ++++++++++++++++
>  fs/ext4/namei.c |  2 +-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9bca5565547b..111296259b89 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2998,6 +2998,7 @@ extern int ext4_break_layouts(struct inode *);
>  extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
>  extern void ext4_set_inode_flags(struct inode *, bool init);
>  extern int ext4_alloc_da_blocks(struct inode *inode);
> +extern void ext4_flush_data(struct inode *inode);
>  extern void ext4_set_aops(struct inode *inode);
>  extern int ext4_writepage_trans_blocks(struct inode *);
>  extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 601214453c3a..4df7ffd3f1b0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3133,6 +3133,22 @@ int ext4_alloc_da_blocks(struct inode *inode)
>  	return filemap_flush(inode->i_mapping);
>  }
>  
> +void ext4_flush_data(struct inode *inode)
> +{
> +	if (!EXT4_I(inode)->i_reserved_data_blocks)
> +		return;
> +
> +	if (filemap_flush(inode->i_mapping))
> +		return;
> +
> +	if (test_opt(inode->i_sb, DELALLOC) &&
> +	    ext4_should_dioread_nolock(inode) &&
> +	    atomic_read(&EXT4_I(inode)->i_unwritten))
> +		filemap_fdatawait(inode->i_mapping);
> +
> +	return;
> +}
> +
>  /*
>   * bmap() is special.  It gets used by applications such as lilo and by
>   * the swapper to find the on-disk block of a specific piece of data.
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 3a31b662f661..030402fe3b9f 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3820,7 +3820,7 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		}
>  	}
>  	if (new.inode && !test_opt(new.dir->i_sb, NO_AUTO_DA_ALLOC))
> -		ext4_alloc_da_blocks(old.inode);
> +		ext4_flush_data(old.inode);
>  
>  	credits = (2 * EXT4_DATA_TRANS_BLOCKS(old.dir->i_sb) +
>  		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 2);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
