Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6733C4C2632
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Feb 2022 09:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiBXI3s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Feb 2022 03:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiBXI3o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Feb 2022 03:29:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A627791A
        for <linux-ext4@vger.kernel.org>; Thu, 24 Feb 2022 00:28:54 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K45Y04K3Gzbbjh;
        Thu, 24 Feb 2022 16:24:20 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 16:28:52 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 16:28:52 +0800
Message-ID: <43391b1d-d58c-f954-e861-1176eac48443@huawei.com>
Date:   Thu, 24 Feb 2022 16:28:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] resize2fs: resize2fs disk hardlinks will be error
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
References: <9dcadf7a-b12a-c977-2de2-222e20f0cebe@huawei.com>
In-Reply-To: <9dcadf7a-b12a-c977-2de2-222e20f0cebe@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100026.china.huawei.com (7.185.36.103) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

friendly ping..

在 2022/1/4 22:23, zhanchengbin 写道:
> Resize2fs disk hardlinks which mounting after the same name as tmpfs
>   filesystem it will be error. The items in /proc/mounts are traversed,
> when you get to tmpfs,file!=mnt->mnt_fsname, therefore, the
> stat(mnt->mnt_fsname, &st_buf) branch is used, however, the values of
>   file_rdev and st_buf.st_rdev are the same. As a result, the system
> mistakenly considers that disk is mounted to /root/tmp. As a result
> , resize2fs fails.
> 
> example:
> dev_name="/dev/sdc" (ps: a disk in you self)
> mkdir /root/tmp
> mkdir /root/mnt
> mkfs.ext4 -F -b 1024 -E "resize=10000000" "${dev_name}" 32768
> mount -t tmpfs "${dev_name}" /root/tmp
> mount "${dev_name}" /root/mnt
> ln "${dev_name}" "${dev_name}"-ln
> resize2fs "${dev_name}"-ln 6G
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
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
