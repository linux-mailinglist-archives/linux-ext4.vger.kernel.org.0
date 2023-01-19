Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E1D673DA1
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 16:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjASPfr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 10:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjASPfn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 10:35:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FE08455D;
        Thu, 19 Jan 2023 07:35:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE06F5CF34;
        Thu, 19 Jan 2023 15:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674142533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bgoU10Jpwp3Wcue7Yi3vYVywPMli7wY4wRcHZx3PSzk=;
        b=G13FrqbK4qEtDHNCacmQIkOHhLPK+f7yD61hzIgnUVOPS+dyNlbt/eKbW8xUVMAznsTzUF
        +zLOuho/JhCVr4aIZnx5Y4H/OSbzmS4+MCiNjv0RnAMtglAviNYjlJEG38gzy0sYP0dzdN
        arKqFM4mG6/HntouaKxHRxYSrPumdoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674142533;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bgoU10Jpwp3Wcue7Yi3vYVywPMli7wY4wRcHZx3PSzk=;
        b=fjURUhO6yVIpkK+w7jZZ1QZQ3Y8dSTDa/+tKq0j1cPHAKYaV/RgyytpUhKJFtcsmzuXJFH
        KRzf2DHurwdAt3Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 952F0134F5;
        Thu, 19 Jan 2023 15:35:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RyNJJEVjyWMnSwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Jan 2023 15:35:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 28627A06B2; Thu, 19 Jan 2023 16:35:32 +0100 (CET)
Date:   Thu, 19 Jan 2023 16:35:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] ext4: init error handle resource before init group
 descriptors
Message-ID: <20230119153532.ws3knxxjy6sjxnuz@quack3>
References: <20230119013711.86680-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119013711.86680-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 19-01-23 09:37:11, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, 's_err_report' timer is init after ext4_group_desc_init() when fill
> super. Theoretically, ext4_group_desc_init() may access to error handle
> as follows:
> __ext4_fill_super
>   ext4_group_desc_init
>     ext4_check_descriptors
>       ext4_get_group_desc
>         ext4_error
>           ext4_handle_error
>             ext4_commit_super
>               ext4_update_super
>                 if (!es->s_error_count)
>                   mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);
> 		  --> Accessing Uninitialized Variables
> timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
> 
> Maybe above issue is just theoretical, as ext4_check_descriptors() didn't
> judge 'gpd' which get from ext4_get_group_desc(), if access to error handle
> ext4_get_group_desc() will return NULL, then will trigger null-ptr-deref in
> ext4_check_descriptors().
> However, from the perspective of pure code, it is better to initialize
> resource that may need to be used first.

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

>  fs/ext4/super.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b31db521d6bf..dc3907dff13a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4738,7 +4738,6 @@ static int ext4_group_desc_init(struct super_block *sb,
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	unsigned int db_count;
>  	ext4_fsblk_t block;
> -	int ret;
>  	int i;
>  
>  	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
> @@ -4778,8 +4777,7 @@ static int ext4_group_desc_init(struct super_block *sb,
>  			ext4_msg(sb, KERN_ERR,
>  			       "can't read group descriptor %d", i);
>  			sbi->s_gdb_count = i;
> -			ret = PTR_ERR(bh);
> -			goto out;
> +			return PTR_ERR(bh);
>  		}
>  		rcu_read_lock();
>  		rcu_dereference(sbi->s_group_desc)[i] = bh;
> @@ -4788,13 +4786,10 @@ static int ext4_group_desc_init(struct super_block *sb,
>  	sbi->s_gdb_count = db_count;
>  	if (!ext4_check_descriptors(sb, logical_sb_block, first_not_zeroed)) {
>  		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
> -		ret = -EFSCORRUPTED;
> -		goto out;
> +		return -EFSCORRUPTED;
>  	}
> +
>  	return 0;
> -out:
> -	ext4_group_desc_free(sbi);
> -	return ret;
>  }
>  
>  static int ext4_load_and_init_journal(struct super_block *sb,
> @@ -5220,14 +5215,14 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	if (ext4_geometry_check(sb, es))
>  		goto failed_mount;
>  
> -	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
> -	if (err)
> -		goto failed_mount;
> -
>  	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
>  	spin_lock_init(&sbi->s_error_lock);
>  	INIT_WORK(&sbi->s_error_work, flush_stashed_error_work);
>  
> +	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
> +	if (err)
> +		goto failed_mount3;
> +
>  	/* Register extent status tree shrinker */
>  	if (ext4_es_register_shrinker(sbi))
>  		goto failed_mount3;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
