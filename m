Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC37730966
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 22:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjFNUr3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFNUr2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 16:47:28 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A32688
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 13:47:26 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-340bd414eb5so4824525ab.3
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 13:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686775646; x=1689367646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmYyn6KjnwCcEInr35KmY2CR5pAuogsMVf8CnIOKBGw=;
        b=VNp5BzerMpWk8xBhY93rqbxg4FaUkgHOW7lstsdLrLw9FK5/vfXnwsPmAiw4qrlY2Y
         NyfCV3+1ALo+rDJkjz9tYceMatkl9qaBYPC70gMhIk8HkOGu4DyTmimHiyXQIvmYhWnZ
         PngKi8UddrHqTacqYxLhR2I01PPt5e5qxOOFwnK6dOk+6Wl2j+KVbl8cI1X1df/Qownd
         9UxbHO8lYlj4c++7zkVPl1SApAUtOqiLXPnHjY6P5M1n5LACk6TA+IujwObW41LulWgV
         K7YHdKUl65Zi/8A6RUUMH1g8JF0LVRlCz5FaasNL+/LERZGrvMcpwdb8xWlqSDbI9nt6
         0yyA==
X-Gm-Message-State: AC+VfDw8zFSrroZVylNKd2t2sdkZPvKO5iowKJA1+JTEVxD9yOv++ZMe
        yI0EVlWwhmomF9laNjZYP9okagOd2pH80QeYubKzYWyWp5VP
X-Google-Smtp-Source: ACHHUZ5ToLA16XDVvAhNW/25+v4XSEYndMm5DT0kaatIkxpwnMZIf/zfE0p7x9xA3A0Lw+CqVJxIM7cy7H1J0ip7ZWuN4posFSI+
MIME-Version: 1.0
X-Received: by 2002:a92:d24c:0:b0:341:3354:7688 with SMTP id
 v12-20020a92d24c000000b0034133547688mr218650ilg.6.1686775646277; Wed, 14 Jun
 2023 13:47:26 -0700 (PDT)
Date:   Wed, 14 Jun 2023 13:47:26 -0700
In-Reply-To: <0000000000004f067905ea8ab9b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003656ed05fe1d0fa5@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in dquot_commit (2)
From:   syzbot <syzbot+70ff52e51b7e7714db8a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, boqun.feng@gmail.com, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f0f44752f5f61ee4e3bd88ae033fdb888320aafe
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Fri Jan 13 06:59:54 2023 +0000

    rcu: Annotate SRCU's update-side lockdep dependencies

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1355576f280000
start commit:   ab072681eabe Merge tag 'irq_urgent_for_v6.2_rc6' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d5c2ee6c2bd4b8
dashboard link: https://syzkaller.appspot.com/bug?extid=70ff52e51b7e7714db8a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11436221480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15133749480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: rcu: Annotate SRCU's update-side lockdep dependencies

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
