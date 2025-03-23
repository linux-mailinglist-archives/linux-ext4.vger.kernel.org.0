Return-Path: <linux-ext4+bounces-6950-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D072A6CE1D
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Mar 2025 07:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDED2189B435
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Mar 2025 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA565201266;
	Sun, 23 Mar 2025 06:53:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213641FECA3
	for <linux-ext4@vger.kernel.org>; Sun, 23 Mar 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742712785; cv=none; b=ivU7qEqwPHU3l6hOjWcmO+cMeEd/xvqDp7olxOQy+OgQD2gPK7G4CBGUxNqnH0hHhjsQEBQXpPHn16/wTAO+jiwkHY1UfODtezy9BlWkVq2XPWMwnYJ+SJCrxi1hJSG0nPYrnv7tZYh+tNvVBEehWfSYL5e1jNnyQDPmLTMsf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742712785; c=relaxed/simple;
	bh=Bf7yka2w1VVpUuX6J7h+vWCKWalB2ArNcjPpVEqVGZc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eKiW2cSTnmxxjZ+Q+E/HmFl0MyEYx4NhdB96XA44Y25mHNXFXbTKevoG4r+39fHdA7eiPA6IpEMMdyWJ7u9orEKf6UyyFqaWu30ekh5Y4qrxp7qmDwxdU76U4R5epbbX9AVJOw3PQOfYpgcee7jbL6cQon2qzOTP2Ky5PwnzW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b5a7981ccso263852739f.2
        for <linux-ext4@vger.kernel.org>; Sat, 22 Mar 2025 23:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742712783; x=1743317583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuTtDdQllfqVQdTnY1GFjo08/XepPL02PHTKNSl5Nyk=;
        b=iAsf07EY+Y+X8JKxsRt6EB+ghJkGEq+HIwnoDzOO/6mLCTvwPzBPJ0xT4QmFz9zXZ6
         HNWcukCvybYoybb+8vzR6f67oUjk71tBVFXRWCY02WmoNYYvrJokB6+ieWVusUf+G9V7
         bn/bbXjLW9ZpCjLF3kWf+mzSZaZ0NZFYb5LXCmHD+vHByws3gwYNEqIU3S+ilcXnglZu
         AddUxx/bZQtnPwMgPrvzIVL1dh0mIHVVMVSTCGC4rKfn+6KsPV/b+EpmuNoSvZZQG6jh
         ZWxk7EUxyiPm8Q3fuw9tTPiW4rg05H4/o3jwwU52yXZX4Any8SgtbeNqfHTeInWhNLPY
         hgwg==
X-Forwarded-Encrypted: i=1; AJvYcCUy5OKU+VBuLzm6ij6N6Q3+l04CTlzDSHQHK25ZOaeJCI7XHXl9AxWoMdxEh5zqKym7IC1JH3Gufjoz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3RdF9U9WBBtV6TddauA/pyzBik/tb7TofrPH2BccxxFYF5ha
	IjjM2P6YaXmbkMrvjeyO0/Cnk73TbzX3XBbcUxLcD9O1YJ0/BzUgsBhL1y7czOmY6W85+7x9XvF
	iRRPL/foRZXf1g48iV9HPV6c4Wk0iqTbN3JOW6+7TYqlzMI8gjWXV4Yo=
X-Google-Smtp-Source: AGHT+IFomXej1RrN6WELV4Qii9/yxfjxlWnmlmMb+ysYA1j31F3Z04e+3d3vMyCUXzjVvvz9y1wv7XB/R6rxL+wT2R6HvXmksUMF
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378c:b0:3d3:cdb0:a227 with SMTP id
 e9e14a558f8ab-3d5960f4d68mr77368565ab.9.1742712783188; Sat, 22 Mar 2025
 23:53:03 -0700 (PDT)
Date: Sat, 22 Mar 2025 23:53:03 -0700
In-Reply-To: <6707499c.050a0220.1139e6.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dfafcf.050a0220.31a16b.0058.GAE@google.com>
Subject: Re: [syzbot] [net] INFO: rcu detected stall in sys_getdents64
From: syzbot <syzbot+17bc8c5157022e18da8b@syzkaller.appspotmail.com>
To: apparmor-owner@lists.ubuntu.com, apparmor@lists.ubuntu.com, 
	edumazet@google.com, jmorris@namei.org, john.johansen@canonical.com, 
	john@apparmor.net, kuba@kernel.org, kuniyu@amazon.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, penguin-kernel@i-love.sakura.ne.jp, razor@blackwall.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e759e1e4a4bd2926d082afe56046a90224433a31
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Jan 29 14:27:26 2025 +0000

    net: revert RTNL changes in unregister_netdevice_many_notify()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1084f004580000
start commit:   fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba92623fdea824c9
dashboard link: https://syzkaller.appspot.com/bug?extid=17bc8c5157022e18da8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135f7d27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1483b380580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: revert RTNL changes in unregister_netdevice_many_notify()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

