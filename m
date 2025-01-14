Return-Path: <linux-ext4+bounces-6085-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23A4A100D0
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 07:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85EC1888A05
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC6233556;
	Tue, 14 Jan 2025 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F0b0Fb1t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F322F11
	for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2025 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736835930; cv=none; b=hTS+MQdpqXs6uuRDq7023tFM91ndLbs05/XswAh4fESyDPh8uxHnsuX2oCo0+FTC2sYMk+RZgvqdoJL97py4gnAhw/1MzVeau6NiLfidjxPpoyCGRnve7c9moN4NcmAWoJr0DNnyuFH4qJHvX0lmw+PlSSCXWcUCnmIwIchGcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736835930; c=relaxed/simple;
	bh=YHTZsofczZciM2ldx8u0jApBGwSPKeL/VawoG+8D4Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaT/ANVP7KzCqqLqd1d0kepWZR0kIXplA7ztKOVlCCrgRANJpStPF0mn5HqiTsrfXxH4G/V89Gb2AUWxOtCrhEeu7vuyig265ZvBPv+nagk/ABx7ak0Rk4IEBPiVtbtQFXhFQiaHbGgenf1tYYCMvoFQoofnL1a6YxGxz/+vjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F0b0Fb1t; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0bf4ec53fso879844a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2025 22:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736835926; x=1737440726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WG68zHpgXN0JEeAnT6d8e+4V4GunA7gzOhdUvu4l6bU=;
        b=F0b0Fb1tDYj/Y6hTatZjTEPm5M98RSihZg6dZHy7QD9NHY4ik5UiKeiPmlMStFCKM8
         WGlOHJOmUvgajV3wK1lx8wCUyiyv0e1D8tm01w8zX1k55mK5irI7MiYhCzS4RtFkgoTT
         df8M/LKWPSIz2DQbtc+sT5+KTshwsimOQjj61seqQY7f+ncUXW6fEA7IzxL56qP89d9G
         qDZTIcVoI1cqK/g+izrRobdOOUcwcQnU+5zcsQfQ7GxiTPtbusw8SkstM2eRAQ2ZBjnC
         duMcJtrmZvl78edqhYfvyfI2q/ba+9Vb6UBaa+YtcmnognVLhwDDOEkoZnY47g1grNXC
         CMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736835926; x=1737440726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WG68zHpgXN0JEeAnT6d8e+4V4GunA7gzOhdUvu4l6bU=;
        b=rPPYg9AbzhyEsPCeLQwlWs77QfUvHniAml4w9Hj15RdFE2tKF51X29QTNjMllQKJQg
         zl/c0bCjadsynxZbKvioeuXcwHFcrQBi6NC85kv+nyvtUuvhiw4ekg8Uz7WT1MvaB3Ds
         p4ENvXK1kVVRKep2aviopMHBn9qG7lGgZXL2tBHAUM9BZ6hhrL1GZguHx66Fz/E79FoC
         gedVdNKSDXdIJ4nP6hNvVkP3wx5/6vMT1C5qhoVZNfwWJG1/fbSQZsVzC1DJZi1PptpB
         KpgTPhhqV/Jrn6pIw5L76MrzB/YNvIY93nlWebOiaKTzLb3+2P7Sqi/NGfe6eZY7AZMI
         Fpzw==
X-Forwarded-Encrypted: i=1; AJvYcCU9q3x/d1wVwC3CqE160PsPi8iVGLdSeSkSUa1/pVpPvVTfXaclu0vLRtm6Zi4NKdMG1JaQtoTglM5d@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qOre22Tb4j5ILOlK7G5E/h+JjeyenkfXfXyGG3xKEhGx55oP
	z5Rpmr6m1CW9jPpaEDJJyF018B8zOJ5IrjGxQzrUwkAGX0anit7bjmtL3+Ucv+8=
X-Gm-Gg: ASbGncuQei3yeO6WIqaNTQxjA+debTIgyP6nSZlOJTzj5n4Yf2KNaUma7U2Rkb6ZXPn
	FeBqHjSKoIKdKKvckAgiA6Hy3QJIR++qZjo4o2h2xgUqcDkbr2O2iXGLrEakDmzUfZZ14TcLFq0
	wy5igzRbXgBfWgLmbPEAz0EhAPX+5VGaF4xms49GgoWsp7Vrph8KgFMmTKlbfc3+mg8h+vaE6kK
	WzEkeywL5rPDjeuN6XfmsYP7fdmeK22qv0O4UjcZvI4UjL+KVNmyzDv/lTn
X-Google-Smtp-Source: AGHT+IGmy8xIOYJXQcPObq4m2Cx6vmu6xHGtv84+U2bEN4z54Im+X4nF9QMlaXFY1yA4XzhFd18Shw==
X-Received: by 2002:a17:907:7203:b0:aab:fcbb:da37 with SMTP id a640c23a62f3a-ab2ab6cbb84mr866865466b.11.1736835926558;
        Mon, 13 Jan 2025 22:25:26 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df62sm62491835ad.21.2025.01.13.22.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 22:25:25 -0800 (PST)
Message-ID: <24f378c8-7a27-47b8-bd79-dba4a2e92f6d@suse.com>
Date: Tue, 14 Jan 2025 14:25:21 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in jbd2_journal_update_sb_log_tail
To: Jan Kara <jack@suse.cz>, Liebes Wang <wanghaichi0403@gmail.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
References: <CADCV8sq0E9_tmBbedYdUJyD4=yyjSngp2ZGVR2VfZfD0Q1nUFQ@mail.gmail.com>
 <mzypseklhk6colsb5fh42ya74x43z5mmkzdjdyluesx6hb744a@hycbebanf7mv>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <mzypseklhk6colsb5fh42ya74x43z5mmkzdjdyluesx6hb744a@hycbebanf7mv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

On 1/6/25 23:14, Jan Kara wrote:
> On Tue 31-12-24 13:53:23, Liebes Wang wrote:
>> Dear Linux maintainers and reviewers:
>>
>> We are reporting a Linux kernel bug titled **WARNING in
>> jbd2_journal_update_sb_log_tail**, discovered using a modified version of
>> Syzkaller.
> 
> Very likely this is actually some issue with ocfs2 since the only thing the
> reproducer seems to be doing is that it is mounting ocfs2 image. Joseph,
> can you have a look please?
> 
> 								Honza

The root cause appears to be that the jbd2 bypass recovery logic
is incorrect.

 From the console log [1]:
  [   70.568684][ T5316] JBD2: Ignoring recovery information on journal

The above output indicates that ocfs2 is calling jbd2_journal_wipe()
to clean up jbd2. (IIUC), Therefore, the subsequent jbd2 initialization
flow should not perform any recovery tasks.

However, in this crash issue, after calling jbd2_journal_wipe(),
jbd2_journal_load() still attempts to perform a recovery, which triggers
a WARN_ON().

On the other hand, the jbd2 code logic is correct, ocfs2 should call
ocfs2_journal_wipe() with the parameter 'write=1' to address this issue.

code flow:
ocfs2_mount_volume
  ocfs2_check_volume
  + ocfs2_journal_init => jbd2_journal_init_inode
  + ocfs2_journal_wipe => jbd2_journal_wipe (input write is 0)
  + ocfs2_journal_load => jbd2_journal_load => do recovery job => WARN_ON()

[1]: 2024/01/12 06:56 log
https://syzkaller.appspot.com/text?tag=CrashLog&x=106f2bc4580000

Thanks,
Heming

> 
>> Linux version: v6.12-rc6:59b723cd2adbac2a34fc8e12c74ae26ae45bf230 (crash is
>> also reproduced in the latest kernel version)
>> The test case and kernel config is in attach.
>>
>> The warning report is (The full report is attached):
>>
>> WARNING: CPU: 0 PID: 6139 at fs/jbd2/journal.c:1887
>> jbd2_journal_update_sb_log_tail+0x32d/0x3b0 fs/jbd2/journal.c:1887
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 6139 Comm: syz.7.135 Not tainted 6.12.0-rc6 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.13.0-1ubuntu1.1 04/01/2014
>> RIP: 0010:jbd2_journal_update_sb_log_tail+0x32d/0x3b0 fs/jbd2/journal.c:1887
>> Code: fe ff ff e8 05 0e a7 ff e9 f4 fd ff ff e8 eb 0e a7 ff e9 16 ff ff ff
>> 4c 89 ef e8 de 0e a7 ff e9 d5 fe ff ff e8 94 ec 54 ff 90 <0f> 0b 90 eb 88
>> 41 bc fb ff ff ff e9 13 ff ff ff e8 7e ec 54 ff be
>> RSP: 0018:ff1100013b6ff818 EFLAGS: 00010246
>> RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffa00000034b3000
>> RDX: 0000000000040000 RSI: ffffffff81fd15ec RDI: 0000000000000005
>> RBP: ff110001405ce000 R08: 0000000000000001 R09: ffe21c00276dfef5
>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>> R13: ff11000107e3a018 R14: ff11000107e3a000 R15: ff110001405ce0b0
>> FS:  00007ff345cd5700(0000) GS:ff110004ca800000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ff3470375c0 CR3: 0000000117544001 CR4: 0000000000771ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> PKRU: 80000000
>> Call Trace:
>>   <TASK>
>>   journal_reset fs/jbd2/journal.c:1779 [inline]
>>   jbd2_journal_load fs/jbd2/journal.c:2109 [inline]
>>   jbd2_journal_load+0x93e/0xcf0 fs/jbd2/journal.c:2074
>>   ocfs2_journal_load+0xbe/0x5e0 fs/ocfs2/journal.c:1143
>>   ocfs2_check_volume fs/ocfs2/super.c:2421 [inline]
>>   ocfs2_mount_volume fs/ocfs2/super.c:1817 [inline]
>>   ocfs2_fill_super+0x19f1/0x4170 fs/ocfs2/super.c:1084
>>   mount_bdev+0x1e6/0x2d0 fs/super.c:1693
>>   legacy_get_tree+0x107/0x220 fs/fs_context.c:662
>>   vfs_get_tree+0x94/0x380 fs/super.c:1814
>>   do_new_mount fs/namespace.c:3507 [inline]
>>   path_mount+0x6b2/0x1eb0 fs/namespace.c:3834
>>   do_mount fs/namespace.c:3847 [inline]
>>   __do_sys_mount fs/namespace.c:4057 [inline]
>>   __se_sys_mount fs/namespace.c:4034 [inline]
>>   __x64_sys_mount+0x283/0x300 fs/namespace.c:4034
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xc1/0x1d0 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f


