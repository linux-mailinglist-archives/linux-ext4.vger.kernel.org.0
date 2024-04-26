Return-Path: <linux-ext4+bounces-2190-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871098B2DDC
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Apr 2024 02:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A652839A6
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Apr 2024 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFAD620;
	Fri, 26 Apr 2024 00:13:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DF1869
	for <linux-ext4@vger.kernel.org>; Fri, 26 Apr 2024 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090394; cv=none; b=KNjC0wQK7Uiaj5KyDgSuFgmpzi6fwQLhFUS664eF1LbzVPA4H6c+1wdxXqJI7RixJKNqlBADQu8yeq60y6JRKu1gbMOXAvBnrnhf+kF3CBOtxRjCsKzWhzmgZobg+Lm9JEmgmMxM0zxO98AZs+jQED6NFV+UZ3NTedbq5BMhDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090394; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YelYIqsjOLytsmQ0PTlUvGxygEm2/o6lV660ooLJWjoI1NlDEIotYGjXIHdhx/2FJj5TaRLssKK87PuFRITIxr45dIpCxoyz3cTvL7Fz3DBBb7i+6Bp7imekK9i73l8jlA9OmdJnmlLM7qw9fod6h1/a+0BokXXbrOiI5W+203c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da4360bbacso193186739f.2
        for <linux-ext4@vger.kernel.org>; Thu, 25 Apr 2024 17:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714090392; x=1714695192;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=PDJa11ne4yA6pTJov9LSOs86MLHnxyGc7c9AOaSO9J7JY8lHQDPtHT26yjbSk6zzXQ
         husceZzTGTdKdsm3wDOarErJo8Sc/PgFUF+ja0Vg3NnaHvWbAEqkOsDi3DepoY6dw8qf
         NtW0CTieyk2j9FkRHjvitUcexly4ZL7LahDZ7ytDzOuF8Sr7iHvzoUJbtZMWev2neMGv
         YO9WDh1s2wKTnTyRzQ9v0TH/simsbmy09oTnZxdOYwHU+ITC+qSzD1fdIoffAj70YhnN
         ogITpmSIeo6HktzZKuf45vSX21wjaFGkcuGqoBbBoT66/1U6oVBzDDPqhlmHg11uU1q+
         tJLA==
X-Forwarded-Encrypted: i=1; AJvYcCWyF7gc4/5G//oIttcZPNPvShP+71LF/jVmDvF9+7j3qC64RPyEOM8pstZUVNsYPuUVrXxzcv1l8q80tV3nCr+Z8KMMZXkJ9gg97Q==
X-Gm-Message-State: AOJu0Yzj10xUg+MW1zRz1wLEalOo8uWjnganq3SIV1yLkvvmxYAhCJXB
	6KV7abLouQZwP+Q4aNljBXtNoyMbVt9ffHDRXvMRcbg7xxMLCLCJ7vZbwQBwk/dqrUQ7U8T3koY
	HBEanzVIlslZe9cGXAur51/y/4Ku/QMWU8qE7YDf46QU1BeI4nGvNDKA=
X-Google-Smtp-Source: AGHT+IFBQ6KqJ9MNkuWzmeJmcldi6/iLn3+SLDTRALCbfTiQw3sNCK/oxmXwAQU4/o+70OeMPCwCoi+4DthNibPndYXd/wtGmW/5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:870c:b0:487:666:652e with SMTP id
 iw12-20020a056638870c00b004870666652emr77404jab.4.1714090391978; Thu, 25 Apr
 2024 17:13:11 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:13:11 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed56a80616f4c41e@google.com>
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

