Return-Path: <linux-ext4+bounces-9806-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C1B42003
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Sep 2025 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D02F84E4E46
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Sep 2025 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8D8270572;
	Wed,  3 Sep 2025 12:50:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B43009E8
	for <linux-ext4@vger.kernel.org>; Wed,  3 Sep 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903806; cv=none; b=bSEeym5KJ0mLr37td1NGEf92IyZw/SoTRRvVyXmYkqv3ddoP+vbjOXXhPH9ImzUpxwW7rk87GtbDx2mUHVKL1C8hgbPUHvTn5O7Mrd+wToxJ2B0lSouYi3KZXRAJA4AuJ3LxnRss0SF4UKj2nn9nNw3Qk7C282vx6lmrbw3KV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903806; c=relaxed/simple;
	bh=NfVY0uOJ6FEvq7e+k5wZc9jqlPu1CfthQXKZe6VNgpo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i7WwAVVGF12duUb6NroODsSZ44j/GMtm28kjSezGP6/MRylBgkXOgw9gYnUyOW3tSq7lTGNNgRnNBSVNETw9bhfjLh6tjV792wKRUgBmxF+tobmn0T4Hvw8Bo+YNPCY+9PKjSi6zcAe0yjpXM7dtZdcUt8EjpyfgGWAajGU2e/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ed39b8563cso148929895ab.1
        for <linux-ext4@vger.kernel.org>; Wed, 03 Sep 2025 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756903804; x=1757508604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OMejl/iQ+Tg2KDNjGuB3kqcQAoPPMTyVmkgNVu9W0w=;
        b=BZJRBOhKlGtJfyLv5ucuxg4OuvzxHETCR1eSD6kjpLzIICg2DdaIhuRP7pq1JlE5IF
         +/NiWqpqU07DN0pQ9EDPjqFACF6yb1Dczj2Oi6U3YSD9dUDTZftq2lyYDp9zWDjXjOqm
         mf79Tu7eqGYi0KN2PKkJVvgzboYK+O4wk6S8KDnhrNwEdumn3c5FELao+5JhX04/KDTB
         iXqqLyGU0T8qEGLZfN5L4mWSspLULC4WG1TnMdbwAdtHysHSWnmBTzn8lZrKxvDo8jtj
         iulFyb/YzpC5ePOQRZdKwR4jp1Fj37c6F3PIJdeECrouZ+cDqyj8DgxBa4lbabZMixvl
         hBug==
X-Forwarded-Encrypted: i=1; AJvYcCUh1WNUZzXb1SNoVM4x92jeM3BHnKbmGUZzRmYGVh3rSUurKiJIYDzUi7wfWyJO1L3ZBhhkOUhA7jSL@vger.kernel.org
X-Gm-Message-State: AOJu0YysueHA7HWwCGpdOwf264qF7j4quKd9lY74aM2IMWaHIpfSgWYO
	UkEoHVpUAu5wT9qTyiUAeSNULASC32zoFjTa8VUaiDuX11ty3yYXbSiIa6aG5QldfB8Nf+StsYy
	ae9p2QqwDoPBmoGnUvKYun1dVx8ysDtRdJFEfE84Z899aOGPmbxGP28MFqno=
X-Google-Smtp-Source: AGHT+IHW+MQ+QmO3Wx+01fYvf/inCr+6x1CkylQIhXButK9at9rxl8FYGObhhj+RRZG4JC9Ep7A4/v7XHZK7WNVrCTnGaekBZmv1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:3ee:a3ff:96c7 with SMTP id
 e9e14a558f8ab-3f401beb3a4mr256042315ab.17.1756903804188; Wed, 03 Sep 2025
 05:50:04 -0700 (PDT)
Date: Wed, 03 Sep 2025 05:50:04 -0700
In-Reply-To: <682ff0bf.a70a0220.1765ec.0148.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b8397c.050a0220.3db4df.01f1.GAE@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in lock_two_directories (4)
From: syzbot <syzbot+1bfacdf603474cfa86bd@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, adilger.kernel@dilger.ca, bp@alien8.de, 
	brauner@kernel.org, casey@schaufler-ca.com, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jack@suse.cz, linkinjeon@kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, roberto.sassu@huawei.com, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	tytso@mit.edu, viro@zeniv.linux.org.uk, x86@kernel.org, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 99f9a97dce39ad413c39b92c90393bbd6778f3fd
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Tue Mar 18 09:00:49 2025 +0000

    exfat: add cluster chain loop check for dir

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13445e62580000
start commit:   3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd2783a0a99d4ed0
dashboard link: https://syzkaller.appspot.com/bug?extid=1bfacdf603474cfa86bd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134b50f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d7018c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: add cluster chain loop check for dir

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

