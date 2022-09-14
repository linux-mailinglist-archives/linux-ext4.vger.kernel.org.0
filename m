Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890FF5B8AC7
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Sep 2022 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiINOiK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Sep 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiINOh7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Sep 2022 10:37:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76537F085;
        Wed, 14 Sep 2022 07:37:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69C09338DF;
        Wed, 14 Sep 2022 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663166277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HyODVLSVFuCohpp5lwAKav3Xdk0QKbprYIJKsk0h700=;
        b=SSJYVE2jXQce2oku0AgwVT5gnfQv652Y8fWNUbYdUC7JA8/lDo8LWPFECQRxH/J2XU0yAD
        XDlaSz/VB7OfKgxHTo43+B9MTtPrHocQF8ffeOxkKZy6Y/XT7lHQ04BDI9kJ/LIQpvvt0Z
        BnoZNgJOHnlYaRog5IfjI+K5kxT32ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663166277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HyODVLSVFuCohpp5lwAKav3Xdk0QKbprYIJKsk0h700=;
        b=QVD3t3yJr6abdexusIKgp2qftokTHDmOAeJoPDMl3BMN3uJNQaiTr5C07uMYL3Y8VimS+m
        fahoIDnv/RPEDVDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D211134B3;
        Wed, 14 Sep 2022 14:37:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BpK4FkXnIWOWOQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 14:37:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D9448A0680; Wed, 14 Sep 2022 16:37:56 +0200 (CEST)
Date:   Wed, 14 Sep 2022 16:37:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: fix miss release buffer head in
 ext4_fc_write_inode
Message-ID: <20220914143756.y5if4kllwi7mz67b@quack3>
References: <20220914100859.1415196-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914100859.1415196-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 14-09-22 18:08:59, Ye Bin wrote:
> In 'ext4_fc_write_inode' function first call 'ext4_get_inode_loc' get 'iloc',
> after use it miss release 'iloc.bh'.
> So just release 'iloc.bh' before 'ext4_fc_write_inode' return.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Yes, nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 2af962cbb835..b7414a5812f6 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -874,22 +874,25 @@ static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
>  	tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_INODE);
>  	tl.fc_len = cpu_to_le16(inode_len + sizeof(fc_inode.fc_ino));
>  
> +	ret = -ECANCELED;
>  	dst = ext4_fc_reserve_space(inode->i_sb,
>  			sizeof(tl) + inode_len + sizeof(fc_inode.fc_ino), crc);
>  	if (!dst)
> -		return -ECANCELED;
> +		goto err;
>  
>  	if (!ext4_fc_memcpy(inode->i_sb, dst, &tl, sizeof(tl), crc))
> -		return -ECANCELED;
> +		goto err;
>  	dst += sizeof(tl);
>  	if (!ext4_fc_memcpy(inode->i_sb, dst, &fc_inode, sizeof(fc_inode), crc))
> -		return -ECANCELED;
> +		goto err;
>  	dst += sizeof(fc_inode);
>  	if (!ext4_fc_memcpy(inode->i_sb, dst, (u8 *)ext4_raw_inode(&iloc),
>  					inode_len, crc))
> -		return -ECANCELED;
> -
> -	return 0;
> +		goto err;
> +	ret = 0;
> +err:
> +	brelse(iloc.bh);
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
