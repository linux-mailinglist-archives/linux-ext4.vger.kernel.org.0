Return-Path: <linux-ext4+bounces-3227-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095F692F479
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 05:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9882830BC
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 03:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968251640B;
	Fri, 12 Jul 2024 03:49:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5207DDCD
	for <linux-ext4@vger.kernel.org>; Fri, 12 Jul 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756155; cv=none; b=SF9RmVwUcDBXQ+5B+4smLUWwgoY0bbczl2WBNI2GI8B7rd7cfO0HdIMMy0yGKhAm1UFlKyKKNchwT6WCLom+imM2/c1rnuZ2zjBYZMU/I7tqupRebkn5LGjOJ3qxkC2RnYRDsRxTP0Lp0OSS06M0Us1OspiLwUKbj9D3mnZwI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756155; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jdq7eKNJP/fg4tDWMusNEulkSrGgX+n6aUQvSSEnGDjYRbFmVFXj9AxUukCAKcZtBQIX8ed3lOP/1YSzDQBV0DYkweMzo6w8f4hphVUB38ed1w0VVH/07vWkfTGAdOWy5lEply28JMrvlGT3SEL2mP0DNwjUJ1ZVrkciBzFjzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3835285561fso17809775ab.2
        for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 20:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720756153; x=1721360953;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=GtdCVZiQxu5Sw8LxlGbm7iuxvyvbZPqS0Nga/Z7nCBn/1n+yWBnCbUckqXlzAyKc25
         uTMAnv7TxK6w/qAM2nupoRL25obW18sDMGBBhrqI9kj7LYMsuMZTcpL76GRq6QKmBetV
         gRTwwWX+qwNax71Hvjvq0A3uHMjyZiEMoi6UxNySfa7POz+V6Sw/pRZT8HX41Lg86sAr
         1HuPdvoKbf9eUDNTD+ZV1QNi2PagUKZ3rusx30P9Vkpp4ERgOYJIjaIJhm4MFFsVwKBc
         bUIFO4ChjnFvojogOEFgqJpPE1JskDe7Q1RVNYCKlyEtNeVux2SJAO3gPqsKB1EMyIfS
         d0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Qi2Pj56Ni6ccA4JCwvcTtjXM/JdHT+HfNm4ekdN5K9dCHV9UuVr9QYW6iWmnc7xY+cFkSvesFAz4UtdX4OO8OR8J+5JczGxuxg==
X-Gm-Message-State: AOJu0Yxmq/XjO+3sbXPnI61O5+R4U2nLGAczpN6rs7UT9I9rxnHHOGOu
	2f+NdnL3rnS+VkWxmKvZgTtV81P/5vNXGuLok+vuz44K1lGnwOsx8z0vZC9zj3McfRf+DrQ/oiq
	kM7mVZPtSJEF/WTlkgcNHXrrSqc+oVcp4YJKMl1glqyatMas1kQ+en8I=
X-Google-Smtp-Source: AGHT+IGO1C3eimY+4kIjVYqb90gWSiSxmLVY7QCe5wkotAoBk1JzawhvczBY+BJ5rlCzBB8bpnwnqt4PrdEYmYSUKM6HECZBL4ud
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d581:0:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-38a5b9aec76mr2280375ab.5.1720756153127; Thu, 11 Jul 2024
 20:49:13 -0700 (PDT)
Date: Thu, 11 Jul 2024 20:49:13 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040a981061d04c3bb@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

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

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

