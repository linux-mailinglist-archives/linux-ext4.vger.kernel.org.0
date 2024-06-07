Return-Path: <linux-ext4+bounces-2805-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C88FF894
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2024 02:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C221C22D6A
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2024 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D50B19D883;
	Fri,  7 Jun 2024 00:15:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96723DE
	for <linux-ext4@vger.kernel.org>; Fri,  7 Jun 2024 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717719323; cv=none; b=jNB51L9R7pvQAZMPI8hmbEIQf4CyN42A+xzW4HAw21gEINdGrjfAxIpVyrC3rVwnVpK1eBbXUw3ktCIGrFZNDvKmRaoC5z6zcAcEBbBKVMSksX9moQwD0J+9srYNGjTTRrRPzk/g41i521GO8zo+/tHWu5/BB3YzxErxJTUMAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717719323; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nq0bU6F4uck78tuPVJlI/nwyDUhGbC43pjc4yGKgdlEMK2XbVf4go8wcqLE7qWCY/2CWtUvqRirrplSH+hc8r6GZpSZRGJpjT7ecQYjVPRfDVTr/5K5po2AcPCiF/p1+iTMaXcyrScnIP06xGsHfDmImQfc/GbiFGzx6V3rCM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb4e561314so141825339f.1
        for <linux-ext4@vger.kernel.org>; Thu, 06 Jun 2024 17:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717719320; x=1718324120;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=LObElWFuZXojiMVpB6UfeFnTU8EDhrXy6EZJ39XFfai/9lvStGvzhA8MlIo+nPlbBc
         j2mHCZORthpofEomn6Rva7QBTZuypA6hgTgjH2sQkf75cy7dE3lu58AgkA8VA0diXVTw
         oxHE0N+1LntQSxeiyg5c8l79nAijtLfFPW6eMpNIEO1cYe/0ylBxxj/WXwUAf6wZQ3+h
         CsNWIYMjHtbFkOFzdB1kgp8iLQjDcjqWmok/x1pJODnF2Twrxv6/7A4X5dYsimFyUVyr
         fzNrunwEtjJDAIVhvrZz2wOolUOGFnAVY6PP0JRRKQhxCFzyUvdJAbxU0ysY4ZbQytFE
         +3qg==
X-Forwarded-Encrypted: i=1; AJvYcCWPcoOu42TOfVNI1I8EG4sqr1Codh7Z3tMRbgb58SGRtFd6VltlFeLTrRzls8KbAhT4S+rZwcsoSxGbNMrElB4rM+yZhjMlcyUsfA==
X-Gm-Message-State: AOJu0YyBqEWWZsjVCZzZj+QflYmZ9h7sPNJ05uZkMTYrp+TFHoyg73Fv
	IjbI4TTOheQ2y44A4Rd7Ldnr81pr79uMDSzFj4koRxcHTi+EESvjtD4oNraTCf4erZwarPbIzHr
	dRHNg6rjUXiNdy9qL9jG4ygv833sa3jt2GLKIzfXYuhPDKJF/WHfJEYQ=
X-Google-Smtp-Source: AGHT+IG5Thx0BiwdKnBqeBFBtnMlWjsuCgPzW/VGb2soX7R1sfkuz/vVj6zDBFaPEs1yVLrdiIW4qaqG5nConq5H20oCXlHKnp90
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fed:b0:373:fed2:d92b with SMTP id
 e9e14a558f8ab-3758030a0e1mr876255ab.2.1717719320681; Thu, 06 Jun 2024
 17:15:20 -0700 (PDT)
Date: Thu, 06 Jun 2024 17:15:20 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eeed79061a41b140@google.com>
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

