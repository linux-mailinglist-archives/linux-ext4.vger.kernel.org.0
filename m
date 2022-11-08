Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2691621993
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiKHQhD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 11:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHQhC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 11:37:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866255656F
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 08:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B599B81BA7
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 16:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C04C433D6;
        Tue,  8 Nov 2022 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667925415;
        bh=JGZ87mEkKOF25H64wPjddGotbq3Zhk6XiKcjvNJCnDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3ehjrGk4+9iLt1/cgQPuxKAtFrjA79nDUY4sfgZwoID6228iCkYdoiUvOxvKr65s
         k0dhzJw2CcYhDvv270SeGmsFxxpKUHLo9QjEpCFuDHp+xSmrUqc9aDOM+aXyJhcRMv
         E+FLAZOYAi2u4Deg8rZ1nhQsCCD22ONJkwUvky9hAoYN3Ho/1Wv/yLJKaPcmvQkV9X
         BK8RmS7HnOAb9I0qjZDpyhAnMNUTYCz3uooUIq5Iq5Mmtsy8er6q95VBdAx9SkWPkO
         sKSLU8z0FDjpYi56B69FGNhR+Bs+QTSfu5/C4OIKlBozgSA87q9XPAwX3N7qPeTH8g
         uHP/K/cIIURgQ==
Date:   Tue, 8 Nov 2022 08:36:55 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        Lukas Herbolt <lukas@herbolt.com>
Subject: Re: [PATCH] ext4: print file system UUID on mount, remount and
 unmount
Message-ID: <Y2qFpxjPpA/+nRm6@magnolia>
References: <20221108145042.85770-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108145042.85770-1-lczerner@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 08, 2022 at 03:50:42PM +0100, Lukas Czerner wrote:
> The device names are not necessarily consistent across reboots which can
> make it more difficult to identify the right file system when tracking
> down issues using system logs.
> 
> Print file system UUID string on every mount, remount and unmount to
> make this task easier.
> 
> This is similar to the functionality recently propsed for XFS.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Cc: Lukas Herbolt <lukas@herbolt.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ext4/super.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7cdd2138c897..4028bfc8206c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1206,7 +1206,8 @@ static void ext4_put_super(struct super_block *sb)
>  	ext4_unregister_sysfs(sb);
>  
>  	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs unmount"))
> -		ext4_msg(sb, KERN_INFO, "unmounting filesystem.");
> +		ext4_msg(sb, KERN_INFO, "unmounting filesystem %pU.",
> +			 &sb->s_uuid);
>  
>  	ext4_unregister_li_request(sb);
>  	ext4_quota_off_umount(sb);
> @@ -5655,8 +5656,9 @@ static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
>  		descr = "out journal";
>  
>  	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
> -		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
> -			 "Quota mode: %s.", descr, ext4_quota_mode(sb));
> +		ext4_msg(sb, KERN_INFO, "mounted filesystem %pU with%s. "
> +			 "Quota mode: %s.", &sb->s_uuid, descr,
> +			 ext4_quota_mode(sb));
>  
>  	/* Update the s_overhead_clusters if necessary */
>  	ext4_update_overhead(sb, false);
> @@ -6611,8 +6613,8 @@ static int ext4_reconfigure(struct fs_context *fc)
>  	if (ret < 0)
>  		return ret;
>  
> -	ext4_msg(sb, KERN_INFO, "re-mounted. Quota mode: %s.",
> -		 ext4_quota_mode(sb));
> +	ext4_msg(sb, KERN_INFO, "re-mounted %pU. Quota mode: %s.",
> +		 &sb->s_uuid, ext4_quota_mode(sb));
>  
>  	return 0;
>  }
> -- 
> 2.38.1
> 
