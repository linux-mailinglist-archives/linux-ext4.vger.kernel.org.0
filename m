Return-Path: <linux-ext4+bounces-4978-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A385D9BF179
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2024 16:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0FA1F21C1F
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2024 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728F41E0DA1;
	Wed,  6 Nov 2024 15:22:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9941F9ABC
	for <linux-ext4@vger.kernel.org>; Wed,  6 Nov 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906526; cv=none; b=ZgpYMsfnarHT/4VUgwOMFRzHsmUSadA5zdSiVtkHHd5I9GiHcsnv19pDpV3YKWnC04DuhwCTRDz5JGgDYIfxgJ2+S8gR5/qxbWw7eWrSH7XloRnxCUF8bFD/EOp/1BqeVLWpjRVNQFFZXfvfCAoJOp9/9FfyedhHsstvK4YJ2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906526; c=relaxed/simple;
	bh=hwQb6Bgpzxjusi1sNjee+JRXjDmZXCInqM6lgcIFXi0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RDzeDUm3PhUVSCtdFEij5A6ovFO7DFbRS/pu52XJ7jKQwbZK384nrwz6Wuo3EcyIPXCXzxFFRp0CYAVZIaXokAoWQa42ulNDSaxu04MTb6QFu5SpkmBkIjU2OOfzDab5UqmZ4i1RVCUpSlgR3dEmfIdUSnUidjWZ2Ax9LAOsW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so70077315ab.2
        for <linux-ext4@vger.kernel.org>; Wed, 06 Nov 2024 07:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906524; x=1731511324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxtIZrToYDUsmz51BXFewoWsiGAdqJraREWxLhVJXpA=;
        b=vns4iqkxx0M7KFWm7TfLbNtyp1NW9gRWEGdif9XNJyQ+5Vb98bkmwkFYm6I2ZHwt+Q
         cHIiJmAd6FuMzGdUSRupDq0mxT1080qRMszDUD3aIGFW7Uihz+0uOeLwfUtJV/PYuz62
         N1uBYUBgXhziwtH/UF18uGYrDvNOWVyNI2+gifnXesf6hd2IsiuEY0Jwm2bUwIzf3+y1
         3NSgXh4UYDs9Aucgf+Q6AOwismQ9NffsiIXl2A0q2vYSMekeildaCPFE7E/I5R0+m7xM
         yzEZKQV5sdO2GH/7hF2ddVxbw59+uIwCNgt95vO1vZxhBWL0o+BOaV6C4awM4+pkPwwV
         JUEA==
X-Forwarded-Encrypted: i=1; AJvYcCWIMZINxadO3J5GFXFVxhHOjlcIhR7RAvbcuDFAQyJyPMmolL5+3/i7Sobokj1iUTp6KR0v4tV/jvPw@vger.kernel.org
X-Gm-Message-State: AOJu0Yymuc7BW8XpJDPu0iKnIt25U8rZYSpt/YZaIvYyDzldxOcNTqMO
	6kxcJEBXW9h5jaS1zPRQoEo3+YjVuJDf3k87xt7oeLwC/y2/wBC0F50eq0WnpxQk8ogjmhlDeWM
	vSdM+0xRKNNFTgPHb/yT/nxb4N9gO2oDUdvTuWjho0ksEq7FAFR0n9Ok=
X-Google-Smtp-Source: AGHT+IGB0fuX92rvZS/mWn27iW0EG8h6GUgkVshI6dXgd3sqA8coI/pcSaFgr7mzopz8lL1dOWvuvS+ns96sVHW4jkdJMv2qVU9o
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:505:b0:3a5:e1f5:156a with SMTP id
 e9e14a558f8ab-3a5e1f51a6bmr238666775ab.2.1730906524025; Wed, 06 Nov 2024
 07:22:04 -0800 (PST)
Date: Wed, 06 Nov 2024 07:22:04 -0800
In-Reply-To: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b899c.050a0220.350062.026d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
From: syzbot <syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, adilger@dilger.ca, eadavis@qq.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, oe-lkp@lists.linux.dev, 
	oliver.sang@intel.com, sandeen@redhat.com, syzkaller-bugs@googlegroups.com, 
	tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5872331b3d91820e14716632ebb56b1399b34fe1
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Wed Jun 17 19:19:04 2020 +0000

    ext4: fix potential negative array index in do_split()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b9ce30580000
start commit:   2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17b9ce30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b9ce30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=0c99c3f90699936c1e77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173636a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1600cf40580000

Reported-by: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Fixes: 5872331b3d91 ("ext4: fix potential negative array index in do_split()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

