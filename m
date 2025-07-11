Return-Path: <linux-ext4+bounces-8937-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C633BB01BF5
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 14:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47F81C282F4
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7F2BD59A;
	Fri, 11 Jul 2025 12:27:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D329B8EA
	for <linux-ext4@vger.kernel.org>; Fri, 11 Jul 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236824; cv=none; b=Jprhc0SDetVJo0zR97ItJdqATfgnQCLqhHJdzPICXMfL0m5NceozkH5Lcxap6Ls9v+gOySyP+kRZ57npSXUxlbG161T3vYAimiLG4lbB0C9ACvd9wAo6JLmKPTnIkEVbbSkbMP799pkySK17wmW2hSD25QoMnuvk9UCzVA1ynQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236824; c=relaxed/simple;
	bh=5RThLuz3tFL7phwFf/QiuipK2M04eM3fXnIvO+PM6js=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UeH0dQ8TDTeKDv7m1AleoAn2H4v1nbl7LgaSefZxxFG901dAIWPYRHLGgwJqFVm8OZaLeHz4zC2oWxfqP+84jmLCrDvCznvClm2UDuPmC67X1fLx/FiiITX9ImwKe/q/pwNX5CiyOANqrdJAEra+IVeMVEF2ufTRRqNoeCgIxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8794f047611so212799939f.2
        for <linux-ext4@vger.kernel.org>; Fri, 11 Jul 2025 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236822; x=1752841622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLiCgbUvpuHgSzedG/d0dkj2/LzDFoEPV2dlBZwd1TU=;
        b=NbP3biMfEeExgy/g/fYCNzvmZher9X4c5LFSnR4mc386ouyRk2psJbIfim8w45lHm+
         iO6mFLi0W4RgYivkHvejuNHvY8MRZPtAcDD4e+qLATm37ez/7Tq9j5JELW8rBxkzV8+f
         JBxSv4k2QSjGgQ9+ee4rZLYf0S3rz4hUlLkOPI69rtTzrBS/6AqXk7w2QxG4ZCVfOHDg
         u2f05VA430y/vCQWFd8cAIdCQ8GnVAWJGQS8z8rdERh3EhroP5i5qVjpKv6LdRsSpdLn
         YfZ6MiwLBRloObJbnmGt56HmlVCvEHve5IOlAw/meddcS+7d+HiR8W/RL3GU5/95u7R9
         uo1g==
X-Forwarded-Encrypted: i=1; AJvYcCUg39i1FlBkrd77Vlxa67NWtoXt6dOWg/MuXAurKEEF2ZeWZigVK7+ZW/M9Bg5bujHoe64HYhBqve05@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wSJvvs9gqdAsB9TJ5G9wSVrocbw+LFNcB0tUXx1PK8CllOJ3
	wKInYAouyIZiItbI+zzXYEHZ6utzRKRGJzGIk4JksIAJ1fZoRJ3IeDf8cSXSHOZUTe1TP0Keg8H
	SC8zDZV4PHSTkAL3MjM3/AY7JDFDJy+mClpVxS+SPHBAECaUBkAxk+7w1SXU=
X-Google-Smtp-Source: AGHT+IGRhMJOZvny5MX2PRrEbROR2nl61a5ERscS0MwH2MJL0/EaCuaUyH5lY/Hs0+U19HgsshuS2Lmy22Yo/U4JhtOYqknQ/OW7
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:b90:b0:86c:f2c1:70d1 with SMTP id
 ca18e2360f4ac-87977f521e7mr361411839f.1.1752236821815; Fri, 11 Jul 2025
 05:27:01 -0700 (PDT)
Date: Fri, 11 Jul 2025 05:27:01 -0700
In-Reply-To: <686a8143.a00a0220.c7b3.005b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68710315.a00a0220.26a83e.004a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in bdev_getblk
From: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, anna.luese@v-bien.de, brauner@kernel.org, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, libaokun1@huawei.com, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.raghav@samsung.com, shaggy@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 77eb64439ad52d8afb57bb4dae24a2743c68f50d
Author: Pankaj Raghav <p.raghav@samsung.com>
Date:   Thu Jun 26 11:32:23 2025 +0000

    fs/buffer: remove the min and max limit checks in __getblk_slow()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127d8d82580000
start commit:   835244aba90d Add linux-next specific files for 20250709
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=117d8d82580000
console output: https://syzkaller.appspot.com/x/log.txt?x=167d8d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8396fd456733c122
dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c40f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11856a8c580000

Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
Fixes: 77eb64439ad5 ("fs/buffer: remove the min and max limit checks in __getblk_slow()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

