Return-Path: <linux-ext4+bounces-1771-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63757890EF3
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 01:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946D91C22357
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 00:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56511EDB;
	Fri, 29 Mar 2024 00:11:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCCA34
	for <linux-ext4@vger.kernel.org>; Fri, 29 Mar 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671079; cv=none; b=Z0GpsgGX6WFCNU8m2Ybhcq+UxgsWOFapDl4hHMaI1A30DrGM2I+famT2LI1CoRj6Ld/vRe7f3Ih3tbXNm4pyhQwrnw+Pk6pi7LYAjL7M8lYe0wLxyNwUUmGfHZ/NzZgmsICALClmQmnhd5uU08KyAnjZJ7IWkb1zHDVJg5kJmTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671079; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J4VEnUKx92rQYaKAzgOAzUc+6vWm+HHlKD5/gJgTOQRKTxK95DR9naZWvZeO0i2HmzvJ+NKjSXPxNbngymHvmFIirdl8tEwlmeZEqiuEKXbNyar3UZgpLFszE752lqT1hnJmF8alsLcB1GbSyoY7k3CmmIAuEOgYs+SgLf2aDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso170757339f.0
        for <linux-ext4@vger.kernel.org>; Thu, 28 Mar 2024 17:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711671077; x=1712275877;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=DYNwAvDZBhdhtEIdAyJBQEZF4urPFfouda7ZIvwHojaFSvExuselcEgvXN5AqUV5tC
         sq7FGX533ASBLC2YSxGXzFf9qo6gzV+a3KpX6woBTXK6vP2lyzrsu+MAnrJQ0BJ7x+nm
         eu+XIqJluCrenZKCr5RFzgtAF7TqR0mqEbZRZm4EkuYRuvHlT0d29rq/Us+DSJ7hSC4h
         NgAtvtJZPWzM0xiAMeXcELLgL5ZV4grBklnZNdUV7eONP9JMUiFy7dfUInE3a9azHTa7
         qYzMptL3dCgR/ylk6qrhfK5ZLGMprcb+L1zSzBcXqUPEbLehKBs+D/4er9UpAaC0FzoZ
         M3sw==
X-Forwarded-Encrypted: i=1; AJvYcCVU7q3OEyoweg2LYy9H/5nQB9pBH4DteePv2MH4x9UoRSuwzNgYlx2eZbGZvBm2ptPkrwYVZmjTCd9xsIrpektrYm6FdvEUSok/HA==
X-Gm-Message-State: AOJu0YwWCK97kbWIhOACTlv2mhDId6b9n+whkQ80IEj6fOo5zs23M/3B
	P6d4zCFH4a1PUu/6pl1GBUhhDvsZUp7o4T5UoKvJam6PeJR9e0EoBdEBsVUfBMXt84fqBlU1Spl
	yJn/fyLf0i6vO1Ck94D4N60Hhs6b/0civnyveJrfpZTNTx4V+fxAgcwA=
X-Google-Smtp-Source: AGHT+IFkuzBOXLL0qovYepiBhl4jyh5xiqBtn4XTNWP9BC4uhLKwBQok6OoN5qt/kdcWfaL0mr2Wio+as2oxhYmU6Eq/0T3j6aeR
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c90:b0:7cc:8980:5ae4 with SMTP id
 i16-20020a0566022c9000b007cc89805ae4mr21732iow.2.1711671076996; Thu, 28 Mar
 2024 17:11:16 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:11:16 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008461a90614c17a44@google.com>
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

