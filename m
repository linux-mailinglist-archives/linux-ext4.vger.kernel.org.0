Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFDB698E5E
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 09:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBPIMg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 03:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPIMf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 03:12:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB72886B;
        Thu, 16 Feb 2023 00:12:34 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PHSKs5xCqznWCc;
        Thu, 16 Feb 2023 16:10:09 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Thu, 16 Feb 2023 16:12:04 +0800
Subject: Re: [PATCH v3 0/2] fix error flag covered by journal recovery
To:     Baokun Li <libaokun1@huawei.com>, Ye Bin <yebin@huaweicloud.com>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
 <fa2c6946-ab52-47f4-e5d2-49043eb2bd50@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63EDE553.2000701@huawei.com>
Date:   Thu, 16 Feb 2023 16:12:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <fa2c6946-ab52-47f4-e5d2-49043eb2bd50@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/2/16 15:18, Baokun Li wrote:
> On 2023/2/14 10:29, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Diff v3 Vs v2:
>> Only fix fs error flag lost when previous journal errno is not record
>> in disk. As this may lead to drop orphan list, however fs not record
>> error flag, then fsck will not repair deeply.
>>
>> Diff v2 vs v1:
>> Move call 'j_replay_prepare_callback' and 'j_replay_end_callback' from
>> ext4_load_journal() to jbd2_journal_recover().
>>
>> When do fault injection test, got issue as follows:
>> EXT4-fs (dm-5): warning: mounting fs with errors, running e2fsck is 
>> recommended
>> EXT4-fs (dm-5): Errors on filesystem, clearing orphan list.
>> EXT4-fs (dm-5): recovery complete
>> EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: 
>> data_err=abort,errors=remount-ro
>>
>> EXT4-fs (dm-5): recovery complete
>> EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: 
>> data_err=abort,errors=remount-ro
>>
>> Without do file system check, file system is clean when do second mount.
>> Theoretically, the kernel will not clear fs error flag. In 
>> errors=remount-ro
>> mode the last super block is commit directly. So super block in 
>> journal is
>> not uptodate. When do jounral recovery, the uptodate super block will be
>> covered by jounral data. If super block submit all failed after recover
>> journal, then file system error flag is lost. When do "fsck -a" couldn't
>> repair file system deeply.
>> To solve above issue we need to do extra handle when do super block 
>> journal
>> recovery.
>>
>>
>> Ye Bin (2):
>>    ext4: commit super block if fs record error when journal record
>>      without error
>>    ext4: make sure fs error flag setted before clear journal error
>>
>>   fs/ext4/super.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
> When we proceed in the flow of ( uninstall after injecting fault 
> triggered error -> mount
> kernel replay journal -> umount to view fsck info ), there are three 
> cases:
>
> 1. When an injection fault causes the ERROR_FS flag to not be saved to 
> disk, but j_errno
> is successfully saved to disk, PATCH 2/2 effectively ensures that 
> ERROR_FS is saved to disk
> so that fsck performs a force check to discover the error correctly.
>
> 2. When j_errno is lost and the ERROR_FS flag is saved, after the 
> journal replay：
>     a. The ext4_super_block on disk has neither error info nor 
> ERROR_FS flag;
>     b. The ext4_super_block in memory contains error info but no 
> ERROR_FS flag
>         because the error info is copied additionally during journal 
> replay;
>     c. The ext4_sb_info in memory contains both error info and 
> ERROR_FS flag.
> This means that the ext4_super_block in memory will be written to disk 
> the next time
> ext4_commit_super is executed, while the ERROR_FS flag in ext4_sb_info 
> will not be written
> to disk until ext4_put_super is called. So if there is a disk 
> deletion/power failure/disk offline,
> we will lose the ERROR_FS flag or even the error info.
>
> (In this case, repairing directly with e2fsck will not do a force 
> check either, because it
> relies on j_errno to recover the ERROR_FS flag after the journal 
> replay. And it reloads
> the information from the disk into memory after the journal replay, so 
> the
> ERROR_FS flag and error info are completely lost.)
>
> 3. If neither the ERROR_FS flag nor j_errno are saved to disk, we seem 
> to be unable to
> determine if a deep sweep is currently needed. But I think when 
> journal replay is needed
> it means that the file system exits abnormally,
> *Is it possible to consider e2fsck to do a force check after the 
> journal replay?*
Perhaps e2fsck can provide a command parameter, because it is 
unacceptable to
do so in scenarios with requirements for startup time.

