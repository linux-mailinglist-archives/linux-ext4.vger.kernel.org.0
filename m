Return-Path: <linux-ext4+bounces-3803-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773FF958926
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB84282788
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712A18E757;
	Tue, 20 Aug 2024 14:23:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC13D982
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163784; cv=none; b=KqoM5vrQIrSlDZjl+wcfMDkbIn58PGdvzEgA2bF8e6Lak8CcETzrMHdoe5JTVzt2ERWgmiS9WF0wwSYRWN+71PWZchzDVSAbVmxS9ab7iv8FKR6QKshLUe9oVEGIfF6b/F3iDMwGvSWMJVctqTnGjlB+7bKQpIzG+SPZEGjzsU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163784; c=relaxed/simple;
	bh=gLUPsuWdSTXJTb7WUNyOiFbA7COIzIkvwM69A72ng2Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DE9gpqUytExw1h1cY4mG7W0LOr7OkNzI6RPY+gblA64wlbmKrkk9sAotCAB0jTpWYTEzQGt77BB+3h2lCSSjud71k9r1Hsxe3zFIcABvchFQCAhCFWnM3uls8S/un3zbhke307gPrVR8TKC31SJOktkoOaR8875qe1uHn+5/Yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8489097eso518007539f.3
        for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 07:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163782; x=1724768582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYjN5/oAhwhrXBgTjU/FX5dzLOB+Fl9k99kdXwpqfh4=;
        b=CwR7Pv7N6/sBwa/oO+GHDepyP2sqaEmrvejrV0J937Rg4AG+KKpv9nvtXhXGe3RGvQ
         BLlI8ccGc/1yVYM2Qo/RN0Qs4X0zGcVluQXdiHlQ+uCfFwJ9+6Sz48im+NmGrdGxUZSN
         +Hn0tI7YcBAypKjepRKiJBhP9Z5XCw5APIeiP6R2eAz9zHCqy5ao5GGi3ep5JmSDwLPc
         X5I2t8WuQRcs3N0NIgBkRDEpx4gdpCu6qRbSR+MteodhXlZRU6GSv0moU6IOx6KkW/Xr
         LL7Idhv+ncF3e+wGbSHWCs9ZCDbZu79LhVoDisyuArYT+tz1F2ecpvUku0FPp1ISghY5
         kLAg==
X-Forwarded-Encrypted: i=1; AJvYcCXPIrfd28rk7L7fsYJ/HumBcoObJCgm7QQTRSsqCMWZtURIGPZTG5S/TJ14tQPd7kSgHn9cLtKVrUBHkHo03j2/5KIs0XROD4B3UQ==
X-Gm-Message-State: AOJu0YzPHFV80FdzNuvMXgZtTerTZaY7uKfqV9U3gPFGi6UKNjFCQpVL
	Mc4cGk9rQUsRtQ2jpG9vsiHvAxW6qWjadx7jMtiijWagzZCoQeFatqzF5Tk2/fqF1jJoVbeZFOu
	7sf7+Kg4KsSVMkH1z69cnfmTHj/yieX012PTU/V0C0P9nAs7MDGUaftI=
X-Google-Smtp-Source: AGHT+IHu4ZkUAJ3FI1u8kEFYnwHpSsm3j2LHBI8asJ1P5KcIq195yEeFNPZMqP22Swuy1epC1bQwMwsnfLF7cqSDFyQEUIk3UsuO
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:980b:b0:4ce:54dc:fa44 with SMTP id
 8926c6da1cb9f-4ce54dd01eamr146141173.1.1724163782330; Tue, 20 Aug 2024
 07:23:02 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:23:02 -0700
In-Reply-To: <ZsSh4NUWT7MlvlSL@quatroqueijos.cascardo.eti.br>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7d90606201e2917@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_search_dir (2)
From: syzbot <syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com>
To: cascardo@igalia.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com
Tested-by: syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com

Tested on:

commit:         47ac09b9 Linux 6.11-rc4
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10631a91980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=0c2508114d912a54ee79
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163ed3f5980000

Note: testing is done by a robot and is best-effort only.

