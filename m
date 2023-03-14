Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A56B94F0
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 13:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCNM4C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 08:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjCNMzP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 08:55:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1A8ACB8C;
        Tue, 14 Mar 2023 05:50:43 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PbXrH5Q8MznXTd;
        Tue, 14 Mar 2023 20:28:47 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 20:31:43 +0800
Subject: Re: [PATCH v2 1/5] ext4: Fix reusing stale buffer heads from last
 failed mounting
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20230313132021.672134-1-chengzhihao1@huawei.com>
 <20230313132021.672134-2-chengzhihao1@huawei.com>
 <20230314113342.74g2pfwe5y7b5poa@quack3>
 <b7d108d6-9e5a-d88a-305d-932e75098b09@huawei.com>
 <20230314121125.tnz22hckcaj46kp6@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f86584f6-3877-ff18-47a1-2efaa12d18b2@huawei.com>
Date:   Tue, 14 Mar 2023 20:31:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230314121125.tnz22hckcaj46kp6@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> On Tue 14-03-23 20:01:46, Zhihao Cheng wrote:
>> 在 2023/3/14 19:33, Jan Kara 写道:
>> Hi Jan,
>>
>>>
>>>> @@ -1271,14 +1277,8 @@ static void ext4_put_super(struct super_block *sb)
>>>>    	sync_blockdev(sb->s_bdev);
>>>>    	invalidate_bdev(sb->s_bdev);
>>
>> For journal in the inode case, journal bhs come from block device, which
>> means buffers will be dropped after this line 'invalidate_bdev(sb->s_bdev)'
>> being executed.
> 
> Right, I've missed that. But then why do you remove the sbi->s_journal_bdev
> != sb->s_bdev condition below?
> 

I think 'sbi->s_journal_bdev != sb->s_bdev' always becomes true if 
sbi->s_journal_bdev exists.


mount_bdev
  fmode_t mode = FMODE_READ | FMODE_EXCL
  bdev_a = blkdev_get_by_path(dev_name, mode, fs_type)


mount_bdev->ext4_fill_super->ext4_load_and_init_journal->ext4_load_journal->ext4_get_dev_journal:
  bdev_b = ext4_blkdev_get(j_dev, sb)
   bdev_b = blkdev_get_by_dev(dev, FMODE_READ|FMODE_WRITE|FMODE_EXCL, sb)
  EXT4_SB(sb)->s_journal_bdev = bdev_b


bdev_a cannot be bdev_b, because bd_prepare_to_claim() makes sure the 
same block device cannot be openned twice with mode 'FMODE_EXCL'.
