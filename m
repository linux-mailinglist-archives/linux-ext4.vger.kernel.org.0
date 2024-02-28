Return-Path: <linux-ext4+bounces-1420-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAA986BC07
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 00:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA8D1C22D39
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Feb 2024 23:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD2113D308;
	Wed, 28 Feb 2024 23:16:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274F13D2FE
	for <linux-ext4@vger.kernel.org>; Wed, 28 Feb 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162166; cv=none; b=JapR+9+s0rCCKxZAMtzanm3oeJPNn818jCGJDuSHNfWCc6RCoHJc9GonMITq496cMjC1mMTAfuCIPHVL8z3foolatuQMCUQU/P2kfN6zLKXBBTPOKfJdbyNe8F+fSPjOe0D+W1Xjh+fVuXumjbrhfsWhTT+OQ4y7hqk+15IZWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162166; c=relaxed/simple;
	bh=AQUahNxliBRnxzbiLyFJhAv8zSnsPgpBvtR8vmHjVTI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S6rX7OVXVn4sjv37rgDh9nCDaOg2AjXUbpqm2QGjpJMpOLim/56174K7r/17WCW/d4MdF+yiz6fHI3kHM/WGE/X/Q3clBNfpQu7K5fejcugCX2ysBIHDEZC9b1ixw5QwY1IO1Daku5EVI0+XhxJ/Yebh4eA7AR4yPBj/HGi/cI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c784914db2so31470139f.0
        for <linux-ext4@vger.kernel.org>; Wed, 28 Feb 2024 15:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162165; x=1709766965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0RlstvxprlM4gkYbdJ5NUP8ntmVKrjAxjshVbrRXSc=;
        b=MyY7XriXiMsw46IEWP5sSDqBQd/r4bzko6j/v6BMQ8WIkuFcuHhfYgBZsptuvvU5AY
         6mrPO+BO77DagaUBnpohZ/5lsJfgeCNfOW6p90xUWeEAIP8G/TtkJiFmQB25gZp0pgaa
         NEn7hmQr5Vq+mMh8BdHw8Zk5Z2X5U4kQHJrvCE2eXyxYc/znuHtdOvnkpzwmzjY4LSCH
         yWpo1kMvTBEC4/uprsarSORYrYTXumZeJq3vp5sPq2GmlpH0sSWAKOwljNP2DlZWabYV
         3wOmO/e6fuH9E2rVWG1+V19PwBf8FfLzjDaYAp8D6rSi7oq0nnM/SaVHcJT5Vq9LTQIE
         fy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfu536ZCSjvZDQUiHcOTUEPrNQYu40YJdum4KAPm0yRF9hJryzB6GUMjub8hLgZR+bUSUpDEIOU4VAncMgI8sJum7LoE94nYPjLQ==
X-Gm-Message-State: AOJu0Yzy+q5y0FISnV4t0DZzkOZBJDyIctIav3y9QWBxmCEKqPCuMIxF
	sjKwSpSMPgW94jL6wykiZq2jOYCariadGQZKtdTuQW7VSpI313CXTjjM8CJXj11a0HHdiVDpgha
	VJYu9ZD34PLDUqoL7n47wobMj7ELalXnZhSHznXI9Mf8GS4ind/t5eXA=
X-Google-Smtp-Source: AGHT+IFji+gWg2pA+eUmcqqi3S63tv894XUzwmU+L6rl/SIS/OebR1zkMrOwnEALjAYt6aL4+TwLBuzpQRHW46MxBHfiWMdCbk8l
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:365:25a2:18ab with SMTP id
 q11-20020a056e0220eb00b0036525a218abmr36292ilv.3.1709162164779; Wed, 28 Feb
 2024 15:16:04 -0800 (PST)
Date: Wed, 28 Feb 2024 15:16:04 -0800
In-Reply-To: <00000000000095141106008bf0b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2059906127953c9@google.com>
Subject: Re: [syzbot] [ext4?] [reiserfs?] kernel BUG in __phys_addr (2)
From: syzbot <syzbot+daa1128e28d3c3961cb2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, bp@alien8.de, 
	brauner@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.com, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1010d154180000
start commit:   95c8a35f1c01 Merge tag 'mm-hotfixes-stable-2024-01-05-11-3..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=daa1128e28d3c3961cb2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14562761e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1089280ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

