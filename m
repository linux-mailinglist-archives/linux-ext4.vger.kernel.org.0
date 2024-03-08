Return-Path: <linux-ext4+bounces-1574-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC018765F9
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Mar 2024 15:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77641B229B3
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Mar 2024 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE773FE22;
	Fri,  8 Mar 2024 14:06:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C13FB8D
	for <linux-ext4@vger.kernel.org>; Fri,  8 Mar 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906767; cv=none; b=jZsTowuz9nHzYG5grgONA7nL7cO92P8YZj/xvJGU2wnQGVbtGO9YFCpk0kv1vp9amPpPo6LuQrTCr1P9aI8q77Fzo/UiaKjNM1IigqX8xzWlpTBv4KlcJtXjNhzn9SVMKjocyMBq1xEeedLzIvJiKum6cMyHj1frG+EUTsups0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906767; c=relaxed/simple;
	bh=zNrlmpuYJ8G3ByJX69mziNbz97dnw1BgMjXDQs2S2wI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m+VI+XrY10nt6ZM7VURkBqLByhCEeIUDyyxP4XJI6gdeqsGdrxieQ4ZH3wqqeVLlUhJzCYzQVRIDlNvN5knIfwoCRzx5/vM26yBVlRQOcW3OjdTvXmbH+h9aBEoAF23QKzOefXs6Yu61hh1Th1gqJLXyvyKNykyqJDIp9cg87e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8414a39b7so150067339f.0
        for <linux-ext4@vger.kernel.org>; Fri, 08 Mar 2024 06:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709906764; x=1710511564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvlBPUPaepY/McwwPG60npSspOFuJcNnGlH0w8W6gto=;
        b=jA/iclt6GaZ9KoOOfWAMgR7girAfATwvLh6Jzn0Lf680rPz1flQ/fV8G2DH/GYqK+F
         8Bc79elUKxhsrAnUPv7LBa6h7IsdFNOWWT9JJ2EUhSUIxt2Xgmrn1et/pG6rvlbzcFlX
         acIjDIfkdppfWYB7pJn97oqNV62cKQ6KabzTZAzM+1x1Gyqz13lU7bnm4YkiGl0Vqszw
         P01obD+9V+1flDotlUfjcFvKYZIeRTycUpUYHSrQeY4LR9Yot8ScMmiOGEVkD4P0fQhw
         ke08cbbbfdgZ+gn4guTApPbQVRbkXGcx5a4g5udm+MchTdSlgxYX0cgqK0WJf5Qmkpp3
         kdOg==
X-Forwarded-Encrypted: i=1; AJvYcCWRbRrkxH15rTB53VGdVbfraSfqdlxwDsTS8H8ikS9+mWxEe3r1lruifgGvsdHzXyuWPXYqJHHjvszCZolNWBGk+2HdYg77SwA1mA==
X-Gm-Message-State: AOJu0Yz1TxCkctwoYkT2xylITl/1qsAFWqvdnL2gED61lsVd37VG5Yr6
	9ewlpnjeCxbonad6gJs4Fk2zfXIA3ME2fzrI5VtdpPXkJXRxi++DgczKa5hPyK+fa3wfQ/Oedkf
	YWFLgEoY2rC4Mz7Jhv4gwPSvB37BPqFQF+aDc7GnErwDy/IGVx+AsmEU=
X-Google-Smtp-Source: AGHT+IF1WLhPpfhqCphP2CD7iN4hnYxZm1j+JuQK/5RtpPGczjcKUuxFnYYjuIv1GYRpdfCn64PfCc7DUclSl0eWcsRbgc5nfjvG
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16c2:b0:476:beb4:7470 with SMTP id
 g2-20020a05663816c200b00476beb47470mr4277jat.3.1709906764014; Fri, 08 Mar
 2024 06:06:04 -0800 (PST)
Date: Fri, 08 Mar 2024 06:06:04 -0800
In-Reply-To: <0000000000005b767405ffd4e4ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044b90e061326b102@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (2)
From: syzbot <syzbot+352d78bd60c8e9d6ecdc@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	elic@nvidia.com, jack@suse.cz, jasowang@redhat.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, mst@redhat.com, 
	nathan@kernel.org, ndesaulniers@google.com, parav@nvidia.com, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f08e0a180000
start commit:   610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=56c2c781bb4ee18
dashboard link: https://syzkaller.appspot.com/bug?extid=352d78bd60c8e9d6ecdc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a4d65ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1715ad7ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

