Return-Path: <linux-ext4+bounces-4683-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A33C89A943D
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 01:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534E2B21551
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725A81FF61F;
	Mon, 21 Oct 2024 23:37:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A831FF5E8
	for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2024 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553826; cv=none; b=I7gwj4ePHQnE9v601NkVzdpVkRhIwyFHcJpkIYypW7QvVykALqlxvwG3mjBlTzR4k3hhpN/0V6wWIvEWQXzkWURe+r7x8iD1DLjg5X5NqqJci71GpO0joAwarBfq8QcPSzu6VIfFbDD4dzFg7SMxGNDCsrBMiFiTkLXyfVhp6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553826; c=relaxed/simple;
	bh=NL1X+hft2ruIZIMQYmjK5ShYEQWaMI2P10qy48QjC4c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EyFrYMuX06RF3XuRZPz+bm4HPoDZn903kAU196E4GtNysFhtTnEN9awU8CSpHg1bHT/ggLIY3OjZJLN1jt0gmhWd/u7XiGFxQTkykHPgGEoIf5cVuu0dVJmCzCIsU1fA9dK7ItJBGNFjoiMeNwe47VcBCNDzqmt0SaaA8t2fGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so44522415ab.2
        for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2024 16:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553824; x=1730158624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVFqvyN4Q/iFEFo+V00ETjOsELtiq4FSU+8ti5coBUg=;
        b=idplONZcX76RKHNBIHfd6WM/yIeuCXWdomQqBpJWAys8GWEJQxihD48FvJdrGOv6Vn
         DOIXNwtbtoAP06cGHQLNxWJAq7wSmk1TI1A4GHlOQwxF2ltfHMFpaqIniVWfxwB2QN9N
         z7lYNRdOVhJroRHkHL5MEaEJGjUZuiDtNTrVePlgEvUk4O6vopBZbGBh96GfqQyxoDMr
         eJaElQcfswztppKEO+7bcE8XDSIj4uh22PPiIWULniq0CbtaV1lu5EEBEJUlGANIjegu
         vIy9qsGci3EK6tPG297izWgGBcZo8mLqSbgoBkWKMqXZ+wO+P0Wc8joZh14cpNtwb5Pl
         bMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYTUFTkZf4OeqB7oYnu5WFoJa0PaIIy1btFZi7JF7Unq0jJ16LuiryZxDkAeZrbgW5YA6s1GKAcR/I@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8tVBU8FDzN2WM2YtADnfOTs0JoOkdalY6O/1THj0o0lf9AlvI
	0o2fKGPNWGpnU0dStMJH0Bjnt+K/+ETQ3v3BpnGiwFl5WoZmvHNfDiEdmkWbPl8v0eHn/4BGQ0F
	WFqeyFfEKZKzCosAA6dUrQ6XhTRmhWGd9tXQrNGxqFZp00oQ/iXh0MEI=
X-Google-Smtp-Source: AGHT+IE0c0321kUM7kl4x3L7VjvrmYLXBEyNuBBR7zrzqRYflgEPoOW2FF3tQQVOY/6lcuFX5csUTbRz2Wr/gLiN3H39YtSA54tJ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a3f409feb5mr98836145ab.17.1729553824034; Mon, 21 Oct 2024
 16:37:04 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:37:04 -0700
In-Reply-To: <000000000000690606061ce1fe7e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716e5a0.050a0220.10f4f4.00d2.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_stop_mmpd
From: syzbot <syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, brauner@kernel.org, 
	clang-built-linux@googlegroups.com, harshadshirwadkar@gmail.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8
Author: Jan Kara <jack@suse.cz>
Date:   Mon Aug 5 20:12:41 2024 +0000

    ext4: don't set SB_RDONLY after filesystem errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d04640580000
start commit:   4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25
dashboard link: https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fbd177980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ea607980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: don't set SB_RDONLY after filesystem errors

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

