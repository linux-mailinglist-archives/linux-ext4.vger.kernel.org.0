Return-Path: <linux-ext4+bounces-6674-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAB8A540DA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 03:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022E116BDF0
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51132191484;
	Thu,  6 Mar 2025 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdasg6Jx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF627453;
	Thu,  6 Mar 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229406; cv=none; b=PT5fsuou6PdN7CnlGfXPNBX+2GNcZJhjFnpjZ7D4NJBY7fRj1RLhaOfBq6GC7DrKa2sbxhtuwYJSGejq2BNWKW3GXvHZ1M9Hfoy9ClIC+jHbovWDQmPvI26rqWWzaFOZJwk70dKQ/1C1ISI5WRn6KCf5NHD0+cn2oDlWHs/o5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229406; c=relaxed/simple;
	bh=/OX7XNJ2dteh0D+EJ3qFirkKXqVkOK37Z1THCfyZs7E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OAhh+XDk1Vb63gPwNndqJH1G4EQP0N89QmOlEKKC1dMEdcoz2mKZp9Z1gZJRv38rp3xT+EgkydFC3ku3PKZ6fbCgKZgfW28013GBPEpc2mkz1DbzGAELrTzxoPej3ZohdwKNGjM69a371aJE10MRqVfktIYRSy9mxA8QmvjbGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hdasg6Jx; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e41e17645dso2233536d6.2;
        Wed, 05 Mar 2025 18:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741229403; x=1741834203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/OX7XNJ2dteh0D+EJ3qFirkKXqVkOK37Z1THCfyZs7E=;
        b=Hdasg6Jxq5U/nW76grezOCInnlio56Lu9HjtW+3qVWna9NJAYNG4y5TLbYuIiI+3fz
         gzW0b5L27PGk5VwmX8d7DvanYjytag4s/0AVqFRnW8YRalI8ecNR96EWpWD1jN4ZLGZV
         BCarvxrJ42w7KtyG04iVf56ETmUIx5KAHAdbAWTusGqOBfvmcOYeNNOXerC4ybEC2J51
         wnMXczkEeAEDTVGTe1IaI7ctfsPwIpYB4Z7Ug8+ipoxOPnypXtx8d0A5fSxTDcQEW1zP
         TDhmRmpetk+em31GLSADPRJJnsJQhjQ9erhJ7LLMKm/MRT6RfJQx7OveZAImB9SJlZEB
         D9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741229403; x=1741834203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OX7XNJ2dteh0D+EJ3qFirkKXqVkOK37Z1THCfyZs7E=;
        b=g+9S2TFazRithQ+I7mpcrHuLGk7FZVEZ1y08N+O/cQT2qsaturDu95JGzwa/6m3f/A
         ndyWa7hx5xhF9pRP1WQHrlwUDRTXxyBl554VaFjMo/BLEwChH+QTO2yytrzjYr/gyISC
         jRb0h7RfpEB6226C+OpDmfpdXwn1w4cHeUipEJjz8lTnG3Q09COlH9M2lUJORteUUBbw
         BsXSlAWXF7+e6PzQthBGrCGOfDOlemTGpclg/KDC3bvEGKT0L10WTybI+28z9KQE/Fru
         TkbDGuoQYkWTaNFAgoO+RmD++pOJA7sXVKot0BOK1PeHOV0SQgSEQBArw4zJx5qW89cz
         QTUA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Pmj9JkwuaErEWnjGUFgbUcH4dcwHczk+MGqw0l8JbBN3Ayp1Ob6wcVFbQLWeIUTa01w2RltBCe881NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtz5H2H0DWvp0NmF78QIzlCQhthJzJxVd73yNLzQy8naJyLP7R
	oM+RF8Lc4C+/WMzBBqZT/IhGvVNVe0eB+aMHXlo1IJWo7yH93qo73dCzaY736LcMmCSaNbo6u36
	ZdLU38TBOP7ISNqjpSiofpzNcfeY=
X-Gm-Gg: ASbGncv2yrj7fuUTp1i7xSnwjKJPd3rui6EMh1ifSFDgmHFptfuDgG0JGmKkgJCbo7Q
	xXlM2arc/8DkPXK/LIjTuYbFTjL+g1m46+QBajLS/jxCy/zEf53n1rQLVctEMaiQpIYIkHjllUJ
	+Swj7RcKYNDyd83jlaAKx+mVMUjjI=
X-Google-Smtp-Source: AGHT+IENbtl/mWDNXh/n1Oro2r9TKFwezmt4nzoY06YqR1+rAcjvkn7ilvNd08+Wi3r5YuXEnSDmZZOx3rLVlBDbgys=
X-Received: by 2002:a05:6214:d4e:b0:6e4:1e1d:10a7 with SMTP id
 6a1803df08f44-6e8e6d13fa6mr82886296d6.1.1741229403249; Wed, 05 Mar 2025
 18:50:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Thu, 6 Mar 2025 10:49:52 +0800
X-Gm-Features: AQ5f1Jro1jD7ecKoa0e8jJ4RslvNgbf8k05LGD_hMY2mf0rVHi04wKr9DKFA8ak
Message-ID: <CALm_T+3QM_YMGV4XZ5ihKkkmbswgLgNBSXhMNHn+giZuz9TW6Q@mail.gmail.com>
Subject: Potential Linux Crash: WARNING in ext4_invalidate_folio in Linux
 kernel v6.13-rc5
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Experts,

Hello!

I am a security researcher focused on testing Linux kernel
vulnerabilities. Recently, while testing the v6.13-rc5 Linux kernel,
we encountered a crash related to the fs/ext4 kernel module. We have
successfully captured the call trace information for this crash.

Unfortunately, we have not been able to reproduce the issue in our
local environment, so we are unable to provide a PoC (Proof of
Concept) at this time.

We fully understand the complexity and importance of Linux kernel
maintenance, and we would like to share this finding with you for
further analysis and confirmation of the root cause. Below is a
summary of the relevant information:

Kernel Version: v6.13.0-rc5

Kernel Module: fs/ext4/inode.c

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

WARNING: CPU: 2 PID: 295 at fs/ext4/inode.c:3210
ext4_invalidate_folio+0x88/0x190 fs/ext4/inode.c:3210
Modules linked in:
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:ext4_invalidate_folio+0x88/0x190 fs/ext4/inode.c:3210
Code: ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85
f2 00 00 00 48 8b 45 00 a9 00 00 01 00 74 09 e8 b9 c1 a1 ff 90 <0f> 0b
90 e8 b0 c1 a1 ff 4c 89 ea 4c 89 e6 48 89 df 5b 5d 41 5c 41
RSP: 0018:ffff888004c2f868 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea00044e1400 RCX: ffffffff8ce543e7
RDX: ffff8881030e3300 RSI: 0000000000000008 RDI: ffff88811687cb28
RBP: ffff88811687cb28 R08: 0000000000000000 R09: ffffed1022d0f965
R10: ffff88811687cb2f R11: 0000000000032001 R12: 0000000000000000
R13: 0000000000001000 R14: ffff888004c2fae8 R15: ffff888004c2fb68
FS: 000055558187d480(0000) GS:ffff88811b300000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002b325d907028 CR3: 0000000007746000 CR4: 0000000000350ef0
Call Trace:
<TASK>
folio_invalidate mm/truncate.c:126 [inline]
truncate_cleanup_folio+0x241/0x350 mm/truncate.c:146
truncate_inode_pages_range+0x1fd/0x880 mm/truncate.c:326
ext4_evict_inode+0x22d/0x1330 fs/ext4/inode.c:198
evict+0x337/0x7c0 fs/inode.c:796
iput_final fs/inode.c:1946 [inline]
iput fs/inode.c:1972 [inline]
iput+0x4c3/0x6a0 fs/inode.c:1958
do_unlinkat+0x4fa/0x690 fs/namei.c:4594
__do_sys_unlink fs/namei.c:4635 [inline]
__se_sys_unlink fs/namei.c:4633 [inline]
__x64_sys_unlink+0xbc/0x100 fs/namei.c:4633
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd4ce0d7b7b
Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc04bc7738 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd4ce0d7b7b
RDX: 00007ffc04bc7760 RSI: 00007ffc04bc77f0 RDI: 00007ffc04bc77f0
RBP: 00007ffc04bc77f0 R08: 0000000000000000 R09: 00007ffc04bc75c0
audit: type=3D1326 audit(1737757667.836:10): auid=3D0 uid=3D0 gid=3D0 ses=
=3D4
subj=3Dsystem_u:system_r:kernel_t:s0 pid=3D4049 comm=3D"syz-executor.7"
exe=3D"/syz-executor.7" sig=3D9 arch=3Dc000003e syscall=3D231 compat=3D0
ip=3D0x7f16c19e842d code=3D0x0
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffc04bc88d0
R13: 00007fd4ce19667b R14: 000000000000e790 R15: 000000000000000d
</TASK>

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

If you need more details or additional test results, please feel free
to let us know. Thank you so much for your attention! Please don't
hesitate to reach out if you have any suggestions or need further
communication.

Best regards,
Luka

