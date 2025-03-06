Return-Path: <linux-ext4+bounces-6675-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B56BA540E4
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 03:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA4B188E38A
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA67192B96;
	Thu,  6 Mar 2025 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVfiB9i1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763261917CD;
	Thu,  6 Mar 2025 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229837; cv=none; b=N1aqxfHZ5dvuhVxxc6LE5/KLIvjfmKWhY0qLRbppacx5OntMBJo4hJmvnpJcxXmJdESfPbLFfqjh5GspD1VFQQYMtCDqwBlP9e0nK1fm1TojWv2O5JkFU7wm2+S6dYUm8VMeJ6/FS6gDqaUd8TL7ubsAYVhTXU22Tzn64PQoV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229837; c=relaxed/simple;
	bh=BIoD5qFBqV3yEisDpxx4/YCUOyVwNYqDpjwUtc0cVs4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jFrWZotK7aXKK2QQt6ddtC2IU9QmRvD21LGut4G/jRXrPMbgLph80Z+pkbvgmJJqlzvaIRrfwPSAw293YjQMPQin4i0DzCpUQcAXzrePGpMNdoNiopgCF/hPXU0VRzAnkAl9/sFamejHLNWg3WZyRxjW3kbMoWW0FFCBdEDG1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVfiB9i1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f916e75fso561146d6.1;
        Wed, 05 Mar 2025 18:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741229834; x=1741834634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BIoD5qFBqV3yEisDpxx4/YCUOyVwNYqDpjwUtc0cVs4=;
        b=KVfiB9i1X1gIO2qKQp2rFlph3HnafapVXd+yH18ZAF0kEQRvjvqMb+qBGAMIZVlBnz
         eKzYQjSZZyGSqOfTuROFrwrBN1MMjYh9jHZfR21ak/mTS4qJvjqPESbDqJV5UWD1dtMu
         FjtpJ4gTNEjKhRrRIK884tJKc6jtZ5rB9MoQK+hIR+WWQmVkoBvsSVRH1IbcZMwB3nS5
         oCPVAriv3wu15FZUkCdB0bCcfPt/a0DbJkQ6BbFfhes/1fJU/HQBmh9VyDjU8uT+GCwn
         mYjgIihE4xCKvPuf+HzPx3Q3cvMsygdUaESAmmwrtle1RsOUPVSf1BZtIzC6v0laPzXO
         Ff4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741229834; x=1741834634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIoD5qFBqV3yEisDpxx4/YCUOyVwNYqDpjwUtc0cVs4=;
        b=Q+bDUF5rLZ9YncQikvuuyHcuCgjniV4h7YhIlLm0v1ED9WflvPCtLodVOmT2gPwk0z
         GLDQaLdZ67+CexXFhCMkoUdEQuedn8AUjcNzkA5Lt43Jnds3eMbn6ARjx2vi/DNncZPk
         rfSe6Y5z1E0TLVSrv5oQXPU8mzc7+WkWVKTIHL/tRwGVC9kHoUlcsmWumM81kA2urQ+k
         +2vqpivQhKNsgix3znhifpsqsPHQKsAZV3u4UhHiAxLmR2krDedo1WGwy9kF5rdvVDwV
         GD+bUiV1oVD4Q5yQEzfVYZ1tbRHQlP9VbfLG761/USjrVAQ7rfvvTZmmHM/q+ITiMyER
         ykTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeo2ksX7KESJeAyy94ppfiLhaBW7UuxTGKv5nXgeiluzTqoLsz4dizI88q93mb1UVxA+wVfxMlVoZnTCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8r6oofHPLwjdRUMxFGpz56Op6SE4npruk9EvmR7rSPuzXuUf
	pIj2ttehcY1zOLPwOjmohfk1IFfXR6sUHp3ec0R3tlHWFNW4Ddd/cSVxoaQy6WkdshR4fSjVsPd
	ZNlhuK7JCSC6+GVoejHjJnheCjXU=
X-Gm-Gg: ASbGncvYTJ5xYk8+bvfcio780NEoSCZdriVs4TmISxJDkD1NcDQFCfrAzLrS0j4yUb/
	Fzy3AQenwbZKKFi+j3vx5YZ3eUK3bRUJR5szWban+h73r2d5XM4MD5/0xFw/ISBTyDGVq+VBsFU
	mIWkslyA8Zxov6c7mDfDUo7Is4U7g=
X-Google-Smtp-Source: AGHT+IERsCQhMrMDQqiU0iMtB+EOtLrzwRivbZlA8p4pPhF7SFuEXGE5Z9cWmLhyVxI3328TRXCA9SPQuLFK9lm8ZeA=
X-Received: by 2002:a05:6214:226a:b0:6e4:4676:85c3 with SMTP id
 6a1803df08f44-6e8f46ee9b0mr21341716d6.11.1741229834208; Wed, 05 Mar 2025
 18:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Thu, 6 Mar 2025 10:57:02 +0800
X-Gm-Features: AQ5f1JptL5EJrqDc_1_pU2JegQ78qmQFCHo74lddduwHiHN5qg3kjwag_N8l56k
Message-ID: <CALm_T+1DnSQRHiyO3c1-H4rRnBJHKRMpfQYQMGN=yZROm7tYKQ@mail.gmail.com>
Subject: Potential Linux Crash: KASAN use-after-free Read in
 ext4_ext_remove_space in Linux kernel v6.13-rc5
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

Kernel Module: fs/ext4/extents.c

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

BUG: KASAN: use-after-free in ext4_ext_rm_leaf fs/ext4/extents.c:2623 [inli=
ne]
BUG: KASAN: use-after-free in ext4_ext_remove_space+0x3401/0x37f0
fs/ext4/extents.c:2961
Read of size 4 at addr ffff888116add7f8 by task syz-executor.5/9417

CPU: 2 UID: 0 PID: 9417 Comm: syz-executor.5 Not tainted
6.13.0-rc5-00012-g0bc21e701a6f #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x7b/0xa0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xce/0x660 mm/kasan/report.c:489
 kasan_report+0xc6/0x100 mm/kasan/report.c:602
 ext4_ext_rm_leaf fs/ext4/extents.c:2623 [inline]
 ext4_ext_remove_space+0x3401/0x37f0 fs/ext4/extents.c:2961
 ext4_ext_truncate+0x1c6/0x260 fs/ext4/extents.c:4466
 ext4_truncate+0x6bb/0xea0 fs/ext4/inode.c:4217
 ext4_evict_inode+0x64c/0x1330 fs/ext4/inode.c:263
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
RIP: 0033:0x7f381a667b7b
Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec5a26028 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f381a667b7b
RDX: 00007ffec5a26050 RSI: 00007ffec5a260e0 RDI: 00007ffec5a260e0
RBP: 00007ffec5a260e0 R08: 0000000000000000 R09: 00007ffec5a25eb0
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffec5a271e0
R13: 00007f381a72667b R14: 000000000002b7da R15: 000000000000001d
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

