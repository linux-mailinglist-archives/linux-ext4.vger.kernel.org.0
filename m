Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A8173DE4B
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jun 2023 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjFZL4u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jun 2023 07:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFZL4u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jun 2023 07:56:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A31AD
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 04:56:48 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QqR8y45VPzLmty;
        Mon, 26 Jun 2023 19:54:42 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 19:56:45 +0800
Message-ID: <58aea170-bb45-a8d5-a2c7-c4967d02b82b@huawei.com>
Date:   Mon, 26 Jun 2023 19:56:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [bug report] tune2fs: filesystem inconsistency occurs by
 concurrent write
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>, <liuzhiqiang26@huawei.com>
References: <29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com>
 <20230626021758.GF8954@mit.edu>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230626021758.GF8954@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500022.china.huawei.com (7.185.36.66) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your explanation, it's a great idea.

  - bin.

On 2023/6/26 10:17, Theodore Ts'o wrote:
> On Mon, Jun 26, 2023 at 12:00:08AM +0800, zhanchengbin wrote:
>> Tune2fs does not recognize writes to the manipulated filesystem in another
>> namespace, there will be two simultaneous write operations on a
>> block, resulting in filesystem inconsistencies.
> 
> What you are reporting has nothing to do with namespaces, since
> "tune2fs -e remount-ro /dev/sdb" is something which is allowed
> regardless of whether the file system is mounted.  What reproduction
> is effectively doing is trying to set up a race between when tune2fs
> writes a byte to update to update the errors behavior, and when the
> actual unmount of the file system happens (e.g., when the last
> namespace unmounts the file system).  At that point, the kernel is
> going to be updating the superblock as part of the unmount, and then
> it calculates the superblock, and then it writes out the superblock.
> 
> If the tune2fs races with the unmount, it's possible for the tune2fs
> update of the error beavhiour bit, and the update of the superblock
> checksum, to race with the kernel's final update of the superblock,
> includinig its attempt to update the checksum.
> 
> There are some workarounds to this, but ultimately, we need to replace
> the ad-hoc modification of the block device by tune2fs with some
> ioctls which specifically update superblock when the file system
> mounted. >
> As far as whether or not tune2fs can detect if the file system is
> mounted, what we can do is check to see if the block device is busy.
> If it is mounted in some other namespace, we won't be able to see it
> mounted in /proc/self/mounts, but we can see that it's not possible to
> open the block device with O_EXCL.
> 
> Compare:
> 
> root@kvm-xfstests:~# /vtmp/tst_ismounted /dev/vdc
> Device /dev/vdc reports flags 31
>          /dev/vdc is apparently in use.
>          /dev/vdc is mounted.
>          /dev/vdc is mounted on /vdc.
> 
> and then "unshare -m" in another terminal, followed by umount /dev/vdc
> in the first terminal:
> 
> root@kvm-xfstests:~# /vtmp/tst_ismounted /dev/vdc
> Device /dev/vdc reports flags 10
>          /dev/vdc is apparently in use.
> 
> ... and then after we exit the last mount namespace which was keeping
> /dev/vdc mounted:
> 
> root@kvm-xfstests:~# [ 2409.811328] EXT4-fs (vdc): unmounting filesystem bdc026fd-85a8-4ccf-94f8-961487000293.
> root@kvm-xfstests:~# /vtmp/tst_ismounted /dev/vdc
> Device /dev/vdc reports flags 00
> 
> Cheers,
> 
> 						- Ted
> 
> .
> 
