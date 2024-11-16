Return-Path: <linux-ext4+bounces-5224-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2930D9D000B
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Nov 2024 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47CA1F229FC
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Nov 2024 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD41191F9B;
	Sat, 16 Nov 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obGJdOaP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE948183CCA
	for <linux-ext4@vger.kernel.org>; Sat, 16 Nov 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731777685; cv=none; b=FAI5/HQYyKA1LooZowYTaXKEnc6pYFaPz8Ek4SBEg3o5Mp2hI8I8efSqV8YtztHeWoNsk4F+31NTxVJOFqYq3nAerIMROPTHip7ls6zT/pBrmb6uKIK94zzfr2Aoh2Y+OCqLnHkLgA0PA4ncyot59HXBZ2kDpnIbjcrkKsEo3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731777685; c=relaxed/simple;
	bh=yol5Alb9ExOeIi21uxzg8Zrtd3N1J1d9mDIHvq8GR48=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IQHZjaRWEHcqsjW70pxvi5mDFQHg8tSZpw02a9DMZ4+LZQwHjbZt3U7xXOVMgS3x0rBT3g88SFdke1TVNo+XX2QpnnDUEZuAFwNvkhbj6p2qZCi+VfDmp7cbkuBHrJ192GHPGOgWu3lidkAuesJiWu7tqdzfkNmUpnz92OQQh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obGJdOaP; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50d5d6f9fdaso1290713e0c.2
        for <linux-ext4@vger.kernel.org>; Sat, 16 Nov 2024 09:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731777682; x=1732382482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4RJlVpmB+lhfFzCb8c/rYbScRS3m48z55/dvsQke+wk=;
        b=obGJdOaPTnuJsJa2q35g+fNG2aIsvYHdH7xA+Kx9XlBOkc0PbfO/wmqjnCf55rXY1h
         Icr1qXqUz9qwnq4riX/1AhjWtAiT4RSnl7qRDUePX8EIWw+ROEWlT1hP3uIVEaK3sT/c
         8SYpV8QdXFts9z5MizUZJ2mrg/MOIdrGJVzEAjrZRpfbwErBDMrCLrP0xIN5eJbXYExD
         YKGyFS7tYRfFC+WeDs9dTqjk80VE12YT3kWqqJwTR/BsggKZtiZvMhVtmwDGy8/Ws7Gz
         EucPlD8KkW563n/ndTj5rAvSmRf+hFsAoPTdBylCNK1LVWjHjMOxWwJ5T7m2dM4IMOrw
         05/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731777682; x=1732382482;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RJlVpmB+lhfFzCb8c/rYbScRS3m48z55/dvsQke+wk=;
        b=i34ppznF1iCn6qnqq/ChijYBZtihtSsC2ujbuURCLznmhZQCMAxeh3T/U47YSBPXqM
         9macMpwKBSNkMKPUgMi8e+8KsxWZREsHT9hgoDkAbIkct9/nDKoGHxKkX9k5UG7+SScQ
         /M+BjvnvJROq2n9r/GW/XxX/K7lJYnUq55hdd9KZPEjLSfUXh3O8YV8JkbhDJ5//YEdY
         AqT12tfa7EUR/hPAMX2ArFHTICy1zlYHjPyTVIaSIe84omayKqOx60a0z3VhaT8BbHsV
         Gh7FNXiZD7mMVBI9IA5L8JN0nqZQJMJUUgyJkeemsWVFpYMYJP7loIJPABh/ur5U3lK6
         6SaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCtnQ+5v43C4TklMVqLG//IHJtC3WnMvX5cQ2usRs6/ZwG0xcyl4WtGn5onGomM5udSGlzM9+o55Xj@vger.kernel.org
X-Gm-Message-State: AOJu0YyDexqn4tNOlGRcFuM+i4o6n/ObzWZqoBi8jgUrPvbxsM+GGPcH
	Lib/bbsICr0/8Sgo7KTN2cWcyMOi0hp7HmWPu+5eppe9CAOzZBSx6wBJoBgwMgqVwXovqCWKslW
	InU6UiX3yuOTziWNR2Z8ZT5IdYosg+atcWE6wlg==
X-Google-Smtp-Source: AGHT+IG7/o2ScsG55LigeM8KzfLtSAk8gbaDRL9xhU7vNgH39ygnmTrnh1Fxw/t1DOqBNwgHAZBvodROL5Sxq5LHfqg=
X-Received: by 2002:a05:6122:4581:b0:50d:69a8:f5a6 with SMTP id
 71dfb90a1353d-5147866c06amr6266906e0c.9.1731777681818; Sat, 16 Nov 2024
 09:21:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 16 Nov 2024 22:51:10 +0530
Message-ID: <CA+G9fYs9R7DwZVkA_MRaqWwrfuuvZ-3wMcYuk3oHA0prN3bKRA@mail.gmail.com>
Subject: arm64: __kmem_cache_create_args(ext4_groupinfo_4k) failed with error
 -22 - Boot failed
To: open list <linux-kernel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The qemu-arm64, qemu-armv7 and qemu-riscv boot failed on Sasha Linus-next tree
due to ext4 crash. Please find more details below

First seen on commit sha id c12cd257292c0c29463aa305967e64fc31a514d8.
Good: 7ff71d62bdc4828b0917c97eb6caebe5f4c07220
Bad:  d11b462aa01e0ffd5f8cc81bd5d2cfe4e48c8fbd

qemu-arm64:
 * boot/gcc-13-lkftconfig
 * boot/clang-nightly-lkftconfig
 * boot/gcc-13-lkftconfig-perf

qemu-armv7:
 * boot/gcc-13-lkftconfig
 * boot/clang-19-lkftconfig

qemu-riscv64:
 * boot/clang-19-lkftconfig
 * boot/gcc-13-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
---------
<4>[    1.961480] __kmem_cache_create_args(ext4_groupinfo_4k) failed
with error -22
<4>[    1.962527] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc7 #1
<4>[    1.963220] Hardware name: linux,dummy-virt (DT)
<4>[    1.964500] Call trace:
<4>[ 1.964869] dump_backtrace (arch/arm64/kernel/stacktrace.c:321)
<4>[ 1.966166] show_stack (arch/arm64/kernel/stacktrace.c:328)
<4>[ 1.966570] dump_stack_lvl (lib/dump_stack.c:123)
<4>[ 1.966998] dump_stack (lib/dump_stack.c:130)
<4>[ 1.967331] __kmem_cache_create_args (mm/slab_common.c:363)
<4>[ 1.967774] ext4_mb_init (include/linux/slab.h:349
fs/ext4/mballoc.c:3525 fs/ext4/mballoc.c:3614)
<4>[ 1.968194] ext4_fill_super (fs/ext4/super.c:5543 fs/ext4/super.c:5717)
<4>[ 1.968680] get_tree_bdev_flags (fs/super.c:1636)
<4>[ 1.969043] get_tree_bdev (fs/super.c:1660)
<4>[ 1.969370] ext4_get_tree (fs/ext4/super.c:5750)
<4>[ 1.969781] vfs_get_tree (fs/super.c:1814)
<4>[ 1.970174] path_mount (fs/namespace.c:3507 fs/namespace.c:3834)
<4>[ 1.970592] init_mount (fs/init.c:25)
<4>[ 1.970937] do_mount_root (init/do_mounts.c:165)
<4>[ 1.971369] mount_root_generic (init/do_mounts.c:205)
<4>[ 1.971782] mount_root (init/do_mounts.c:410)
<4>[ 1.972175] prepare_namespace (init/do_mounts.c:493)
<4>[ 1.972610] kernel_init_freeable (init/main.c:1593)
<4>[ 1.973030] kernel_init (init/main.c:1473)
<4>[ 1.973385] ret_from_fork (arch/arm64/kernel/entry.S:861)
<0>[    1.974278] EXT4-fs: no memory for groupinfo slab cache
<3>[    1.974889] EXT4-fs (vda): failed to initialize mballoc (-12)
<3>[    1.979727] EXT4-fs (vda): mount failed
<4>[    1.985849] VFS: Cannot open root device "/dev/vda" or
unknown-block(254,0): error -12
<4>[    1.986425] Please append a correct "root=" boot option; here
are the available partitions:
<4>[    1.987344] fe00         2651632 vda
<4>[    1.987471]  driver: virtio_blk
<4>[    1.988006] 1f00          131072 mtdblock0
<4>[    1.988071]  (driver?)
<3>[    1.988693] List of all bdev filesystems:
<3>[    1.989007]  ext3
<3>[    1.989089]  ext2
<3>[    1.989243]  ext4
<3>[    1.990678]  squashfs
<3>[    1.990900]  vfat
<3>[    1.991157]
<0>[    1.991778] Kernel panic - not syncing: VFS: Unable to mount
root fs on unknown-block(254,0)
<4>[    1.993227] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc7 #1
<4>[    1.994220] Hardware name: linux,dummy-virt (DT)
<4>[    1.994690] Call trace:
<4>[ 1.994943] dump_backtrace (arch/arm64/kernel/stacktrace.c:321)
<4>[ 1.995263] show_stack (arch/arm64/kernel/stacktrace.c:328)
<4>[ 1.995478] dump_stack_lvl (lib/dump_stack.c:124)
<4>[ 1.995802] dump_stack (lib/dump_stack.c:130)
<4>[ 1.996206] panic (kernel/panic.c:354)
<4>[ 1.996603] mount_root_generic (init/do_mounts.c:252)
<4>[ 1.996964] mount_root (init/do_mounts.c:410)
<4>[ 1.998083] prepare_namespace (init/do_mounts.c:493)
<4>[ 1.998533] kernel_init_freeable (init/main.c:1593)
<4>[ 1.998977] kernel_init (init/main.c:1473)
<4>[ 1.999334] ret_from_fork (arch/arm64/kernel/entry.S:861)
<2>[    1.999930] SMP: stopping secondary CPUs
<0>[    2.001613] Kernel Offset: 0x25c315a00000 from 0xffff800080000000
<0>[    2.001973] PHYS_OFFSET: 0x40000000
<0>[    2.003672] CPU features: 0x00,0000000d,062f797c,677e7f3f
<0>[    2.005317] Memory Limit: none
<0>[    2.007534] ---[ end Kernel panic - not syncing: VFS: Unable to
mount root fs on unknown-block(254,0) ]---


Boot log:
---------
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15193-gd11b462aa01e/testrun/25853423/suite/boot/test/gcc-13-lkftconfig-no-kselftest-frag/log
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15430-gc12cd257292c/testrun/25848510/suite/boot/test/clang-19-lkftconfig/log

Build image:
-----------
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2owGnu3uAtzDsaiD2mLqcZ5VwHq/

Steps to reproduce:
------------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2owGobRSnVpIZQtcenWfntoheHJ/reproducer
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2owGobRSnVpIZQtcenWfntoheHJ/tux_plan

metadata:
----
Linux version: 6.12.0-rc7
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
git sha: d11b462aa01e0ffd5f8cc81bd5d2cfe4e48c8fbd
kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2owGnu3uAtzDsaiD2mLqcZ5VwHq/config
build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2owGnu3uAtzDsaiD2mLqcZ5VwHq/
toolchain: gcc-13 and clang-19
config: gcc-13-lkftconfig
arch: arm64

--
Linaro LKFT
https://lkft.linaro.org

