Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A527119E7E2
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Apr 2020 00:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgDDWNF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 Apr 2020 18:13:05 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:46154 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgDDWNE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 4 Apr 2020 18:13:04 -0400
Received: by mail-il1-f199.google.com with SMTP id n18so11060562ilp.13
        for <linux-ext4@vger.kernel.org>; Sat, 04 Apr 2020 15:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bt/1x8EyTmuUIcBDvOOh7SgGrhssirnD/BYB/4tXepA=;
        b=Z43v46tP3i1A4kJbSKAwz8QQI8ofKuegRK210KXCkQJySkh44vma1CwZy35cv/0gzp
         15gX3Gb8cICijY02lXZoLmPATo2aOXxK6fwlWagvx3WD/b1IaVtsgjm3GsZHYvrEh1P5
         DjXmUikLzIX4Zzr5iG5tJHGbkbqUAE4c1RsFsVWOaEVX3hUSbW+qxOC7vF2wCOwVYokw
         OnnQa01LR169wAcAmf+b/PMo/yT4hGaP2xmdp8Ebx98iUatGNLEebTOd2FiiPxS4bCMj
         hL311yB5RuPQRlj7iRdUY2DqKMy5rprKvCjE/dq5u1Uxwfk6w1EInoZGYnjhWYYgNSAv
         rttQ==
X-Gm-Message-State: AGi0PuaeZBhkWBL4/G53TyaKw/u/3NaYdaQ3Ne9rYyNMUh8xCy6OhZLw
        IJbAC4mL67jZgU5m/kJU2JZokcPNuvH5AVXeu/jqkiMzamQe
X-Google-Smtp-Source: APiQypKcRyVBeoiDWCvZb7tswqkam9aNeXGh+t+Ou4uEcCLuNQD/97y44iDElTiQg68XVts3nXfySRjVZo8xHnjk4aisV+oXHT50
MIME-Version: 1.0
X-Received: by 2002:a92:8183:: with SMTP id q3mr14989618ilk.43.1586038384055;
 Sat, 04 Apr 2020 15:13:04 -0700 (PDT)
Date:   Sat, 04 Apr 2020 15:13:04 -0700
In-Reply-To: <20200404183707.GK45598@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b5aea05a27e5637@google.com>
Subject: Re: WARNING in ext4_da_update_reserve_space
From:   syzbot <syzbot+67e4f16db666b1c8253c@syzkaller.appspotmail.com>
To:     a@unstable.cc, adilger.kernel@dilger.ca,
        b.a.t.m.a.n@diktynna.open-mesh.org, benh@kernel.crashing.org,
        davem@davemloft.net, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mareklindner@neomailbox.ch, mpe@ellerman.id.au,
        muriloo@linux.ibm.com, netdev@vger.kernel.org, paulus@samba.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+67e4f16db666b1c8253c@syzkaller.appspotmail.com

Tested on:

commit:         54d3adbc ext4: save all error info in save_error_info() an..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
kernel config:  https://syzkaller.appspot.com/x/.config?x=4527d1e2fb19fd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=67e4f16db666b1c8253c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
