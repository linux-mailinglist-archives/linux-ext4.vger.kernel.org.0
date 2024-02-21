Return-Path: <linux-ext4+bounces-1336-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3B85E11C
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 16:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6281F24C30
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079B80601;
	Wed, 21 Feb 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY8F8WMU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112E6994A
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529394; cv=none; b=JcnBbUoTW3N51CuyiYtm0znaEAekJpgwos7kQBZN6rc7D7Qj3cMVBrGuQr52EQ24arFE/01MYqyiPGTtJc4i2vFvddM0WaaTvbIL7BNNLZ9zmys5xBuzepP0FRmXsttnJOv8WA3CihQy3eqZHdDDoEc5dS9bfGemohF237S8zs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529394; c=relaxed/simple;
	bh=McD08Fm0GKyHx5pDyFguClvfLzsv8XC1Md3ptow+aZQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iZSXlfC/ZlmeMQLJMbk6CJDO3zVDFeQv2ZNaCZFHI0RiS3qz24F7+DrVVS7dbfz5XEG0rWcRVXuUwGv5zXGaV3IGvIJuOkeK8yBnXQ4Kb8/5yW4Edr8iuMWHc/31jjrzu7HEpVe8tY03mzNYIKzV41KeHcW6r0VwWssaPjL2SFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY8F8WMU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so1199462a12.1
        for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 07:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708529391; x=1709134191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9uJN+tmnHDtLaxl7AyczUM64h9qG1TszIsWP+NAZ7yw=;
        b=mY8F8WMUeDRuktPA/ZgVDv7sKB+z+WCfacbEwVSbksiDLiQGCHH/tE8tVtLcbPyQu+
         lxvD3UzXPc6GGi85YVIEQRPl6JMOYg5V+S+zCrlIylhzsAElUTBHSi9KZX9k5P7+UoRH
         2b963AfHB9FwZsFwpVbFqmjHJdN2fCezAoXWf6CTNr/xZjRnTDE6FxOrERrFnkE+Ixve
         9Yl3ujarDmzzCcBnFxEe0lF6Q7WK7qwNmD2k3UVDFj9kNDN5P7NUxPprrWbCg+ZhF8nJ
         nu60//hNdc+bpL8xWLyXnQ+ksyR5mBzz8ueB6khVCgtibnGxwkGXxJACw5ppvNXZ4Ilk
         4OgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529391; x=1709134191;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uJN+tmnHDtLaxl7AyczUM64h9qG1TszIsWP+NAZ7yw=;
        b=c39j+wkK2+3BogNvhoJOPtctbuI7sykiAW8VpO4EBgXft08c+Ao4chGnC/Tjv63qHc
         pYuuDP5m75L7W4fPiDS1h421Si6Yxx5+IUwZ5izz2cm2e+AwOih+Ud2RMzX4Ppg2QGb5
         7T+XcZXRA+MT2og/NbN6hYHrtJosgfC213lJ4O7YSvuBbgHOcWaHr/s5taWa5WGWKg+2
         KsBKzaJNdURU13BdzuQJfARp2Fr5th5HekUoiibZK92NrWe8xsEsU0eaqH9+9WDWAp5S
         wCorRfCsSd6MJAIDt/PGLh8mD8ro/WmOG8wCBVXNzhupGh8WRQW7nsH3MCiVo2HeIZww
         SsLg==
X-Gm-Message-State: AOJu0YxBCprg5zPA8oxfJhQlE7tycSd9IOmVc5QUoI+LEyQAR9jfsxJI
	6bjbBsmHXW6+Kv1iO26rt8ks3E7VnLofZZTw4Cc880DYtot6+/tN81zOJe6Lqtx7GFD5qvsF+JN
	FaxAFPl6Ge36zJ9eAIrR2mIMY7HT6Qe+yGDgVeljX
X-Google-Smtp-Source: AGHT+IGiNd8itQkh8ZHpPsNXoJxPdx5gGCBpV1gU9J+xM8w1mgVsdwELYelrWrNEq2ww3fOjqee7U6srGGJ5tbIYVzM=
X-Received: by 2002:aa7:d483:0:b0:564:26d9:b4ac with SMTP id
 b3-20020aa7d483000000b0056426d9b4acmr6464433edr.41.1708529390830; Wed, 21 Feb
 2024 07:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Wed, 21 Feb 2024 23:29:39 +0800
Message-ID: <CAHB1NahoCEsw-vtu=6AUgG8oL0tTVV3gbP121zTgvdBzrMUo8w@mail.gmail.com>
Subject: A problem about BLK_OPEN_RESTRICT_WRITES
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

Hi

I saw that ext4 has supported BLK_OPEN_RESTRICT_WRITES in commits
aca740cecbe("fs: open block device after superblock creation")  and
afde134b5bd0("ext4: Block writes to journal device"). I'm not certain
whether these commits caused the following issue.

Environment:
6.8.0-rc3-00279-g4a7bbe7519b6-dirty(commit 4a7bbe7519b6a5).
sjc@sjc-laptop:~/linux$ mkfs.ext4 -V
mke2fs 1.47.0 (5-Feb-2023)
Using EXT2FS Library version 1.47.0
sjc@sjc-laptop:~/linux$ mount -V
mount from util-linux 2.39.1 (libmount 2.39.1: selinux, smack, btrfs,
verity, namespaces, idmapping, assert, debug)

Problem:
When I mounted the ext4 file system in the qemu system, I encountered
the following error:
root@q:~/linux# mount -t ext4 ext4.img  /mnt/ext4/
[  848.897532] loop1: detected capacity change from 0 to 2097152
[  848.905535] /dev/loop1: Can't open blockdev
mount: /mnt/ext4: /dev/loop1 already mounted or mount point busy.
       dmesg(1) may have more information after failed mount system call.

I reviewed the relevant code and found that the mount program first
calls the openat system call to open the /dev/loop1 file, followed by
the mount system call (with /dev/loop1 as the first parameter).

As for the former openat system call, it eventually reaches the chain
of (vfs_open->do_dentry_open->blkdev_open->bdev_open_by_dev->bdev_claim_write_access).
In bdev_claim_write_access, the following logic applies:
            /* Claim exclusive or shared write access. */
            if (mode & BLK_OPEN_RESTRICT_WRITES)
                    bdev_block_writes(bdev);
            else if (mode & BLK_OPEN_WRITE)
                    bdev->bd_writers++;
The argument mode here doesn't set BLK_OPEN_RESTRICT_WRITES flag, so
goes bdev->bd_writers++.

And in the latter mount system call, the following logic is followed:
(vfs_get_tree->get_tree_bdev->setup_bdev_super->bdev_open_by_dev->bdev_may_open).
In bdev_may_open, the following logic applies:
            if (mode & BLK_OPEN_RESTRICT_WRITES && bdev->bd_writers > 0)
                    return false;

Due to the fact that the argument mode has already been set with the
BLK_OPEN_RESTRICT_WRITES flag in the setup_bdev_super function, and
since bdev->bd_writers is already 1 at this point, the function
returns false. This ultimately leads to the mount system call
returning the EBUSY error.

Is this indeed a problem, or is there a misunderstanding in my
comprehension? If it is indeed a problem, can we resolve it by
removing the BLK_OPEN_RESTRICT_WRITES from the sb_open_mode macro
definition?

At last, here is a partial output of the trace captured using the
strace command:

openat(AT_FDCWD, "/home/sjc/linux/ext4.img", O_RDWR|O_CLOEXEC) = 3
openat(AT_FDCWD, "/dev/loop1", O_RDWR|O_CLOEXEC) = 4
ioctl(4, LOOP_CONFIGURE, {fd=3, block_size=0, info={lo_offset=0, lo_[
891.723213] /dev/loop1: Can't open blockdev
number=0, lo_flags=LO_FLAGS_AUTOCLEAR,
lo_file_name="/home/sjc/linux/ext4.img", ...}}) = 0
close(3)                                = 0
newfstatat(AT_FDCWD, "/dev/loop1", {st_mode=S_IFBLK|0600,
st_rdev=makedev(0x7, 0x1), ...}, 0) = 0
openat(AT_FDCWD, "/sys/dev/block/7:1", O_RDONLY|O_CLOEXEC) = 3
openat(3, "loop/autoclear", O_RDONLY|O_CLOEXEC) = 5
fcntl(5, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
newfstatat(5, "", {st_mode=S_IFREG|0444, st_size=4096, ...}, AT_EMPTY_PATH) = 0
read(5, "1\n", 4096)                    = 2
close(5)                                = 0
openat(3, "ro", O_RDONLY|O_CLOEXEC)     = 5
fcntl(5, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
newfstatat(5, "", {st_mode=S_IFREG|0444, st_size=4096, ...}, AT_EMPTY_PATH) = 0
read(5, "0\n", 4096)                    = 2
close(5)                                = 0
close(3)                                = 0
statx(AT_FDCWD, "/sbin/mount.ext4",
AT_STATX_DONT_SYNC|AT_NO_AUTOMOUNT, STATX_TYPE|STATX_MODE|STATX_INO,
0x7ffd6c0b8ce0) = -1 ENOENT (No such file or directory)
statx(AT_FDCWD, "/sbin/fs.d/mount.ext4",
AT_STATX_DONT_SYNC|AT_NO_AUTOMOUNT, STATX_TYPE|STATX_MODE|STATX_INO,
0x7ffd6c0b8ce0) = -1 ENOENT (No such file or directory)
statx(AT_FDCWD, "/sbin/fs/mount.ext4",
AT_STATX_DONT_SYNC|AT_NO_AUTOMOUNT, STATX_TYPE|STATX_MODE|STATX_INO,
0x7ffd6c0b8ce0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/run/mount/utab", {st_mode=S_IFREG|0644,
st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "/run/mount/utab", {st_mode=S_IFREG|0644,
st_size=0, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
access("/run/mount/utab", R_OK|W_OK)    = 0
mount("/dev/loop1", "/mnt/ext4", "ext4", 0, NULL) = -1 EBUSY (Device
or resource busy)


Best regards.

