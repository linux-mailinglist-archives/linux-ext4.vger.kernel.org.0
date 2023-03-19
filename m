Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E86BFF7D
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Mar 2023 06:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCSFpK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Mar 2023 01:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCSFpE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Mar 2023 01:45:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E617CFD
        for <linux-ext4@vger.kernel.org>; Sat, 18 Mar 2023 22:45:01 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PfRZB2tcdzSmNl;
        Sun, 19 Mar 2023 13:41:38 +0800 (CST)
Received: from [10.174.179.254] (10.174.179.254) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 13:44:58 +0800
Subject: Re: [PATCH] tune2fs: check whether dev is mounted or in use before
 setting
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        <adilger@whamcloud.com>, Jan Kara <jack@suse.cz>,
        linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>, <libaokun1@huawei.com>
References: <8babc8eb-1713-91c9-1efa-496909340a6f@huawei.com>
 <20230318162421.GB11916@mit.edu>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <138552dd-c323-f9f9-9b26-84346527fd05@huawei.com>
Date:   Sun, 19 Mar 2023 13:44:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20230318162421.GB11916@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/3/19 0:24, Theodore Ts'o wrote:
> On Sat, Mar 18, 2023 at 11:36:03AM +0800, Zhiqiang Liu wrote:
>> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>
>> tune2fs is used to adjust various tunable filesystem pars, which
>> may conflict with kernel operations. So we should check whether
>> device is mounted or in use at the begin similar to e2fsck and mke2fs.
>>
>> Of course, we can ignore this check if -f is set.
> 
> Tune2fs is designed to work on mounted file systems.  There are
> individual checks for those changes which can not be safely done on
> mounted file systems, but most changes are safe to do on mounted file
> systems.
> 
Thanks for your reply.

Does quota setting is safely done on mounted or busy filesystems?

We have met a problem as follows,
# mkfs.ext4 /dev/sdd
# mount /dev/sdd /test
			# /test mountpoint is used in other namespace
# umount /dev/sdd
# tune2fs -O project,quota /dev/sdd
# mount -o prjquota /dev/sdd /test
# mount | grep sdd
/dev/sdd on /test type ext4 (rw,relatime,seclabel,prjquota)
# quotaon -Ppv /test
quotaon: Mountpoint (or device) /test not found or has no quota enabled

Here, tune2fs only check whether /test is mountted when setting project,quota,
it does not check whether /test is busy (/test is mounted in other namespace).
Users will be very confused about why prjquota does no take effect.

Should we check whether mountpoint is busy when setting quota?

Zhiqiang Liu.

> Cheers,
> 
> 					- Ted
> 
> .
> 
