Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AFE3A5624
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Jun 2021 05:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhFMDeH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Jun 2021 23:34:07 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:34653 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFMDeG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Jun 2021 23:34:06 -0400
Received: by mail-il1-f199.google.com with SMTP id c11-20020a928e0b0000b02901e829148382so5870887ild.1
        for <linux-ext4@vger.kernel.org>; Sat, 12 Jun 2021 20:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WqYJoqJsyMYgUdC6b62PxEbDszhLAQSkrOXeTsrlnio=;
        b=jGI+q56H3qEK+Btpu68YP4DjApILb1A+/fXbuMKG2SsVLYtY+vr3Cwl0uObN1uINgX
         JDGSQpqLR+g2iCTxZ236ClpQybzFPPtbUJjunZMVb5HAIuPwqFAVMSzguRj/4UfDVAhL
         pIPDSr6fWSFzftSiAvZyFVdEGiiOMgnfY0PHqWMBxcVcDGqPdxrElC7zD8yBkn/Y/geF
         orX3JiDOOMGi7GKjvxnS+0rLAedl6w3xH+2UpqMJMCtq6OVrz+6ZtkjX0Fy3oB6Hv3ja
         2HBmS5iVx/7eUbnRTEjF1pTuyghdgqSUVGQrq5HP8i06KMN6SFtGPdGL7WGz0rJI+A6U
         cL9w==
X-Gm-Message-State: AOAM5333ne44Of+7jGGuAU4PWe/Mhma0tOlSgoLqoqvtVH302bxuHSgN
        dKbIVbUlSwXQgk6NXNZ3vHrXythPhD9i4nPpRdNa/raOcnen
X-Google-Smtp-Source: ABdhPJzDOFEG6Wg4cWREEDblKTALjgnN8DAxe+xCPOjk7jLrBUKsgnxTA8ujHlnxJZ0WJz9qqJIR7tuhzNoFGg5z3L7qAMNvUCGf
MIME-Version: 1.0
X-Received: by 2002:a92:c569:: with SMTP id b9mr8679474ilj.3.1623555126267;
 Sat, 12 Jun 2021 20:32:06 -0700 (PDT)
Date:   Sat, 12 Jun 2021 20:32:06 -0700
In-Reply-To: <0000000000003853da05c39afd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093166f05c49d62ea@google.com>
Subject: Re: [syzbot] kernel BUG in mpage_prepare_extent_to_map
From:   syzbot <syzbot+99043e2052d9c50c81fc@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, duyuyang@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has bisected this issue to:

commit 68e9dc29f8f42c79d2a3755223ed910ce36b4ae2
Author: Yuyang Du <duyuyang@gmail.com>
Date:   Mon May 6 08:19:36 2019 +0000

    locking/lockdep: Check redundant dependency only when CONFIG_LOCKDEP_SMALL

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f2bda8300000
start commit:   ad347abe Merge tag 'trace-v5.13-rc5-2' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11f2bda8300000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f2bda8300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
dashboard link: https://syzkaller.appspot.com/bug?extid=99043e2052d9c50c81fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1204231fd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1324e4d0300000

Reported-by: syzbot+99043e2052d9c50c81fc@syzkaller.appspotmail.com
Fixes: 68e9dc29f8f4 ("locking/lockdep: Check redundant dependency only when CONFIG_LOCKDEP_SMALL")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
