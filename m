Return-Path: <linux-ext4+bounces-7098-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7AAA7EF8F
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 23:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07963ABFC7
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6FE221DB0;
	Mon,  7 Apr 2025 21:10:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BB2222D4
	for <linux-ext4@vger.kernel.org>; Mon,  7 Apr 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060204; cv=none; b=ddc9repQZ0nD88Llk4b3a9T6U3/HtdHvrZ9lAgSYCNt9j1zu+rv5GLQMo7NFjl6Z4gwCASmkDCzGsJQ5M6z7YDbnV+OuJcJKYP8L3fS1tpPtUHu1sMRGhHo5EAru326hey/spGTk+feMi99N9nUF0nFphPoFO2SDkGJdOAyaurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060204; c=relaxed/simple;
	bh=l33H7W/dajNswr6zoB4uEzQnZ3xV2ksVZyWMgdOsk+c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vAtoj8s/kJS1na+1MBSBYdvPtsUajSTZYKg1Xch+nvgPqOZzr6tLxBjgUZ0PS7eCfXF419UgAqCdfbdAUBO0/cJmX7b+UoCM0f/N6ZQqdVo0texHOZsi+wRg4vSJ8gEZoZVRdau5lmLJ2lHFKUSh4aa0yuB+kfrLLM3bL5r+vjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85e6b977ef2so1011615839f.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Apr 2025 14:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060201; x=1744665001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obSJQ5g5QULaHlCzGG1efUqikPTPRZ9Sdsw5hiAMvVs=;
        b=b2DMR+WvRGg6JYu4//sqlax+OzFk3i7H0/VnvIrq45vrbFGzi23nfXtT0WIexvTCWd
         TyJUlWSe+M1xcW03G5dagyb9vJqbALXDliFVFwepaetJMfKRYl4thtcyHsFycrf01vzl
         dJRg2OMrj0ghaN6p9cHHBkBkJ4dd+kht3EJreWd/xOHpXPhYkN0wOiE6ekCATRVi7c0a
         ymRZ8UJ4yTjA15teD9imLZMHf2SswinCi/6QlyyLrOkyqb3kPG9jzLYkExvK+VgqOOqx
         MJ6QL7e3xkVAxD3Ro7sgiL6oOIw1WF/VPspCUDHGXL0Z2Stm95Emw00Ul5rgUVO+Ds5k
         SH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdaEW9d2m5ILRzicvBSH7pur7mMPsu0x5AvnbMypb2tIb75vgbliRY1QNWdZnZSSbhrQHbV8wX0mMQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYutaTarN0GH3ujPUBMeQxBQEGhTSzCDDPf8+9u0EyzSW2g47
	qonfPQ6cGvEfsFwl9ptzTKQBk7ZzYhnfxJvlrGFiwCcTf2w6YYYixpmTbuEgZa/gzYbCYzdsJ9u
	mksEHpEDkrdh6Zmdj4cvPWjIsE5Id/skL33tKMJQxSmiziOeXelv5cbM=
X-Google-Smtp-Source: AGHT+IH3y067eDUmOjv5CFVChEZZ+wYOKbqcRDrio8C6VJxigSI3fEGx40IpkZ9McIdubTIYOFN7nscVeIXbCNAf69zlWSylOENX
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2199:b0:3d4:244b:db20 with SMTP id
 e9e14a558f8ab-3d6e3f653acmr156570565ab.16.1744060201704; Mon, 07 Apr 2025
 14:10:01 -0700 (PDT)
Date: Mon, 07 Apr 2025 14:10:01 -0700
In-Reply-To: <67f34d24.050a0220.0a13.027c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f43f29.050a0220.396535.0554.GAE@google.com>
Subject: Re: [syzbot] [ext4?] [overlayfs?] WARNING in file_seek_cur_needs_f_lock
From: syzbot <syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, amir73il@gmail.com, dhowells@redhat.com, 
	edumazet@google.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 00b35530811f2aa3d7ceec2dbada80861c7632a8
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Feb 6 14:04:22 2025 +0000

    batman-adv: adopt netdev_hold() / netdev_put()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175f8c04580000
start commit:   16cd1c265776 Merge tag 'timers-cleanups-2025-04-06' of git..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14df8c04580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10df8c04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79406130aa88d22
dashboard link: https://syzkaller.appspot.com/bug?extid=4036165fc595a74b09b2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f9bd98580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1571c7e4580000

Reported-by: syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com
Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

