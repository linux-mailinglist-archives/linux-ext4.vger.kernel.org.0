Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED0262D472
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Nov 2022 08:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiKQHzs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Nov 2022 02:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiKQHzq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Nov 2022 02:55:46 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BFD59FF4
        for <linux-ext4@vger.kernel.org>; Wed, 16 Nov 2022 23:55:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a29so1492347lfj.9
        for <linux-ext4@vger.kernel.org>; Wed, 16 Nov 2022 23:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C78aGbjrXr/kztGG2Ey4CvIW/8gpjBglbtD87+pP3/g=;
        b=L5NI37RMQHU/jKY7fsOJm5fHqjyg67DgFAJIRcYsy2MSda+2XZwjnR/S6jp3uBXQPv
         +q/1okHDvOo8hfhxDWwpXs2LQV74UsNV6kukkYiN6wFNK/Dam5ZkQHWxjyzQjdrOXP4P
         SA4KlR/TOvZClvL9soUWzpG0Oa7WlKIo0Qf6pcwQQncv3uAYYbPgXWD1r6s5b7tdCB2H
         tw2QAZJMTRK+v2Z+2J2eFe/WIj46HVc3Osz0Zx3O3FB6wcgXBmbb3yFYa3pE2TMJpU8r
         7LA044q12rqA+mbqslhqWSO7OHQKVGIyufI8wlfiuXSmCBdm5PvWLhxSjcbKOiRI1p2W
         RYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C78aGbjrXr/kztGG2Ey4CvIW/8gpjBglbtD87+pP3/g=;
        b=bVGenSaGbSQ583tgvfv539037tY30Kw7vSSOUkBGeE6mSOvYXiiWYmiiIyxlspM6Do
         6je/TRGij11pDmFsHTsou2wnOoTxxqJgtfsGloPuX2nRMrdse/RzH+jHWCbO2SGoXh43
         SoHhDhbZBRUf7RwmlsPnTZXf7310KdO5YA7uyIyf1DuiKYWlI0y0e8mb8l75I5I+eEsw
         LSIDd3TIhjidqJ0RajzovlqPBKrGykyB2RbzDBwRAIBv6CntFgN8Pxrx+Mbk1Fc5OOVf
         Sd9aXZBWLNBGMGH918iN/NUY1lXgPsvMuIniv+cH8sOfXg/rqNiKWg/ZIq1+gDGeQsAY
         b/Rg==
X-Gm-Message-State: ANoB5plE/VLvFhH5LB69wzT6nvJqeyhE4nCJAOmY74gpqoBkrkLhXaS9
        6noLM2uNDMJmrzIPezMRLe7oV/BF0g0Yr+rrb6dekQ==
X-Google-Smtp-Source: AA0mqf6vacXv8wtce7xA07fSW8Cd8F7eJx9Z6EmNaiflvVQOZGLGZKLwV8fdDEugCSwC09Mx+Wq/QT9RXjrrC9cUlkk=
X-Received: by 2002:ac2:52ad:0:b0:4a2:23b0:b850 with SMTP id
 r13-20020ac252ad000000b004a223b0b850mr466081lfm.60.1668671744208; Wed, 16 Nov
 2022 23:55:44 -0800 (PST)
MIME-Version: 1.0
From:   Jun Nie <jun.nie@linaro.org>
Date:   Thu, 17 Nov 2022 15:55:35 +0800
Message-ID: <CABymUCOsVcpaS+uXqzB7-hm0FZwm2ZXD8J=6m0NKAh8WyrTiwA@mail.gmail.com>
Subject: [BUG REPORT] kernel BUG in ext4_write_inline_data_end
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Lee Jones <joneslee@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

syzbot find a bug[0] in ext4 on android13-5.15-lts as below and it can
be reproduced on mailine v6.1-rc5(094226ad94f4) too The log from
mainline can be found in URL [1]. The bisect test shows below
commit[2] is the first commit that reproduce the bug. With reverting
the commit, there is no bug reproduced[3].

Is reverting the commit 21175ca434c5 a acceptable solution? Any fix
work is in progress?

[0] https://syzkaller.appspot.com/bug?id=5bafe4554067100b70f58a81268aa06ea3f9c345
[1] https://syzkaller.appspot.com/text?tag=CrashLog&x=118359c1880000
[2] 21175ca434c5 ext4: make prefetch_block_bitmaps default
[3] https://groups.google.com/g/syzkaller-android-bugs/c/HKLNVJQICMM/m/YcHNpH_iBAAJ

kernel BUG at fs/ext4/inline.c:227!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
Call Trace:
 <TASK>
 ext4_write_end+0x1af/0x9d0 fs/ext4/inode.c:1307
 ext4_da_write_end+0x92/0xa70 fs/ext4/inode.c:3067
 generic_perform_write+0x3c7/0x5d0 mm/filemap.c:3836
 ext4_buffered_write_iter+0x49b/0x630 fs/ext4/file.c:271
 ext4_file_write_iter+0x456/0x1dc0
 do_iter_readv_writev+0x52a/0x720
 do_iter_write+0x1f4/0x760 fs/read_write.c:855
 vfs_iter_write+0x7c/0xa0 fs/read_write.c:896
 iter_file_splice_write+0x810/0xfd0 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0xfe/0x130 fs/splice.c:934
 splice_direct_to_actor+0x4d4/0xbd0 fs/splice.c:889
 do_splice_direct+0x2a0/0x3f0 fs/splice.c:977
 do_sendfile+0x63b/0xfd0 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64 fs/read_write.c:1303 [inline]
 __x64_sys_sendfile64+0x1ce/0x230 fs/read_write.c:1303
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb

Regards,
Jun
