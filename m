Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1777654D913
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 06:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358519AbiFPECr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 00:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFPECq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 00:02:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3910BF;
        Wed, 15 Jun 2022 21:02:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a10so382346pju.3;
        Wed, 15 Jun 2022 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VgcmvBMYaAvkFoV/GdmhxQGa/IBRdQ0jo4q3o5tSuHU=;
        b=dvbGf2tL6ZgyHlbnVGCzRHoX2OO90yzF+vdTCxIe0BdKFNJQvoQewxxj477aQLIsP3
         jqWslkGhR9PZ8efKAftZc/Z0vYnocZ/16bxE6um/i1/Hry5e6Yl1NW4+3imk83zfdVID
         29FaVKz08eNFaue1Yrk0GQ0AgN2nbNNBS4FuOpH2VNhqqkgt2kRT8ZW3CbrJ2IJId4Kx
         4C8Yet7t38VibaFgn8J8fPNMkAoZwiPMqSbsaW+Mc91G1VueudPmV8J+g7RPH4+Dc4ol
         zI8ZNZ2RBzs5ZvCp7MhnRZwAE4Xm5WmLoUNqdgGHKVzd3eLDZjgWCSsyHXhRZp5B1DbM
         cf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VgcmvBMYaAvkFoV/GdmhxQGa/IBRdQ0jo4q3o5tSuHU=;
        b=2/gtKVXLyb6MJLy040FViqfrLfOKoGyMgt9975YI8XkbiY8TeIwuWhYaLIBTMhqPcX
         EVKG7r5zx5PdOx3xU8uggqDLdBJQf8s9hyR7/jrRtK1K7ePGHazURBJyqUh+3cPTt05L
         QD+D+ApzlCesq2UpW69OrRZ9s8VFLlJ/BMyG11Kmp8G+Wc6LPLls5NbSTMLPPuZakNOf
         Sz3a83BUZR6tYkEihmD0E/rSprFkPlI8FombyIfcLUkx42dFuJ1Rtz6D2s2UIm8jn2kd
         Q8ZDFEAoOPoQ8hjgtIcxz181Q8qGJRFYwe+ElKT4oEak2OXuRw+cA1E8sn1QnAmwcvDH
         V6tA==
X-Gm-Message-State: AJIora8MQecLifwXdCvxL0tgb0UYR0erI62vawkTLQwmbd4dBSjm/Poe
        oCuXq4v5acLtiCFp0EUhNsU3illghtU=
X-Google-Smtp-Source: AGRyM1srZTsddY7wDeuwZeMcrA1MybfuK6rBb3WilKsQy27fsC6z/OJYwUtBURUNytqxPWXK7HSg5g==
X-Received: by 2002:a17:902:ccd0:b0:168:db72:15e with SMTP id z16-20020a170902ccd000b00168db72015emr3015004ple.63.1655352164856;
        Wed, 15 Jun 2022 21:02:44 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id x27-20020aa78f1b000000b0051c78a6fb9csm451725pfr.111.2022.06.15.21.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 21:02:44 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:32:40 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        enwlinux@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH v3 2/4] ext4: fix use-after-free in ext4_xattr_set_entry
Message-ID: <20220616040240.wxftnctzfaboxziw@riteshh-domain>
References: <20220616021358.2504451-1-libaokun1@huawei.com>
 <20220616021358.2504451-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616021358.2504451-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/06/16 10:13AM, Baokun Li wrote:
> Hulk Robot reported a issue:
> ==================================================================
> BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x18ab/0x3500
> Write of size 4105 at addr ffff8881675ef5f4 by task syz-executor.0/7092
>
> CPU: 1 PID: 7092 Comm: syz-executor.0 Not tainted 4.19.90-dirty #17
> Call Trace:
> [...]
>  memcpy+0x34/0x50 mm/kasan/kasan.c:303
>  ext4_xattr_set_entry+0x18ab/0x3500 fs/ext4/xattr.c:1747
>  ext4_xattr_ibody_inline_set+0x86/0x2a0 fs/ext4/xattr.c:2205
>  ext4_xattr_set_handle+0x940/0x1300 fs/ext4/xattr.c:2386
>  ext4_xattr_set+0x1da/0x300 fs/ext4/xattr.c:2498
>  __vfs_setxattr+0x112/0x170 fs/xattr.c:149
>  __vfs_setxattr_noperm+0x11b/0x2a0 fs/xattr.c:180
>  __vfs_setxattr_locked+0x17b/0x250 fs/xattr.c:238
>  vfs_setxattr+0xed/0x270 fs/xattr.c:255
>  setxattr+0x235/0x330 fs/xattr.c:520
>  path_setxattr+0x176/0x190 fs/xattr.c:539
>  __do_sys_lsetxattr fs/xattr.c:561 [inline]
>  __se_sys_lsetxattr fs/xattr.c:557 [inline]
>  __x64_sys_lsetxattr+0xc2/0x160 fs/xattr.c:557
>  do_syscall_64+0xdf/0x530 arch/x86/entry/common.c:298
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x459fe9
> RSP: 002b:00007fa5e54b4c08 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
> RAX: ffffffffffffffda RBX: 000000000051bf60 RCX: 0000000000459fe9
> RDX: 00000000200003c0 RSI: 0000000020000180 RDI: 0000000020000140
> RBP: 000000000051bf60 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000001009 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc73c93fc0 R14: 000000000051bf60 R15: 00007fa5e54b4d80
> [...]
> ==================================================================
>
> Above issue may happen as follows:
> -------------------------------------
> ext4_xattr_set
>   ext4_xattr_set_handle
>     ext4_xattr_ibody_find
>       >> s->end < s->base
>       >> no EXT4_STATE_XATTR
>       >> xattr_check_inode is not executed
>     ext4_xattr_ibody_set
>       ext4_xattr_set_entry
>        >> size_t min_offs = s->end - s->base
>        >> UAF in memcpy
>
> we can easily reproduce this problem with the following commands:
>     mkfs.ext4 -F /dev/sda
>     mount -o debug_want_extra_isize=128 /dev/sda /mnt
>     touch /mnt/file
>     setfattr -n user.cat -v `seq -s z 4096|tr -d '[:digit:]'` /mnt/file

Thanks for sharing the test case. Indeed this results into UAF.

>
> In ext4_xattr_ibody_find, we have the following assignment logic:
>   header = IHDR(inode, raw_inode)
>          = raw_inode + EXT4_GOOD_OLD_INODE_SIZE + i_extra_isize
>   is->s.base = IFIRST(header)
>              = header + sizeof(struct ext4_xattr_ibody_header)
>   is->s.end = raw_inode + s_inode_size
>
> In ext4_xattr_set_entry
>   min_offs = s->end - s->base
>            = s_inode_size - EXT4_GOOD_OLD_INODE_SIZE - i_extra_isize -
> 	     sizeof(struct ext4_xattr_ibody_header)
>   last = s->first
>   free = min_offs - ((void *)last - s->base) - sizeof(__u32)
>        = s_inode_size - EXT4_GOOD_OLD_INODE_SIZE - i_extra_isize -
>          sizeof(struct ext4_xattr_ibody_header) - sizeof(__u32)
>
> In the calculation formula, all values except s_inode_size and
> i_extra_size are fixed values. When i_extra_size is the maximum value
> s_inode_size - EXT4_GOOD_OLD_INODE_SIZE, min_offs is -4 and free is -8.
> The value overflows. As a result, the preceding issue is triggered when
> memcpy is executed.
>
> Therefore, when finding xattr or setting xattr, check whether
> there is space for storing xattr in the inode to resolve this issue.

Sounds right. Thanks for fixing it and providing detailed analysis.

Feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/xattr.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 042325349098..c3c3194f3ee1 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2176,8 +2176,9 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
>  	struct ext4_inode *raw_inode;
>  	int error;
>
> -	if (EXT4_I(inode)->i_extra_isize == 0)
> +	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
>  		return 0;
> +
>  	raw_inode = ext4_raw_inode(&is->iloc);
>  	header = IHDR(inode, raw_inode);
>  	is->s.base = is->s.first = IFIRST(header);
> @@ -2205,8 +2206,9 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
>  	struct ext4_xattr_search *s = &is->s;
>  	int error;
>
> -	if (EXT4_I(inode)->i_extra_isize == 0)
> +	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
>  		return -ENOSPC;
> +
>  	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
>  	if (error)
>  		return error;
> --
> 2.31.1
>
