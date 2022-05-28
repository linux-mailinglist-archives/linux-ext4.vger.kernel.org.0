Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42D536D64
	for <lists+linux-ext4@lfdr.de>; Sat, 28 May 2022 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiE1PBS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiE1PBS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 11:01:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9DB63A4
        for <linux-ext4@vger.kernel.org>; Sat, 28 May 2022 08:01:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id j21so6334892pga.13
        for <linux-ext4@vger.kernel.org>; Sat, 28 May 2022 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y08oTtWqhyWbdPnqXUbFtXSo1yY24kHxI5QdJAjUrI0=;
        b=FMCFVD7RWf+cOhitFIw1vqDJkYLDiH0GvYMB3I0H7i3poRMEdS7eozUL8/J9Oy+cWS
         VQji76ZzEkeOIx52ain1amHSXMv2Dm6QHIc3ibNFZxRnbbMEO8Gg32NY8gfbGwT4yxFh
         uid5FsJs0P7gyOtsrqbLj6mSFFGqyjC9hmaFMNI8TPHM+O7yvGo58TWLmkv0ySCv8sHw
         lR1GwZHT48SHqBu9dWno7mZg/vT+zqeIG4wzmc9MPkhwK1ZYATRjzVxlnXA7GcNyXVRk
         ERScaTM8KOvF9DmdwB2XX4d8gvPM4BRo0Q24HnEnU9wKh9AyUsgd3p1y6H6hj4HghFqc
         XQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y08oTtWqhyWbdPnqXUbFtXSo1yY24kHxI5QdJAjUrI0=;
        b=4QK3EQTX/hFSWakO2oWQJFGYixoKtzfLeBoA/jWJKGdEciqXec32vtOJ0Kn2kUPjAd
         ef8PbhOe/EcBhkxHlx8VK4qXSeyfpOIKT3pBAaFch7H0LT5W5e6PICeMQ0dsBV5WtGnc
         BgEgbKEq5ofJLb5/6GnRm1cp/eItH95c+/GGpn7U2GbfVbLBWyxtyfEpdGwOHbP3/L1O
         eL8YD4XsMyaJdso1US+AyOA7c+gsyG2yps+cU71uKLRAds0yqEBj6q8HeZqMTbSRLMBw
         LdDUCk8ubFvLdKe069AatEh/7XIIirvv9lACqbGR0pHDxmf+2DO3CoXdZBpkJLQPoEMA
         jjpA==
X-Gm-Message-State: AOAM5325eM+NXJ4PzqF9Mmi/ORCJV78qpuQeTL7IjyCR+9+5by175msg
        KViEJJdMFYxG5hHM3/85RO4=
X-Google-Smtp-Source: ABdhPJwq3ai1PUcWFeex5ZI5w00MoonoYTu0qgP514wT3vwFjtcMZKTb09bj52XBd9dDTACFNuVkmA==
X-Received: by 2002:a63:5422:0:b0:3fb:f208:9ea3 with SMTP id i34-20020a635422000000b003fbf2089ea3mr147770pgb.305.1653750076155;
        Sat, 28 May 2022 08:01:16 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b00163c2b807a6sm366574plh.147.2022.05.28.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 08:01:15 -0700 (PDT)
Date:   Sat, 28 May 2022 20:31:11 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com,
        lilingfeng3@huawei.com
Subject: Re: [PATCH] ext4: add reserved GDT blocks check
Message-ID: <20220528150111.jw7env3gkpt24a2i@riteshh-domain>
References: <20220526073222.380259-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526073222.380259-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/26 03:32PM, Zhang Yi wrote:
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
> The fix is simple, add a check in ext4_resize_fs() to make sure that the
> es->s_reserved_gdt_blocks is zero when the resize_inode feature is
> disabled.

Your reasoning looks correct to me.

>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/resize.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 90a941d20dff..5791eb7c0761 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -2031,6 +2031,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
>  			ext4_warning(sb, "Error opening resize inode");
>  			return PTR_ERR(resize_inode);
>  		}
> +	} else if (es->s_reserved_gdt_blocks) {
> +		ext4_error(sb, "resize_inode disabled but reserved GDT blocks non-zero");
> +		return -EFSCORRUPTED;
>  	}

I think we should do this check in ext4_resize_begin(), i.e.
if ext4_has_feature_resize_inode() is false and es->s_reserved_gdt_blocks is
non-zero, then we should straight away mark and return error.

Later (not as part of this patch/fix) maybe if we detect this problem, we could
use helpers like ext4_update_super() to fix this mismatch problem in kernel
during mount itself. But I think this is not absolutely necessary,
as kernel already during mount outputs a warning and ask for running e2fsck.

Thougts?

-ritesh

>
>  	if ((!resize_inode && !meta_bg) || n_blocks_count == o_blocks_count) {
> --
> 2.31.1
>
