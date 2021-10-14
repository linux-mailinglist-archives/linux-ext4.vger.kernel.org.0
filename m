Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43542D5F3
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 11:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhJNJ2L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 05:28:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41964 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJ2K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 05:28:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3A4EA1FD29;
        Thu, 14 Oct 2021 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634203565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RFOdYQjzDv9lKUvJKboCo23r0L/XTwNAaieaO8QbCzY=;
        b=lPxvvFIjUfVNHyO0Mk2zC16+PLVqSeQLVgSSAx4M2H1+hXVTuop+RuupG4auHz9Ey9Ix5V
        tU+hAXdDoK74y3HWiW6Ua+zRRJ6Kn+0/S3fR3ttQDJwoMqmhuq70ZVGReGJHT4smT+BAEX
        FrXogTsztG/KeCqDrZ6NbSvpAXopE8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634203565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RFOdYQjzDv9lKUvJKboCo23r0L/XTwNAaieaO8QbCzY=;
        b=6TUWxJUwwf94kokRjlC2HXQBh+uij3gFkgmi/LsLkZyvDTg6Tt8cuIvNO9PxUfYczmqgBM
        mCsDiVobQVkC3HCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id AD2B9A3B84;
        Thu, 14 Oct 2021 09:26:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6C7BA1E0C03; Thu, 14 Oct 2021 11:26:04 +0200 (CEST)
Date:   Thu, 14 Oct 2021 11:26:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        austin.kim@lge.com
Subject: Re: [PATCH] ext4: remove an unused variable warning with
 CONFIG_QUOTA=n
Message-ID: <20211014092604.GC15931@quack2.suse.cz>
References: <20210824034929.GA13415@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210824034929.GA13415@raspberrypi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 24-08-21 04:49:29, Austin Kim wrote:
> The 'enable_quota' variable is only used in an CONFIG_QUOTA.
> With CONFIG_QUOTA=n, compiler causes a harmless warning:
> 
> fs/ext4/super.c: In function ‘ext4_remount’:
> fs/ext4/super.c:5840:6: warning: variable ‘enable_quota’ set but not used
>   [-Wunused-but-set-variable]
>   int enable_quota = 0;
>               ^~~~~
> 
> Move 'enable_quota' into the same #ifdef CONFIG_QUOTA block
> to remove an unused variable warning.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>

I guess this has fallen through the cracks. The fix looks good to me. Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6b03e4281f6f..6adb570f4b31 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5845,10 +5845,10 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	unsigned long old_sb_flags, vfs_flags;
>  	struct ext4_mount_options old_opts;
> -	int enable_quota = 0;
>  	ext4_group_t g;
>  	int err = 0;
>  #ifdef CONFIG_QUOTA
> +	int enable_quota = 0;
>  	int i, j;
>  	char *to_free[EXT4_MAXQUOTAS];
>  #endif
> @@ -6053,7 +6053,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  					err = -EROFS;
>  					goto restore_opts;
>  				}
> +#ifdef CONFIG_QUOTA
>  			enable_quota = 1;
> +#endif
>  		}
>  	}
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
