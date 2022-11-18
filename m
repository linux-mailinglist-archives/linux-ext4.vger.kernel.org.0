Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2562ECD9
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 05:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbiKRE1H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Nov 2022 23:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbiKRE1A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Nov 2022 23:27:00 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8617C02F
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 20:26:59 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b3so6331197lfv.2
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 20:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANMjB79Hor/hX7/LfVpi04nyIKj9faCqLB/7gmJOf1E=;
        b=ZlXMK5P2BDcYxpmLMhrgf4Y8MO0Pql3SbQ+2DFo84VrrkAxtlAx6XpMdtkAClqhO46
         7yTu6vaqE5Ao7Yg420ER+UatcmRycrP3uPJ7mSElX6wESaLTixSVVabyU10p+SbX1OaB
         /yeAzq3uYXTtX1q90pu+bapJD6xbQi6/LhKV+eKNTuzFu8DdsVb2hxoDsUFc90ci17ln
         CKbao+4nUuJw4WqmOGz7EUQ4OsP46D4S10IQwkRFO4cjknKueMSGgMXAVktmCpOX2KhW
         eRQaSYENnTHmyp52BrCJEKG9R3kn49Olaj+x9rP5cC0RCJn8MNt142Ap9fW819uUCw6s
         MZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANMjB79Hor/hX7/LfVpi04nyIKj9faCqLB/7gmJOf1E=;
        b=Tx/Gj1emeLj5vcSIGfJvqibYLZq27ikS5i6agzHFdZQV2eq7QSHzlL+V/byiJmpQJo
         8W70F9LgR8IkUHsuzwP+zA3hZhWnNG434t5s1YMSL/vcirHOp/p0nu3ld3uK3V+TEFAB
         cHCGwMrlq1jT9OlrsLyy4Q+ZNAIYokk7QsVIerbduP/NIWaBSVZQJTg4xXeGz9SGGPda
         3s7u2YXX5jVhXquuXtb7R0Pe26DAsJ98gLHxrGcqtz2Bn4QlhBqfksVfFq3Bm8pzaSqJ
         Te1lEUHXFi3V2nbG52EjVIBCuR1wv93+HYavMQpYPkv3kv0jpwlNHsLZ89yF6flE7kPH
         xWeQ==
X-Gm-Message-State: ANoB5pne7GRpX+79LTNYwLRBHHaLh+Wo6GZ/qQO1Cj7+JscEiXYmdvbU
        XTjPVzaCgeWZXE/tGU1Mp2/VFNwA2lKFHLWxiWJCbw==
X-Google-Smtp-Source: AA0mqf6W91cYEh0Bc43CazWSbPvfoEzQXALtufiM4OrZ3vzgn00HMZpFEts7hzrIUeZQ8bASxtsHGciLNGJX4fPwLmk=
X-Received: by 2002:ac2:4341:0:b0:4b1:215b:167d with SMTP id
 o1-20020ac24341000000b004b1215b167dmr1963634lfl.558.1668745617631; Thu, 17
 Nov 2022 20:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20221118025036.3380705-1-yebin@huaweicloud.com>
In-Reply-To: <20221118025036.3380705-1-yebin@huaweicloud.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Fri, 18 Nov 2022 12:26:49 +0800
Message-ID: <CABymUCN+NSzkunRqFs8LgqjT6vXz-gyyZYn0hQWf8V9kmcO0Hw@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix kernel BUG in 'ext4_write_inline_data_end()'
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ye Bin <yebin@huaweicloud.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=94 10:30=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Ye Bin <yebin10@huawei.com>
>
> Syzbot report follow issue:
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/inline.c:227!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 3629 Comm: syz-executor212 Not tainted 6.1.0-rc5-syzkaller-00=
018-g59d0d52c30d4 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/26/2022
> RIP: 0010:ext4_write_inline_data+0x344/0x3e0 fs/ext4/inline.c:227
> RSP: 0018:ffffc90003b3f368 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8880704e16c0 RCX: 0000000000000000
> RDX: ffff888021763a80 RSI: ffffffff821e31a4 RDI: 0000000000000006
> RBP: 000000000006818e R08: 0000000000000006 R09: 0000000000068199
> R10: 0000000000000079 R11: 0000000000000000 R12: 000000000000000b
> R13: 0000000000068199 R14: ffffc90003b3f408 R15: ffff8880704e1c82
> FS:  000055555723e3c0(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fffe8ac9080 CR3: 0000000079f81000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  ext4_write_inline_data_end+0x2a3/0x12f0 fs/ext4/inline.c:768
>  ext4_write_end+0x242/0xdd0 fs/ext4/inode.c:1313
>  ext4_da_write_end+0x3ed/0xa30 fs/ext4/inode.c:3063
>  generic_perform_write+0x316/0x570 mm/filemap.c:3764
>  ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:285
>  ext4_file_write_iter+0x8bc/0x16e0 fs/ext4/file.c:700
>  call_write_iter include/linux/fs.h:2191 [inline]
>  do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
>  do_iter_write+0x182/0x700 fs/read_write.c:861
>  vfs_iter_write+0x74/0xa0 fs/read_write.c:902
>  iter_file_splice_write+0x745/0xc90 fs/splice.c:686
>  do_splice_from fs/splice.c:764 [inline]
>  direct_splice_actor+0x114/0x180 fs/splice.c:931
>  splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
>  do_splice_direct+0x1ab/0x280 fs/splice.c:974
>  do_sendfile+0xb19/0x1270 fs/read_write.c:1255
>  __do_sys_sendfile64 fs/read_write.c:1323 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1309 [inline]
>  __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> ---[ end trace 0000000000000000 ]---
>
> Above issue may happens as follows:
> ext4_da_write_begin
>   ext4_da_write_inline_data_begin
>     ext4_da_convert_inline_data_to_extent
>       ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
> ext4_da_write_end
>
> ext4_run_li_request
>   ext4_mb_prefetch
>     ext4_read_block_bitmap_nowait
>       ext4_validate_block_bitmap
>         ext4_mark_group_bitmap_corrupted(sb, block_group, EXT4_GROUP_INFO=
_BBITMAP_CORRUPT)
>          percpu_counter_sub(&sbi->s_freeclusters_counter,grp->bb_free);
>           -> sbi->s_freeclusters_counter become zero
> ext4_da_write_begin
>   if (ext4_nonda_switch(inode->i_sb)) -> As freeclusters_counter is zero =
will return true
>     *fsdata =3D (void *)FALL_BACK_TO_NONDELALLOC;
>     ext4_write_begin
> ext4_da_write_end
>   if (write_mode =3D=3D FALL_BACK_TO_NONDELALLOC)
>     ext4_write_end
>       if (inline_data)
>         ext4_write_inline_data_end
>           ext4_write_inline_data
>             BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
>            -> As inode is already convert to extent, so 'pos + len' > inl=
ine_size
>            -> then trigger BUG.
>
> To solve above issue, there's need to judge inode if has EXT4_STATE_MAY_I=
NLINE_DATA
> flag in 'ext4_write_end()'. 'ext4_has_inline_data()' flag only cleared af=
ter do
> write back, EXT4_STATE_MAY_INLINE_DATA flag indicate that inode has inlin=
e data,
> so use this flag in 'ext4_write_end()' is suitable.
>
> Fixes:f19d5870cbf7("ext4: add normal write support for inline data")
> Reported-by: syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com
> Reported-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fca47470c85a..89404d1aa1d5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1309,7 +1309,7 @@ static int ext4_write_end(struct file *file,
>
>         trace_ext4_write_end(inode, pos, len, copied);
>
> -       if (ext4_has_inline_data(inode))
> +       if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
>                 return ext4_write_inline_data_end(inode, pos, len, copied=
, page);
>
>         copied =3D block_write_end(file, mapping, pos, len, copied, page,=
 fsdata);
> --
> 2.31.1
>

Acked-by: Jun Nie <jun.nie@linaro.org>
