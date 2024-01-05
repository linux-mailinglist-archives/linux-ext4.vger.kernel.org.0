Return-Path: <linux-ext4+bounces-705-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE60824C06
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 01:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B31F2306C
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 00:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0A3FD4;
	Fri,  5 Jan 2024 00:07:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE03C24
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 00:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3604ae9e876so7627045ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 04 Jan 2024 16:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704413236; x=1705018036;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=MrEEaiz/9e3we8y0fDFI3Z0zjdSNXOxkidS91UOEzPpRzQDVc3hYq31NxXeBsiMTm1
         XDXUcVxcdmKMo9u7LY79bkH0sQE/tJi4urekze92PvY83xXWeRHY/dI6Zmjw/vwyOYKR
         Vl+tlF7zAWFX30igljqNSHcKCcLiVhLQ6Zq+jlr9J3BKIaoL8QQEYLzbJ3s1jy5KWC1D
         bGKivt7ATiQ25qPMe6xBTtwROIlrt04FtnuEgAhOjkOsEe6u6SQHIhUKLzUbLuQsicYu
         /iw4lTh9a6tlXPG7UYXXz9a2THkJSBHTfr5hgUS97Px/ANhFLDUa0GLCzrYkVXok/gIo
         btUQ==
X-Gm-Message-State: AOJu0YxdkV7q6Lk3IpKS0Ig5KpM/0to3vyBQMZwa+L84K8rGO4HPywIv
	nOB/HXeawbzR5qwR58mXt38y+jsQGRcEmBZsfo07FQ8oOXEA
X-Google-Smtp-Source: AGHT+IG8XWLl04pnC8v+zbeKvvM9XWF9CjqAwYsPkD2ltAuLqhA4qsL+OXQEDBWqdmTt2aYEJSMATbN7UElsfDu2UI5kUPCgAS0S
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8f:b0:35f:c723:1f62 with SMTP id
 w15-20020a056e021c8f00b0035fc7231f62mr149481ill.0.1704413236853; Thu, 04 Jan
 2024 16:07:16 -0800 (PST)
Date: Thu, 04 Jan 2024 16:07:16 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000888720060e27a1cc@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

