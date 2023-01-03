Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BFC65B969
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 03:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjACCho (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 21:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjACChn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 21:37:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC22C8
        for <linux-ext4@vger.kernel.org>; Mon,  2 Jan 2023 18:37:41 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NmH0n5RKLzRqLX
        for <linux-ext4@vger.kernel.org>; Tue,  3 Jan 2023 10:36:09 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 10:37:39 +0800
Message-ID: <1346be25-5984-e980-9745-f3944c4ddb74@huawei.com>
Date:   Tue, 3 Jan 2023 10:37:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: ext4 superblock checksum invalid after running resize2fs
Content-Language: en-US
To:     Zsolt Murzsa <thxer@thxer.hu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <VI1PR0302MB2685C0378F00C4CC413B85E6C9F49@VI1PR0302MB2685.eurprd03.prod.outlook.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <VI1PR0302MB2685C0378F00C4CC413B85E6C9F49@VI1PR0302MB2685.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/1/3 8:35, Zsolt Murzsa wrote:
> Hi!
>
> I've had the same issue with twice in the last couple of days with the resize2fs online expand function.
> I have a md raid 1, with an LVM volume, which is formatted with ext4. I resized the volume (from 4T to 5T), then I ran resize2fs, which ran without error, the file system got bigger.
>
> After a few hours, I reset the machine (unsafely), due to some zombie processes, but after restarting, the system could not mount the filesystem.
> I checked the disks, and ran some hardware checks, but I didn't find anything wrong. I thought the hard reset caused some problem.
>
> That was the problem: "Superblock checksum does not match superblock". I tried several superblocks, e2fsck, testdisk, but nothing helped, dumpe2fs showed all the data about the superblock.
> I started to restore from a backup.
>
> In the meantime, I found the debugfs tool, with which I could skip the checksum check and thus see all the folders and files that I restored to a separate disk.
> I replaced the two drives, recreated md RAID 1, LVM, then reformatted with ext4, started copying the data back.
>
> I ran out of space so expanded the LV and ran resize2fs again (from 3T to 5T). It ran successfully again, the attached file system is 5T.
> Then I ran an e2fsck.
>
> "e2fsck -n /dev/vg1/data
> e2fsck 1.46.5 (30-Dec-2021)
> Warning!  /dev/vg1/data is mounted.
> ext2fs_open2: Superblock checksum does not match superblock
> e2fsck: Superblock invalid, trying backup blocks...
> e2fsck: Superblock checksum does not match superblock while trying to open /dev/vg1/data
>
> The superblock could not be read or does not describe a valid ext2/ext3/ext4
> filesystem.  If the device is valid and it really contains an ext2/ext3/ext4
> filesystem (and not swap or ufs or something else), then the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
>      e2fsck -b 8193 <device>
> or
>      e2fsck -b 32768 <device>"
>
> I'm shocked it happened again.
> I can currently write / read the files, but it is suspicious that I will not be able to mount the filesystem again.
> In the first case, I couldn't find a simple solution, but is it possible to fix the checksum somehow?
> It takes a lot of time to use debugfs to copy everything to another drive and back again.
>
> My current kernel version: 5.19.17-1-pve.
> I can attach all the superblocks (Both the first and second case), or any other information, if needed.
>
> Best Regards,
> Zsolt Murzsa

Hi Zsolt,

Maybe this patch on the mainline has fixed your problem:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a408f33e895e455f16cf964cb5cd4979b658db7b

--
With Best Regards,
Baokun Li
.
