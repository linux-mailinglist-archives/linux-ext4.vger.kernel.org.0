Return-Path: <linux-ext4+bounces-1373-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB9F860975
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 04:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3C91F25217
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 03:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C348F9E0;
	Fri, 23 Feb 2024 03:42:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7DABA5F
	for <linux-ext4@vger.kernel.org>; Fri, 23 Feb 2024 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659737; cv=none; b=RRNxcu3EUuJcX4gBj5624dbUcyzbzGGh+4TzlPNWfyjrm3xMNpK4tcXWlm+9bAEQxLHav23f7eZ21D/Rwa9L1whzKo8s+9VfKuise91FAsMZv6cmoblkjwl23T/HT04Yb4xEuqBhgQBkL92TEkdVbnPu5o16+681aq++2xmrKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659737; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bnrzjWqM0eDru57n/3GDKORnqEOlFF6LWs9jR9HGQ6iidJs2Kr1htaCsh0JvcnaDNaIWxaFuwdJevd8FnQSdGsWFyu3HtsPyrzmlTK945fSuNFuztUHIWYe2Gz0yLnDtXrYl1gNFfJn2dsNxIBm6mYY7ajStHbEVF+Tjp3inBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3650bfcb2bfso4636315ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 19:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708659735; x=1709264535;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=qKg29Q+a1a55dD+5xRNXgQRwwA3o2cxUKwWTjDwsI86qGB4kCabUtqf+9SayIlqexl
         pe0VIyajr+bzvmna90dhyIaPLnqR/QVLQ09VZfyCXbEfxRdtqAjQWqXcLmQ0Tg4LaONm
         FZ76EINaPyBCgb5edbNCE3J318DZiY2K6mlzMlB2GfXGp65bqyH7H5pHrh3c2VfdvIR7
         HW0K1CbjbQnOJpcC4uY3jW8uRoOE4HmYOWvceinhYQ64L66ZZHFucldTFqS9bsjdCfhL
         1YPkq+YLt8GHL/WGJ62HHpTKZP1lfCkJklknI0UVu0NgCd5uFwHgiZP0HRaZRo34yMoY
         e+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqY9unkBvfFZqR8l+1LyzO5Vo48VlYT6hx1cWryjZz8Y2aNTdlVowY4BYXWFivy0FOGo0X54wNbabeO9JoZF2RxkAwqsqgi23DuA==
X-Gm-Message-State: AOJu0YyZSnFgEL2XKLU5IdwouAmRRiZUBhyLFGzy/8/ErcTZWCLGpxfd
	83bsv144lB2zNHmNB5c3/TH98+IYIwHr7OV7x+Ych7m29Nlger2fs5IVbF7ou/25KgB97NrPdJB
	2ozdx7OVITfq0qIcxI98M7cN3LgYDl1JwjQvKBTmdvjTlKWHI/bkfElI=
X-Google-Smtp-Source: AGHT+IEHITDeGfXXKEEcbHVMaqOoheljYjlUsecct9kjAKXpEmDlVgujpax/NYL3RtH4uYF21UbJQOIW2GGvNrOkqD4amCBoXswK
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:365:616c:59de with SMTP id
 i14-20020a056e021d0e00b00365616c59demr62531ila.2.1708659735114; Thu, 22 Feb
 2024 19:42:15 -0800 (PST)
Date: Thu, 22 Feb 2024 19:42:15 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dbd5306120458f9@google.com>
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

