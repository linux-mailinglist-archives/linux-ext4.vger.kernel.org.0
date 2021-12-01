Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9D946463E
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Dec 2021 06:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhLAFJK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Dec 2021 00:09:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31930 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhLAFJK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Dec 2021 00:09:10 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J3n912zM6zcbWF;
        Wed,  1 Dec 2021 13:05:41 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 13:05:48 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 13:05:47 +0800
Message-ID: <6e13a541-03db-7056-5e9d-23e4c0ab79b8@huawei.com>
Date:   Wed, 1 Dec 2021 13:05:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: Re: [PATCH] resize2fs : resize2fs failed due to the same name of
 tmpfs
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <54d44dbc-861d-8c49-9b29-2621c201ca4f@huawei.com>
In-Reply-To: <54d44dbc-861d-8c49-9b29-2621c201ca4f@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500018.china.huawei.com (7.185.36.186) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If there is a tmpfs with the same name as the disk, and mount before the 
disk,example:
	/dev/sdd /root/tmp tmpfs rw,seclabel,relatime 0 0
	/dev/sdd /root/mnt ext4 rw,seclabel,relatime 0 0

Create a hard link /dev/sdd-ln for the disk and resize2fs it.The items in
/proc/mounts are traversed, When you get to tmpfs,file!=mnt->mnt_fsname,
Therefore, the stat(mnt->mnt_fsname, &st_buf) branch is used,However, the
values of file_rdev and st_buf.st_rdev are the same.As a result, the system
mistakenly considers that disk is mounted to /root/tmp.As a result,resize2fs
fails.

mkdir /root/tmp
mkdir /root/mnt
mkfs.ext4 -F -b 1024 -E "resize=10000000" /dev/sdd 32768
mount -t tmpfs /dev/sdd /root/tmp
mount /dev/sdd /root/mnt
ln /dev/sdd /dev/sdd-ln
resize2fs /dev/sdd-ln 6G

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: guiyao <guiyao@huawei.com>
---
  lib/ext2fs/ismounted.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
index aee7d726..463a82a6 100644
--- a/lib/ext2fs/ismounted.c
+++ b/lib/ext2fs/ismounted.c
@@ -98,6 +98,7 @@ static errcode_t check_mntent_file(const char 
*mtab_file, const char *file,
  {
  	struct mntent 	*mnt;
  	struct stat	st_buf;
+	struct stat	dir_st_buf;
  	errcode_t	retval = 0;
  	dev_t		file_dev=0, file_rdev=0;
  	ino_t		file_ino=0;
@@ -144,8 +145,12 @@ static errcode_t check_mntent_file(const char 
*mtab_file, const char *file,
  		if (stat(mnt->mnt_fsname, &st_buf) == 0) {
  			if (ext2fsP_is_disk_device(st_buf.st_mode)) {
  #ifndef __GNU__
-				if (file_rdev && (file_rdev == st_buf.st_rdev))
-					break;
+				if (file_rdev && (file_rdev == st_buf.st_rdev)) {
+					if (stat(mnt->mnt_dir, &dir_st_buf) != 0)
+						continue;
+					if (file_rdev == dir_st_buf.st_dev)
+						break;
+				}
  				if (check_loop_mounted(mnt->mnt_fsname,
  						st_buf.st_rdev, file_dev,
  						file_ino) == 1)
-- 
2.23.0

在 2021/11/30 12:04, zhanchengbin 写道:
> If there is a tmpfs with the same name as the disk, and mount before the 
> disk,example:
>      /dev/sdd /root/tmp tmpfs rw,seclabel,relatime 0 0
>      /dev/sdd /root/mnt ext4 rw,seclabel,relatime 0 0
> 
> Create a hard link /dev/sdd-ln for the disk and resize2fs it.The items in
> /proc/mounts are traversed, When you get to tmpfs,file!=mnt->mnt_fsname,
> Therefore, the stat(mnt->mnt_fsname, &st_buf) branch is used,However, the
> values of file_rdev and st_buf.st_rdev are the same.As a result, the system
> mistakenly considers that disk is mounted to /root/tmp.As a 
> result,resize2fs
> fails.
> 
> mkdir /root/tmp
> mkdir /root/mnt
> mkfs.ext4 -F -b 1024 -E "resize=10000000" /dev/sdd 32768
> mount -t tmpfs /dev/sdd /root/tmp
> mount /dev/sdd /root/mnt
> ln /dev/sdd /dev/sdd-ln
> resize2fs /dev/sdd-ln 6G
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: guiyao@huawei.com
> ---
>   lib/ext2fs/ismounted.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
> index aee7d726..463a82a6 100644
> --- a/lib/ext2fs/ismounted.c
> +++ b/lib/ext2fs/ismounted.c
> @@ -98,6 +98,7 @@ static errcode_t check_mntent_file(const char 
> *mtab_file, const char *file,
>   {
>       struct mntent     *mnt;
>       struct stat    st_buf;
> +    struct stat    dir_st_buf;
>       errcode_t    retval = 0;
>       dev_t        file_dev=0, file_rdev=0;
>       ino_t        file_ino=0;
> @@ -144,8 +145,12 @@ static errcode_t check_mntent_file(const char 
> *mtab_file, const char *file,
>           if (stat(mnt->mnt_fsname, &st_buf) == 0) {
>               if (ext2fsP_is_disk_device(st_buf.st_mode)) {
>   #ifndef __GNU__
> -                if (file_rdev && (file_rdev == st_buf.st_rdev))
> -                    break;
> +                if (file_rdev && (file_rdev == st_buf.st_rdev)) {
> +                    if (stat(mnt->mnt_dir, &dir_st_buf) != 0)
> +                        continue;
> +                    if (file_rdev == dir_st_buf.st_dev)
> +                        break;
> +                }
>                   if (check_loop_mounted(mnt->mnt_fsname,
>                           st_buf.st_rdev, file_dev,
>                           file_ino) == 1)
