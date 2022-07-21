Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE76057C2A4
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 05:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiGUDYk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 23:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGUDYj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 23:24:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B8481FB;
        Wed, 20 Jul 2022 20:24:37 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LpHrt00g5zWf2P;
        Thu, 21 Jul 2022 11:20:45 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 11:24:34 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 11:24:33 +0800
Subject: Re: [PATCH v3 1/2] ext4: resize fs after resize_inode without e2fsck
To:     Zorro Lang <zlang@redhat.com>, Theodore Ts'o <tytso@mit.edu>
CC:     <fstests@vger.kernel.org>, <linux-ext4@vger.kernel.org>
References: <20220713092859.3881376-1-sunke32@huawei.com>
 <20220713092859.3881376-2-sunke32@huawei.com>
 <20220714154607.qq6cqgvncxhsn66w@zlang-mailbox> <YtCSAjiMc9RElnHu@mit.edu>
 <20220715180815.gegmapvruor6vin3@zlang-mailbox>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <5a2415ab-e40f-da66-abc0-aca2d49d77d1@huawei.com>
Date:   Thu, 21 Jul 2022 11:24:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220715180815.gegmapvruor6vin3@zlang-mailbox>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



ÔÚ 2022/7/16 2:08, Zorro Lang Ð´µÀ:
> On Thu, Jul 14, 2022 at 06:00:34PM -0400, Theodore Ts'o wrote:
>> On Thu, Jul 14, 2022 at 11:46:07PM +0800, Zorro Lang wrote:
>>> On Wed, Jul 13, 2022 at 05:28:58PM +0800, Sun Ke wrote:
>>>> +
>>>> +# forget to run requested e2fsck after resize_inode
>>>> +$TUNE2FS_PROG -O ^resize_inode $SCRATCH_DEV | grep -w "e2fsck"
>>>> +
>>>> +_scratch_mount
>>>> +
>>>> +# resize fs will trigger NULL pointer in ext4_flex_group_add
>>>> +$RESIZE2FS_PROG $SCRATCH_DEV 1G >> $seqres.full 2>&1
>>>> +
>>>> +echo "Silence is golden"
>>    ...
>>>> diff --git a/tests/ext4/057.out b/tests/ext4/057.out
>>>> new file mode 100644
>>>> index 00000000..4784ad7e
>>>> --- /dev/null
>>>> +++ b/tests/ext4/057.out
>>>> @@ -0,0 +1,3 @@
>>>> +QA output created by 057
>>>> +Please run e2fsck -f on the filesystem.
>>>
>>> If you hope to match this line, means this case isn't "Silence is golden".
>>>
>>> I don't know why you'd to have this line, it looks not suit to be golden
>>> image. If you'd like to make sure current ext4 supports "resize_inode"
>>> feature, you can use:
>>>    _require_scratch_ext4_feature resize_inode
>>
>> That's not the problem.
>>
>> The "tune2fs -O ^resize_inode" command is printing that message as a
>> reminder that it would be a Really Good idea to run e2fsck on the file
>> system, because tune2fs doesn't completely remove the resize inode
>> after turning off that feature.
>>
>> The commit which this test is trying to verify is that the kernel
>> won't oops if the system adminsitrator ignores the rather explicit
>> request:
>>
>> Please run e2fsck -f on the filesystem.
>>
>> ... and blithely mounts the file system without running fsck -f on the
>> file system first.  While it could be argued that a system
>> administrator which fails to follow instructions deserves everything
>> they get, we decided the as a quality of implementation issue, it
>> would be better if the kernel didn't dereference a NULL pointer in
>> that case.  :-)
>>
>> The one thing I'll note is that it is possible that at some point in
>> the future, tune2fs could be improved so that it cleanly removes the
>> resize_inode when the resize inode feature is removed, so that running
>> "fsck.ext4 -f" is no longer necessary.  So if you want to future-proof
> 
> Good to know :)
> 
>> the test so it doesn't fail once tune2fs is made more idiot-proof, it
>> might be better if the test did something like this:
>>
>> mke2fs -t ext4 -O ^resize_inode /dev/vdc 512m
>> debugfs -w -R "set_super_value s_reserved_gdt_blocks 100" /dev/vdc
> 
> So make sure there're reserved GDT blocks, even if disable resize_inode
> feature.
> 
>> mount -t ext4 /dev/vdc /vdc
>> resize2fs /dev/vdc 1G
> 
> Thanks Ted! That's really helpful to get review points from ext4 expert.
> 
> Hi Ke, would you mind re-sending this case refer to above review points?
> You can refer to below code, but I didn't test it, so please test and make
> sure it works and can reproduce the bug. Feel free to improve it if something
> wrong.

Glad to do that, it can reproduce the bug.

Thanks,
Sun Ke
> 
> _require_command "$DEBUGFS_PROG" debugfs
> ...
> 
> MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> 	>>$seqres.full 2>&1 || _fail "mkfs failed"
> $DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
> 	>>$seqres.full 2>&1
> $DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
> 	grep "Reserved GDT blocks"
> _scratch_mount
> $RESIZE2FS_PROG $SCRATCH_DEV 1g >> $seqres.full 2>&1
> 
> 
> Thanks,
> Zorro
> 
> 
>>
>> Translating the above from commands suitable for manual trial using
>> "kvm-xfstests shell" to a proper xfstests script is left as an
>> exercise for the reader.  :-)
>>
>> 					- Ted
>>
> 
> .
> 
