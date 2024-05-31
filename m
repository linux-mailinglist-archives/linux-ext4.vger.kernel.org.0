Return-Path: <linux-ext4+bounces-2721-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1108D591C
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2024 05:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37B41C229E8
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2024 03:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C869C78C80;
	Fri, 31 May 2024 03:46:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A0D51E
	for <linux-ext4@vger.kernel.org>; Fri, 31 May 2024 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717127182; cv=none; b=Yyj5BWu6oWUemxY6sec1t0ZL3x9i3nnsrIe7SbQkyO5bPtb+wFr8vz9uWP8McL8T249FmywdjIFJdqSDeNkoRYJ4F6iXSZlDXUd7a2Xjv1ci7Ffe8YtAzlOPS2oMk+vHyK9DGWDIJSPsLtWsG53+8av1Go6Z+DplnNcMshu1wvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717127182; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q5Z9TkrUfTFqafZ+X542JBau9WM+uaObtOAyZBEpCslKaBddBl3Rc1/NgCiqVLjF2na7jpXDa3Kwg+LJgPeXjf9MS3qrM5ZfGwgGTCMoulcxi3lFmUrm6u8gcfFG1DQmWV1Ng9pywqqtMV9/aIoONjyFHZtkktNeiupKEzznjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3748cab6364so2065525ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 30 May 2024 20:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717127180; x=1717731980;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=pbh8ggkooOfDk19SLHf/cxIg7oQuS9xtt32VX1CfnHedf1XlKMxyzGROQryzGuabOZ
         +jrI51+9W8KsYMo0LA7ofBc8Ozyp+aE1QE4+GZWmAxd6Gx3y8ZDyogqXje9TMDYz1Tw9
         pRL1HWIwuYJBc02AaJKuPv44C1Lpxf62g+vFgLxLyo6YabOcVOxPSCrhzh0gNtHRMTw2
         57pIl+0Y7uXT/GGo3JmBJpoYG0+VKK6jhAefOu0RcgHMQjDUtxkLcxgmDyyAvwPvdQfS
         coOuyWDvp6XMuJetxY/clOleL6wCkPth4COUAmIs5ZBuJQyPvkocl8y4bFLsBd3AEsWX
         61Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXae9leTRPov7YySjXj4Qubf7lpmCaf4aQKamBfG4S5c9vg9YUmY5d+9e1W241ujPFNCRGwIXYKc4dlIoHLiRykYwNDzuZNUI3N/A==
X-Gm-Message-State: AOJu0YyVNNlVpNdGGpPuZII5fELxpTNhpaRugscDtHG290btqGPYS6VX
	ZkEHW6kyvzu0Z1psc0Rf++kH1OVTIHJX0uJ876hFXzZBRlyce3bDY+C8+xIQhpipPmn/yr3z8o3
	EO7BF6ch1YFQWmkpLF1ApIFXAf8O1XK38I75CMLUfCGdcz8UuU6Oq7eQ=
X-Google-Smtp-Source: AGHT+IFAlsDFvycw9GtdEcUnKblFYVUmsufEcUGHjOdczoQb273MFgKPjf2HsqU/ULaiNL0DiWQF9DvncnFTP9/cEgX9Dm6AepsC
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c4:b0:373:fed2:d934 with SMTP id
 e9e14a558f8ab-3748b96aa5amr863735ab.1.1717127180409; Thu, 30 May 2024
 20:46:20 -0700 (PDT)
Date: Thu, 30 May 2024 20:46:20 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f6f220619b7d3a8@google.com>
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

