Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2903621E50
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 22:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKHVMp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 16:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiKHVMl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 16:12:41 -0500
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 13:12:36 PST
Received: from relay.herbolt.com (relay.herbolt.com [37.46.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DD13C6EE
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 13:12:36 -0800 (PST)
Received: from ip-78-102-244-147.net.upcbroadband.cz (ip-89-176-251-106.bb.vodafone.cz [89.176.251.106])
        by relay.herbolt.com (Postfix) with ESMTPSA id 342AB103464F;
        Tue,  8 Nov 2022 22:03:44 +0100 (CET)
Received: from mail.herbolt.com (http-server-2.local.lc [172.168.31.10])
        by mail.herbolt.com (Postfix) with ESMTPSA id AC6B8D34A00;
        Tue,  8 Nov 2022 22:03:43 +0100 (CET)
MIME-Version: 1.0
Date:   Tue, 08 Nov 2022 22:03:43 +0100
From:   Lukas Herbolt <lukas@herbolt.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: print file system UUID on mount, remount and
 unmount
In-Reply-To: <20221108145042.85770-1-lczerner@redhat.com>
References: <20221108145042.85770-1-lczerner@redhat.com>
Message-ID: <97cf8d4ac4b3a27b2fd0ee2013193cb1@herbolt.com>
X-Sender: lukas@herbolt.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 08.11.2022 15:50, Lukas Czerner wrote:
> The device names are not necessarily consistent across reboots which 
> can
> make it more difficult to identify the right file system when tracking
> down issues using system logs.
Looks good to me. Thanks Lukas for proposing it!

> Print file system UUID string on every mount, remount and unmount to
> make this task easier.
> 
> This is similar to the functionality recently propsed for XFS.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Cc: Lukas Herbolt <lukas@herbolt.com>
> ---
>  fs/ext4/super.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7cdd2138c897..4028bfc8206c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1206,7 +1206,8 @@ static void ext4_put_super(struct super_block 
> *sb)
>  	ext4_unregister_sysfs(sb);
> 
>  	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs unmount"))
> -		ext4_msg(sb, KERN_INFO, "unmounting filesystem.");
> +		ext4_msg(sb, KERN_INFO, "unmounting filesystem %pU.",
> +			 &sb->s_uuid);
> 
>  	ext4_unregister_li_request(sb);
>  	ext4_quota_off_umount(sb);
> @@ -5655,8 +5656,9 @@ static int ext4_fill_super(struct super_block
> *sb, struct fs_context *fc)
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
> @@ -6611,8 +6613,8 @@ static int ext4_reconfigure(struct fs_context 
> *fc)
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
