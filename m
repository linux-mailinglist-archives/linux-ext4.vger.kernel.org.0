Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1092F6F2E69
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 06:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjEAEbS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 May 2023 00:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjEAEbS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 May 2023 00:31:18 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728B8E58
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 21:31:16 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32f23e2018fso148233265ab.0
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 21:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682915475; x=1685507475;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMopvbnl/gI/YDHKMUQoJhnm8zsxWuaap4+5arlbB+g=;
        b=JAMTM28vA8l/ExIuIsD5DXQlIqpMbZ1+n5MMQzFqsF/aysHRQRw7GiiRxW5PUbx028
         bXR0ESMqlTzaxRpj+u2NwEHJFSa/7RxWI3qWtyu8zBFKnAlsMFiFmIavZLuNE53ir699
         /g/cqIUZBrKPV2TPRO2keQHGMvqx0aVadL4mxXIGR/6Bp4DPOdsp3H6H+7AbeYe1YmIM
         3BupySdkFk1pxFsor+lYk3ruLjjm4ee8r5NmQ/hn/OZA+AE+jLvQ5cBQWpK3yKnuaWMb
         8ZwagbwSejgrjdd2cvRt6VPXY/WnlnJm8SwFTYFVe24dGnLPMtva0daVL3MHmsVl6/m5
         6v9A==
X-Gm-Message-State: AC+VfDyMn96uk7YZbViiMjPPIc6t7QwbVIgYY+VtX8UouqNROlYplsoY
        928/c+zFadRek5mNt5xLt75bglZsYhseABRNRVZLYLYOIBFe
X-Google-Smtp-Source: ACHHUZ7Q4rjTeGpf85L1LGOh7wLdCEauIqOMBHRiBNJYJKx9Tuq8Qab9mCWymwv/5AvWALVhHrPjoTTQ0jQIJr2WAoX/JN3/Rsxj
MIME-Version: 1.0
X-Received: by 2002:a02:95e4:0:b0:40f:b984:ca85 with SMTP id
 b91-20020a0295e4000000b0040fb984ca85mr5812640jai.1.1682915475766; Sun, 30 Apr
 2023 21:31:15 -0700 (PDT)
Date:   Sun, 30 Apr 2023 21:31:15 -0700
In-Reply-To: <000000000000de34bd05f3c6fe19@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ec6ce05fa9a4bf7@google.com>
Subject: Re: [syzbot] [xfs?] BUG: unable to handle kernel paging request in clear_user_rep_good
From:   syzbot <syzbot+401145a9a237779feb26@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, clm@fb.com,
        djwong@kernel.org, dsterba@suse.com, hch@infradead.org,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, willy@infradead.org
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

commit d2c95f9d6802cc518d71d9795f4d9da54fb4e24d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Apr 15 20:22:31 2023 +0000

    x86: don't use REP_GOOD or ERMS for user memory clearing

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13636ffc280000
start commit:   ab072681eabe Merge tag 'irq_urgent_for_v6.2_rc6' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=23330449ad10b66f
dashboard link: https://syzkaller.appspot.com/bug?extid=401145a9a237779feb26
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b3ba9e480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: x86: don't use REP_GOOD or ERMS for user memory clearing

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
