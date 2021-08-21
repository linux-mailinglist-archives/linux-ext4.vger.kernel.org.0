Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202E33F38B9
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Aug 2021 06:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhHUEbs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Aug 2021 00:31:48 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40471 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhHUEbr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Aug 2021 00:31:47 -0400
Received: by mail-il1-f199.google.com with SMTP id f13-20020a056e02168d00b002244a6aa233so6590036ila.7
        for <linux-ext4@vger.kernel.org>; Fri, 20 Aug 2021 21:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SF7CJ7/rhuB732OlNTU5mo9NpnEHv8CCUjOPhiyovzs=;
        b=sBJrpCggJi9OLFfQoBnWHOcxJGeAoK5jwI4Xuufcvo4XXPBws9V9lLPDwAIHlKffaf
         BPrWgbqV0sjRqmB95WGPhrBzT7pO6Uu7HLgwn2qNfzwGZBHZbsiL62d4hBAdHCSt5uhr
         VqtqCssUdK6lfLZZavVuV154N7oxdr+NjK7AYTcDNABS7dNXDzlk48eyzAhFtCjsyY8m
         eAv4jGPYKGTm/uiZcczwaINNP9NuDAw4v24Lr1nH40+VDesJwp1z4NHffxlUVZlHxrp7
         w9zP48o3jGLnYHSJOI4KIiNFzMY9FgZ+2q422VJzDqyzUSL1Jaou72DajpRpGOoZIFfr
         aXLQ==
X-Gm-Message-State: AOAM531Fk02NpfFx4oiXBs5rDhydcpsJc9BUjhQNM4+wJZ7vtX2MLn4i
        mZwSD3Unb9QS6tEcZ3SdtMR5J3fDFfdsN0BSH0QSoXUSlKIv
X-Google-Smtp-Source: ABdhPJycMqq/kBL2U5zB47hNjELZkvB5idcY6iW8Hlasb11U5hpKLy4m+yBfr4uFPLYUMUrNouEoNKeSUgoD52HA2d7TvQtxdc9v
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1905:: with SMTP id p5mr20766782jal.25.1629520268905;
 Fri, 20 Aug 2021 21:31:08 -0700 (PDT)
Date:   Fri, 20 Aug 2021 21:31:08 -0700
In-Reply-To: <YSB7AENonC6a0rCH@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8531505ca0a4047@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in ext4_write_inline_data
From:   syzbot <syzbot+1bd003b0dbaa786227e6@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, bvanassche@acm.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1bd003b0dbaa786227e6@syzkaller.appspotmail.com

Tested on:

commit:         9e445093 ext4: fix race writing to an inline_data file..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=7273c75708b55890
dashboard link: https://syzkaller.appspot.com/bug?extid=1bd003b0dbaa786227e6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
