Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661E34E9FE9
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Mar 2022 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbiC1Tnx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 15:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242573AbiC1Tnu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 15:43:50 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBF55C370
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 12:42:08 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o17-20020a92c691000000b002c2c04aebe7so8392469ilg.8
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 12:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=1f9ND9o/PsSNeonnJwXgaxAKcaZUJc1enOSDuKxkvj0=;
        b=vYIMcNd7F5HlC7zaF57fOoD9n0OSAuVrE3u0GnuWKkiwV/MBexOuiJ4EN7m5uyufUf
         SmHhTmBfXjDUPwhn2hVXjtndphHepHTvX4Bh0fxrx6EEpQynEQ3zrKDgpD2DKfb0Eqle
         YsFJTaA0gKxm5EfKT6DxbRPxtKZ2vDWqjAyYxDKhIm4CC2iTyArwyn7FD+NFcfyizm4E
         XA5QehQmiqnX3OiIUyIsj4D/+h+/a23cHaUGaDZWfFTBa4+Y/hbgm/5PUOaEHIX+dCxf
         CPIBoSV4hdUlS6XteNnb8e5lQu6qmHffet3HE68sPgG3D9D506Y/1ihsHHMquAo+Z5e0
         CAYg==
X-Gm-Message-State: AOAM5332umvLwNKotnBKXEyZaIucaOL9gqwcM+xG7fQekAaMEmCvxhJ9
        8AoeXkv27pfJqk+20zKlRh/tskcJz2N+32cfTWOgI4S0ilkT
X-Google-Smtp-Source: ABdhPJwT4asTjmA8p7L275zbIbaYIcJpq0BzCmH5c/hc+svlsV1Zz9bZm6Ufec9Kfmy1AOliy435OXO66dIHDrAlVOXaEd4z83u9
MIME-Version: 1.0
X-Received: by 2002:a6b:fd0c:0:b0:645:d261:ba25 with SMTP id
 c12-20020a6bfd0c000000b00645d261ba25mr7379533ioi.124.1648496528212; Mon, 28
 Mar 2022 12:42:08 -0700 (PDT)
Date:   Mon, 28 Mar 2022 12:42:08 -0700
In-Reply-To: <20220328194157.1585642-7-sashal@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa496505db4c811d@google.com>
Subject: Re: [PATCH AUTOSEL 5.17 07/21] ext4: don't BUG if someone dirty pages
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
> index 01c9e4f743ba..531a94f48637 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1993,6 +1993,15 @@ static int ext4_writepage(struct page *page,
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
> @@ -2594,6 +2603,22 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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

