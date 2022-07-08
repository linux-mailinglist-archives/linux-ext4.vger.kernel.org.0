Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C656B7EE
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiGHLDm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jul 2022 07:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiGHLDj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jul 2022 07:03:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0FF642D;
        Fri,  8 Jul 2022 04:03:37 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LfVjx5WdmzpWCP;
        Fri,  8 Jul 2022 19:02:45 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 19:03:35 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 19:03:35 +0800
Subject: Re: [PATCH 2/2] ext4/058: set 256 blocks in a block group Set 256
 blocks in a block group
To:     Zorro Lang <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>, <linux-ext4@vger.kernel.org>
References: <20220707135917.373342-1-sunke32@huawei.com>
 <20220707135917.373342-3-sunke32@huawei.com>
 <20220707151833.72ggvyxjzz2e42kh@zlang-mailbox>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <5b019cf0-02ee-b7b8-9f08-b48e96ac74e8@huawei.com>
Date:   Fri, 8 Jul 2022 19:03:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220707151833.72ggvyxjzz2e42kh@zlang-mailbox>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your suggestions, I will improve them in v2.

ÔÚ 2022/7/7 23:18, Zorro Lang Ð´µÀ:
> On Thu, Jul 07, 2022 at 09:59:17PM +0800, Sun Ke wrote:
>> Set 256 blocks in a block group, then inject I/O pressure, it will
>> trigger off kernel BUG in ext4_mb_mark_diskspace_used.
>>
>> Regression test for commit a08f789d2ab5 ext4: fix bug_on
>> ext4_mb_use_inode_pa.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
> 
> About the subject:
> "ext4/058: set 256 blocks in a block group Set 256 blocks in a block group"
> 
> Don't use a fixed number for new case, you can use "ext4: ...". And I can't
> understand the meaning of this subject, except you say it's a duplicate :)
> 
> 
>>   tests/ext4/058     | 37 +++++++++++++++++++++++++++++++++++++
>>   tests/ext4/058.out |  2 ++
>>   2 files changed, 39 insertions(+)
>>   create mode 100755 tests/ext4/058
>>   create mode 100644 tests/ext4/058.out
>>
>> diff --git a/tests/ext4/058 b/tests/ext4/058
>> new file mode 100755
>> index 00000000..dc7903b7
>> --- /dev/null
>> +++ b/tests/ext4/058
>> @@ -0,0 +1,37 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
>> +#
>> +# FS QA Test 058
>> +#
>> +# Set 256 blocks in a block group, then inject I/O pressure,
>> +# it will trigger off kernel BUG in ext4_mb_mark_diskspace_used
>> +#
>> +# Regression test for commit
>> +# a08f789d2ab5 ext4: fix bug_on ext4_mb_use_inode_pa
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>       ^^^
> 
> This's comment can be removed.
> 
>> +_supported_fs generic
> 
> If it's a ext4 specific test case, don't use "generic" at here.
> 
> And _fixed_by_kernel_commit() is recommend.
> 
>> +_require_scratch
>> +_require_command "$KILLALL_PROG" killall
>> +
>> +# set 256 blocks in a block group
>> +MKFS_OPTIONS="-g 256"
>> +_scratch_mkfs >>$seqres.full 2>&1
> 
> I think
>    _scratch_mkfs_ext4 -g 256 >>$seqres.full 2>&1
> is enough. Does other mkfs options will affect this testing?
> 
> Or make sure mkfs passed:
> _scratch_mkfs -g 256 >>$seqres.full 2>&1 || _fail "mkfs failed"
> 
>> +_scratch_mount
>> +
>> +$FSSTRESS_PROG -d $SCRATCH_MNT -n 1000 -p 1 >> $seqres.full 2>&1 &
> 
> Is "-p 1" necessary?
> 
>> +sleep 3
>> +$KILLALL_PROG -q $FSSTRESS_PROG
>> +wait
> 
> Hmm.... one more background fsstress test case again ... if so, you need to make
> sure the fsstress processes be killed in _cleanup(). Please refer to other cases.
> 
> Besides that, I'm wondering if you really need to run fsstress in background?
> Due to from the code logic, you run and kill it directly, then do nothing.
> What special reason cause you have to run fsstress as that?
> 
> Thanks,
> Zorro
> 
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/058.out b/tests/ext4/058.out
>> new file mode 100644
>> index 00000000..fb5ca60b
>> --- /dev/null
>> +++ b/tests/ext4/058.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 058
>> +Silence is golden
>> -- 
>> 2.13.6
>>
> 
> .
> 
