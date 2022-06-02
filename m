Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96B53B1BC
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jun 2022 04:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiFBC2I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jun 2022 22:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiFBC2G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jun 2022 22:28:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23121A5
        for <linux-ext4@vger.kernel.org>; Wed,  1 Jun 2022 19:28:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g205so3530305pfb.11
        for <linux-ext4@vger.kernel.org>; Wed, 01 Jun 2022 19:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sP1AjltD2kCSdzco34oaeLkK6/y2BQE2jAAvB2QYynw=;
        b=qUTfLffRcROj0Rw7oGHnkblprJ0+PnfA2BkZg4UM0nd1Nnto8Z5w2xTvbHPv5o/IOf
         1nNicCllomgPjQrQrlFTEqpuWo8/81lXHbibiGYhKRip+8MBn9jguJJ/dUTvEz2Nmthf
         Jh95P952abxDXyp8o8PcNDL+IDPfH441DXx+YJ/QhTognWE9kxa3IgHKruiLwlTu8o0D
         qVbH2YbJidYOaKZ8qNFO/cq2PDeUwkeRNXclBZsOUNX9kgUBbRVQ5SlGYLbkOaL/Sism
         hdKGhFBNvTWVhby7zPIlZRCAldseAAvG0BoaHQoiFcONbDTnqsAGITLipvJWrm4VvLeB
         H6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sP1AjltD2kCSdzco34oaeLkK6/y2BQE2jAAvB2QYynw=;
        b=uokqCJcS1219vtQwbwn7nryPZcQ+J6jgbzEdokkTGnj7EhYVgdIlFSytqEamMpiH3a
         vfPkvTXEhCPSpGl8K+kWGvgszG5z81ZXyNEctaKeUIp1aYIfPImqEwyv7I65HN4y5Qxg
         feQaJNKnB8hv0wubvfrZTgW//UiQlnTleXtcwhUiLBn+sLZcjg0YOs9V3fzBwoblW73x
         H/gfp+Y4l2WsFDY1chl25xyFoWfHuUws37JfLgX4Jh+G5PYB9jjhgJGZgmCEEf2GCE2i
         EvHqnWMwDUAI5qITwQtW9fdHFhWXWcdWpPkq7C6doIiHhFOky5LgBmIR//aiX47wJVnF
         5WkQ==
X-Gm-Message-State: AOAM530RLXVgDwOA4/hkhT0PZi4jken1BTwCjl40mQyXnQoQERkw1eNS
        E9iaLwIpjzPcP3ua91fJZJI=
X-Google-Smtp-Source: ABdhPJyZ4DLdEfNuszjKv4/9eMx9fTr8AlqlnAt8UGAOlTu4YubqM5EvXRKX7XWU2m+/gSwot39kFw==
X-Received: by 2002:a62:ce4f:0:b0:51b:ac5c:4e49 with SMTP id y76-20020a62ce4f000000b0051bac5c4e49mr2533364pfg.81.1654136885034;
        Wed, 01 Jun 2022 19:28:05 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id k14-20020a63560e000000b003c6a71b2ab7sm1923431pgb.46.2022.06.01.19.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 19:28:04 -0700 (PDT)
Date:   Thu, 2 Jun 2022 07:57:59 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v2] ext4: add reserved GDT blocks check
Message-ID: <20220602022759.toshyajuhbw2iz4g@riteshh-domain>
References: <20220601092717.763694-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601092717.763694-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/06/01 05:27PM, Zhang Yi wrote:
> We capture a NULL pointer issue when resizing a corrupt ext4 image which
> is freshly clear resize_inode feature (not run e2fsck). It could be
> simply reproduced by following steps. The problem is because of the
> resize_inode feature was cleared, and it will convert the filesystem to
> meta_bg mode in ext4_resize_fs(), but the es->s_reserved_gdt_blocks was
> not reduced to zero, so could we mistakenly call reserve_backup_gdb()
> and passing an uninitialized resize_inode to it when adding new group
> descriptors.
>
>  mkfs.ext4 /dev/sda 3G
>  tune2fs -O ^resize_inode /dev/sda #forget to run requested e2fsck
>  mount /dev/sda /mnt
>  resize2fs /dev/sda 8G
>
>  ========
>  BUG: kernel NULL pointer dereference, address: 0000000000000028
>  CPU: 19 PID: 3243 Comm: resize2fs Not tainted 5.18.0-rc7-00001-gfde086c5ebfd #748
>  ...
>  RIP: 0010:ext4_flex_group_add+0xe08/0x2570
>  ...
>  Call Trace:
>   <TASK>
>   ext4_resize_fs+0xbec/0x1660
>   __ext4_ioctl+0x1749/0x24e0
>   ext4_ioctl+0x12/0x20
>   __x64_sys_ioctl+0xa6/0x110
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f2dd739617b
>  ========
>
> The fix is simple, add a check in ext4_resize_begin() to make sure that
> the es->s_reserved_gdt_blocks is zero when the resize_inode feature is
> disabled.

Sure, I have verified this change at my end too with your execerciser.
And having this check this in ext4_resize_begin(), looks good to me.

Feel free to add -

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v2->v1:
>  - move check from ext4_resize_fs() to ext4_resize_begin().
>
>  fs/ext4/resize.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 90a941d20dff..8b70a4701293 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -53,6 +53,16 @@ int ext4_resize_begin(struct super_block *sb)
>  	if (!capable(CAP_SYS_RESOURCE))
>  		return -EPERM;
>
> +	/*
> +	 * If the reserved GDT blocks is non-zero, the resize_inode feature
> +	 * should always be set.
> +	 */
> +	if (EXT4_SB(sb)->s_es->s_reserved_gdt_blocks &&
> +	    !ext4_has_feature_resize_inode(sb)) {
> +		ext4_error(sb, "resize_inode disabled but reserved GDT blocks non-zero");
> +		return -EFSCORRUPTED;
> +	}
> +
>  	/*
>  	 * If we are not using the primary superblock/GDT copy don't resize,
>           * because the user tools have no way of handling this.  Probably a
> --
> 2.31.1
>
