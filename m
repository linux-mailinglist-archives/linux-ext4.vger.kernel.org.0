Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577355A7C54
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiHaLl6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHaLl5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:41:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256BAB9F9A
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:41:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D13BE1F93E;
        Wed, 31 Aug 2022 11:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661946115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A5skB+dd2AD2sGuukGotIBQPJFTiBN6XmZ0jQsDThcU=;
        b=Y1BktVKuKT67veVvSNbXsQ/wjQmE9dwAcPAn8Tq4/FQWNNvkRf6DuS7ctRBFrUQQle5Csx
        uLGb5PPw/MeuqSH9CFQqb1Um3tEgj3jpV20NZnq7aLYWtIRqKD9wSTx9Zs14wOchjMs482
        KzICkPJtxHWhfMVqTK3XJbFJv4Gacns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661946115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A5skB+dd2AD2sGuukGotIBQPJFTiBN6XmZ0jQsDThcU=;
        b=xCfemN9AJX668zaIiRLhLdiJQcPvfdNpm5RXVOJ/4F6eISNgFPXktWcp50/0/L/LQCnEIy
        Gg2HkbBjacvbS3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE0521332D;
        Wed, 31 Aug 2022 11:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tbdSLgNJD2NdBQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:41:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3E409A067B; Wed, 31 Aug 2022 13:41:55 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:41:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 02/13] ext4: remove cantfind_ext4 error handler
Message-ID: <20220831114155.6eilxulqisq7zg2j@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-3-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-3-yanaijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:00, Jason Yan wrote:
> The 'cantfind_ext4' error handler is just a error msg print and then
> goto failed_mount. This two level goto makes the code complex and not
> easy to read. The only benefit is that is saves a little bit code.
> However some branches can merge and some branches dot not even need it.
> So do some refactor and remove it.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Yeah, probably makes sense. Just small style nits below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -4798,8 +4800,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
>  
>  	sbi->s_inodes_per_block = blocksize / EXT4_INODE_SIZE(sb);
> -	if (sbi->s_inodes_per_block == 0)
> -		goto cantfind_ext4;
> +	if (sbi->s_inodes_per_block == 0 || (EXT4_BLOCKS_PER_GROUP(sb) == 0)) {

I'd write this as:

	if (sbi->s_inodes_per_block == 0 || sbi->s_blocks_per_group == 0) {

to avoid superfluous braces and make the code a bit more natural.

									Honza

> +		if (!silent)
> +			ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
> +		goto failed_mount;
> +	}
>  	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
>  	    sbi->s_inodes_per_group > blocksize * 8) {
>  		ext4_msg(sb, KERN_ERR, "invalid inodes per group: %lu\n",
> @@ -4896,9 +4901,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		goto failed_mount;
>  	}
>  
> -	if (EXT4_BLOCKS_PER_GROUP(sb) == 0)
> -		goto cantfind_ext4;
> -
>  	/* check blocks count against device size */
>  	blocks_count = sb_bdev_nr_blocks(sb);
>  	if (blocks_count && ext4_blocks_count(es) > blocks_count) {
> @@ -5408,11 +5410,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	return 0;
>  
> -cantfind_ext4:
> -	if (!silent)
> -		ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
> -	goto failed_mount;
> -
>  failed_mount9:
>  	ext4_release_orphan_info(sb);
>  failed_mount8:
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
