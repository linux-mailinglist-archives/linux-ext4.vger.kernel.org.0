Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F84B61EF7C
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 10:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiKGJq4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 04:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiKGJqv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 04:46:51 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2185178BA
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 01:46:50 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id o70so12892553yba.7
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 01:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WBuAqvJwNzbK7aFJDRuKKXUc72gKk0jK+U1Jq9qVZBY=;
        b=iAZrcXgbgrHxR7U/PiFdvmW2Za9asY24vURRJGcl26Jv1tf4hDdSJHFcfm+9UrXHEh
         c9nSmmOzIjRJw3YUJ+1JHeWjsGoJpqFiEL3swNxDwGvuiN/cBPo81lXOn23FDROKtQ/a
         jJcf3R+RdrgmRKwyWACsHhB9j5Avm+JTNH11G0Eto2m+nZ61B/I4Kih+ZOfpwXdrjGN1
         w8VgDhgiqI2UhEIIReyeTrEAbi9wyDL4IVqi+jtAgmRtSpCIe7JGjUOhJj2sjJJwyLRu
         Io0MV0FErcwEtTs846vXts4qDAI87likEZQM+TTDsIGw6nNaJ3r0L/vPcOIUEnJk6+xR
         f+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBuAqvJwNzbK7aFJDRuKKXUc72gKk0jK+U1Jq9qVZBY=;
        b=j3FGQAwTb6F4twtHpLIdkcQ8SJJJcXroSZxyg0eE1BJyPlTpyfrWH+2trYZQyYHjLs
         9Wa9JUKKvoDw1RnKZd2S/++plYFg9TjgOlAhkRiLbWyo99iEEX6nnsfQmqk6O34Mk93Y
         DvBcp5HnLpMYOpHnVsvheZhsEil9ovC6Ek5GU7010k5bgQtsir0elKhgXKEbFm/J/AAy
         RGidNwU6rks2Bx/1CNuG02tKI9K9IJ8PKo42YwpCt1vxiqBAcerIi9fqeI9aHE7RffG6
         sQuLSAJtu1JybDhTSwYZdBYTq/XnYU4yfm5g50phc92YTcu9OzZyqf5uh8m5msW74jkl
         1LLQ==
X-Gm-Message-State: ANoB5pkIv9VXg+X3f89A+UkqkCGehvl+doHf6j/Pd1kDbpKYcAlzxbtK
        24lYqBAafVNdvstK66XEOHS4ZBrnV/lUuh1EFeJCKg==
X-Google-Smtp-Source: AA0mqf60KM7To85c5F3vL7VpopIOeWhfrNlKtLo6tdSAX76P5UHsBuadfmhFw8ekhRczN2CTiAJVk+bDeJVuZzXOKP8=
X-Received: by 2002:a25:4090:0:b0:6d3:7bde:23fe with SMTP id
 n138-20020a254090000000b006d37bde23femr15025924yba.388.1667814409715; Mon, 07
 Nov 2022 01:46:49 -0800 (PST)
MIME-Version: 1.0
References: <00000000000058d01705ecddccb0@google.com>
In-Reply-To: <00000000000058d01705ecddccb0@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 7 Nov 2022 10:46:13 +0100
Message-ID: <CAG_fn=WAyOc+1GEC+P3PpTM2zLcLcepAX1pPXkj5C6aPyrDVUA@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in pagecache_write
To:     syzbot <syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 7, 2022 at 10:10 AM syzbot
<syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    968c2729e576 x86: kmsan: fix comment in kmsan_shadow.c
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d01ad6880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=131312b26465c190
> dashboard link: https://syzkaller.appspot.com/bug?extid=9767be679ef5016b6082
> compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c78ce21b953f/disk-968c2729.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/22868d826804/vmlinux-968c2729.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
>
> =====================================================
> BUG: KMSAN: uninit-value in pagecache_write+0x655/0x720 fs/ext4/verity.c:91
>  pagecache_write+0x655/0x720 fs/ext4/verity.c:91
>  ext4_write_merkle_tree_block+0x84/0xa0 fs/ext4/verity.c:389
>  build_merkle_tree_level+0x972/0x1250 fs/verity/enable.c:121
>  build_merkle_tree fs/verity/enable.c:182 [inline]
>  enable_verity+0xede/0x1920 fs/verity/enable.c:268
>  fsverity_ioctl_enable+0x895/0xab0 fs/verity/enable.c:392
>  __ext4_ioctl fs/ext4/ioctl.c:1572 [inline]
>  ext4_ioctl+0x26dd/0x8c50 fs/ext4/ioctl.c:1606
>  ext4_compat_ioctl+0x702/0x800 fs/ext4/ioctl.c:1682
>  __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
>  __se_compat_sys_ioctl+0x781/0xfa0 fs/ioctl.c:910
>  __ia32_compat_sys_ioctl+0x8f/0xd0 fs/ioctl.c:910
>  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>  __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>  do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
>  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
>  entry_SYSENTER_compat_after_hwframe+0x70/0x82
>
> Local variable fsdata created at:
>  pagecache_write+0x21c/0x720 fs/ext4/verity.c:85
>  ext4_write_merkle_tree_block+0x84/0xa0 fs/ext4/verity.c:389
>
> CPU: 1 PID: 15121 Comm: syz-executor.3 Not tainted 6.0.0-rc5-syzkaller-48543-g968c2729e576 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> =====================================================

This is identical to other reports fixed in
https://lore.kernel.org/lkml/20220915150417.722975-43-glider@google.com/
To fix the error, we need to initialize fsdata explicitly, because
aops->write_begin is not guaranteed to do so:

=============================================================================
   ext4: initialize fsdata in pagecache_write()

    When aops->write_begin() does not initialize fsdata, KMSAN reports
    an error passing the latter to aops->write_end().

    Fix this by unconditionally initializing fsdata.

    Fixes: c93d8f885809 ("ext4: add basic fs-verity support")
    Reported-by: syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
    Signed-off-by: Alexander Potapenko <glider@google.com>

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 3c640bd7ecaeb..30e3b65798b50 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -79,7 +79,7 @@ static int pagecache_write(struct inode *inode,
const void *buf, size_t count,
                size_t n = min_t(size_t, count,
                                 PAGE_SIZE - offset_in_page(pos));
                struct page *page;
-               void *fsdata;
+               void *fsdata = NULL;
                int res;

                res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
=============================================================================
