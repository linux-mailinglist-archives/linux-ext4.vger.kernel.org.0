Return-Path: <linux-ext4+bounces-6664-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C88A4E8A8
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 18:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D18D8C4349
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5BE296155;
	Tue,  4 Mar 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSz0Xm2N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C0264600
	for <linux-ext4@vger.kernel.org>; Tue,  4 Mar 2025 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107299; cv=pass; b=Tg56HqVk+5O/i+4jnT9g6OFN/6clcTYaD/MKM9a75WAgEIjBwDlR3Njtwh51d7Bau8oCqVhzJ0yAR3Ttrvac9ZhcraZqRgQaGxx719qU//G/YqQncjW/NK66+lqe+Nrk+/L0k3y4Dat1H4ZlwPadYXbaXn2t+DrLdb2pDeTh88E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107299; c=relaxed/simple;
	bh=jv8QNOnGRtS9x1BC651dA4iBv2EFIu2vDnFzfk0OtiM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ianS0aNa3dTatsz34MFrHf5RHKdv4wH/DCOwMoqIPhY0AtxpGW8Oy4Jo6F699rQYsr/37PtnG38Eam0O0WUXPrYwCUPrynr4Xe6hLVPAYvHAViTp+CRNEvW9jJyaEq7Cq2MzJf4mSf2adoB5+AnZMeO61vFjtSChw8s6NIJnhAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSz0Xm2N; arc=none smtp.client-ip=209.85.160.43; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id D0E03408B65A
	for <linux-ext4@vger.kernel.org>; Tue,  4 Mar 2025 19:54:55 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gmR6qw5zG2fM
	for <linux-ext4@vger.kernel.org>; Tue,  4 Mar 2025 19:16:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 796E742720; Tue,  4 Mar 2025 19:16:38 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSz0Xm2N
X-Envelope-From: <linux-kernel+bounces-541264-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSz0Xm2N
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id C303E42495
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:24:37 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 729422DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:24:37 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A81170804
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F41F12EA;
	Mon,  3 Mar 2025 09:24:24 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84B13C8E8;
	Mon,  3 Mar 2025 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993860; cv=none; b=ZRwPMXqDXOLlv2hXmFimfD5QGhN+2QQdz422lcvnoxLnMhT3lWYsx9r19LsNerhjWUS1c3KLaw+qJcSE23byNl9UTASnLC0YIJkpyOziVZDasfZ3jl3MVNED6utBoeMYyiN/JQBY4HHFbZrHpNu6FUtU0a+iUz4os5jIherSNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993860; c=relaxed/simple;
	bh=jv8QNOnGRtS9x1BC651dA4iBv2EFIu2vDnFzfk0OtiM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=K2s6KcjyMRCesLhee0K6ExEh+FR4KmDB90JGg+42/ZBj6lrr6FAcF+GVTctnWLAe/7sbm61rGar8kuftqDi9+e+Rn+HF5J5s8FwIOgsNCo4kjUC/mxCI3seO1uxTk59hrCTGip5x2I3HSs5MqPcDvmDZzTl3OwOk1f0GnY+Nvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSz0Xm2N; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2bcc5c887efso2066605fac.2;
        Mon, 03 Mar 2025 01:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740993857; x=1741598657; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=StT21v5HBuVlAjcwwtmfuWVN4spL/bYiZH8r7Pf+vYo=;
        b=FSz0Xm2NA0m6Lpi7CnMZ46yRlBFoJAesydVPriutGpuCBlejgTZaTI8tin/9WZDHFp
         zbcKpdQbu2LNyJupQklemscxFkq64wTLYcJL6NcWAv/i9SYpYIbKc2gc4ZFNZRCfgTcV
         uMLj5lFr8kJPozdy+xg5J6soTRlIOEm0oGv5vM9RfkE3+JsCeWIMHIR9p+r9jdVu5s6x
         9nsp5W5ESIPIPjpAyzW5tjip7s75TPHKkXl79gjA78Ky7n4ybLtSE6bzlLUHTMN/Lu9V
         yuONhIwprbgUb/G1kPGrEte3QEWhWftx4j2wBx9Zh9ShYgbf/DkwvNAne5KMgwXDYEV7
         5YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993857; x=1741598657;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StT21v5HBuVlAjcwwtmfuWVN4spL/bYiZH8r7Pf+vYo=;
        b=HB0io2UYa1Io9OSumzKTcCaY/zOhnDzjjS+1N37NvZBQvyohC36Ryx7Y31iheZ0pej
         VnlSAue7VOAGe/s5y54z12sHF809Mme88L7LR0ygGYGSiwYVCnBp2Dg0uFnab9Zrapj2
         8vbVoeF8vuhciCnJp3JBeaqydGdzgS3YERGLcCtLrrFdIJl/+3qp5XmW0b3kwnyyyoyb
         1JgKxvRNgNo64ekchn1jCBuNgFUON5kHPheF71kxAi5mkfe8yeZNdBWh8DGpkb5+IQw9
         qXKVJ6pv2vcHFpRfDsLI7O2Tt5jkKooJQwAB/nXYm1wS0B9w0DKnJNJwiaf7jXqjykHs
         zRMw==
X-Forwarded-Encrypted: i=1; AJvYcCUX7Dq3ycgFdHDF8Nfx+WtePqJMa4QZM5Th14SUghj4KD/l/mvgsA0HrA8QpfVUEfYvKJ5PvRcF+/5sc5KY@vger.kernel.org, AJvYcCWs0W4BZOob2J5UF0XCTQnMi4Dc+8InQApZeGjZv1SBoNIqm8fNsE3Oj3rIuvGXo3a6SDer/vIfna2g@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9ilaHwGpnVCyuU9QG/6wtYoqqJgP7SM0iybkQyb0l0vHcM4p
	f4Vrl/vhf3ooKXgRELjqWeAxJHgLLDRI/rJOsY40JVPr3S6PQdxIpXLqV/gBWpm2+Tf6qcl5HJ1
	RHTtvK8ubqQU4WjFPbOs/vHFMeTc=
X-Gm-Gg: ASbGncuouSb6g7z2bnA2KXt4J4/lJX9a2VplfPf8ZKaopHcaYqGWBRh98q9evJYuFqJ
	cI218Xb2IGzAjJyTPmSbSrHxKL/x0LULoeXfFA3y6tVPqH6sG4ImY4IymUb8qBXaDUx5GjNlvLY
	Rz0u5swBB6rxxC+zOFgVUQKAER5A==
X-Google-Smtp-Source: AGHT+IF16/kJli1v2uTtADRoHDtMAoUcPO2J+zPdLjC8SofWOkXju3fPYSbHZB7Jnjo8/j/zSdOmfzK79E/Gia8vEc4=
X-Received: by 2002:a05:6871:6285:b0:29e:6394:fd4a with SMTP id
 586e51a60fabf-2c178317c67mr7686734fac.2.1740993856737; Mon, 03 Mar 2025
 01:24:16 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Strforexc yn <strforexc@gmail.com>
Date: Mon, 3 Mar 2025 17:24:06 +0800
X-Gm-Features: AQ5f1JoPn6AnvkWK8AKFf6LPWhDzHWifc3pnJcAlMqH7z6CRxab0PmEVW2HxQDE
Message-ID: <CA+HokZqTi7=ossgk7gKqJY_pViaso=Hy0-iRj8v3H5A35Bxhqw@mail.gmail.com>
Subject: [BUG] Kernel BUG in ext4_write_inline_data (Ext4) on 6.14.0-rc4 -
 Possible Regression**
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gmR6qw5zG2fM
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711987.6756@Wg9jMwGX9ojtybakoo9LGw
X-ITU-MailScanner-SpamCheck: not spam

Dear Linux Kernel Developers,
I=E2=80=99ve encountered a kernel BUG in the Ext4 filesystem on Linux
6.14.0-rc4 during an inline data write, which may indicate a
regression from prior fixes. Here are the details:

Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.conf=
ig
Kernel Log=EF=BC=9A https://github.com/Strforexc/LinuxKernelbug/blob/main/b=
ug_ext4_write_inline_data/log0
Reproduce.c: https://github.com/Strforexc/LinuxKernelbug/blob/main/bug_ext4=
_write_inline_data/repro.cprog

A kernel BUG is triggered at fs/ext4/inline.c:235 in
ext4_write_inline_data, causing an invalid opcode exception. This
occurs during a sendfile64 operation writing inline data, likely due
to an assertion failure (BUG_ON).

Location: The BUG occurs at a BUG_ON in ext4_write_inline_data, likely
BUG_ON(pos + len > EXT4_I(inode)->i_inline_size) (line 231), with
pos=3D96 and len=3D97 (total 193 bytes).

Cause: The write exceeds the inode=E2=80=99s inline size , triggering the
assertion. Higher-level calls  fail to validate the size, allowing an
oversized request.
Context: Syzkaller=E2=80=99s sendfile64 crafted a write to an inline Ext4
inode, exposing this issue.
Regression: Ext4 inline data handling has had prior fixes . This BUG
suggests a regression where size validation was weakened, allowing
invalid writes to reach the assertion.

Impact: The BUG causes a kernel panic (DoS). While not directly
exploitable beyond that, it indicates a validation gap.
Request: Could Ext4 maintainers investigate? This appears to be a
regression from prior inline data fixes. Suggested  Add size
validation in ext4_da_write_end or ext4_file_write_iter before calling
ext4_write_inline_data.

Our knowledge of the kernel is somewhat limited, and we'd appreciate
it if you could determine if there is such an issue. If this issue
doesn't have an impact, please ignore it =E2=98=BA.

If you fix this issue, please add the following tag to the commit:
Reported-by: Zhizhuo Tang strforexctzzchange@foxmail.com, Jianzhou
Zhao xnxc22xnxc22@qq.com, Haoran Liu <cherest_san@163.com>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:235!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 12157 Comm: syz.0.58 Not tainted 6.14.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:ext4_write_inline_data+0x346/0x3e0 fs/ext4/inline.c:235
Code: d0 f6 4b ff e8 cb f6 4b ff 42 8d 6c 25 c4 41 bd 3c 00 00 00 45
29 e5 e9 e8 fe ff ff e8 b3 f6 4b ff 90 0f 0b e8 ab f6 4b ff 90 <0f> 0b
e8 63 95 ac ff e9 fb fd ff ff 4c 89 f7 e8 56 95 ac ff e9 96
RSP: 0018:ffffc900043e7628 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888012c251f0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000060
R13: 0000000000000061 R14: ffff888012c2579a R15: ffffc900043e76c0
FS:  00007f2c042b2640(0000) GS:ffff88807ee00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc99327fc00 CR3: 000000006a448000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x25f/0xc20 fs/ext4/inline.c:774
 ext4_da_write_end+0x201/0x2d0 fs/ext4/inode.c:3080
 generic_perform_write+0x51c/0x910 mm/filemap.c:4204
 ext4_buffered_write_iter+0x11a/0x440 fs/ext4/file.c:299
 ext4_file_write_iter+0x350/0x420 fs/ext4/file.c:717
 iter_file_splice_write+0xa0a/0x1080 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x194/0x6f0 fs/splice.c:1164
 splice_direct_to_actor+0x343/0x9c0 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x176/0x250 fs/splice.c:1233
 do_sendfile+0xa79/0xd90 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64 fs/read_write.c:1410 [inline]
 __x64_sys_sendfile64+0x1de/0x220 fs/read_write.c:1410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c033b85ad
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c042b1f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f2c03646080 RCX: 00007f2c033b85ad
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f2c0346a8d6 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2c03646080 R15: 00007f2c04292000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data+0x346/0x3e0 fs/ext4/inline.c:235
Code: d0 f6 4b ff e8 cb f6 4b ff 42 8d 6c 25 c4 41 bd 3c 00 00 00 45
29 e5 e9 e8 fe ff ff e8 b3 f6 4b ff 90 0f 0b e8 ab f6 4b ff 90 <0f> 0b
e8 63 95 ac ff e9 fb fd ff ff 4c 89 f7 e8 56 95 ac ff e9 96
RSP: 0018:ffffc900043e7628 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888012c251f0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000060
R13: 0000000000000061 R14: ffff888012c2579a R15: ffffc900043e76c0
FS:  00007f2c042b2640(0000) GS:ffff88802b600000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2680f65e70 CR3: 000000006a448000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Regards,
Strforexc


