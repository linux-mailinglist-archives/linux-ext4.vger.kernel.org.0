Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF81761E788
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 00:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKFXYi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Nov 2022 18:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiKFXYh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Nov 2022 18:24:37 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B90864E1
        for <linux-ext4@vger.kernel.org>; Sun,  6 Nov 2022 15:24:33 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so5660816otl.3
        for <linux-ext4@vger.kernel.org>; Sun, 06 Nov 2022 15:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/fAx5icLyZy6p+/Pj+sdRlORwJBoVUC3ZLIszdsgAx0=;
        b=b7Ax6YPavujgHopFxQNOY5a+EVle1cCV1+/ypabjnqdwpDwLxSWoA5ciQtdUeUcUWq
         l0GjPAYyK/YRZvehD8viWoSRVScMOc91VC5BWaFmYhGjPdcjevw5Bvhpk97DaauGwj0F
         XH7VZ/9VFdQXI1qBxfUf5MnJ8Jdt5CwjIXhgvzxKlP0WE0Wpa8Un+KWXsPvOrrCxkAvE
         e7ipPP9l/ujF/MI/8CZVgLqapMsyR6abjk0HMEcFPfr2edkdF1n4lbgCtGLR6O20o5tX
         7zXX5ug4kImOVXBmOy8AMyvWKJ6igkeuHUPWulrNZVayuu5F3AwfQNln8VAITo9G55bh
         fSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fAx5icLyZy6p+/Pj+sdRlORwJBoVUC3ZLIszdsgAx0=;
        b=k1NPJlv24aCJnhOD2s4iWYLkaZ7UQ6eiAyOCnmjbbP31aAVpe1WyDChoBXCcP5MdVX
         /IuPP/9rZIPyNgfLN4Tc9okAcsyZpye3g96G571H8byWYhxALag3/ZRfdKiCCaMGgTRe
         Qxe3BF17OxRlmidefMisKDA4YvcyLFiLYawjZ13qbKgyFX1M888EJUECSwJ761TWF7vT
         A3u64kv26DCRUYGNV6pswhlxhXZp+O1LJorkDyJ7GDalYHELWfPUwuoSEx1Go1/1tuj9
         zYFy/9d2CB+Db7lCb4WKlMQjC++YXUZwenFwx6pO/7oBJktnoUtnSFA97DSe7zYvUnWd
         VbAw==
X-Gm-Message-State: ACrzQf1GxAu6FgKxVSl9TYkQQ/qfibFSxBUbYrs55ZddZ7P3op33V6L6
        k2RJ6B/dIU2pZsa/ApQqqsVnnIrLev9rtNObeponPg==
X-Google-Smtp-Source: AMsMyM6e6HN2rwu83SL9cQH/oONLMcyRR/dPSdz9C3gIPSEgsN4OLYApw+H+8IDXERpyQlzFE2ou4+zsr3xgIa6juWE=
X-Received: by 2002:a9d:62d8:0:b0:66c:4f88:78ff with SMTP id
 z24-20020a9d62d8000000b0066c4f8878ffmr18794526otk.269.1667777072697; Sun, 06
 Nov 2022 15:24:32 -0800 (PST)
MIME-Version: 1.0
References: <00000000000082ed3805ea318a4a@google.com> <000000000000ccbdf705ecad3fda@google.com>
In-Reply-To: <000000000000ccbdf705ecad3fda@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 6 Nov 2022 15:24:21 -0800
Message-ID: <CACT4Y+ZSF6DEshmwYy5pKOexADrGXAj0=_2OyGcWXqJTYQgoeQ@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in ext4_mb_use_inode_pa
To:     syzbot <syzbot+4998f18bcd5fc7e40c8b@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 4 Nov 2022 at 16:15, syzbot
<syzbot+4998f18bcd5fc7e40c8b@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 4bb26f2885ac6930984ee451b952c5a6042f2c0e
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Jul 27 15:57:53 2022 +0000
>
>     ext4: avoid crash when inline data creation follows DIO write
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14eb2fb6880000
> start commit:   4fe89d07dcc2 Linux 6.0
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48b99eaecc2b324f
> dashboard link: https://syzkaller.appspot.com/bug?extid=4998f18bcd5fc7e40c8b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bc15c880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d97bc0880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ext4: avoid crash when inline data creation follows DIO write
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Looks reasonable based on subsystem and the patch:

#syz fix: ext4: avoid crash when inline data creation follows DIO write
