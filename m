Return-Path: <linux-ext4+bounces-4618-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA99A31D4
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 02:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0120B21CFE
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 00:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC8558BA;
	Fri, 18 Oct 2024 00:57:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FD20E30B
	for <linux-ext4@vger.kernel.org>; Fri, 18 Oct 2024 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729213026; cv=none; b=TjJYJfcCZ10wSVy8IjJIlJrCpN64RJSzFUX9UyfwR6ulABkIkTZjaRkd14mcVAQhNGtoTH72cw+l6hRyTHgrIySOxePpAP/mdnYktCeOrbQPYfH5xiEpU5yd6owIjTuM6t2gZZvvQQDnoXf6VMm3XDRqHUZVoiSqq5oTg9nRu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729213026; c=relaxed/simple;
	bh=gCfZCa3eCO/ImdtfrgayImJe3Jk4aFQ+KvM1j0hJ13Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q5JQUs9h5+eQYFqGgLzQj63YvREDIjG2ZY3dUDf1teITaNO8XwnqvrHzicvIvMPDB4Ft67AIEFelLnuYZYT4op73EgDPB+ncElUaHtdjUR6qFORS3n6tO7sz/nrQ8FG2L/eeyoVFK3fR/et57DGvmwbu7K7aB5/Jf8ULXCYqjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c4ed972bso15747385ab.2
        for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2024 17:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729213023; x=1729817823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqeLqdi4VZTQWUI7otEtoyavMb4hyb3TjNvZ1DOSFB4=;
        b=xOlz8WE0gCTPZNuk0YJU3XTiRn4DrJwzciTzbEcBiVii+i1si3566arVXL9vhXz0W3
         30xTa/oHWVcsTVLdsLwOMr3zGZWspFPHVQOGmwEaxwoF14xt9AdmvaMLqO3Kebh2eQZE
         jAh4qllzaQL+u1G7o9278O3Q2mcRh8yx7j/7FYrrlZKyV3KbqXRY/NlQuLrdyhWy12C5
         HevTnNIhe7iEa57dTYoU2WdeiK6NLgdLWuq1mNVejeh6nmIH5U5+3i9IIjEseiQ7UFWd
         U0H25p1goHg41aXRpaWrR19/D6J0SLC3r3eZY4aaMaDPTE3dn50nfLo1dBqoMx5kurRf
         mm6A==
X-Forwarded-Encrypted: i=1; AJvYcCUX4Mft4aCjpghUSx0oGyWfQieqGfWUxAJuvWGzAgk+sOeBKyYuhhGb+dbtzun0qZpJuv308PvcqLzS@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHmOPNZx4P42pJDclNShKKd6sLXJ0meETVw+FHA7NPvY+W2ZA
	vnp2QKjlSx3ZB9ZpcF5xd8MWzA76dRUJ2VxqgMuJ1CBtyCJmgGR4B5D0lt23Veviw7Bk9HJDTok
	c+ROPjvYs4ovreMf6CYm/e9PbP/Ltkr8X8ScCkeJZmp6N28oOKqZsvZg=
X-Google-Smtp-Source: AGHT+IF2l/I5CwjB4QRbjF8KLulqSx+JqIfNHnjpBOSO5ETpL1Yv+UJRRdeB0PbR1ueuLAyjYo8Gc0436YSDNNO0EuMsJR0ZOblI
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a3f40b531fmr6352115ab.21.1729213023103; Thu, 17 Oct 2024
 17:57:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 17:57:03 -0700
In-Reply-To: <ZxGkuaVUl8KRPAxO@Boquns-Mac-mini.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6711b25f.050a0220.1e4b4d.000b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_move_extents
From: syzbot <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, boqun.feng@gmail.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com
Tested-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com

Tested on:

commit:         117ea4db locking/pvqspinlock: Convert fields of 'enum ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git lockdep-for-tip
console output: https://syzkaller.appspot.com/x/log.txt?x=14229830580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de68ea2a11cb537b
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

