Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1912622B
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2019 13:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfLSMb2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Dec 2019 07:31:28 -0500
Received: from mail-vk1-f171.google.com ([209.85.221.171]:33509 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMb1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Dec 2019 07:31:27 -0500
Received: by mail-vk1-f171.google.com with SMTP id i78so1582534vke.0
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2019 04:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kKUQOO8GAOxSyLrOrJIhghBIrcK2BmQyDPGG7pLmQHs=;
        b=OAS9I7sTnwBYXbjfWHTFStE8NXCpQHW9SDDrf0fRPIIesRzWe+McqoaYSmWDknVmSg
         v9rVVEn06iZ+2phZXOkdtby9zKoIVMzinMtjVbp5+IdPksZSGVTQtl+41PCPRFCD1Q/e
         Ew5vrQZCWeCpzbeaxhVo0Bguphn+TFiWjZRxybuMb4iVUBgrcvY0Xvw485ZtEwW44z+V
         LS44CZEHyv/+TMwga10FhNuurWhIAI6tnXL1wP1NDvigipG9vKatRkztz4Nu21yN4kRt
         bTaiRVhJVyXzOnWTPzng3IBL7dRBHGhorwyKhEn2l89ayWVD4VgAIU65kgthYJ9si3I0
         3rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kKUQOO8GAOxSyLrOrJIhghBIrcK2BmQyDPGG7pLmQHs=;
        b=bG1ZkE6xL/bi/jCcWBDGsRTMDwSycN6GdyO6dSmtQ/fjfw1vhhSJFL3cqX9EVrxgpV
         6Ji+VIKiPdpCnJUQRa+XUvo8kAiwyhEKE3H8Wxhh2qqYYppBAn+lvdyT/WG5EE1fIevh
         ZNtfMiU6PH3+GP7TTVfm6GngpODYoas1fzTytKotsBOgUUtqi33vK/B0mJ6W19eOsjOJ
         VwwShYLKqA5jpnN7eMdDL8UNCtpJeYs7StW2b7nOIfkmSOXVQ4c/9Yj0JEyqZv/YDkkG
         BzVXChR0ge6YI9qGG95W/Qkw1BxL2njNiSYoHYTM5mxhBaOjMcSdF34QPwcV4CMiwKU3
         dHuQ==
X-Gm-Message-State: APjAAAVPiIpiYIuEP70vEfCl8WJkayMkIZceLaNXXcDLKdf+Zh3H6t+u
        W6SiZr3MMcl8QWc4G8E42gQVebf0bb+nVLo9DYj+OWKDl8s=
X-Google-Smtp-Source: APXvYqwE3J+VIlQiUo+S68INeDwzs/vo9Zasnn0rCyxg3CpgSOpwbXdqwebiqwdpfLZEsFGtVMQlJxCsZrW0KOu2o0I=
X-Received: by 2002:a1f:4354:: with SMTP id q81mr5617470vka.31.1576758686211;
 Thu, 19 Dec 2019 04:31:26 -0800 (PST)
MIME-Version: 1.0
From:   liming wu <wu860403@gmail.com>
Date:   Thu, 19 Dec 2019 20:31:14 +0800
Message-ID: <CAPnMXWX7LvMXWTTWf6WHSuOaU7EVVPRz88i-T0h9NBRy6imeKQ@mail.gmail.com>
Subject: 
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi


Who can help analyze the following message . Or give me some advice, I
will appreciate it very much.

Dec 17 22:14:42 bdsitdb222 kernel: Buffer I/O error on device dm-7,
logical block 810449
Dec 17 22:14:42 bdsitdb222 kernel: lost page write due to I/O error on dm-7
Dec 17 22:14:48 bdsitdb222 kernel: Buffer I/O error on device dm-7,
logical block 283536
Dec 17 22:14:48 bdsitdb222 kernel: lost page write due to I/O error on dm-7
Dec 17 22:14:48 bdsitdb222 kernel: Buffer I/O error on device dm-7,
logical block 283537
Dec 17 22:14:48 bdsitdb222 kernel: lost page write due to I/O error on dm-7
Dec 17 22:14:48 bdsitdb222 kernel: JBD: Detected IO errors while
flushing file data on dm-7
Dec 17 22:15:42 bdsitdb222 kernel: Buffer I/O error on device dm-8,
logical block 127859
Dec 17 22:15:42 bdsitdb222 kernel: lost page write due to I/O error on dm-8
Dec 17 22:15:42 bdsitdb222 kernel: JBD: Detected IO errors while
flushing file data on dm-8
Dec 17 22:15:48 bdsitdb222 kernel: Aborting journal on device dm-7.
Dec 17 22:15:48 bdsitdb222 kernel: EXT3-fs (dm-7): error in
ext3_new_blocks: Journal has aborted
Dec 17 22:15:48 bdsitdb222 kernel: EXT3-fs (dm-7): error in
ext3_reserve_inode_write: Journal has aborted
Dec 17 22:16:42 bdsitdb222 kernel: Aborting journal on device dm-8.
Dec 17 22:16:42 bdsitdb222 kernel: EXT3-fs (dm-7): error:
ext3_journal_start_sb: Detected aborted journal
Dec 17 22:16:42 bdsitdb222 kernel: EXT3-fs (dm-7): error: remounting
filesystem read-only
Dec 17 22:16:48 bdsitdb222 kernel: Buffer I/O error on device dm-7,
logical block 23527938
Dec 17 22:16:48 bdsitdb222 kernel: lost page write due to I/O error on dm-7
Dec 17 22:16:48 bdsitdb222 kernel: Buffer I/O error on device dm-7,
logical block 0
Dec 17 22:16:48 bdsitdb222 kernel: lost page write due to I/O error on dm-7
Dec 17 22:16:48 bdsitdb222 kernel: JBD: I/O error detected when
updating journal superblock for dm-7.
Dec 17 22:17:05 bdsitdb222 kernel: EXT3-fs (dm-7): error in
ext3_orphan_add: Journal has aborted
Dec 17 22:17:05 bdsitdb222 kernel: __journal_remove_journal_head:
freeing b_committed_data

plus info:
it's KVM
# uname -a
Linux bdsitdb222 2.6.32-279.19.1.el6.62.x86_64 #6 SMP Mon Dec 3
22:54:25 CST 2018 x86_64 x86_64 x86_64 GNU/Linux1

# cat /proc/mounts
rootfs / rootfs rw 0 0
proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
devtmpfs /dev devtmpfs
rw,nosuid,relatime,size=8157352k,nr_inodes=2039338,mode=755 0 0
devpts /dev/pts devpts rw,relatime,gid=5,mode=620,ptmxmode=000 0 0
tmpfs /dev/shm tmpfs rw,nosuid,nodev,relatime 0 0
/dev/mapper/systemvg-rootlv / ext4 rw,relatime,barrier=1,data=ordered 0 0
/proc/bus/usb /proc/bus/usb usbfs rw,relatime 0 0
/dev/vda1 /boot ext4 rw,relatime,barrier=1,data=ordered 0 0
/dev/mapper/systemvg-homelv /home ext4 rw,relatime,barrier=1,data=ordered 0 0
/dev/mapper/systemvg-optlv /opt ext3
rw,relatime,errors=continue,barrier=1,data=ordered 0 0
/dev/mapper/systemvg-tmplv /tmp ext3
rw,relatime,errors=continue,barrier=1,data=ordered 0 0
/dev/mapper/systemvg-usrlv /usr ext4 rw,relatime,barrier=1,data=ordered 0 0
/dev/mapper/systemvg-varlv /var ext4 rw,relatime,barrier=1,data=ordered 0 0
/dev/mapper/datavg-datalv /mysql/data ext3
rw,relatime,errors=continue,barrier=1,data=ordered 0 0
/dev/mapper/datavg-binloglv /mysql/binlog ext3
rw,relatime,errors=continue,barrier=1,data=ordered 0 0
none /proc/sys/fs/binfmt_misc binfmt_misc rw,relatime 0 0
sunrpc /var/lib/nfs/rpc_pipefs rpc_pipefs rw,relatime 0 0
none /sys/kernel/debug debugfs rw,relatime 0 0

# ll /dev/mapper/
total 0
crw-rw---- 1 root root 10, 58 Dec 19 19:21 control
lrwxrwxrwx 1 root root      7 Dec 19 19:21 datavg-binloglv -> ../dm-3
lrwxrwxrwx 1 root root      7 Dec 19 19:21 datavg-datalv -> ../dm-2
lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-homelv -> ../dm-4
lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-optlv -> ../dm-7
lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-rootlv -> ../dm-1
lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-swaplv -> ../dm-0
lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-tmplv -> ../dm-6
lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-usrlv -> ../dm-8
lrwxrwxrwx 1 root root      7 Dec 19 19:21 systemvg-varlv -> ../dm-5
