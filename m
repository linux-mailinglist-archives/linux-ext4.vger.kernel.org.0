Return-Path: <linux-ext4+bounces-4255-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561B697E04B
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 08:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CAB280F3B
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2543192B7F;
	Sun, 22 Sep 2024 06:35:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23836C
	for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726986905; cv=none; b=Qx/KirO5Jk8S6hXQzknW5r3sAHDNaQqp4jkdDyzc4PwbcUe4trfFYWKvUnVZyDsE7egV9Pzd+jPfJdn1IAKij0Q1U1AOqO7JsF9+wrIbEE72J1UzXmhQ5bMwn71N0qgc+DNjXmLO1zbmguOBRqOTBziHDw9qv/EGV0xTWgN4bSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726986905; c=relaxed/simple;
	bh=b9mtJm9xuGfFLelet8z9ZOGZWBAk0VRniYaNWoh5nmg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oRCD5ocAe3pAylRe+YPDwpa9KWVdp5wDX4ogGyqru3yBTUoE3j8shEIPcN7jwipv5tIf7WUCVaokdYdy2Hu7Af7fIixM4z7mNcXWlKCgQ0vi6TYCrZHYYr/YcQz7Gmm0g5y9RWr/Mqgl6bS7irHQLzqZmTwFX7YuUioVfC8KYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a05311890bso41990025ab.1
        for <linux-ext4@vger.kernel.org>; Sat, 21 Sep 2024 23:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726986902; x=1727591702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXbke1TSf/Lujspb4haKHNfN010h0/F5mBpaEuhZTCY=;
        b=a6PssFN+bNCiorN2/NK7Rbz0hMcP0+0mlflXO2rdm2fMqZt1oyXNxLLCJBtrCxIao4
         ZX8T+9A9tdb9Tzh1poFGKEvOGM9oAP1N3Qvy/rAY343pEVdNyljHyGixMzi19n/c+ad1
         rHPS5GzusTrkTOeE08aUJxcC/F0QSMD57INH9J4hN9ltAKzlARi/uUFkPenYaAqiG3SF
         /nFJJDf5kPlf+TuY182qbWFW02pUGao1dHDOgjGjalQCKxoA9N1n+oA53IK96BTI2pjh
         79E0uV+qCecKW4O0oqsyroVEbSqmow4k+Hxp2fE8ZF/FASiQGGQE1wIhBAcD5270sCH9
         tGBA==
X-Forwarded-Encrypted: i=1; AJvYcCUEUKS3Iksmdetvmu2eYEatZtUGRr4bXruWcOVgxP1A+DmhOrKFyJqTyGyQAaBLNXX4wW15fXpGZnZ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkz8ZyT9OWaMLRmypahHg239RVOPHXcSNYogjxxl8Gsl6fQ4K
	Jocox5ftR/DIfjeIykArLfmx7j6W/3pprskeoNjPzxehy7JmxlMlWV6Y0JtpLA6P61e5CRX/leP
	vmEAGfj+vlhTOfX46PN2Tlx4qRt0b1oxXcKRlDPpVqzJSjrcehZXCD6c=
X-Google-Smtp-Source: AGHT+IEE3fIYF7JYZfwfVso4xkEDFVA5x+Wqk04Kn4vv9c0N+UuSyQFLZJ9sTKVNLvN8mAgc36GMEMb+OyuZRTT0EpC1goCEGxx+
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:3a0:c403:b575 with SMTP id
 e9e14a558f8ab-3a0c8ca4af1mr55887715ab.6.1726986901891; Sat, 21 Sep 2024
 23:35:01 -0700 (PDT)
Date: Sat, 21 Sep 2024 23:35:01 -0700
In-Reply-To: <Zu+vI3EipxSsPOMe@thinkpad.lan>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66efba95.050a0220.3195df.008c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in ext4_xattr_set_entry
From: syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, qianqiang.liu@163.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Tested-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com

Tested on:

commit:         88264981 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c78e07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b5c53071a819d59
dashboard link: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16538e07980000

Note: testing is done by a robot and is best-effort only.

