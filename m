Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571C360DE51
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiJZJjK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 05:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiJZJiz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 05:38:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64275C2C96;
        Wed, 26 Oct 2022 02:38:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2519D1F8B3;
        Wed, 26 Oct 2022 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666777099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYwForcnIzUHI++SczF7Cc0RCPx5lVQo/NMKAVmYF/w=;
        b=YVIBfXx5gT+c7Wu/bej1zX2byODJtXrhbkAT/7ZiZwglYngsD0C7VB1q/IoSAtWq/n9Obp
        OJZD9cJA01UpApai3miROsOHBChYFZV/mPotmTL3QQYD7a/+isfaU61egOBBcphoN8TWZv
        7rxwOMmAGLLdDOdNP4k82d68xhte9Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666777099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYwForcnIzUHI++SczF7Cc0RCPx5lVQo/NMKAVmYF/w=;
        b=DI8/mP+MLZjOpiDPh4+76l3CxM9J6sMwSvvtLnkXgUX4FNp9WFqYfub4Pey6C/LczZD01B
        7l8GkwsvtbGzIdDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15FB813A6E;
        Wed, 26 Oct 2022 09:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5ZRTBQsAWWNQZgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 26 Oct 2022 09:38:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9CA27A06F9; Wed, 26 Oct 2022 11:38:18 +0200 (CEST)
Date:   Wed, 26 Oct 2022 11:38:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 2/4] ext4: add helper to check quota inums
Message-ID: <20221026093818.cxnyr6h5ioxukgvf@quack3>
References: <20221026042310.3839669-1-libaokun1@huawei.com>
 <20221026042310.3839669-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026042310.3839669-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 26-10-22 12:23:08, Baokun Li wrote:
> Before quota is enabled, a check on the preset quota inums in
> ext4_super_block is added to prevent wrong quota inodes from being loaded.
> In addition, when the quota fails to be enabled, the quota type and quota
> inum are printed to facilitate fault locating.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 34b78f380968..0b4060d52d63 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6885,6 +6885,20 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
>  	return err;
>  }
>  
> +static inline bool ext4_check_quota_inum(int type, unsigned long qf_inum)
> +{
> +	switch (type) {
> +	case USRQUOTA:
> +		return qf_inum == EXT4_USR_QUOTA_INO;
> +	case GRPQUOTA:
> +		return qf_inum == EXT4_GRP_QUOTA_INO;
> +	case PRJQUOTA:
> +		return qf_inum >= EXT4_GOOD_OLD_FIRST_INO;
> +	default:
> +		BUG();
> +	}
> +}
> +
>  static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
>  			     unsigned int flags)
>  {
> @@ -6901,9 +6915,16 @@ static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
>  	if (!qf_inums[type])
>  		return -EPERM;
>  
> +	if (!ext4_check_quota_inum(type, qf_inums[type])) {
> +		ext4_error(sb, "Bad quota inum: %lu, type: %d",
> +				qf_inums[type], type);
> +		return -EUCLEAN;
> +	}
> +
>  	qf_inode = ext4_iget(sb, qf_inums[type], EXT4_IGET_SPECIAL);
>  	if (IS_ERR(qf_inode)) {
> -		ext4_error(sb, "Bad quota inode # %lu", qf_inums[type]);
> +		ext4_error(sb, "Bad quota inode: %lu, type: %d",
> +				qf_inums[type], type);
>  		return PTR_ERR(qf_inode);
>  	}
>  
> @@ -6942,8 +6963,9 @@ int ext4_enable_quotas(struct super_block *sb)
>  			if (err) {
>  				ext4_warning(sb,
>  					"Failed to enable quota tracking "
> -					"(type=%d, err=%d). Please run "
> -					"e2fsck to fix.", type, err);
> +					"(type=%d, err=%d, ino=%lu). "
> +					"Please run e2fsck to fix.", type,
> +					err, qf_inums[type]);
>  				for (type--; type >= 0; type--) {
>  					struct inode *inode;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
