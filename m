Return-Path: <linux-ext4+bounces-2878-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2BB9082A2
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jun 2024 05:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02B01C215D7
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jun 2024 03:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AFA146D43;
	Fri, 14 Jun 2024 03:47:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64D12D205
	for <linux-ext4@vger.kernel.org>; Fri, 14 Jun 2024 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336833; cv=none; b=lZS4gHn6rUL6ngtNeHwV9SyS5qg/DevI6tTylmtabFE2/6FM4mNQrh0OR+8SNhvXHCdy/qNeb+JtjrADEGoD24n5mzm8QXNQ/8YAhkDuQ7Bl9BO6xcnwKnaw7q+aNpP/lP4KOCmTRS/SFql8BA179VNIuFujl+POO/aIekNDtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336833; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f5HBzAbNoZLwSgG1+hJxZMMQIbugQMxfSI1uXd1sAkQ/0IIwIY8xKevHmuG4l76+2JbiL8h5s4YgoOkTH12Nwa8iuso8wBZk+6bdV0v9tMivUxPFw3lpYJxNVCM1wdb0TSA+QSACkknKJPa/Eu6A5bb2EhRO0I3qgnyx3O+klhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374b2adee08so23498365ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jun 2024 20:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718336831; x=1718941631;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=S0IR5iSksbPh5EkSAV3D6CoCLsLh0uP+IWFwnlDQRzqik81mL2R6YjmMOD8kPDLISS
         aUna7e1mT5Ugu33fvXcjrXr+lwVqN6mrR/s6Anl9EmxdjhqSLJOP2WVWMsjwGZ1qtDow
         XC5gpU04MgmYVqEg6dIFs1179LUABWlqihFUqvS3zvavnCAaGPpp4zdfPfw4BqJhZeqs
         KFQpFMyNX8fhWIkgGO+eeT4eBgUprPD+urs63Mw20d4UH6RyjlZrdncIIf5I9JfjZNJW
         2KK90cn9bmD/j3dW/kQ2AqErDSUKkcx5vP9o48qhtqq92KcCblw8Hvlm+7f5/q0XlKDw
         ASDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqsx5FvR6F4hF3J6U7K6pvMrCe5xDd/OnbefDHJM+waDe8mAtj9hNN534cRRvW5KzE+sj2AO57+WfK4UwrzoW5clIC72fs56TW+g==
X-Gm-Message-State: AOJu0Yyi9K8gr1/v6/3RRhJxlTOMMMQK8GZOnzA/yeoL//eUcLp4x7uE
	ec4RH5xKF1406OdJPpOrnyMhknIVj0D2Cibu77c9Hj1CHm6AjL8L4f/nYkjRhc6sDmycXpzZexy
	tAgv5wPgqMuD3Erb7kF0odfR+1aP3aeqS9tLSl07i/UVGajb8TykOkuo=
X-Google-Smtp-Source: AGHT+IEKxi6GNaWi+R9YfJxWIznc2xKYuKXmBGS8WoUzkTSiA5OuyEBc8xGupOmjy3zTJ3UmWO1ib4ELCthvMmcu3bKb+UmfOAZ5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:373:8d04:28b2 with SMTP id
 e9e14a558f8ab-375e00059bemr712485ab.0.1718336831592; Thu, 13 Jun 2024
 20:47:11 -0700 (PDT)
Date: Thu, 13 Jun 2024 20:47:11 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073ab6e061ad17840@google.com>
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

