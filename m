Return-Path: <linux-ext4+bounces-6685-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3E0A54491
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 09:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6D518886DA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB7C1FECD1;
	Thu,  6 Mar 2025 08:20:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE91EF0BC
	for <linux-ext4@vger.kernel.org>; Thu,  6 Mar 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249204; cv=none; b=gbkDtFAAYOVb0tWg1BY5hXx4i+YCCiFLpfoxpfoxro8MQujLHLdwEwtTOS7ifckKDKaxeRCtsTigczao/GheK8Fg1KeC+ymmzNsoO8ViqBSernb7LY8Hs51YE8DSNnZIto3nfUoGCLmQmczQaT8DjuRhlDgkg4mpn0gqhbBOW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249204; c=relaxed/simple;
	bh=gHN6Ds/h4YVfEldKcJ19rEHnazmHoy39GSi4zICTIM4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q+LOvxk9Z5bT3gHCT6jMa2azu5l66p6EPzFMPFwngNk39PsQcnrZy/0ko7yeUt3Ly5mZWiQOgGqlHhi6ZAWMEjkiG/O6ij2kBQvM4OiCXZ1dmemA8hqj3txDBNGWmcXyTusoad9oty+qS/ubqSpPxdjCsT2MIp9OWeTwzYS2fS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d3d9be92f5so3494745ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 06 Mar 2025 00:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249202; x=1741854002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0hd4M1D7MlFaULZOul0ePw1a/pBWIY/W9+Rm+LP3lo=;
        b=GflXWjo3sqdadZIwywFhlCpxp3KRrM1fONylyUTjotN0SpXB5SMIrEtFUJ6QNpe1lD
         1wn+K2Z19yZNaiaCR/tqhymuyiIihzWKm7R3EcdwkSWH0M1x4AFT25pHllGDKJxiQVKr
         lZfoolX2b5/sscTOUCaYCLzcTmbxhpT0Ju2rWNjdstNdoCUjcmBd9A0vwEwSZXw1O6Bm
         5s251/g4cIQaEEVFz6yr0kB644VisuhJkAjf2AvyiMs5lyd/jiRtEUoc4sDUGf5gmYdJ
         DGhq270PsiLMcu/++zccak4RoHai62Hs5wnCHM4dDZ8sO0qLwsmqAOH9U2nUtQeD5oSH
         vLlg==
X-Forwarded-Encrypted: i=1; AJvYcCXwl6nYX6buB0YRPnp76Tfuftml6Fyc/l5v3GNPcDVYTX5i/co0pEEMAMYL4CoufId8g0B/Psver9tR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AAhzLm3hX5xhSkzcWNWMI0sj7xVWRgxnCSJNgEZse3IUDmOg
	VDb0EXANq48P2SQ3EQ6DHVV+TeFNI4JwQ+zr4TeJGhCElaKbf++Y6Iu/1Nt1VL8VHlGtl3b40D4
	QWBWwxd1FN/jv9rLbL9C6CAt17E92WzWIHgk6CcbEbFh8aJdGBRBSd8k=
X-Google-Smtp-Source: AGHT+IFenqW4PdQH9l07esEqQ/uhih8b0tkc9NwLzLA/q7gUPf7eB7FiANpwSUE47hb7jqPCIfEI7ghIJ1cLYQmURoUwJgWZN4t3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d349:0:b0:3d3:d156:1dcd with SMTP id
 e9e14a558f8ab-3d436a77b84mr23771455ab.1.1741249201808; Thu, 06 Mar 2025
 00:20:01 -0800 (PST)
Date: Thu, 06 Mar 2025 00:20:01 -0800
In-Reply-To: <67c6cf6f.050a0220.15b4b9.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c95ab1.050a0220.15b4b9.002f.GAE@google.com>
Subject: Re: [syzbot] [net?] [ext4?] BUG: corrupted list in __sk_destruct (2)
From: syzbot <syzbot+2f2bc79f24dae1dc62b6@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, adilger@dilger.ca, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	kuniyu@amazon.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5872331b3d91820e14716632ebb56b1399b34fe1
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Wed Jun 17 19:19:04 2020 +0000

    ext4: fix potential negative array index in do_split()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122e44b7980000
start commit:   7eb172143d55 Linux 6.14-rc5
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112e44b7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=162e44b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=2f2bc79f24dae1dc62b6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126fd5a8580000

Reported-by: syzbot+2f2bc79f24dae1dc62b6@syzkaller.appspotmail.com
Fixes: 5872331b3d91 ("ext4: fix potential negative array index in do_split()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

