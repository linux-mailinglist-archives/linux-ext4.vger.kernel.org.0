Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FFAF7FD0
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2019 20:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKKTZB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Nov 2019 14:25:01 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:35688 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfKKTZB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Nov 2019 14:25:01 -0500
Received: by mail-il1-f197.google.com with SMTP id w69so17845455ilk.2
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2019 11:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r0YjuwzIebyQaRt0NCBTzFXK/e7I0JZCjM3cB55KQAc=;
        b=MylRiScYQV1ATeVvC1AueAB5XlmAkYlKnL4IFH20zx30dN1Bb9blzL4xJXJSHCsvTN
         Uu+oCwjDtuPFg/s5muXSOvzRcq5OrjXVRuuFWLLvvkVvxZXbmNKddqGIZ/xsGJowCZi7
         PTDH7UYvMw2VGNQZqQdWqFo5HreXnLjwm7WUnumF2oixE28HlOYsQxeTjFYon/aAmkOa
         fwOyTAWV2GlzQUrwD841DqiOAvCxmbGQlhGE2OUD+f2r0H3TEw1fPItNy8mQJOFhO/fi
         ydgHYVEXSSdPjCnZQ1iBLk3wmPwmiENETyms+dX9I9Zdm1Ttuse/5cclsJyzGOJm8Z0c
         RItw==
X-Gm-Message-State: APjAAAWyPgSwg3iwV+DQfafNoV7GQG8XwwCDB46z7jrI81BkSorDzpTk
        nqpNrCq+1xiUPvd/hOP9zzTrXr4e3UHw0x9b5IAeVa9jRXFI
X-Google-Smtp-Source: APXvYqwjOAd6qg8boJqVOPEwejNnAYo5toGjgZZRs/LFgnQ/swhjJf1U+XdiNVfdnQaWG3g6Y2/txbvrT0G+luva0XSkxRbbbVSf
MIME-Version: 1.0
X-Received: by 2002:a02:b792:: with SMTP id f18mr2173501jam.32.1573500300671;
 Mon, 11 Nov 2019 11:25:00 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:25:00 -0800
In-Reply-To: <20191111182417.GB5165@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079c18b059717166e@google.com>
Subject: Re: general protection fault in ext4_writepages
From:   syzbot <syzbot+9567fda428fba259deba@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+9567fda428fba259deba@syzkaller.appspotmail.com

Tested on:

commit:         4d06bfb9 ext4: Add error handling for io_end_vec struct al..
git tree:        
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cc209e226c8fbbd
dashboard link: https://syzkaller.appspot.com/bug?extid=9567fda428fba259deba
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
