Return-Path: <linux-ext4+bounces-8694-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF059AECB5D
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Jun 2025 07:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309ED3B7C64
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Jun 2025 05:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D21D7995;
	Sun, 29 Jun 2025 05:10:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902319ABD1
	for <linux-ext4@vger.kernel.org>; Sun, 29 Jun 2025 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751173804; cv=none; b=R9qpbJmvpYsBrmnoWZdqHmwDlLirXf8G9VFxrqwujcbjUC0N5p29Oe41AvMj7fhns3S5h8ikMy2ZUXpCOf2PgKHSFu8c2XWyxgde6uMCilCPSOeYDwd+jXLQ2kW/Fd4U358UJ+V93ve6xxiHL7bEiudKPoSQgxx6M/1EQOCPpE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751173804; c=relaxed/simple;
	bh=aNiR3Lw9MNDSlRocyMPoiz+Do8n0Kkd/i/v0ChqN9+Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YRukpj9Mjl8xufJljALtwdkljvRWXzbCldRNM693yCmdxY8y93fyMLswcfAdjqhAPfy+VIttiUudZiFp92oBKIJCM8ffRK1iGBxkXZCYqPJ4eca4afWMQ6Jx1DWDVKesxPx8q5iSeNcMSMIUpWDHdgOVvKcTfMFQrRXFUtChD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddc5137992so13115595ab.2
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 22:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751173802; x=1751778602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfAPSBFodS1baEzZSVSrOtDU6GtBDxIYvoZte8GGu3Q=;
        b=NNu951EU47wtTlbSvE+NheWrWxCN5A/ZE3xeSZ6g/j/UTCkNAvRe9nL56VBobdjRRj
         r/e/FpxRyS+K9yUueJvH2eWtwxixuHK0grA7BcQxhvtqtXMGXpy8Eyf5C9ZnC1mBLjBJ
         EBioeAt79B+utFx7HhrCay32ZffFn45KEOIy4d5U9QtGtX/JL5RieXWWmy+Sn1hgiSbN
         wZhO0L8YfdS8Sj/eJwm2rPPf0P/vRuX2MtTJ+3KtvHF7l3tcQEUywa3EAx+3RMamoSiw
         6jVUlKomSyQYs/S0e6Ue4AnBRc5hxVbE5Ardp2XRVMmxxSNV8lnP90omwK61NvXk4E+N
         JSzw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZgoHJiIfsqHKmFuYZeX/0L19rUOphlY6c7+lsdxGxtgmM3VORZBDcOWBtqTw9jfV3jPJnDy0DBfe@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZRgVZ5cd1tr7CFJrWOBUEBmbN5ZEd+opuHsrV19TgAyz1l7r
	DB6dysBRhm5xhxC1bCuTpIVmrJEYDEHqZ6UrbMZqEzBnLQROPGp6/Dl8oEWUzE1egTX7LZIRc2F
	Pm/9yfhDcKNzt69i6bEx9MxNliEVJivzK3n9ltaiXTprS3dwGkREiAT+iS48=
X-Google-Smtp-Source: AGHT+IF3m9bBlVsKZz0AGHRHyIYQ9S4LRZ3vx30SyuVPQlv33/rFHSqNg/KF/RT1LyGjClooUbalVUkAYG+XvFvDhpNolEOHgkDw
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d85:b0:3df:2a58:381a with SMTP id
 e9e14a558f8ab-3df4ab2c75dmr115400835ab.3.1751173802056; Sat, 28 Jun 2025
 22:10:02 -0700 (PDT)
Date: Sat, 28 Jun 2025 22:10:02 -0700
In-Reply-To: <67f94057.050a0220.2c5fcf.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6860caaa.a00a0220.274b5f.000d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_ext_insert_extent (2)
From: syzbot <syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 665575cff098b696995ddaddf4646a4099941f5e
Author: Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri Feb 28 20:37:22 2025 +0000

    filemap: move prefaulting out of hot write path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1434a3d4580000
start commit:   739a6c93cc75 Merge tag 'nfsd-6.16-1' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1634a3d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1234a3d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=ad86dcdffd6785f56e03
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fb2b0c580000

Reported-by: syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com
Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

