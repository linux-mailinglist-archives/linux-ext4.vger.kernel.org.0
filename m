Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D63E11F546
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Dec 2019 02:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfLOB1D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Dec 2019 20:27:03 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:35505 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfLOB1C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Dec 2019 20:27:02 -0500
Received: by mail-il1-f199.google.com with SMTP id t15so3213439ilh.2
        for <linux-ext4@vger.kernel.org>; Sat, 14 Dec 2019 17:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=c+s69FUrevmh/qMLgOyZw9GWvtN3ytNCAie8XX1Wio0=;
        b=uc9pWyznF9yQh0b1Ei+35QfsyJ6QMGwHLnv+XZQ+E3+FsFBNaEiYNhFS2Xo6qLhLHp
         mztXopA9zqRpxg7JkySYEW9o1gDo3N0mSiUDjo9WJWU/sgD4KQvlDTLCEwRQ7jVj+pJe
         0m/y+d3znKTVXHNthOuOiiDqpSeUUm/y+3F/aQ5aUASqHHerKGlJzCraXCPVBP2J+nny
         e9kGHe8oxYlnr5nQoJiiIkL1Wz51yefKay6v5C6HM3ESkoXABzto/UoJFmcXdlHUqe21
         kdLhJPhf8MXMS82+RSQXsl8YA5TvgFl6up+dcE/ABeY2hNgt5M56qgoi+Mc/kCLhgZ4g
         m9cg==
X-Gm-Message-State: APjAAAW9MdwqBRB6nCbQlCcKibxZLnqusOAsJzfvj+znK1YJ0NF27AI4
        UG5x6LDlr8zmv+0S6T7U0wRnzLQerGQcOLOSrS6RrP3zotAg
X-Google-Smtp-Source: APXvYqy7O21f8gr/KcYVDGHHA00H9AO2+CAAcrvPyJbJkQR9bGCOqaPnuFyWq42GKUJVdxRtIb/Aqis0HVOF9COqLeCaOOMD3jTv
MIME-Version: 1.0
X-Received: by 2002:a92:5a56:: with SMTP id o83mr2853063ilb.97.1576373220852;
 Sat, 14 Dec 2019 17:27:00 -0800 (PST)
Date:   Sat, 14 Dec 2019 17:27:00 -0800
In-Reply-To: <000000000000c71dcf0579b0553f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcc9b10599b3fd5e@google.com>
Subject: Re: KASAN: use-after-free Read in ext4_xattr_set_entry (2)
From:   syzbot <syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com>
To:     a@unstable.cc, adilger.kernel@dilger.ca, afd@ti.com,
        b.a.t.m.a.n@lists.open-mesh.org, chris@lapa.com.au,
        davem@davemloft.net, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has bisected this bug to:

commit 8835cae5f2abd7f7a3143afe357f416aff5517a4
Author: Chris Lapa <chris@lapa.com.au>
Date:   Wed Jan 11 01:44:47 2017 +0000

     power: supply: bq27xxx: adds specific support for bq27520-g4 revision.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16661f41e00000
start commit:   ae4b064e Merge tag 'afs-fixes-20191211' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15661f41e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11661f41e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=4a39a025912b265cacef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ec1332e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163455dee00000

Reported-by: syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com
Fixes: 8835cae5f2ab ("power: supply: bq27xxx: adds specific support for  
bq27520-g4 revision.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
