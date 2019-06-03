Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDA533AA9
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jun 2019 00:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfFCWEB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 18:04:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:37060 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfFCWEB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jun 2019 18:04:01 -0400
Received: by mail-it1-f199.google.com with SMTP id q20so3531437itq.2
        for <linux-ext4@vger.kernel.org>; Mon, 03 Jun 2019 15:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=J4fvUgW1EwHf5GdkMvLmBkbktAv6wzecd5S4Jz43ikQ=;
        b=F9LkKhQgVhq/bBRQGGuGxL7XxQPYIqiwMa9Y9UQE8gWASkfcX6ZHPahhvyTzVxw8A0
         uGWzg6B6E9ktnUMfrFz54u5HIthgzvvKhsgXyJkhWu1G3LfM2s8zBqtuZcEkTYW4ZEJP
         T83hZpBtZ5UlgOlVJlQx7F3G6053rZGpjLmMaCCWCcKKpflpCPKOm3noX2KZ0hTWQPvy
         mBHqip1jQl0QjnnOGD+2I6MitySYquD42v8yBaXAzFopHP08F7T+FUGeTPNegTrbhCwq
         VVLkzEbRoDxlYKsE53oIQN0e9QuttPsfy/YmL9hGyrXbizxeu5R5ASRMPNjE1C2aOHm0
         J/vA==
X-Gm-Message-State: APjAAAW1/rF20QXgPDIvIP0+FK1KA6ofOFeEKQYpMpKWYt1twV5okbv1
        d67Y7m4KDu34+hNxEf//WlOM2VGxODVKG9JLWfqQ55OgsmEk
X-Google-Smtp-Source: APXvYqy092dyuRmUAcZWsDzruOze1nu2JQlB3MegZ3Kb0WH/yI/h42We3X9lAKWA1LcM4A9vfuDNs1zplvdSKP5p/7RrqdxuebqJ
MIME-Version: 1.0
X-Received: by 2002:a24:3ce:: with SMTP id e197mr19185899ite.143.1559599440698;
 Mon, 03 Jun 2019 15:04:00 -0700 (PDT)
Date:   Mon, 03 Jun 2019 15:04:00 -0700
In-Reply-To: <000000000000fa91e1058a358cd5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7a51a058a728a6c@google.com>
Subject: Re: possible deadlock in __do_page_fault (2)
From:   syzbot <syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, hdanton@sina.com, jmorris@namei.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has bisected this bug to:

commit 69d61f577d147b396be0991b2ac6f65057f7d445
Author: Mimi Zohar <zohar@linux.ibm.com>
Date:   Wed Apr 3 21:47:46 2019 +0000

     ima: verify mprotect change is consistent with mmap policy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16461c5aa00000
start commit:   3c09c195 Add linux-next specific files for 20190531
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15461c5aa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11461c5aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cfb24468280cd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=606e524a3ca9617cf8c0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10572ca6a00000

Reported-by: syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com
Fixes: 69d61f577d14 ("ima: verify mprotect change is consistent with mmap  
policy")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
