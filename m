Return-Path: <linux-ext4+bounces-1415-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F486B70B
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Feb 2024 19:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6C71F2746D
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Feb 2024 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3724085D;
	Wed, 28 Feb 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTGyl+jW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0DA79B72
	for <linux-ext4@vger.kernel.org>; Wed, 28 Feb 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144388; cv=none; b=uQsVTL0slD1TNYh+9LVLeLZRmRjeyc1k7sdKVvSo6LskJ3UCXdjp9FS+JbE4pX2fpzcmC+BiumC3cA7kJm8Es5uSxVGe3yVVPp9Fr1ZmdsVCWqRAeD4+lCAnr0VHjYAehdwwuO8clkEp3KDvThU84Gs5HwhSJ/R/m2eCKFQ44gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144388; c=relaxed/simple;
	bh=2MVim7vcg6zG4dgwBgUbb92jix69yhKFoBEDtfHIlx0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JJAgZpIKr7vtKH08BlV3mYswHgsrSuyOp43EF5JNBjbBKj4zLf4qi/f0L6nm6FCi3cEp6zkLVYCoKiHV/2+neCOmiUrNEX7xleGR5UhEhLstbIqqVJttEr5wRry/L1z7RwX4ZF9LW9AffHoB1wtLIgpyP7P5wP/gSTSSUePP5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fTGyl+jW; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4d345250ee1so143943e0c.1
        for <linux-ext4@vger.kernel.org>; Wed, 28 Feb 2024 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709144386; x=1709749186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rOb8MfNZpuDqY+iVoOY3+5jM0jnMc/9y7kDjWXkTChA=;
        b=fTGyl+jWZKuNVXVlziCkxVyDtGfD/58/xoSGoZ4LFETp28tg0CcD5+WXaiW6I2wdVe
         phfQYoohOOB63REVdW0RnjSPi2zN578AuljSdFQTHpPMozWhakXrOecR4imWh/jQy9S/
         l61GCO8vz/x7Go6WefOTf5O84gNL86DLufEWQEVKlEDdU5FUG9gyZ7DJi9612q0oXGYG
         BeHM8kdmQq6SwbH+YkXqZeQnHj7byAlg6NGawe7CATQPsqdCbIW4Pj+3rLd3WBPw54KH
         JZBiK/G+hCph9dvqQ7YweeseMs5Z6B2IVlyGhv7HoqS2Meuuuoq0kYAuGOV0zVacA7HS
         JI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144386; x=1709749186;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOb8MfNZpuDqY+iVoOY3+5jM0jnMc/9y7kDjWXkTChA=;
        b=D5IWcjnNLGy1Igd93C+6wety7YvvpBecBSNz41mVQCEjm1ZIzchHqvPaocy414bJeV
         wsusweK1GHvy2uUBjWOb4sChRRvwtKL7YZNAyLenmhZZlNL8gkpa4VLFL9rnvSqOiMIn
         9mkvEaLBN8XwWBiUE8g2kqDMQNopQUzw8Zqf0DE6IO268/a/P1YY6x8ivj95oNSpvMsF
         OERPguirN7NWMphOFS/glXa15xbirsSftW65jVXDrC7MJjuOeQafG1Llan6OPxlhB4so
         cLtXIIBEXnym4/TKieCNhWwVdLLzgAiymB+CKesJY8+SYZ2sf5t3wl3SmdEzlJAYKAFo
         bCbA==
X-Forwarded-Encrypted: i=1; AJvYcCUaZjkI31kazpE3U0rORI0fZx43S2Cwu7TaBKEaoxvYlXu3vNxMuC/x6ojYi10Q2R+CGiwMsXCEXIekt8tnE03M8hxQybHgBYpoFA==
X-Gm-Message-State: AOJu0YwCtbSPOU+jLvGXI9++8QbJLmAikV7HDpJpp7AIDdWRfjhSisu3
	2VWl+hKfWaAAMfRfToujL+vIuWn/dJR5PDZolloqUdEJVrkpyIcIi/i4WaUIx6l5nQamFOsIUEW
	jxG+nojHTCwAECPYpM2jz1FxnigbTYAWMZumI/g==
X-Google-Smtp-Source: AGHT+IFB+2S0GYpst6g5ZGStxLrP8Q9KlA5OQ64ZDp8HQVnU2Dqyt80rQZdiONkWN0JJ7/Bm8xb9EvTiMZllPIL1o7o=
X-Received: by 2002:a1f:4f41:0:b0:4d3:35ac:3553 with SMTP id
 d62-20020a1f4f41000000b004d335ac3553mr375587vkb.10.1709144385319; Wed, 28 Feb
 2024 10:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 Feb 2024 23:49:34 +0530
Message-ID: <CA+G9fYvnjDcmVBPwbPwhFDMewPiFj6z69iiPJrjjCP4Z7Q4AbQ@mail.gmail.com>
Subject: fs: ext4_mballoc_test: Internal error: Oops: map_id_range_down (kernel/user_namespace.c:318)
To: open list <linux-kernel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org
Cc: Jan Kara <jack@suse.cz>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	"Theodore Ts'o" <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	shikemeng@huaweicloud.com, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Kunit ext4_mballoc_test tests found following kernel oops on Linux next.
All ways reproducible on all the architectures and steps to reproduce shared
in the bottom of this email.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
---------
<6>[   14.297909]     KTAP version 1
<6>[   14.298306]     # Subtest: ext4_mballoc_test
<6>[   14.299114]     # module: ext4
<6>[   14.300048]     1..6
<6>[   14.301204]         KTAP version 1
<6>[   14.301853]         # Subtest: test_new_blocks_simple
<1>[   14.308203] Unable to handle kernel paging request at virtual
address dfff800000000000
<1>[   14.309700] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
<1>[   14.310671] Mem abort info:
<1>[   14.311141]   ESR = 0x0000000096000004
<1>[   14.312969]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   14.313566]   SET = 0, FnV = 0
<1>[   14.314228]   EA = 0, S1PTW = 0
<1>[   14.314750]   FSC = 0x04: level 0 translation fault
<1>[   14.316382] Data abort info:
<1>[   14.316838]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
<1>[   14.317742]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[   14.318637]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   14.319975] [dfff800000000000] address between user and kernel
address ranges
<0>[   14.322307] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
<4>[   14.324184] Modules linked in:
<4>[   14.326693] CPU: 1 PID: 104 Comm: kunit_try_catch Tainted: G
            N 6.8.0-rc6-next-20240228 #1
<4>[   14.327913] Hardware name: linux,dummy-virt (DT)
<4>[   14.329173] pstate: 11400009 (nzcV daif +PAN -UAO -TCO +DIT
-SSBS BTYPE=--)
<4>[ 14.330117] pc : map_id_range_down (kernel/user_namespace.c:318)
<4>[ 14.331618] lr : make_kuid (kernel/user_namespace.c:415)
<trim>
<4>[   14.344145] Call trace:
<4>[ 14.344565] map_id_range_down (kernel/user_namespace.c:318)
<4>[ 14.345378] make_kuid (kernel/user_namespace.c:415)
<4>[ 14.345998] inode_init_always (include/linux/fs.h:1375 fs/inode.c:174)
<4>[ 14.346696] alloc_inode (fs/inode.c:268)
<4>[ 14.347353] new_inode_pseudo (fs/inode.c:1007)
<4>[ 14.348016] new_inode (fs/inode.c:1033)
<4>[ 14.348644] ext4_mb_init (fs/ext4/mballoc.c:3404 fs/ext4/mballoc.c:3719)
<4>[ 14.349312] mbt_kunit_init (fs/ext4/mballoc-test.c:57
fs/ext4/mballoc-test.c:314)
<4>[ 14.349983] kunit_try_run_case (lib/kunit/test.c:388 lib/kunit/test.c:443)
<4>[ 14.350696] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30)
<4>[ 14.351530] kthread (kernel/kthread.c:388)
<4>[ 14.352168] ret_from_fork (arch/arm64/kernel/entry.S:861)
<0>[ 14.353385] Code: 52808004 b8236ae7 72be5e44 b90004c4 (38e368a1)
All code
========
   0: 52808004 mov w4, #0x400                  // #1024
   4: b8236ae7 str w7, [x23, x3]
   8: 72be5e44 movk w4, #0xf2f2, lsl #16
   c: b90004c4 str w4, [x6, #4]
  10:* 38e368a1 ldrsb w1, [x5, x3] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: 38e368a1 ldrsb w1, [x5, x3]
<4>[   14.354545] ---[ end trace 0000000000000000 ]---

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240228/testrun/22877850/suite/log-parser-test/test/check-kernel-bug/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240228/testrun/22877850/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240228/testrun/22877850/suite/log-parser-test/test/check-kernel-bug-43e0665fdb2d5768ac093e1634e6d9a7c65ff1b6a66af7d0c12b3bce5ca7e717/details/

Steps to reproduce:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2czN4PCDk4BIKg76qUnQE4WkNny/reproducer

--
Linaro LKFT
https://lkft.linaro.org

