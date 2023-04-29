Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA966F26A0
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Apr 2023 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjD2VsA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Apr 2023 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2VsA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Apr 2023 17:48:00 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9F010F1
        for <linux-ext4@vger.kernel.org>; Sat, 29 Apr 2023 14:47:59 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-330990e0a50so2551365ab.1
        for <linux-ext4@vger.kernel.org>; Sat, 29 Apr 2023 14:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682804878; x=1685396878;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/kdX89oiu310NLaCEpTfVOYXcR8EFosa+bX55W/l5I=;
        b=FfGBTLIfuSJ7biicGviKvzb10FGs+TMbxlbpa0ApuTasOvB+joyOXpoX9V1BdymVkH
         lLMbHsMmIKk8VU4K9I/AxL9w46bhh3drdp8h3X0KrtNeBLsbjvvqiLDsmpT7yr4GlhWa
         av4E5DHDWilphmtlSBdyzWKoWSqx1VQjMD/z2AIrrpAd7vcoU7viVLcouF7xn6L92BQq
         f4WyZUQ8ENceD76S2o12xjnLrLv9UH3hIMF8RxqxDze6uo5zlSVDnVvewqgGjGXLyhJg
         daW0RSBpirBbPZ7lB3Se+Xm7WsHL4gH+fokqAiEacgbiUj8mJqGo+tjaUngc6B+2ihW6
         hLLw==
X-Gm-Message-State: AC+VfDwaYqgopnC4qRPNNpOcixmyeNxKIhxCcV41+Dwm67Wppi9pXS2B
        LHMDyHFU6KywDvonH3pfBowTDzwIFb9VU5bO+wARZTbf1rCn
X-Google-Smtp-Source: ACHHUZ4o4w1ZxzqbpCz3rHa+86uawcOFYSJj4v2Kx6YKju+GnaeD1BN5RpuwugJtFUc/AiQenJyS2qQHftAGFtN+5vW8rlbEBnLI
MIME-Version: 1.0
X-Received: by 2002:a92:d80c:0:b0:32b:8bf:4d77 with SMTP id
 y12-20020a92d80c000000b0032b08bf4d77mr4995082ilm.1.1682804878447; Sat, 29 Apr
 2023 14:47:58 -0700 (PDT)
Date:   Sat, 29 Apr 2023 14:47:58 -0700
In-Reply-To: <ZE2QhyNzgMo8KFVS@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000019d7e05fa808b1f@google.com>
Subject: Re: [syzbot] WARNING in ext4_dirty_folio
From:   syzbot <syzbot+ecab51a4a5b9f26eeaa1@syzkaller.appspotmail.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        tytso@mit.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> #syz set subsystems: mm

Your commands are accepted, but please keep syzkaller-bugs@googlegroups.com mailing list in CC next time. It serves as a history of what happened with each bug report. Thank you.

>
> On Wed, Jun 08, 2022 at 04:36:20AM -0700, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    cf67838c4422 selftests net: fix bpf build error
>> git tree:       net
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=123c2173f00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=fc5a30a131480a80
>> dashboard link: https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1342d5abf00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ecafebf00000
>
> The root cause of this failure is a fundamental bug / design flaw in
> get_user_pages and related functions, which file system developers
> have been complaining about for literally **years**.  See the recent
> discussion at [1] and going back earlier to 2018[2][3] and 2019[4].
>
> [1] https://lore.kernel.org/all/6b73e692c2929dc4613af711bdf92e2ec1956a66.1682638385.git.lstoakes@gmail.com/
> [2] https://lwn.net/Articles/753027/
> [3] https://lwn.net/Articles/774411/
> [4] https://lwn.net/Articles/784574/
>
> I'm going to reassign this to the mm subsystem, since there's not much
> we can do on the file system end.  The WARNING is considered a good
> thing because users can see silent data corruption/loss if they use
> process_vm_writev() or RDMA to write to memory backed by a file.  And
> while most users at large hyperscale scientific compute farms probably
> won't be paying attention to the system logs, at least we've done
> something to warn them.
>
> Fortunately data corruption is rare (but when it happens it could
> really screw with your results!), but if they are doing some large
> scale simulation to evaluate the safety of nuclear weapons (for
> example), it would be nice if they got at least some hint.
>
> There is a potential solution discussed at [1], but there is push back
> since it could break users by disallowing the thing that might cause
> data corruption.  Why breaking user applications is bad, turning a
> possible silent data corruption to a very visible, hard failure is
> arguably a good thing....
>
> 						- Ted
