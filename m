Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AF3697348
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Feb 2023 02:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBOBPq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Feb 2023 20:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjBOBPp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Feb 2023 20:15:45 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7CC32CF0;
        Tue, 14 Feb 2023 17:15:17 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PGg6T4kdmz16Ncn;
        Wed, 15 Feb 2023 09:12:33 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 15 Feb 2023 09:14:53 +0800
Subject: Re: [PATCH v2 0/6] fix error flag covered by journal recovery
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
References: <20230210032044.146115-1-yebin@huaweicloud.com>
 <20230210115628.l6b4zukudqcp5hot@quack3>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63EC320C.2090404@huawei.com>
Date:   Wed, 15 Feb 2023 09:14:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20230210115628.l6b4zukudqcp5hot@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/2/10 19:56, Jan Kara wrote:
> Hello!
>
> On Fri 10-02-23 11:20:38, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Diff v2 vs v1:
>> Move call 'j_replay_prepare_callback' and 'j_replay_end_callback' from
>> ext4_load_journal() to jbd2_journal_recover().
>>
>> When do fault injection test, got issue as follows:
>> EXT4-fs (dm-5): warning: mounting fs with errors, running e2fsck is recommended
>> EXT4-fs (dm-5): Errors on filesystem, clearing orphan list.
>> EXT4-fs (dm-5): recovery complete
>> EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: data_err=abort,errors=remount-ro
>>
>> EXT4-fs (dm-5): recovery complete
>> EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: data_err=abort,errors=remount-ro
>>
>> Without do file system check, file system is clean when do second mount.
>> Theoretically, the kernel will not clear fs error flag. In errors=remount-ro
>> mode the last super block is commit directly. So super block in journal is
>> not uptodate. When do jounral recovery, the uptodate super block will be
>> covered by jounral data. If super block submit all failed after recover
>> journal, then file system error flag is lost. When do "fsck -a" couldn't
>> repair file system deeply.
>> To solve above issue we need to do extra handle when do super block journal
>> recovery.
> Thanks for the patches. Looking through the patches, I think this is a bit
> of an overengineering for the problem at hand. The only thing that is
> really worth preserving so that it is not lost after journal replay is the
> error information. So in ext4_load_journal() I would just save that if
> EXT4_ERROR_FS is set in es->s_state before journal replay and restore it
> after journal replay. Sure if the superblock write during journal replay
> succeeds but the write restoring the error information fails, we will loose
> the error information but that is so unlikely in practice that I don't
> think it is really worth complicating the code for it. Also the only
> downside is we will loose the information there is some error in the
> filesystem - we'll soon find that out again anyway :).
>
> 								Honza
Yes, this solution seems a little cumbersome, but to solve the problem 
of error
information loss, I can only think of this solution.
I re-analyzed the issue scenario. Because the error information of the 
last journal
super block was not recorded. This will cause that the error flag will 
not be updated
when the super block is submitted subsequently. However, when processing 
orphan
list, the file system errors were recorded in the memory, and the orphan 
list were
cleared directly, resulting in file system inconsistencies. To solve 
above isuue, i sent
V3 patch.
>> Ye Bin (6):
>>    jbd2: introduce callback for recovery journal
>>    ext4: introudce helper for jounral recover handle
>>    jbd2: do extra handle when do journal recovery
>>    ext4: remove backup for super block when recovery journal
>>    ext4: fix super block checksum error
>>    ext4: make sure fs error flag setted before clear journal error
>>
>>   fs/ext4/ext4_jbd2.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/ext4/ext4_jbd2.h  |  2 ++
>>   fs/ext4/super.c      | 18 ++++--------
>>   fs/jbd2/recovery.c   | 27 ++++++++++++++++++
>>   include/linux/jbd2.h | 11 ++++++++
>>   5 files changed, 112 insertions(+), 12 deletions(-)
>>
>> -- 
>> 2.31.1
>>

