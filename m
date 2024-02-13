Return-Path: <linux-ext4+bounces-1202-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD48524F6
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 02:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CC8B2253E
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 01:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1F212BF10;
	Tue, 13 Feb 2024 00:24:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B312BEAE
	for <linux-ext4@vger.kernel.org>; Tue, 13 Feb 2024 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783846; cv=none; b=ZaZpg1D2mLCc/ZVvjokgnL3BUeEdci72AvERoK09ORcRy+tPKdpmC34MMq4oD162UwbFBmYQKeNhqrwAVCM+BYeUnzBRvQIfokaG/XPzG31M32YdGH/F+WhP4ff5C33xFxwcdJFSXkIaaCtZv2XdvUZ3IAxDrveNWKRZR37o0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783846; c=relaxed/simple;
	bh=dqTQI63+ZqDNKjpAbbZCxeV49nIfSpoeFvQR60x/Qw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IEISpU858jztWHTvMVqNMHqNHMvoFlPk5EP/PqYRTaEO5n63DlegzK05h5POR0B/Jt+XNoMtt6Zg7NsXYMtwzLiY9Gd/DwjPF4gxtTDR958AbjzWEn6gzh9g6wKFzW0GWwjQpyGmdFMreA9vjmOF/vhuCo5x9zBifSgHu2sd01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363bc80467bso22104245ab.1
        for <linux-ext4@vger.kernel.org>; Mon, 12 Feb 2024 16:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783844; x=1708388644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiXaK9TFzZAPYPnTyw0VSmUtJHPDIyF9ZuwGBaLUHN4=;
        b=GBb1Z1Eyu2xgtb+trNF8nuOFl7nN5sbzLVNOGm+4qQxNJcU8bf+CuFG55wIjTSdiEr
         mTdhERM0+/CdJhabxtXpuisNM2FhuYj1vPGIw6dBcuOTOyqKIShfttwXOn923mKUxJ8+
         gOaOzx0y0eti5PVhPyWR2/QNZyfr6lCXogPSdhQiFC1n9zS/Hi+EQiQAjIeEsuzLb9iQ
         1Ffq3Cardxlu+5l3O8PqO7/0oe6vPLSJZdj6mRlw1EA6FAyXjIDSitHM7MBwWQL26Qf/
         bjnfF7FFeryPCfcZ3rmmLPxO4t2Nj4l6NNXr1A6qdGM756DHlMz1tiMi1d3096UsBjE8
         9XEg==
X-Forwarded-Encrypted: i=1; AJvYcCXkb7gMOpwEOGlqs0AFVVxdvgZ8cepPDT7IRsffRKqOSUhbW3VxP5tApAj2fzwFEJM/aGTuzfVR0nfPck0HSLYePJ7NL2dLXU2MFg==
X-Gm-Message-State: AOJu0YyM2/P99JYT55tN451yOZs3NJDzti/IpQcOA6TTYXsNBIFoCZkT
	c0ZcoqBPmjlJ9tPfLG+CDzyXMy8RNzG6Hc2w6bUM808liaFNAXG9CShelokpxjDCMfA8iM4G5O6
	D4vgPV/zJmWoLsOsZiB3j3vX3mNgK5g0bpXD1EmMcgXySAKDRMmwdQvk=
X-Google-Smtp-Source: AGHT+IF6MxRdyVnerz3TZh0IMvFhTsYoobPC91qocz9bxduYTKyDy5vR6SC+Hzhdc924TduO/JMxFxAP1kD/Km0bsBVcWg9yuwkk
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:363:8b04:6df7 with SMTP id
 y9-20020a056e02178900b003638b046df7mr80908ilu.0.1707783844004; Mon, 12 Feb
 2024 16:24:04 -0800 (PST)
Date: Mon, 12 Feb 2024 16:24:03 -0800
In-Reply-To: <0000000000001f0b970605c39a7e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000600b5d06113869f0@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in utf8nlookup
From: syzbot <syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	ebiggers@google.com, ebiggers@kernel.org, jack@suse.cz, krisman@collabora.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	twuufnxlz@gmail.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17547fd4180000
start commit:   e42bebf6db29 Merge tag 'efi-fixes-for-v6.6-1' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=9cf75dc581fb4307d6dd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374a174680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b12928680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

