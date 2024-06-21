Return-Path: <linux-ext4+bounces-2910-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35D991172F
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 02:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552B61F22F2B
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F046310E6;
	Fri, 21 Jun 2024 00:16:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49719F
	for <linux-ext4@vger.kernel.org>; Fri, 21 Jun 2024 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718928978; cv=none; b=GQAB+SGso5wihnuKHaUqq1tR4bQ8oXpz/AASBA0dwGnORLNlTH7zuKDZF7Fyep8DqgjuvOu8/EMyTMwyNqjfgeXC2DqMx/RYTBca8nhIIrzF4/8bkpUAChaYaurQKXWRVFrfDG6EjpMofnC4f3xctsQwl4E0AVgvmIw971xL5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718928978; c=relaxed/simple;
	bh=dfBRawcr2glCEAMpyVpqh9p8zTcVwCn3sIfnaGnucac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cuYuIKGGP8p8C4B4KJ2iJKATmUHKFcmgVv0TuR122G5MqGJopEpTbaNMWmgtWwkGuwAmyXhlBos+QB7wUBVo/bm6NIDnmNVk7KLvR/USyWv5R0UBvZaYqEKaSXbXR/dfJZVGZ9nf2YZDpojMuLZ17OBZuL0qyqYT4lf45264wO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f12e60c050so201788739f.1
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2024 17:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718928976; x=1719533776;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfBRawcr2glCEAMpyVpqh9p8zTcVwCn3sIfnaGnucac=;
        b=lCgxNKjoVZ5VYuv6h9aGmrMLxp1dt5iHI4JlqzoKip5Zd1S/zpC5BByZmihWtTFSto
         g05ntZ+VOFMIc8Y7FEId3kMjOgHgSDlBzWVtb0tavrxtxDd4Y1DxNjn9k2dCsaSL07PC
         eA5Q0CVC6l0fhJzd2hJh8KKvSs7ACE1SaUf6eQXHd9jiCAiSFE50oyj/l7z+YGsiJ3Ig
         yRHvSzHxGOUjhL0l0ZqbHCACYIJ3/MGFsUGOHGnkBbH6LWktmfye7nwcOkMTV4SWyXqY
         g5rL09FISgHY04VvzDKbv0dKsNn5tMUNw6L9+kkO52+f2+xbi5rvJyF1PRxpoMvl7suI
         1KGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbjA7OFKM8ONBGKMjm/9epES7tkAz80ibzsBqG3lKPFO1Wz7QHWxmEmrPJRQTM6N0rDGtaKgAvr7drsOJdjeIST40ajbDTZRQC9g==
X-Gm-Message-State: AOJu0YwBhS0qMV/WxiaOZsP6CBe1NPeZOZJ1bMAlrQ/jHY2/lHqsvjUA
	luHcW1fxtzDxWcS7slD0EGu0RpjX79oR54xCoJnoWo8z/lpzXYCbsJmd23Pqjh7bT2nFfs9arRn
	K2nR578/LSXV3ju2Z30xUBSwJhxgjOamhuJhHjhggGWWRl+G0HEO3lBw=
X-Google-Smtp-Source: AGHT+IG89JAyn/NY9M/Hy78bC+ISEzcD5xhsyf833dKnYvd1Hw1ejNIzlzrpDi2XnWamhjOzKzSs1NIbkg2FI3422oAvKYuK7+dc
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d90:b0:375:8a14:1012 with SMTP id
 e9e14a558f8ab-3760951edd3mr3427405ab.2.1718928976587; Thu, 20 Jun 2024
 17:16:16 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:16:16 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b3e69061b5b5762@google.com>
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

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

