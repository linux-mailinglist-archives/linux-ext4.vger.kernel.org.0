Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD64822B2
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Dec 2021 09:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhLaIPI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Dec 2021 03:15:08 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31127 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhLaIPI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Dec 2021 03:15:08 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JQHtr0cbvz8w9F;
        Fri, 31 Dec 2021 16:12:36 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 16:15:05 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 16:15:05 +0800
Message-ID: <fc29b8f3-4214-cb62-afa4-98a6e7ff8b34@huawei.com>
Date:   Fri, 31 Dec 2021 16:15:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] resize2fs : resize2fs failed due to the same name of
 tmpfs
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <54d44dbc-861d-8c49-9b29-2621c201ca4f@huawei.com>
 <YcI/xt1IiJKLN/Bw@mit.edu>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <YcI/xt1IiJKLN/Bw@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500024.china.huawei.com (7.185.36.10) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

To clarify, commit ea4d53b7b9079fd6e2cc34cf569a993a183bfbd2  does
solve the problem for mounting a disk with the same name as file
  system "tmpfs". However, after mounting it, "ln" command (creating
  a hard link) and "resize2fs" command still report an error.

example:
dev_name="/dev/sdc" (ps: a disk in you self)
mkdir /root/tmp
mkdir /root/mnt
mkfs.ext4 -F -b 1024 -E "resize=10000000" "${dev_name}" 32768
mount -t tmpfs "${dev_name}" /root/tmp
mount "${dev_name}" /root/mnt
ln "${dev_name}" "${dev_name}"-ln
resize2fs "${dev_name}"-ln 6G

You can see the disk is mounted on /root/tmp, but it should be
mounted on /root/mnt actually. I will modify the commit message
  and submit the v2 patch to solve this problem.

在 2021/12/22 4:57, Theodore Ts'o 写道:
> On Tue, Nov 30, 2021 at 12:04:48PM +0800, zhanchengbin wrote:
>> If there is a tmpfs with the same name as the disk, and mount before the
>> disk,example:
>> 	/dev/sdd /root/tmp tmpfs rw,seclabel,relatime 0 0
>> 	/dev/sdd /root/mnt ext4 rw,seclabel,relatime 0 0
> 
> This should already be fixed e2fsprogs 1.45.5+ via this commit:
> 
> commit ea4d53b7b9079fd6e2cc34cf569a993a183bfbd2
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Sun Nov 10 12:11:49 2019 -0500
> 
>      libext2fs/ismounted.c: check device id in advance to skip false device names
>      
>      If there is a trickster which tries to use device names as the mount
>      device for pseudo-file systems, the resulting /proc/mounts can confuse
>      ext2fs_check_mount_point().  (So far as I can tell, there's no good
>      reason to do this, but sysadmins do the darnest things.)
>      
>      An example of this might be the following /proc/mounts excerpt:
>      
>      /dev/sdb /mnt2 tmpfs rw,relatime 0 0
>      /dev/sdb /mnt ext4 rw,relatime 0 0
>      
>      This is created via "mount -t tmpfs /dev/sdb /mnt2" followed via
>      "mount -t ext4 /dev/sdb /mnt".  (Normally, a sane mount of tmpfs would
>      use something like "mount -t tmpfs tmpfs /mnt2".)
>      
>      Fix this by double checking the st_rdev of the claimed mountpoint and
>      match it with the dev_t of the device.  (Note that the GNU HURD
>      doesn't support st_rdev, so we can't solve this problem for the HURD.)
>      
>      Reported-by: GuiYao <guiyao@huawei.com>
>      Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> I've tested via tst_ismounted and I can't replicate the issue you've described.
> 
> % cd /build/e2fsprogs-maint/lib/ext2fs
> % make tst_ismounted
> % sudo ./tst_ismounted /dev/dm-7
> Bogus entry in /proc/mounts!  (/dev/dm-7 is not mounted on /root/tmp)
> Device /dev/dm-7 reports flags 11
>          /dev/dm-7 is apparently in use.
>          /dev/dm-7 is mounted.
>          /dev/dm-7 is mounted on /root/mnt.
> 
> Cheers,
> 
> 							- Ted
> .
> 
