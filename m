Return-Path: <linux-ext4+bounces-4244-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09FC97D9BD
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2024 21:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D4D282DFD
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2024 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5F317DE06;
	Fri, 20 Sep 2024 19:06:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC92383B1
	for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726859164; cv=none; b=PO84mefk6AkgSVxrTwb30Ms4fY6ClEbTbzES4oHIE/SVfncSu2aNf5zxMo4QzmZd/86IQV2xiWFSaHNFK5mDm685EOOl1iDB0jL4PzLwFyz+XR9lBcuLg5PZFw5wfscgtLKUWiF+ujvjybZFJ89ciSbRoX4MQYR7nfdP+K22ZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726859164; c=relaxed/simple;
	bh=ZClcruaHXzbCXilN5gpeBeg5BdJWSvqQCgujFKR2ov8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wiu0uJ7Gaegsn23Xu3e/JP1bOGTEfDOVaFNuEcNmjgTC+M2ne8/OD8pe8u0lA07CI4JslfZ9Ro1TvWMBM2JdZWhSqzrvIOOKpjVzG6wjbIWd/o+ZhGWCSdROzee76oOGldxdWAsnEytaP9tHrz5DPeNh6Et4Ta+ml9rnbjocPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ce92f8779so246445239f.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2024 12:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726859162; x=1727463962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUf6CGjR4bWSGj2+PQOxtIYx6vWyI3WMtK3UwHwb85g=;
        b=Ws6O5cJELnyTh/UgTenZJRDaPzHqebfBcuHu3PxnNtiM8V6shqHfetbMhBIuKfzBXx
         1nQrwEIGhL6YCNZDApSh0YpcXRFiKsifgKoVeuRmIG3hUQu9nBvi/yWsAfYtqQ3BSKOB
         lWZQO6+BWaUFz4PlWZiISiyPrRNdXCAJ2KwKQpVPoDXCuczg9kf2IQASbaJL6fnlOsUj
         iguFDBGBt/rRLGKKBmr4L+dfpwOXvX4A17Ac+bl2tlN6aP+UM5ygR1W/HIcko0J5943l
         rmdH4GJCGz4DfFxzJWyoEtm5dQB6GyD7zGrwCx7DF77eTv3HyvbXosBmN6iXpAymvI5q
         vEBA==
X-Forwarded-Encrypted: i=1; AJvYcCWkp66z3dph/nxPoIs3TpdI00Ggnn/TgvxQu2coWSw1uZDXsmiHHx65l9tg3mRyBfochRiXyJMgOcaC@vger.kernel.org
X-Gm-Message-State: AOJu0YyIU9luOaX8EIIPancKfMBxEa+TKoWyP/Coxf4v16MQWXhLCJVe
	D3j0TC+YdzyNX49Ig6RE5hP6Y8fx2nO6FzuxCePXNSuitkpR+BwZkrpB/McKtDXlT/A/dvOur/C
	yoBHQuR2REn+ujPjUAHVyDagLoBAMn1cKADST4BUNmkthYsDiKr01WPM=
X-Google-Smtp-Source: AGHT+IG1hoyGre/j6uvxWbFCcktiEEGo2p2sZKmOGbXrZKIDn00siJgnoZzKJXTwK/2nQSjEHlbmh6LVxOAHL5SyZEdUvibN8dR9
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1546:b0:3a0:98b2:8f2a with SMTP id
 e9e14a558f8ab-3a0c8c9a3eamr37091595ab.10.1726859162172; Fri, 20 Sep 2024
 12:06:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 12:06:02 -0700
In-Reply-To: <000000000000690606061ce1fe7e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66edc79a.050a0220.3195df.000b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_stop_mmpd
From: syzbot <syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com, 
	harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 21175ca434c5d49509b73cf473618b01b0b85437
Author: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu Apr 1 17:21:29 2021 +0000

    ext4: make prefetch_block_bitmaps default

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1427bf00580000
start commit:   4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1627bf00580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1227bf00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25
dashboard link: https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fbd177980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ea607980000

Reported-by: syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com
Fixes: 21175ca434c5 ("ext4: make prefetch_block_bitmaps default")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

