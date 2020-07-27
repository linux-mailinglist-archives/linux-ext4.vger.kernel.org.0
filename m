Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BD622EC67
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 14:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgG0Mnv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 08:43:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44901 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728173AbgG0Mnu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jul 2020 08:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595853829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eKRCQYKT+EWPJTdFowcKdbbh3iytoIGi9ujFt3zxfqU=;
        b=g7ItrKe0UhfyrEpsXxxhRYguMDtxeMOuc4hkGUoAoRDK/qMIrF/F/VG+0sHTTiWxYIqBc0
        1cNii0dvy+FT4WokJfj6J4jEbLnDoni2E6X2e9tXzopswugruBRi2GS6sEwi4p+BeqHedB
        2PllRjuz93yyogcEgerw31vK60m7thw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-_qOowKWbPoKcJ_i5D4PfAA-1; Mon, 27 Jul 2020 08:43:47 -0400
X-MC-Unique: _qOowKWbPoKcJ_i5D4PfAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CE248017FB;
        Mon, 27 Jul 2020 12:43:46 +0000 (UTC)
Received: from work (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F656712C2;
        Mon, 27 Jul 2020 12:43:45 +0000 (UTC)
Date:   Mon, 27 Jul 2020 14:43:40 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/6] ext4: Correctly restore system zone info when
 remount fails
Message-ID: <20200727124340.doyenujsriu7gtw3@work>
References: <20200727114429.1478-1-jack@suse.cz>
 <20200727114429.1478-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727114429.1478-7-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 27, 2020 at 01:44:29PM +0200, Jan Kara wrote:
> When remounting filesystem fails late during remount handling and
> block_validity mount option is also changed during the remount, we fail
> to restore system zone information to a state matching the mount option.
> This is mostly harmless, just the block validity checking will not match
> the situation described by the mount option. Make sure these two are always
> consistent.

Looks good, thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Reported-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/block_validity.c |  8 --------
>  fs/ext4/super.c          | 29 +++++++++++++++++++++--------
>  2 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 2d008c1b58f2..c54ba52f2dd4 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -220,14 +220,6 @@ int ext4_setup_system_zone(struct super_block *sb)
>  	int flex_size = ext4_flex_bg_size(sbi);
>  	int ret;
>  
> -	if (!test_opt(sb, BLOCK_VALIDITY)) {
> -		if (sbi->system_blks)
> -			ext4_release_system_zone(sb);
> -		return 0;
> -	}
> -	if (sbi->system_blks)
> -		return 0;
> -
>  	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
>  	if (!system_blks)
>  		return -ENOMEM;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8e055ec57a2c..37f09ecca0df 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4698,11 +4698,13 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	ext4_set_resv_clusters(sb);
>  
> -	err = ext4_setup_system_zone(sb);
> -	if (err) {
> -		ext4_msg(sb, KERN_ERR, "failed to initialize system "
> -			 "zone (%d)", err);
> -		goto failed_mount4a;
> +	if (test_opt(sb, BLOCK_VALIDITY)) {
> +		err = ext4_setup_system_zone(sb);
> +		if (err) {
> +			ext4_msg(sb, KERN_ERR, "failed to initialize system "
> +				 "zone (%d)", err);
> +			goto failed_mount4a;
> +		}
>  	}
>  
>  	ext4_ext_init(sb);
> @@ -5653,9 +5655,16 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  		ext4_register_li_request(sb, first_not_zeroed);
>  	}
>  
> -	err = ext4_setup_system_zone(sb);
> -	if (err)
> -		goto restore_opts;
> +	/*
> +	 * Handle creation of system zone data early because it can fail.
> +	 * Releasing of existing data is done when we are sure remount will
> +	 * succeed.
> +	 */
> +	if (test_opt(sb, BLOCK_VALIDITY) && !sbi->system_blks) {
> +		err = ext4_setup_system_zone(sb);
> +		if (err)
> +			goto restore_opts;
> +	}
>  
>  	if (sbi->s_journal == NULL && !(old_sb_flags & SB_RDONLY)) {
>  		err = ext4_commit_super(sb, 1);
> @@ -5677,6 +5686,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  		}
>  	}
>  #endif
> +	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->system_blks)
> +		ext4_release_system_zone(sb);
>  
>  	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
>  	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
> @@ -5692,6 +5703,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  	sbi->s_commit_interval = old_opts.s_commit_interval;
>  	sbi->s_min_batch_time = old_opts.s_min_batch_time;
>  	sbi->s_max_batch_time = old_opts.s_max_batch_time;
> +	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->system_blks)
> +		ext4_release_system_zone(sb);
>  #ifdef CONFIG_QUOTA
>  	sbi->s_jquota_fmt = old_opts.s_jquota_fmt;
>  	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
> -- 
> 2.16.4
> 

