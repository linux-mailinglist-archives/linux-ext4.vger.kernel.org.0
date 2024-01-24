Return-Path: <linux-ext4+bounces-907-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407E983B23E
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jan 2024 20:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975B0B23DF3
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jan 2024 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B52132C17;
	Wed, 24 Jan 2024 19:21:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9213174F
	for <linux-ext4@vger.kernel.org>; Wed, 24 Jan 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124067; cv=none; b=TqxoYNykASqpvvsDpK8N5VgOitL2Ik3gshYypQZ6wQYZfrh5NUS8BD2Gv3gDVvbkBy0amR4F0VNhdyWu9VI0kwxQxOMialfOhqfFWlSrZTxB8NBoQ77bechbU69/ART0EW6Nc2haUbo0d/krJYJAh7BGcXiKp+C6q7NTdph7DLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124067; c=relaxed/simple;
	bh=c6WFIf+JHlsGEfzQEZQLoJIP7VaM+Bmu6MrXa+u4PA4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XV4TBsmlYQ4ylAf/Zq+x4AB0ia7ydFdR3dxKeLin/KXBhWz2VCtstb5CW0FDaf1BQ4q3naUZHVsnC5t/1PrKBjv67AkKbZHzrU4mgDMuAbPfyk7lJ9XBjLa4/pyvoeohVWptLXrVc5M7u36JJtlclhJvxsetNCDbKnGgLZkynoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36279aecbb2so30352405ab.3
        for <linux-ext4@vger.kernel.org>; Wed, 24 Jan 2024 11:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706124065; x=1706728865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7uAoJlJc/r/AdH+EKRBB9ocEe4x/wXE6PggxylocZs=;
        b=mq87F+l6Cc/FvrTsbfiIHutiV9a1s0kAEfqae1AUuAVjh/ZIpkcWfFTiVdcwTReIrz
         lP0md/sSyMDc4QaoR+JIQvrSPA+p5kZgSb/lrVTg/LsHKjj13OGtnSsm8ocMSFPYlZsO
         OH+nBly6Y4qpSxdUciWW1z3GsEDcIwNAlwelUXzszzT/BIQ2iYL8IfHjIi3YWDanH4l7
         FO0nhxMeh0eGK1fYwkR1FLISGG1Tq+QrFrNDbXsKQ9Ea5wnW2xqPReLO5vcyLnsAZOvM
         Z/NrSkuz1N1wC83ttllWQOh7SSmh9dKpSZ4ZZPagKC1khx+kvwR3aIMTfiMt5mt+6gXZ
         On7g==
X-Gm-Message-State: AOJu0Yx5zhl9ourFDGG0kQafCGOYL0NDRc1xarOHzcTKJhmSscn6iPzc
	0KNFrMfP2YHczNS4O37TJP5UdDF/p2g0unxW1JoQpdHbUKLGu491vTEPs3mgepBQoSp2cxEEN+m
	8MGtSgrRUYgTmlUr94S6VCP64e9J/QwLU6wbcan+uolgAKvJSLkKYWcc=
X-Google-Smtp-Source: AGHT+IE0i10pqpyY8PAMZM/n2o6EisAhLNFNU3MnVtH68x+1q+ebTb1VrFJvegV2R7EiIEC4oR8hRVnJ+M70p6wabP5Bx+g/3ZW9
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bcf:b0:35f:9ada:73a8 with SMTP id
 x15-20020a056e021bcf00b0035f9ada73a8mr269347ilv.2.1706124065104; Wed, 24 Jan
 2024 11:21:05 -0800 (PST)
Date: Wed, 24 Jan 2024 11:21:05 -0800
In-Reply-To: <00000000000099887f05fdfc6e10@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7ed43060fb5f676@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_split_extent_at (2)
From: syzbot <syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	yebin10@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102ded8be80000
start commit:   25041a4c02c7 Merge tag 'net-6.4-rc6' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=0f4d9f68fb6632330c6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b3bc8d280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

