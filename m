Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629933F38C2
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Aug 2021 06:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhHUExu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Aug 2021 00:53:50 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34753 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhHUExu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Aug 2021 00:53:50 -0400
Received: by mail-io1-f71.google.com with SMTP id a9-20020a5ec309000000b005baa3f77016so4079738iok.1
        for <linux-ext4@vger.kernel.org>; Fri, 20 Aug 2021 21:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5FRAuZPUiU0xKn4RWrot8z/nYnETAm9Goj44lyXceb0=;
        b=JWLDgPZ+4c1HQ/1ABQfXpvr5lFwakzR5V5r2Tb6bzy84b07bRzBAea2ZNFwMymla99
         X+ssdyx3F9pdSrhQ+2A5Fg31UXMtRqN1mdRTCcUhf75hGR/j0BBpMMX7tJS4UB9/ak8U
         gTzQ+uwqGbRy9jlUZKqmkzykEh/6hyKekJRYonsQ+wq0GmDny89r0BhmV7jrXbRQV2rJ
         HTyZ2aijLy0Fk6y8sdTjB1R5RptrAw04MO+CP+hQEQJR8zTYLAte86GjVNmldwcexXng
         X9GQ0AN51Fn3f0gpkpT3qooW63Zj1P1FJYZjfdt1BgvL6P9Mt9IF0kFcTtriQYoeVXGJ
         dZkw==
X-Gm-Message-State: AOAM533G9Oaa+s9FXe43hk9Zd1r9uK9N/BH/No1n0WScjwp+MWnDJo70
        /cqpBeITBj9tpkPT9fx7CakgM6ivZwWc6vtSblO86TmKXOX/
X-Google-Smtp-Source: ABdhPJw6ZnuG/vzpJFEfkG6KnqS/hPSfKcIbJMZgAjuksqm6JM8G8NUo0yq5mmnikNMq0w37gVacq00iq7qfpxM/+EPQV1nGC8P8
MIME-Version: 1.0
X-Received: by 2002:a92:cf07:: with SMTP id c7mr15916909ilo.291.1629521591381;
 Fri, 20 Aug 2021 21:53:11 -0700 (PDT)
Date:   Fri, 20 Aug 2021 21:53:11 -0700
In-Reply-To: <YSB79Lt77EpxHTnl@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bb2f105ca0a8f57@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in ext4_write_inline_data_end
From:   syzbot <syzbot+13146364637c7363a7de@syzkaller.appspotmail.com>
To:     linux-ext4@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+13146364637c7363a7de@syzkaller.appspotmail.com

Tested on:

commit:         9e445093 ext4: fix race writing to an inline_data file..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=300aea483211c875
dashboard link: https://syzkaller.appspot.com/bug?extid=13146364637c7363a7de
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
