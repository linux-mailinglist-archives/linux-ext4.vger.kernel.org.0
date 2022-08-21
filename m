Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D9259B664
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Aug 2022 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiHUU7S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Aug 2022 16:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiHUU7R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Aug 2022 16:59:17 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA6312D0F
        for <linux-ext4@vger.kernel.org>; Sun, 21 Aug 2022 13:59:16 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o5-20020a056e02102500b002ddcc65029cso7099830ilj.8
        for <linux-ext4@vger.kernel.org>; Sun, 21 Aug 2022 13:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=iV6gcKM1GJJSWkpDC+Iv2PckRjW/iBIbJSlzEPuB9vg=;
        b=aPU179021GM76t+LeSwZ0stZgx1IUkBp2kCg/Zcqm7tDKherAb9sAdXGkmsaOqW2ZS
         +tkGj6cHCasCjIgr7gT+VeTv+5SdwSi2Q02uRxPY/SiCG5TlmgXSkBN/C7dVQyIa/aEA
         hirNhvfGftY/tIJ9zTY9TU5JqGAfrRBSIR8hSbV+bmQysQ0zKweRssFU4WYPcR/Eb20E
         kh3ReP3Jt7tEmQiMK2JPkZHMoOYcG8x5vLGdph1d5OuaddJt+VxYtbyrOuNDUHm8sNsA
         5OJC10tlf1YgTA20aT00Wxn6ZqJDKWaKORpWtVdmkZ0xUjUhpBHKCOhvtrnxr1zAWK4B
         lpow==
X-Gm-Message-State: ACgBeo2++P81RVaK6JH31W8jp3x5QvaBS3FYio6LpesPRWLb6zWUvvui
        H19ClxYDa6UAi/UxT25PGz/78Iy5JfUcrYL1uwfBdeoIMP8U
X-Google-Smtp-Source: AA6agR7l7mj/dIeDXCF3s+KvdeZo7E4WFlUBD1ZSnhSSVaC4zdn5pb++CpLMUyYPWXSln22thqPqX8FUtzhtArZ5Y6pEJDmpXKHq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:2e9:763c:485b with SMTP id
 t10-20020a056e02160a00b002e9763c485bmr3272522ilu.173.1661115556242; Sun, 21
 Aug 2022 13:59:16 -0700 (PDT)
Date:   Sun, 21 Aug 2022 13:59:16 -0700
In-Reply-To: <20220821114816.24193-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a92b9305e6c69a3f@google.com>
Subject: Re: [syzbot] WARNING in iomap_iter
From:   syzbot <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>
To:     code@siddh.me, david@fromorbit.com, djwong@kernel.org,
        fgheet255t@gmail.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com

Tested on:

commit:         e3f259d3 Merge tag 'i2c-for-6.0-rc2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16085295080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3babfbf8c1ad1951
dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c53aa5080000

Note: testing is done by a robot and is best-effort only.
