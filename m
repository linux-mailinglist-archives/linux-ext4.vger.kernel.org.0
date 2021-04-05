Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC4354520
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Apr 2021 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbhDEQ0e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Apr 2021 12:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhDEQ0d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Apr 2021 12:26:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAD2C061756;
        Mon,  5 Apr 2021 09:26:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r12so17592819ejr.5;
        Mon, 05 Apr 2021 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWKKEI2qQ3wWViynrZwoc6kXk4GmytWirE64OO9AN6s=;
        b=Z6cdZJdrRW/IIfH2D5fu9L/pLTaaBtFziLK0chls4Xlr5ixzsWgpxy+w7I0YkWV35Z
         KpWnn+B1oiKisJafZTl+Dn01DnS4gNyvVjWtpooTblCAGaLWZk3QS9wcx5NsWwG4vO7o
         3gXviq++yqTQB/70kej+QTy6Z1JLBwD8Iqby6cK5RsODndn7yAAXwhM77lJU2nX5NXTo
         qqBYGEARXYyfPQ7Nop5QEFdunQYiEVARSNw+Jni2ZsE0ysnsU5JyS9nMt0uyqTvax6Hm
         Gj93cz5iqe0U0vTOEyMpXL6uc4UTiUwqKU4+hJjJdILCQxL4cCPocDw4r8JJuMWAA+WZ
         frow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWKKEI2qQ3wWViynrZwoc6kXk4GmytWirE64OO9AN6s=;
        b=mWoTFxG0v+C8Qp3wWOOlaUQiEIKqNmNRJsdpufuIZ+s2GyNjzcST3PUn6d40NzXvHm
         rogKaH1IGJTtbfM89wuEFkPgMPvgev5/zvEpTpINZqSZ3hgI5/1nhZoOjKEUcg3xg19N
         1CU3nhPr/UWjPZlJXfpokPZfAwBXEuh8onu4rp9YYgdLV/AfGpTH1Mx+d/PM3JNTKG30
         fVojjkCkWDWvLGBgqXMKhrutIbOpNA3jR9eWDyIVK3zRmzNz3+vbA2T1ukdGEAAsROD2
         C3F4wyxBWEyposCY45RykAAz/V0Zf1sBIApu+kISsSxhnL7u/UbGPj4J/qNKBWsC1nui
         cRtg==
X-Gm-Message-State: AOAM533Fe3x+a/WpWf2MArKyoI2HPn8E/BwZ/BTfWBbuE05k37dkKVMP
        QZA5gD5cQFcXWMpC3bfVbIJnIKno59hBA6yQ6JU=
X-Google-Smtp-Source: ABdhPJxcUFtD2fbD/JFbIVumO6iXekulLLSGz+KeBiKC+k2tXAbRlPUBQb2S1vWoHSjh5ZClmkfFeSvUVsnKjSZ1Iac=
X-Received: by 2002:a17:906:1706:: with SMTP id c6mr29873290eje.223.1617639986080;
 Mon, 05 Apr 2021 09:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsb+FMh-ftyzfM0ntHWXuvg4SPM6U2h+dQB9bokkavi8GQ@mail.gmail.com>
In-Reply-To: <CACkBjsb+FMh-ftyzfM0ntHWXuvg4SPM6U2h+dQB9bokkavi8GQ@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 5 Apr 2021 09:26:14 -0700
Message-ID: <CAD+ocbzK=L1tBkc=uGk2Wigo=QaxBxGMLJHXgUgMz_T14g7dfA@mail.gmail.com>
Subject: Re: KCSAN: data-race in ext4_fc_commit / ext4_fc_commit
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the report Hao! I think following lines in fast_commit.c
are the culprit:

        if (likely(sbi->s_fc_avg_commit_time))
                sbi->s_fc_avg_commit_time = (commit_time +
                                sbi->s_fc_avg_commit_time * 3) / 4;
        else
                sbi->s_fc_avg_commit_time = commit_time;

This should have been done after taking sbi level lock, but this is
happening after releasing the lock.

I'll send a patch to fix this, thanks again!

- Harshad

On Sun, Apr 4, 2021 at 2:52 AM Hao Sun <sunhao.th@gmail.com> wrote:
>
> Hi:
>
> When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
> the Linux kernel, I found a data-race vulnerability in ext4_fc_commit
> / ext4_fc_commit, which looks strange.
> Sorry, data-race is usually difficult to reproduce. I cannot provide
> you with a reproducing program.
> I hope that the call stack information in the crash log can help you
> locate the problem.
> Kernel config and full log can be found in the attachment.
>
> Here is the detailed information:
> commit:   3b9cdafb5358eb9f3790de2f728f765fef100731
> version:   linux 5.11
> git tree:    upstream
> report:
> ==================================================================
> BUG: KCSAN: data-race in ext4_fc_commit / ext4_fc_commit
> write to 0xffff88800dd89f10 of 8 bytes by task 12063 on cpu 0:
>  ext4_fc_commit+0x1e6/0x1850 linux/fs/ext4/fast_commit.c:1205
>  ext4_fsync_journal linux/fs/ext4/fsync.c:115 [inline]
>  ext4_sync_file+0x38c/0x6d0 linux/fs/ext4/fsync.c:174
>  vfs_fsync_range linux/fs/sync.c:200 [inline]
>  vfs_fsync linux/fs/sync.c:214 [inline]
>  do_fsync linux/fs/sync.c:224 [inline]
>  __do_sys_fdatasync linux/fs/sync.c:237 [inline]
>  __se_sys_fdatasync linux/fs/sync.c:235 [inline]
>  __x64_sys_fdatasync+0x7a/0xd0 linux/fs/sync.c:235
>  do_syscall_64+0x39/0x80 linux/arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
