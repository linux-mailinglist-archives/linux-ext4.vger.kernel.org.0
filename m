Return-Path: <linux-ext4+bounces-1880-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B58993F4
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 05:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC06E28B95D
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 03:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924551E4BE;
	Fri,  5 Apr 2024 03:43:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C718E28
	for <linux-ext4@vger.kernel.org>; Fri,  5 Apr 2024 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712288599; cv=none; b=Y5dgVh8Dci9FE0pwzR+VtCNYCZWo7Ih5VNloOIiJDhDwA49wg9Cgix8BEEOLzcuWMfAcw3VR2cvAN8IAU29tZzY6Mbh3sCoyCe9gRxif9DYV/woT9KNTYpYVi+K6goE0k+vH0rC7volraE4X/tSznNlW5bk+Z5oxQndffwZhnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712288599; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F5G8XVE0CKTYwU4q1MXU6zoHRiLX1VAHZBmPjSQDKSyqoKZrNTEBFFm50Y+C1VvBZqTUsRLqa79aG04U5QxWq7UGbMDyleDFqT+W6sm5PCZUG2R29I44YcrwY+TP/ciXcPGKx73m9Wc5+4RRhEep21uZogwn3KGKEcxf+/1r0E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc78077032so167819739f.0
        for <linux-ext4@vger.kernel.org>; Thu, 04 Apr 2024 20:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712288596; x=1712893396;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=iIv2d6U2Yje3tbyYtPqNQHLcfKx5A4cy7huk1auPatfs/ChB7TGkDIO36DMvS3UBDR
         NZ9j44El55ntuseXDD8ImL7fKviv07qkisT2hk3ykSnMc4k/EJbzbz6d2RLoanMrF6N+
         zBQd1kERxRoDwFoUeEPM0p001xoyExtnrxMr+ItPKrujSuK1UeqvyztXGbC/HBWbUWEU
         fv+HphVdgj/XcwMZPb8xcNOwT7ov/yAJPTIcruXktINxmbXX3Rq/r3Gt3cTwUcNYWkpT
         TvSRYm45zTUCgh/ST8TWoTDXuIoc9gnVN3tghxieo9vuMCT18DB0KcP6jm7fvqVBt44v
         rjyg==
X-Forwarded-Encrypted: i=1; AJvYcCXJRo4JuhsAKkKUBZnREU5pC5uuHCpxZc3pDQb3WRlYxWcoFNE0Od9HxYgTZP70uLXuzfGLHN3eOpRBXsIpwDqooxQ+LLIvygU5RA==
X-Gm-Message-State: AOJu0Yzbx//QCfa6F/gwS4yRr/20BgjgsndPfyye9lh6Xu/bsB88DQJo
	f6g2S9jY2XBhC8utw2GBOhMo9oTxkN6co3wsL053v+XhQnHIMjIbpBfKc1BrP7up+0AZBHftZUm
	xK3UjqFW5+UAM+L0pDiWSh/wz21r+3m3GD1deNGk5eiqolvWW/j3bT1I=
X-Google-Smtp-Source: AGHT+IHFjzv8CNoc6/4+S+f/8xeraOyYdzTyewDxgRGtLwR+czgNzeoy4SNazCpVhYvJOMTKJpxR6ioDqjc478Je8Q7mka4bDHJ7
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3892:b0:36a:a46:69e1 with SMTP id
 cn18-20020a056e02389200b0036a0a4669e1mr8852ilb.6.1712288596096; Thu, 04 Apr
 2024 20:43:16 -0700 (PDT)
Date: Thu, 04 Apr 2024 20:43:16 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086534706155141d5@google.com>
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

