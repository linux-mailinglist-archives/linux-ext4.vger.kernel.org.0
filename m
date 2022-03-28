Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073D14EA060
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Mar 2022 21:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbiC1Tuj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 15:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344045AbiC1TsH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 15:48:07 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756E869CF9
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 12:43:49 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id f7-20020a056602088700b00645ebbe277cso11011958ioz.22
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 12:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=sfYq/8af34F5Pw2+woSwGSNtMRJiUNObDRkzKEWFtx8=;
        b=GOTpQzrQnXUn2y3mpcAZqqC2HDjaZ9VKVNIPYkV/3zmPlIkop8VFRdq/lbt06r0+rR
         ItZ2xDBOV8jm0M7ECgaIizljDfs6V042mt/Go13tisZGWcJKOGM9q1bRdg+DCF8SRq/g
         u3K0i50bWN7N0mDCgEgRPpwFz/SFLu38OhJ1dEXDo2YAt0UPcvInNYFgumqyhhz6AWr2
         TZCWS/9D0aDIUFntcYRX6RqKDQJT3LyYNBRIjMmjG6V0Y7zVwoFqol1J5FA/h8b6yJRp
         BE3IX9lG7K26IzEUs2O4tF0V+gIKO+V1FdFA7iinwpKiTPjCGYHXm00GnF3eRNWhneX6
         4MQw==
X-Gm-Message-State: AOAM5323ue/nW1w6tBht6YijoNmpqCcPLJI8++PRl7CfA7XgDYedDZLQ
        mnWz8hM7mweHfl7vClFLNUjorbZU1PCxRQ/8ZHWW1SQ7t0m7
X-Google-Smtp-Source: ABdhPJxU9Z+aUCzvfuGvBlkzXzAL4SENDFQ4hQdHyneJE4P5abgm03akl3a+KXSQuj1XaskcfizfaitvkMboPGA/Vh9A5KIvzLVF
MIME-Version: 1.0
X-Received: by 2002:a02:c4cd:0:b0:321:2aef:337f with SMTP id
 h13-20020a02c4cd000000b003212aef337fmr13327539jaj.213.1648496618813; Mon, 28
 Mar 2022 12:43:38 -0700 (PDT)
Date:   Mon, 28 Mar 2022 12:43:38 -0700
In-Reply-To: <20220328194334.1586542-1-sashal@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060bcd005db4c87b8@google.com>
Subject: Re: [PATCH AUTOSEL 5.4 1/2] ext4: don't BUG if someone dirty pages
 without asking ext4 first
From:   syzbot 
        <syzbot+d59332e2db681cf18f0318a06e994ebbb529a8db@syzkaller.appspotmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     adilger.kernel@dilger.ca, lee.jones@linaro.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        sashal@kernel.org, stable@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> From: Theodore Ts'o <tytso@mit.edu>
>
> [ Upstream commit cc5095747edfb054ca2068d01af20be3fcc3634f ]
>
> [un]pin_user_pages_remote is dirtying pages without properly warning
> the file system in advance.  A related race was noted by Jan Kara in
> 2018[1]; however, more recently instead of it being a very hard-to-hit
> race, it could be reliably triggered by process_vm_writev(2) which was
> discovered by Syzbot[2].
>
> This is technically a bug in mm/gup.c, but arguably ext4 is fragile in
> that if some other kernel subsystem dirty pages without properly
> notifying the file system using page_mkwrite(), ext4 will BUG, while
> other file systems will not BUG (although data will still be lost).
>
> So instead of crashing with a BUG, issue a warning (since there may be
> potential data loss) and just mark the page as clean to avoid
> unprivileged denial of service attacks until the problem can be
> properly fixed.  More discussion and background can be found in the
> thread starting at [2].
>
> [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> [2] https://lore.kernel.org/r/Yg0m6IjcNmfaSokM@google.com
>
> Reported-by: syzbot+d59332e2db681cf18f0318a06e994ebbb529a8db@syzkaller.appspotmail.com
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://lore.kernel.org/r/YiDS9wVfq4mM2jGK@mit.edu
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/ext4/inode.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index dcbd8ac8d471..0d62f05f8925 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2161,6 +2161,15 @@ static int ext4_writepage(struct page *page,
>  	else
>  		len = PAGE_SIZE;
>  
> +	/* Should never happen but for bugs in other kernel subsystems */
> +	if (!page_has_buffers(page)) {
> +		ext4_warning_inode(inode,
> +		   "page %lu does not have buffers attached", page->index);
> +		ClearPageDirty(page);
> +		unlock_page(page);
> +		return 0;
> +	}
> +
>  	page_bufs = page_buffers(page);
>  	/*
>  	 * We cannot do block allocation or other extent handling in this
> @@ -2710,6 +2719,22 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  			wait_on_page_writeback(page);
>  			BUG_ON(PageWriteback(page));
>  
> +			/*
> +			 * Should never happen but for buggy code in
> +			 * other subsystems that call
> +			 * set_page_dirty() without properly warning
> +			 * the file system first.  See [1] for more
> +			 * information.
> +			 *
> +			 * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> +			 */
> +			if (!page_has_buffers(page)) {
> +				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", page->index);
> +				ClearPageDirty(page);
> +				unlock_page(page);
> +				continue;
> +			}
> +
>  			if (mpd->map.m_len == 0)
>  				mpd->first_page = page->index;
>  			mpd->next_page = page->index + 1;
> -- 
> 2.34.1
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

