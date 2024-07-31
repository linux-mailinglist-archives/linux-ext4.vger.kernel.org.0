Return-Path: <linux-ext4+bounces-3576-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC39433F0
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 18:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6575F1C2228B
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD901BC090;
	Wed, 31 Jul 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Eq6/eCDv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CE1BC068
	for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442412; cv=none; b=WdCvhPUv1z7qrZDgdypr+6+l5WH08cP79XdnE1lzs2P8v6qTURuTO+nMPruF0iLuCLg+7QZOR/Yn53QMtEG5P9Ah6lXMlLRI7gtv6PPV5m/4wS6rPfHMgOp5kzbpDNBFqnwYsVlF+8sOZz6RXjavqVsodK8nyuqgtS1bE7vvhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442412; c=relaxed/simple;
	bh=1ToGq8tDYcP3EnhKkaQNclMFW8U6PW4iOxs2BPJugOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JObMOzInNle2FUW2WPqLK6or9PTBObx4k/H3COCrXgTSl8afEcHJNLGld6WS7gw+k/kYPbr/LrU1ZTwiBSeRNrhZGOsQfUfJ7t4FdDhGdAYuHNGEoH0bvTn/rWz+4aFTpoFHhbAVtauCEE/KOhnS3RkHusgh4OR6xwL4ujn1EKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Eq6/eCDv; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f86cebca3so36211439f.2
        for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2024 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722442408; x=1723047208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGEPFD0VsvpiER1Gcdr0ldZno8g2mdkKklIuMxohlEg=;
        b=Eq6/eCDvLbY0kvJU+ELLrfoBrx3w0Lxa17jD35aqfbvH4RmROHjuor0VclRqBtBwS6
         ccWkJQocn0izBnedEfjJ49tmpcGOHIfyHdYzePGHTQ/PL8KEzT6eI/30frYiHUuARrSo
         LV35GAnEPNco2nZjmResFDHl5EHUV5XG9y5Kh/46cLKhE8TeL+VoZ2XYKSKoC8MO64DR
         QtygZPw3M+5wTdIvSrUTpwoHGdWhSQEEPwR4ZcZ8Zfwvp+0yGcyuvF4XBeGu0w5A1ITK
         52zo8IlpCUU2sMKvcxiGV0qL0UVUH644aA/suU9S08kjpBAvAeycMECXBmMwMCyB2XbH
         RPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442408; x=1723047208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGEPFD0VsvpiER1Gcdr0ldZno8g2mdkKklIuMxohlEg=;
        b=LH0v97yEhxOb7eXpApD7A8KOetGGgTB23fZI+ebbf32fZCpzrRQecAoJ5wF00mrJ0t
         T2Np7sI8m/+9foNUK//urWbQ/CEMGle4x71ewIvNlLthLWn0NyQgI7DLjOSE2QYMCkRi
         MlTOTL4MTf6CfT1r6xlozC/pp+sB7Q2ZL3taVuH0sPpF3BguqO8MGZpSOt03gnTVVVaT
         P/zcUf3lcX96hLDjKF3MEeYeNeaGJGtGl1ASsP/Fyn4b/no5ZS0gHBHpMTY0shy0Caj3
         ImkUGvDzRXL0YAnxqF3XNqnGGJBvcwFK4jjwIPoRNWliR6EegIySxZpTiIJ+Nxj/C3Bx
         HJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjpqdU4XfBAQ4RV6FCA3o4UKedikldDDDWEYmRDJuqivzVNYIQ/Toq1Oat6MpMYA9762pR/dnjEGRK96NYiXoTQQq74lU1m4FXjg==
X-Gm-Message-State: AOJu0Yz0KNnPjsMMWp93Hs+CNTKqc8Wz5cXnupK9p6dsFmW2mMSfqMDy
	xTbXqCeuZNzg4Sl4pWGlv26KjiG/mNBqrsE8z2XOMN3Rf/y2gS1xRVgzsKPDEXw=
X-Google-Smtp-Source: AGHT+IGF6YjyChoAMnrkMzY1qNvxVIFbruE28nDfVy0J3JingBM0K8i2YEdNExluMVPY1chhtwOQug==
X-Received: by 2002:a5e:c91a:0:b0:81f:922a:efdb with SMTP id ca18e2360f4ac-81f922af876mr950959939f.1.1722442408291;
        Wed, 31 Jul 2024 09:13:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa98efasm3265550173.48.2024.07.31.09.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:13:27 -0700 (PDT)
Message-ID: <ad4543e3-53bf-4e2c-8a3c-1e21b9cfa246@kernel.dk>
Date: Wed, 31 Jul 2024 10:13:26 -0600
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
References: <20240730151615.753688326@linuxfoundation.org>
 <CA+G9fYuGGbhKgt6dD2pBCK1y4M3-KUhPZcw21gYtUFzQ32KLdg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+G9fYuGGbhKgt6dD2pBCK1y4M3-KUhPZcw21gYtUFzQ32KLdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/24 3:24 AM, Naresh Kamboju wrote:
> On Tue, 30 Jul 2024 at 21:21, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 6.1.103 release.
>> There are 440 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.103-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> As others reported the boot failures and bisection results.
> I started validating 6.1.103-rc2 results.
> 
> [only for the record]
> The stable-rc 6.1 boot failed on all devices due to the following kernel panic.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Boot crash log:
> ----------
> <1>[    6.427635] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000000d0
> <1>[    6.428491] Mem abort info:
> <1>[    6.428852]   ESR = 0x0000000096000004
> <1>[    6.429458]   EC = 0x25: DABT (current EL), IL = 32 bits
> <1>[    6.430263]   SET = 0, FnV = 0
> <1>[    6.430677]   EA = 0, S1PTW = 0
> <1>[    6.431170]   FSC = 0x04: level 0 translation fault
> <1>[    6.431711] Data abort info:
> <1>[    6.432167]   ISV = 0, ISS = 0x00000004
> <1>[    6.432667]   CM = 0, WnR = 0
> <1>[    6.433136] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000100005000
> <1>[    6.433848] [00000000000000d0] pgd=0000000000000000, p4d=0000000000000000
> <0>[    6.435845] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> <4>[    6.436795] Modules linked in: ip_tables x_tables
> <4>[    6.437973] CPU: 1 PID: 1 Comm: systemd Tainted: G
>   N 6.1.103-rc1 #1
> <4>[    6.438884] Hardware name: linux,dummy-virt (DT)
> <4>[    6.439800] pstate: 02400009 (nzcv daif +PAN -UAO +TCO -DIT
> -SSBS BTYPE=--)
> <4>[ 6.440501] pc : dd_limit_depth (block/mq-deadline.c:609
> block/mq-deadline.c:630)
> <4>[ 6.442475] lr : __blk_mq_alloc_requests (block/blk-mq.c:474)
> <4>[    6.443041] sp : ffff80000802b7a0
> <4>[    6.443397] x29: ffff80000802b7b0 x28: 7fffffffffffffff x27:
> 0000000000000000
> <4>[    6.444406] x26: ffffa2ac0d3e5328 x25: ffff0000c0ad9cc0 x24:
> ffff0000c15986a0
> <4>[    6.445160] x23: 0000000000000001 x22: ffff0000c0ad9cc0 x21:
> ffff80000802ba38
> <4>[    6.445905] x20: ffff0000c0ad9cc0 x19: ffff80000802b820 x18:
> 0000000000000000
> <4>[    6.446654] x17: 0000000000000000 x16: 0000000000000000 x15:
> ffffffffffffffff
> <4>[    6.447404] x14: ffffffffffffffff x13: ffffffffffffffff x12:
> ffffffffffffffff
> <4>[    6.448159] x11: 0000000000000000 x10: 0000000000000000 x9 :
> ffffa2ac0c60feb0
> <4>[    6.448953] x8 : ffff80000802b668 x7 : 0000000000000000 x6 :
> 0000000000000001
> <4>[    6.449694] x5 : ffffa2ac0ea3f000 x4 : 0000000000000000 x3 :
> ffff0000c0f7bc00
> <4>[    6.450440] x2 : ffff0000c0ad9cc0 x1 : ffff80000802b820 x0 :
> 0000000000000000
> <4>[    6.451329] Call trace:
> <4>[ 6.451720] dd_limit_depth (block/mq-deadline.c:609 block/mq-deadline.c:630)
> <4>[ 6.452228] blk_mq_submit_bio (block/blk-mq.c:2911 block/blk-mq.c:3011)
> <4>[ 6.452712] __submit_bio (block/blk-core.c:595)
> <4>[ 6.453098] submit_bio_noacct_nocheck (include/linux/bio.h:614
> block/blk-core.c:668 block/blk-core.c:696)
> <4>[ 6.453610] submit_bio_noacct (block/blk-core.c:799)
> <4>[ 6.454026] submit_bio (block/blk-core.c:828)
> <4>[ 6.454440] ext4_io_submit (fs/ext4/page-io.c:380)
> <4>[ 6.454884] ext4_writepages (fs/ext4/inode.c:2876)
> <4>[ 6.455328] do_writepages (mm/page-writeback.c:2491)
> <4>[ 6.455788] filemap_fdatawrite_wbc (mm/filemap.c:388 mm/filemap.c:378)
> <4>[ 6.456243] __filemap_fdatawrite_range (mm/filemap.c:422)
> <4>[ 6.456750] file_write_and_wait_range (mm/filemap.c:774)
> <4>[ 6.457249] ext4_sync_file (fs/ext4/fsync.c:151)
> <4>[ 6.457644] vfs_fsync_range (fs/sync.c:189)
> <4>[ 6.458095] do_fsync (fs/sync.c:202 fs/sync.c:212)
> <4>[ 6.458491] __arm64_sys_fsync (fs/sync.c:218)
> <4>[ 6.458899] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:57)
> <4>[ 6.459349] el0_svc_common.constprop.0
> (arch/arm64/include/asm/daifflags.h:28
> arch/arm64/kernel/syscall.c:148)
> <4>[ 6.459864] do_el0_svc (arch/arm64/kernel/syscall.c:205)
> <4>[ 6.460272] el0_svc (arch/arm64/include/asm/daifflags.h:28
> arch/arm64/kernel/entry-common.c:133
> arch/arm64/kernel/entry-common.c:142
> arch/arm64/kernel/entry-common.c:638)
> <4>[ 6.460644] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
> <4>[ 6.461099] el0t_64_sync (arch/arm64/kernel/entry.S:585)
> <0>[ 6.461765] Code: f9400022 d50323bf f9401820 f9400443 (f9406802)
> All code
> ========
>    0: f9400022 ldr x2, [x1]
>    4: d50323bf autiasp
>    8: f9401820 ldr x0, [x1, #48]
>    c: f9400443 ldr x3, [x2, #8]
>   10:* f9406802 ldr x2, [x0, #208] <-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0: f9406802 ldr x2, [x0, #208]
> <4>[    6.463039] ---[ end trace 0000000000000000 ]---
> <4>[    6.464924] ------------[ cut here ]------------
> <4>[ 6.465459] WARNING: CPU: 1 PID: 1 at kernel/exit.c:816 do_exit
> (kernel/exit.c:816 (discriminator 1))
> <4>[    6.466537] Modules linked in: ip_tables x_tables
> <4>[    6.467108] CPU: 1 PID: 1 Comm: systemd Tainted: G      D
>   N 6.1.103-rc1 #1
> <4>[    6.467792] Hardware name: linux,dummy-virt (DT)
> <4>[    6.468226] pstate: 42400009 (nZcv daif +PAN -UAO +TCO -DIT
> -SSBS BTYPE=--)
> <4>[ 6.468843] pc : do_exit (kernel/exit.c:816 (discriminator 1))
> <4>[ 6.469218] lr : do_exit (kernel/exit.c:816 (discriminator 1))
> <4>[    6.469612] sp : ffff80000802b370
> <4>[    6.469941] x29: ffff80000802b3a0 x28: ffffa2ac0dbe3f48 x27:
> ffffa2ac0dbe3f40
> <4>[    6.470683] x26: 0000000000000000 x25: 0000000000000001 x24:
> ffff80000802b472
> <4>[    6.471437] x23: 0000000000000001 x22: 000000000000000b x21:
> ffff0000c02c0000
> <4>[    6.472185] x20: ffff0000c02dc000 x19: ffff0000c02b8000 x18:
> 0000000000000006
> <4>[    6.472916] x17: 3030303030303030 x16: 3030303030303020 x15:
> ffff80000802af00
> <4>[    6.473652] x14: 0000000000000000 x13: 205d393330333634 x12:
> 2e36202020205b3e
> <4>[    6.474386] x11: 3030303030206563 x10: ffffa2ac0eabb978 x9 :
> ffffa2ac0d379d20
> <4>[    6.475118] x8 : ffff80000802b278 x7 : 0000000000000000 x6 :
> 0000000000000001
> <4>[    6.475845] x5 : ffffa2ac0ea3f000 x4 : ffffa2ac0ea3f2e8 x3 :
> 0000000000000000
> <4>[    6.476576] x2 : ffff0000c02b8000 x1 : ffff0000c02b8000 x0 :
> ffff80000802ba38
> <4>[    6.477310] Call trace:
> <4>[ 6.477595] do_exit (kernel/exit.c:816 (discriminator 1))
> <4>[ 6.477948] make_task_dead
> (arch/arm64/include/asm/atomic_ll_sc.h:95 (discriminator 2)
> arch/arm64/include/asm/atomic.h:52 (discriminator 2)
> include/linux/atomic/atomic-arch-fallback.h:440 (discriminator 2)
> include/linux/atomic/atomic-instrumented.h:199 (discriminator 2)
> kernel/exit.c:968 (discriminator 2))
> <4>[ 6.478357] die (arch/arm64/kernel/traps.c:239)
> <4>[ 6.478697] die_kernel_fault (arch/arm64/mm/fault.c:307)
> <4>[ 6.479134] __do_kernel_fault (arch/arm64/mm/fault.c:404)
> <4>[ 6.479574] do_page_fault (arch/arm64/mm/fault.c:658)
> <4>[ 6.479962] do_translation_fault (arch/arm64/mm/fault.c:671)
> <4>[ 6.480411] do_mem_abort (arch/arm64/mm/fault.c:803 (discriminator 1))
> <4>[ 6.480781] el1_abort (arch/arm64/include/asm/daifflags.h:28
> arch/arm64/kernel/entry-common.c:368)
> <4>[ 6.481142] el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:455)
> <4>[ 6.481588] el1h_64_sync (arch/arm64/kernel/entry.S:580)
> <4>[ 6.481958] dd_limit_depth (block/mq-deadline.c:609 block/mq-deadline.c:630)
> <4>[ 6.482355] blk_mq_submit_bio (block/blk-mq.c:2911 block/blk-mq.c:3011)
> <4>[ 6.482778] __submit_bio (block/blk-core.c:595)
> <4>[ 6.483184] submit_bio_noacct_nocheck (include/linux/bio.h:614
> block/blk-core.c:668 block/blk-core.c:696)
> <4>[ 6.483650] submit_bio_noacct (block/blk-core.c:799)
> <4>[ 6.484098] submit_bio (block/blk-core.c:828)
> <4>[ 6.484454] ext4_io_submit (fs/ext4/page-io.c:380)
> <4>[ 6.484858] ext4_writepages (fs/ext4/inode.c:2876)
> <4>[ 6.485285] do_writepages (mm/page-writeback.c:2491)
> <4>[ 6.485670] filemap_fdatawrite_wbc (mm/filemap.c:388 mm/filemap.c:378)
> <4>[ 6.486122] __filemap_fdatawrite_range (mm/filemap.c:422)
> <4>[ 6.486587] file_write_and_wait_range (mm/filemap.c:774)
> <4>[ 6.487048] ext4_sync_file (fs/ext4/fsync.c:151)
> <4>[ 6.487463] vfs_fsync_range (fs/sync.c:189)
> <4>[ 6.487848] do_fsync (fs/sync.c:202 fs/sync.c:212)
> <4>[ 6.488223] __arm64_sys_fsync (fs/sync.c:218)
> <4>[ 6.488649] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:57)
> <4>[ 6.489039] el0_svc_common.constprop.0
> (arch/arm64/include/asm/daifflags.h:28
> arch/arm64/kernel/syscall.c:148)
> <4>[ 6.489522] do_el0_svc (arch/arm64/kernel/syscall.c:205)
> <4>[ 6.489876] el0_svc (arch/arm64/include/asm/daifflags.h:28
> arch/arm64/kernel/entry-common.c:133
> arch/arm64/kernel/entry-common.c:142
> arch/arm64/kernel/entry-common.c:638)
> <4>[ 6.490212] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
> <4>[ 6.490682] el0t_64_sync (arch/arm64/kernel/entry.S:585)
> <4>[    6.491191] ---[ end trace 0000000000000000 ]---
> <0>[    6.492871] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> <2>[    6.493803] SMP: stopping secondary CPUs
> <0>[    6.494951] Kernel Offset: 0x22ac04000000 from 0xffff800008000000
> <0>[    6.495536] PHYS_OFFSET: 0x40000000
> <0>[    6.495944] CPU features: 0x00000,000d3cbf,e69a773f
> <0>[    6.496943] Memory Limit: none
> <0>[    6.497664] ---[ end Kernel panic - not syncing: Attempted to
> kill init! exitcode=0x0000000b ]---
> 
> 
> Links to boot log:
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.102-441-ga90fe3a94186/testrun/24742768/suite/boot/test/gcc-13-lkftconfig-devicetree/log
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.102-441-ga90fe3a94186/testrun/24742768/suite/boot/test/gcc-13-lkftconfig-devicetree/details/
>  - Config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jyP6yz35Go9caJsvrdNOlq0X9t/config
>  - Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jyP6yz35Go9caJsvrdNOlq0X9t/
> 
> metadata:
> ----------
>   ## Build
> * kernel: 6.1.103-rc1
> * git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> * git commit: a90fe3a941868870c281a880358b14d42f530b07
> * git describe: v6.1.102-441-ga90fe3a94186
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.102-441-ga90fe3a94186

I built and booted 6.1.103-rc3 and didn't hit anything. Does it still
trigger with that one? If yes, how do I reproduce this?

There are no deadline changes since 6.1.102, and the block side is just
some integrity bits, which don't look suspicious. The other part this
could potentially be is the sbitmap changes, but...

-- 
Jens Axboe


