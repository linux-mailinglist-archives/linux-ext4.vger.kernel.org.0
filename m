Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1A64585E
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 11:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLGK7O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 05:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGK7B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 05:59:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6A222524;
        Wed,  7 Dec 2022 02:58:59 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 729A421C52;
        Wed,  7 Dec 2022 10:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670410738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJYO0uD3jTg/tI4wB3PWVjeIqiQpVG7dNNpG4QjBY68=;
        b=pjfhVWP05Knj1l+EBAKsqcfhKSYdFDdqivZ14wkEvneGi6L2srra+yOdbJswgS7ISVmb7M
        07EA+dXz9IidjTSElM78C1Nr8MqU5Fn4OfNqMhgg+yMrClWQ4Goene+Ij23FVegTFEngad
        Bg1rqgiMPVdphXlt5CRrssQf/FqacE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670410738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJYO0uD3jTg/tI4wB3PWVjeIqiQpVG7dNNpG4QjBY68=;
        b=vDnGRNPluVJ+xAZ2a1qbB7Skklsp8cNsNGW9DLTs9LGZsyVQ1wAp2ijZO7PMHFdkq08A02
        FWJ0yJh8zjvNi+DQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6154D134CD;
        Wed,  7 Dec 2022 10:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ipUkGPJxkGNYHQAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 10:58:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D7BD3A0725; Wed,  7 Dec 2022 11:58:57 +0100 (CET)
Date:   Wed, 7 Dec 2022 11:58:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 5/6] ext4: rename xattr_find_entry() and
 __xattr_check_inode()
Message-ID: <20221207105857.75xesk7psydjibz4@quack3>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-6-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207074043.1286731-6-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 07-12-22 15:40:42, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> xattr_find_entry() and __xattr_check_inode() is in EXT4 xattr module. so
> add 'ext4' prefix to unify name style.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index efa623658c12..5c0476ff62c8 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -290,8 +290,9 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
>  
>  
>  static int
> -__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
> -			 void *end, const char *function, unsigned int line)
> +__ext4_xattr_check_inode(struct inode *inode,
> +			 struct ext4_xattr_ibody_header *header, void *end,
> +			 const char *function, unsigned int line)
>  {
>  	int error = -EFSCORRUPTED;
>  
> @@ -307,12 +308,12 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
>  	return error;
>  }
>  
> -#define xattr_check_inode(inode, header, end) \
> -	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
> +#define ext4_xattr_check_inode(inode, header, end) \
> +	__ext4_xattr_check_inode((inode), (header), (end), __func__, __LINE__)
>  
>  static int
> -xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
> -		 void *end, int name_index, const char *name, int sorted)
> +ext4_xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
> +		      void *end, int name_index, const char *name, int sorted)
>  {
>  	struct ext4_xattr_entry *entry, *next;
>  	size_t name_len;
> @@ -577,7 +578,7 @@ ext4_xattr_block_get(struct inode *inode, int name_index, const char *name,
>  	ext4_xattr_block_cache_insert(ea_block_cache, bh);
>  	entry = BFIRST(bh);
>  	end = bh->b_data + bh->b_size;
> -	error = xattr_find_entry(inode, &entry, end, name_index, name, 1);
> +	error = ext4_xattr_find_entry(inode, &entry, end, name_index, name, 1);
>  	if (error)
>  		goto cleanup;
>  	size = le32_to_cpu(entry->e_value_size);
> @@ -628,11 +629,11 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
>  	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> -	error = xattr_check_inode(inode, header, end);
> +	error = ext4_xattr_check_inode(inode, header, end);
>  	if (error)
>  		goto cleanup;
>  	entry = IFIRST(header);
> -	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
> +	error = ext4_xattr_find_entry(inode, &entry, end, name_index, name, 0);
>  	if (error)
>  		goto cleanup;
>  	size = le32_to_cpu(entry->e_value_size);
> @@ -773,7 +774,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
>  	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> -	error = xattr_check_inode(inode, header, end);
> +	error = ext4_xattr_check_inode(inode, header, end);
>  	if (error)
>  		goto cleanup;
>  	error = ext4_xattr_list_entries(dentry, IFIRST(header),
> @@ -859,7 +860,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
>  		raw_inode = ext4_raw_inode(&iloc);
>  		header = IHDR(inode, raw_inode);
>  		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> -		ret = xattr_check_inode(inode, header, end);
> +		ret = ext4_xattr_check_inode(inode, header, end);
>  		if (ret)
>  			goto out;
>  
> @@ -1862,8 +1863,8 @@ ext4_xattr_block_find(struct inode *inode, struct ext4_xattr_info *i,
>  		bs->s.first = BFIRST(bs->bh);
>  		bs->s.end = bs->bh->b_data + bs->bh->b_size;
>  		bs->s.here = bs->s.first;
> -		error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
> -					 i->name_index, i->name, 1);
> +		error = ext4_xattr_find_entry(inode, &bs->s.here, bs->s.end,
> +					      i->name_index, i->name, 1);
>  		if (error && error != -ENODATA)
>  			return error;
>  		bs->s.not_found = error;
> @@ -2222,12 +2223,12 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
>  	is->s.here = is->s.first;
>  	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
>  	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
> -		error = xattr_check_inode(inode, header, is->s.end);
> +		error = ext4_xattr_check_inode(inode, header, is->s.end);
>  		if (error)
>  			return error;
>  		/* Find the named attribute. */
> -		error = xattr_find_entry(inode, &is->s.here, is->s.end,
> -					 i->name_index, i->name, 0);
> +		error = ext4_xattr_find_entry(inode, &is->s.here, is->s.end,
> +					      i->name_index, i->name, 0);
>  		if (error && error != -ENODATA)
>  			return error;
>  		is->s.not_found = error;
> @@ -2742,7 +2743,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
>  	min_offs = end - base;
>  	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
>  
> -	error = xattr_check_inode(inode, header, end);
> +	error = ext4_xattr_check_inode(inode, header, end);
>  	if (error)
>  		goto cleanup;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
