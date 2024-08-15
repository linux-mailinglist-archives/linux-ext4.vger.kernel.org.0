Return-Path: <linux-ext4+bounces-3737-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE43953DD2
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 01:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9498A28ADAB
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 23:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F8155727;
	Thu, 15 Aug 2024 23:05:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795D1547DC
	for <linux-ext4@vger.kernel.org>; Thu, 15 Aug 2024 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763105; cv=none; b=AkDg9G3qotvdHmhqG29Eh3Jtwy5r+SRJnecw97jOyRLR9o4PhQ1fdHZB1q1Ff8DHkuA3rV97kinE+pX0UKpu0z/bWcF4ElbxBeXO76ov7J27/+naaiVkETQ/09GVLfpfBVtKWD1RlmM/hoKCCQimJL6BFo8eYPg/ZF3oydiQkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763105; c=relaxed/simple;
	bh=YJy4lc1bj1TYf7510AE8IFXj1VVTCYd0vazW6/WlNzM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=odjNWRIrVpITh2kdHmmL8hvkDWIiRF3+YZzYjn3S1JKcKgs+yIPCA2my8ALbIqdDZy7wbunWzH66Qcwp6sMg3JoPzMWgsKqxMvSbJT4ul35UR/Ny/y2zoRGXv/6E/tcuDmDYOBb0+LnnDaX9WkUfYG/CEkAR4z4+moImc00crRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39b331c43deso15614555ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 15 Aug 2024 16:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723763103; x=1724367903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+8ExRki/2mPUy45OfRjcI1ar0bT71rPNzcqjBT6Qbk=;
        b=QydCCrJ0rzXbtDMf8NxxuiMyulyPcQpu+VmpWPrTOqhhgW5YZe5+dHNfNWmEGsYNE7
         qnE1G5l8orEOhtPQvmNy1bEM8VAu7T4ii0rMoRoPv5qTFZLw/Rz3Pz7Ba2S3MuRU3F6P
         sL9DEu4cpEnS/JPhuyOIjoHhsHXP3p0wK0RqRXpbV/EvZuPozqOHpfKE6z8FiOF3QUpC
         foCy6VPW0y0w2L07rgmrFlv1Ve8AWGek0YCP4tEUKPYa0TOcreAOIhQv3tWZFCceJMni
         apl5EaJH3D0g1t8k/Py2A7+xX+JX9ZKwE2VpFpFrrq59kmvIEvOSQHUY6wy1yJ69OTmS
         HpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGdILGD92umLG2RAtYCZ4BDdfF2qoADFtpR/RrwwFyVCgx86lvIrz5fhUmK3SaEf16BL5Drwe++rZ00AO3afzDAKX4r82kOvASsg==
X-Gm-Message-State: AOJu0Yy0M2if/8BDmjQk1+xW27zdpNmgBQvRbU4zNnUzynx5Km03AocA
	v2qaAANUStHP+L9MV/Uqkfp4JG50bUX/2bLyR7Yn8ZVQs6wPpLInbKPHg7Lu47VGtrAxFscRXm8
	S0JqxtDMgJ+kRNTOnMoZppFvaUyjeFdBPe9ZHkW4yyxImCyXDRVVpA/o=
X-Google-Smtp-Source: AGHT+IHCqUKgyfh4Glqj+SXRyQpWyEExNQX1Czm9+5oSoupX7wou9+kboOgmqpPSXFZKftq0jlheM9d8RbO0QawuUZesZUlWmtk/
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:39d:1236:a9cb with SMTP id
 e9e14a558f8ab-39d26cfe4e8mr1100085ab.2.1723763103022; Thu, 15 Aug 2024
 16:05:03 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:05:03 -0700
In-Reply-To: <Zr5+SvVwqIWeO75m@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ed636061fc0df15@google.com>
Subject: Re: [syzbot] [ext4?] divide error in ext4_mb_regular_allocator
From: syzbot <syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojaswin@linux.ibm.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com

Tested on:

commit:         e724918b Merge tag 'hardening-v6.11-rc4' of git://git...
git tree:       https://github.com/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=123767d9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=1ad8bac5af24d01e2cbd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c916d5980000

Note: testing is done by a robot and is best-effort only.

