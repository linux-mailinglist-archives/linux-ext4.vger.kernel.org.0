Return-Path: <linux-ext4+bounces-1252-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5BC857245
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Feb 2024 01:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588911F25533
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Feb 2024 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7118BFB;
	Fri, 16 Feb 2024 00:09:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51F149DE5
	for <linux-ext4@vger.kernel.org>; Fri, 16 Feb 2024 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042154; cv=none; b=JDawRrq/n2HEjToOOJfC0mZuMn+eMjlCw1zSTsr7v/BThGiZ39o040d1t00XzHwCqR7cgjiwc2tSFHYRqsaFTdnp77Edh9A8afX9et5HgLtCfClvYZ5HIsIgzyuvjoR1iXS4aHFesY8rGTtO7sygJURF70vGKuRgD/qCzIyN21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042154; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CKjkDrpTXiDQGk2rVrl1M/JFAJSOuBJ6DiOZUW+TfzKBXa23OSrJcraqoHDiZvq6gPJkMfMlHDAr+qhAHmK6L60odOdPKlL7Ey4xG1D7m3SmdH+9+tcHjpLjPfkWp1KbCIj56+rtYKl+GUKeqzSGeDylQnWEPRHtW6r3B0i/8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-364f79395fdso8198225ab.3
        for <linux-ext4@vger.kernel.org>; Thu, 15 Feb 2024 16:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042152; x=1708646952;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=S4VF0hcJ+jnp69ShW/99uo5hw+SkDVuA5z2GTTPfadB7PLXh5VHt6yGX2iXvsvkM0A
         WN1p0/pOkoUJvyAbPx4+JXIfzQBrC/BaQ3ugxua/+U+6DUMWyETkzcVa6TyCFOQRocRV
         snWgJjyfpEh886TYfvCnkDJW7ypnZBWBh4CTVU21JPxpnL/YpH1mO6E6/WeQTTwIuhuh
         MvTxiO6EaKD5S88C12H6o8Ja3y+fkZ7pak9GccesOZhx8ZMBgEeyovco1xY2Lhs42I84
         IL5bDzCserEVJsEvWP9cROx31AL4qCZ9HEhHlK8pjWV7FGoc97qxnskbzvvRFPv3E1sX
         HW0A==
X-Forwarded-Encrypted: i=1; AJvYcCWtM1DkxYilpceoTr4k2BjJXltK+eBO5AAjx1Y1EFrHJk7lAl9Ag8k2zvwvqDKaYs3raK2//Frp/YEkkq6yDZwd2KQuaUkuzv+N5Q==
X-Gm-Message-State: AOJu0YzAs8nmnGvsX/PCiA13U6qfJ2XCnhGnM3DdZ5mPVv8Z3lKDjc7X
	kqml5gO/pO0wTIAbILdSEDZBafUbqxR/mTktiB2jRkwMbz9tEy75xIJk9cZ/wxG3ZNDzOKCwxX8
	9gETwiBab3Oycyl1sLIINUGPeT3HgB/WzHcuXnD2qTuBWZFYYskTd1IA=
X-Google-Smtp-Source: AGHT+IHWCVuUeC7v0lAZJFezIkfQcaDrrBjAbxzk6k6ndWAM0wqDyd8gqinQBOi355JqaWTeH85DoeiriithR+xpOQuYk5VA0C5d
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:363:c75c:8c9 with SMTP id
 j10-20020a056e02218a00b00363c75c08c9mr271591ila.5.1708042152425; Thu, 15 Feb
 2024 16:09:12 -0800 (PST)
Date: Thu, 15 Feb 2024 16:09:12 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1bf960611748d2f@google.com>
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

