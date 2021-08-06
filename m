Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7023E2859
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbhHFKOb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 06:14:31 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38826 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244760AbhHFKO2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 06:14:28 -0400
Received: by mail-io1-f71.google.com with SMTP id g5-20020a05660203c5b02905867ea91fc6so2189313iov.5
        for <linux-ext4@vger.kernel.org>; Fri, 06 Aug 2021 03:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Vpzob4HJVT0gsbEDKcUpjv1PhL52+wuvbx1JFOPGfCs=;
        b=OOfvpOmR3Db0Cn4rbQcjaIDF/Vt4sNAtJkIiABQkoPTA8HJUbWsoO5dZDD1LBdjRAO
         Rgfz3+rqgpuNwdCv4wjugqNyZEGQ7Wbh2OQUWEICKrS20ksHLr54bcK98d+mQ12vJ7QQ
         rWwdC0Q4X/mLX79d+YPxfMWoZcADSHAf71qKCUdgPGu+v5lMxmz8xX5pnKteXcZaqYCY
         +RWL2pdg14tMzQ/a/B0nwTB2QvhMSotdfglYy9a3zRHqKlxeIUpKKsa7o5A1FFjr6WB4
         NBmfGqnhb1elPSYXO+mUJ/94PPeYZDbJtIHEHVbmTtsNQbAXKyV/EpJe8KVPGtjnPJXU
         I9aQ==
X-Gm-Message-State: AOAM533gpShZ5zTfVA1q0q0kFNa1rpkrKLiTqSb1alTZu6KeBg3IErlE
        tTpw348kq+VIhmcRsjo/4UFzQIt9T9DsKiiJFJ5qBN90AjoW
X-Google-Smtp-Source: ABdhPJz/CcQHmGUqBPzOdHy6NF2avDG0hKnERDW8wGKUkoWXWE+B0Prm+oxsLOoJgM3/iDB73i9Aj45ScvmP+hZZx1t/1iTrvyJe
MIME-Version: 1.0
X-Received: by 2002:a92:c245:: with SMTP id k5mr60444ilo.143.1628244852406;
 Fri, 06 Aug 2021 03:14:12 -0700 (PDT)
Date:   Fri, 06 Aug 2021 03:14:12 -0700
In-Reply-To: <daae3696-aed8-a0b6-9470-d76ab4901b7d@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008fde105c8e14c57@google.com>
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

commit:         902e7f37 Merge tag 'net-5.14-rc5' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=166c8f6532dd88df
dashboard link: https://syzkaller.appspot.com/bug?extid=c9ff4822a62eee994ea3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12680c4e300000

Note: testing is done by a robot and is best-effort only.
