Return-Path: <linux-ext4+bounces-7213-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A8A86D91
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 16:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BC77B3AC7
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDD1E835C;
	Sat, 12 Apr 2025 14:12:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EA1DFED
	for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744467126; cv=none; b=PV3J+rAvoj7OOShDz393/xZ/Jmnb3Uus02by4mJZe603nK3lIM8y2YYXMLOuoMTQOv/xX+ZAguT7JdWv/11v6tCM7VTqmkyqx/P5ZOf2YjjrP+Da7rPJZS91UMyonMChCwnksKZf/71xyGnleY/xY1rjR81AKekIm+exm+cM6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744467126; c=relaxed/simple;
	bh=SW9baJwU90rv2J08hxwWTXYAPDJHnlNUogyQNt3kCn0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jTR58mHC+gvTXDPhQif1D9uH8E8LbgXCEIhCpNpiRIsRdCQbQnmBklAEGx9MEZSHwZb7efticedrv4joHULS4rF3IWCyPw1H1EWrRqJne3nvLRJq/mouws+f+xaqAAqS45DaNyDEsCAXzJm7IZI8ds30Z8InVDwByGEUTofmRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d5da4fd944so19077035ab.2
        for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 07:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744467124; x=1745071924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVtPfFRZtMU+7c6m3Lu81ACxShZ6xV2tolYQ458rPJE=;
        b=ZfMzuo7V4zkOKpez9mMVZOtrPVkGnhV3/kkrz5hFS1fdAquU21X/koeLKsrD+5chbj
         HochBP2fMdmMbXnmOJC+mcP94/wTqYkBD2IpJ8AvcZ/nGQO2Yv6IJQm0l8K7DLajEZ4y
         eYdZr2pFytf0CSSNL1Vl1V4vGgKrv7dILHT7FDYfbyW3ZFBHI92gnZhQjJJtI+d+Ktki
         K2SZJySVkYk3092XPHgBCn0xGdprIypEugUIg7P5u+m8velCr5hhxgNW2xcfqA/G/lZ0
         sttfvtJt6OM2TRHFAgcsaORNQIcoIN+0iS7bSxmBcrFBkum1m8Uln15Svs9MjJXM+SjJ
         Fw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVctpUMF744IvNb+B/p4fqrgfP1O/OuQefRRStIH+Nt0cEYp6tMKT9D16Q9fFooHPg7jRtMKbpHEAp5@vger.kernel.org
X-Gm-Message-State: AOJu0YxuiX/IYHLaoCWiVtkEow09SU4BLVXGbvQwPnJElcpElm13FRsJ
	kj5MEpw081UVqaU/rjm/O6qKtA9w48vEljKktBbkf4ZJojSZXM8VhhQODX6zz7nGiKNLUAq8kHL
	kjseQ34GLYkLEVDAChukIj6eqifgjOhqMS7HsFbrHzHldoe5Det5/EBU=
X-Google-Smtp-Source: AGHT+IG7VQEkjMn9Fh81REVLoIjtUnO2qusesDv6QWiP6EtGelZywJ0/A6uJ9MaxHB1wgUUFcIRhP/tzWHTQpVud7sauboNK6hLB
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338f:b0:3d4:3fbf:966e with SMTP id
 e9e14a558f8ab-3d7ec265c39mr67322365ab.14.1744467123757; Sat, 12 Apr 2025
 07:12:03 -0700 (PDT)
Date: Sat, 12 Apr 2025 07:12:03 -0700
In-Reply-To: <6702c4bb.050a0220.49194.04d9.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fa74b3.050a0220.379d84.000e.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in
 __ext4_check_dir_entry (3)
From: syzbot <syzbot+09921540dd04aba82a35@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 26343ca0df715097065b02a6cddb4a029d5b9327
Author: Baokun Li <libaokun1@huawei.com>
Date:   Wed Jan 22 11:05:27 2025 +0000

    ext4: reject the 'data_err=abort' option in nojournal mode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15734870580000
start commit:   e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f009dd80b3799c2
dashboard link: https://syzkaller.appspot.com/bug?extid=09921540dd04aba82a35
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102f23d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1082e580580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: reject the 'data_err=abort' option in nojournal mode

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

