Return-Path: <linux-ext4+bounces-1566-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512A3875CD5
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Mar 2024 04:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007E71F21E9D
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Mar 2024 03:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E8F2C691;
	Fri,  8 Mar 2024 03:42:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D32C1A6
	for <linux-ext4@vger.kernel.org>; Fri,  8 Mar 2024 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869339; cv=none; b=KbF+0iQfRUeopgDMAfLscAOeA2HhRMRwTo1Qt9rioDpzZadF0lAWmV5dPDpf5LxdmBf4ju2G3wY3U3YCtjKzdWmPvGMlWhibRU3hMqLmscJidzgBkeldMVMxujtpZ0DpFLdU8OZewNVHirxVGUNNshR5D+e0LOkoqDYYpwmUnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869339; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MGxjMm1AOrhYM/scmnm4W5ECPlTQTtFvUQj1oRzaAjYqxHqEoZZDvmi8dsfKGIgEJxOvfO8lnPTaVJwaldMUkEIcwLwLAYovPOw30hnFeAJ4InAetjqVCya8IfJS3ex13c6zNNSBxN0znwizsV1mY3Y0p7f8kItRdjIQArjlv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so125620639f.1
        for <linux-ext4@vger.kernel.org>; Thu, 07 Mar 2024 19:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709869337; x=1710474137;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=Yxzwdn26N/iZJqWSkekBW6f86lFryKUQV0YwUxYUPlzy48rGGYQLx1FEoCUNfQpKks
         WUoCYTucZAK39aVt93sb3WfOs2eM1esSki3R0L7c18MvouzALQgMRrJVA1tsExdOxOwG
         w7e0dj0n9AeW/n1WeKrtSHBWE+UcYA9cI679FDm+XQ1gCBzr6s0syEpK/TcSgC6yJhcg
         BWMVcrmP0CekJL5CTydQodowWH2pbksl3xAZaE04buvzvPxFBXAcbNdhdLjDEsK1rIbP
         0/KhV7yCGkq6KLqdGM434Rk0kr8DGwRvrOveg/5TgOodlhMVhpFoAhVHsjP5QIdSVcGh
         WgXA==
X-Forwarded-Encrypted: i=1; AJvYcCVOobsFxsy0rLThhev7qwB3tarC6GHOYcT+GYdsilhsATyDnQ+RHhHFhuZhrdBZ4usIM26yEeyfShgTcvo+oI7yrq2Al6CiKfHvew==
X-Gm-Message-State: AOJu0Yz945wQRkB2i2v/+dITf/ByXqKNzToJSlrFCuhAbt/VBNCZtza5
	+9XeWOMzqkjLJila7aHOHZMaJBlmfUP084MIYZbNvkR2fjOopzOf37oEJbrkWonpkG8zgPRp8/E
	yyTSS25h4h1YUOLOlaxEA66qdsz/qyqwSXwAUMZT19svSRaJB2Jf3N+M=
X-Google-Smtp-Source: AGHT+IEfm4T3ox+Arg1FX0HDoKBf8GotmyyS9mYWuGNzH8O8IDART7Br5RhAcWTaqRvmJbP+PX/UzLeeC2tHO2MZ9l1ucsbwX/bl
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b18:b0:476:b3e5:4392 with SMTP id
 fm24-20020a0566382b1800b00476b3e54392mr150721jab.2.1709869337792; Thu, 07 Mar
 2024 19:42:17 -0800 (PST)
Date: Thu, 07 Mar 2024 19:42:17 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007de36306131dfa42@google.com>
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

