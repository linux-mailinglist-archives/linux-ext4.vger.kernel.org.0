Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E560D4FE602
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Apr 2022 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiDLQmx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 12:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiDLQmb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 12:42:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7971649689
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 09:40:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E4F0F1F38D;
        Tue, 12 Apr 2022 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649781610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+cFcrBGDRq5wXinnuj3YEWwyUjiPZroTP/b6Kyix1Y=;
        b=K63oqVP/a7Ch5emB8u12cgVJTd02ijLZcNq/jI2hARiIUFxtV7V73lv4Ylm+DXP9ONyWj9
        sBxuzXXSZ8jGvxeffQYPcBKGcaIhg6pkEFJI1HkIy/MOnpFRr669WWzvl0Ykzz+57hpQbb
        lQ3ivjnvnpj2vFniN8nGPTAUm+utTvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649781610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+cFcrBGDRq5wXinnuj3YEWwyUjiPZroTP/b6Kyix1Y=;
        b=zPG1lEjUd5TVgrz6Gp1lNpFtYlM0dL6B7sw6I6PFjGIdQvFv8kfUvyp0xIxubUwinNMiKT
        OoBmW3TSp7dhJKCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A2EB6A3B8A;
        Tue, 12 Apr 2022 16:40:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A04DA0615; Tue, 12 Apr 2022 18:40:09 +0200 (CEST)
Date:   Tue, 12 Apr 2022 18:40:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com,
        yebin10@huawei.com, liuzhiqiang26@huawei.com, liangyun2@huawei.com
Subject: Re: [RFC PATCH] ext4: add unmount filesystem message
Message-ID: <20220412164009.n24vnb2ivzjihaw6@quack3.lan>
References: <20220412145320.2669897-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412145320.2669897-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 12-04-22 22:53:20, Zhang Yi wrote:
> Now that we have kernel message at mount time, system administrator
> could acquire the mount time, device and options easily. But we don't
> have corresponding unmounting message at umount time, so we cannot know
> if someone umount a filesystem easily. Some of the modern filesystems
> (e.g. xfs) have the umounting kernel message, so add one for ext4
> filesystem for convenience.
> 
>  EXT4-fs (sdb): mounted filesystem with ordered data mode. Quota mode: none.
>  EXT4-fs (sdb): unmounting filesystem.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 81749eaddf4c..bdecf62f4b55 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1199,6 +1199,9 @@ static void ext4_put_super(struct super_block *sb)
>  	int aborted = 0;
>  	int i, err;
>  
> +	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs unmount"))
> +		ext4_msg(sb, KERN_INFO, "unmounting filesystem.");
> +
>  	ext4_unregister_li_request(sb);
>  	ext4_quota_off_umount(sb);
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
