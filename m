Return-Path: <linux-ext4+bounces-2149-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2C8AA750
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Apr 2024 05:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B361C20BBC
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Apr 2024 03:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C318F5B;
	Fri, 19 Apr 2024 03:44:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32079CC
	for <linux-ext4@vger.kernel.org>; Fri, 19 Apr 2024 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498254; cv=none; b=jG9fB9GFz1L44IM1hUdQvnqJxT5h6mra/lpUBAGgvJUGkEy/1SGNu2e3VwZF+0vNDxWIwVdBy2SFWJmeAEpX2v5IqL4a+MY0hh/N+iyjD2QnCZm8d7vPpXe2d1k7ebfPkiS0adDeIquU4t7Xy3RmN4zu0d/ypvsqG+HAun91fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498254; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jo5Q/Vomw5HJEthFgGyJVz2LJQwWKwlLneZN9B/UlcFpIoZcj80mqQt1N3Nmjr8frjqH6EOV4gQzXAZlqBG/5yIsglHHQad/c1n3nFfX51fIattwS0cMJHqavDCbgVM2+exJ8FKarY5xGu2h2I9HMxoM7uibyRCIJefS1nN6N5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5f08fdba8so280192639f.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Apr 2024 20:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713498252; x=1714103052;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=ZKldTnszGRRRefS3Z4W1gbcYjIiooP9oywKoSfZmGNLLKHhRk7M7Y0I8Fpg8i1rwzv
         GMiOPe34aS01P2bMAMtb5l1vThJdZuRTy0Keg4ODFgne3BAdAbQqtgU5Bh6HREZI6CNv
         E2hAhRPLnJVhAn0xeE3gugTRAiAV2QknuOWoMXoyQzs0ko5jd61hkqez5sGL71St4DP8
         IcFCr5BgFTvwmi8TCisWhTBSBO0yn7v4D/4iyV0uF7DmxsuilMOfUdBcn+TOiJbLbSM4
         YFjyrPdiVevs4tQWlKXJEj9+ty0kSYmvrbb3JtzEPW/krtPOGXZvxmth4onJ6guLR9O6
         2JXg==
X-Forwarded-Encrypted: i=1; AJvYcCUBdTKbgVjhJGfbTrEurzcH+nNeSePKjVNTY6ArUh9yT1HFWfNhrqXce7DxCyhTxe0aXSCi34QgexGU9u1nwQ5BYd9PyEwNSiBtiA==
X-Gm-Message-State: AOJu0Yy5mEgLf/bfGm/k0mFhyN8pCMZM5Q3tGQxxTEngOpdQAqQJldIM
	z6R+AUCtyPbiSqAhI+lySNAaHIRg4X0FXJmy++8oEFERdCTHhnhI/FlvIyqEaBkM3TucOfhArUH
	voUAibti2/jtqzEhaicUBSyDZAvk//c5R5ccV2XY3JrH+5d0nt/+AUtI=
X-Google-Smtp-Source: AGHT+IH3iHj+p778Prfz/op9yzVlc6IHlFlrPUAXxBsVYGX2Oi9UKR/mPnmrlFcE5vwiibiZppLH/ePr4F6EWdAQHqQL9B0e0mpp
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a6:b0:482:fa6e:648c with SMTP id
 w38-20020a05663837a600b00482fa6e648cmr91745jal.3.1713498251939; Thu, 18 Apr
 2024 20:44:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 20:44:11 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1618b06166ae6d9@google.com>
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

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

