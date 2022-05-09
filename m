Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52565202BC
	for <lists+linux-ext4@lfdr.de>; Mon,  9 May 2022 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiEIQpG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 May 2022 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiEIQpF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 May 2022 12:45:05 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE634505E
        for <linux-ext4@vger.kernel.org>; Mon,  9 May 2022 09:41:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id h17-20020a056602155100b0065aa0081429so10280755iow.10
        for <linux-ext4@vger.kernel.org>; Mon, 09 May 2022 09:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UQHR7i6vxvG7W9b1CjIdDI1PA7CC1Fpf3pZBpknVs7w=;
        b=fKfWxprwjzr7vwCXr1+WjM4duYK0KpcAiMvuswHMdgp75aekOvt2kAlC+rnkO4ldpL
         dB87cQXk/jUCZIZEU3cyfezvTOLjCWDL0QBO3z/9+ZLmplshOmSYb9/uwLbxfKbTygCi
         Dd/Ih7Qay/EiztLGy50TH6UqNo80dokkUr58NbNrL/bmx/pggWkOzQQnJBs2UDSokDs/
         w94NuujXdV17jwrU2yD4X/BeWvgdA53nBmG7xxRQ1Pi6TNMJLTGhMaAoV1t5pgtq37XP
         XFKiKHJWAeKBQthEg6uirh5cqqP3NJWQfe8mpR6WJ/Lq22Jv+XEvXZIXM592COsP8a6c
         zPWQ==
X-Gm-Message-State: AOAM5328BJE9Tu3N30HPachVwuB553Hho72Z3WmKFK34FwqgqJDxXJMM
        Pwi81n7Wb3SXSS/8Mvh7l/w/S6gRqBqmkafSGZmExb0IySZP
X-Google-Smtp-Source: ABdhPJwR1r1shYChS7IbA+UkumG788L8TrCk2UoXDoS4lYNAKkbmJqSpjSmeEcYshtQqDLBeGt0kQ+Ug7FglJSsTUI49/CpRqUor
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c2:b0:657:d130:daa with SMTP id
 b2-20020a05660214c200b00657d1300daamr6942690iow.83.1652114469771; Mon, 09 May
 2022 09:41:09 -0700 (PDT)
Date:   Mon, 09 May 2022 09:41:09 -0700
In-Reply-To: <000000000000183d9e05d7f0c0ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000195e9205de96e067@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_ind_remove_space
From:   syzbot <syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tadeusz.struk@linaro.org, tytso@mit.edu
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

syzbot suspects this issue was fixed by commit:

commit 2da376228a2427501feb9d15815a45dbdbdd753e
Author: Tadeusz Struk <tadeusz.struk@linaro.org>
Date:   Thu Mar 31 20:05:15 2022 +0000

    ext4: limit length to bitmap_maxbytes - blocksize in punch_hole

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100ac712f00000
start commit:   09688c0166e7 Linux 5.17-rc8
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc629d1a1ae8d3fe8a5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1205b189700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dda4fe700000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: limit length to bitmap_maxbytes - blocksize in punch_hole

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
