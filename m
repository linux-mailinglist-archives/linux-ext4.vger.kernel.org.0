Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3893E173F
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbhHEOqj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 10:46:39 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:41809 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbhHEOqY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 10:46:24 -0400
Received: by mail-il1-f199.google.com with SMTP id m18-20020a924b120000b02901ee102ac952so2871967ilg.8
        for <linux-ext4@vger.kernel.org>; Thu, 05 Aug 2021 07:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M+CG0V/JI/8dSO9GWQyntpikCmP0PrauSUlgadFbtcw=;
        b=fOnxglSbecPFrR/nGiiKGCDPt0TkgR1+rc/Z4eGyPmu0ku4JkCae/F5eVJAH9zlnzS
         UtHWNrgr0iiU856Q1NoT7IjmfamF4CQ2bnlVYQl7oindDYG2diSGwErJXLewRhdjd6qR
         ItaltK68FBA0VSRHGBkUtu6S6+hvLVKq7midhF350VM9aM7myEmu1UEkDFLLuvJVbzO5
         HrxWDKhHFwgLI1zhYagYIZKrcwP/TawEvpI8iBe0AtWuwMzFPV0FvCzKkKMRAzWZjDeS
         4od+He7xagDkN/Y8+hFZpeSzvXDvQgyUpzoBxJLwsGkKI6bL56cnh8hDV3KFa0fgVNWL
         yNuQ==
X-Gm-Message-State: AOAM531sEbWmzDLQ9GOGQVu4fP6/gr6KHUxXsCRdyAM12u5KiIYGPkCy
        /XyPUwVpUhu58zNQorXJXKcLx3O3FAGOPQf8V9JVQGWnH7Z/
X-Google-Smtp-Source: ABdhPJz8IPp08WqV02D4H6gE7y7ffaPfZAftqTCnXJyRCYESE0r6TvHsonBfJMMGgx494836Yn3kg6UdOlg+p4zGbRss3T1Hh4o+
MIME-Version: 1.0
X-Received: by 2002:a02:8807:: with SMTP id r7mr197145jai.35.1628174768557;
 Thu, 05 Aug 2021 07:46:08 -0700 (PDT)
Date:   Thu, 05 Aug 2021 07:46:08 -0700
In-Reply-To: <1e291320-3ad3-aa21-77c6-c71da9d32fdb@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6692805c8d0fae6@google.com>
Subject: Re: [syzbot] INFO: task hung in ext4_fill_super
From:   syzbot <syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com

Tested on:

commit:         251a1524 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=166c8f6532dd88df
dashboard link: https://syzkaller.appspot.com/bug?extid=c9ff4822a62eee994ea3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160a3301300000

Note: testing is done by a robot and is best-effort only.
