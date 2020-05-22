Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346671DDDC0
	for <lists+linux-ext4@lfdr.de>; Fri, 22 May 2020 05:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEVDJl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 May 2020 23:09:41 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49473 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbgEVDJl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 21 May 2020 23:09:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TzEzuWv_1590116977;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TzEzuWv_1590116977)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 May 2020 11:09:38 +0800
Subject: Re: [PATCH RFC] ext4: fix partial cluster initialization when
 splitting extent
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        joseph.qi@linux.alibaba.com
References: <1589444097-38535-1-git-send-email-jefflexu@linux.alibaba.com>
 <20200514222120.GB4710@localhost.localdomain>
 <20200518220804.GA20248@localhost.localdomain>
 <9b526ae9-cba6-35dd-0424-61e8fa5ab016@linux.alibaba.com>
 <20200521212619.GA10473@localhost.localdomain>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <5d4362c8-b11f-e7ef-8f48-baf1286c9289@linux.alibaba.com>
Date:   Fri, 22 May 2020 11:09:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521212619.GA10473@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for reviewing. I will send a formal patch later ;)

Thanks,

Jeffle


On 5/22/20 5:26 AM, Eric Whitney wrote:
> * JeffleXu <jefflexu@linux.alibaba.com>:
>> On 5/19/20 6:08 AM, Eric Whitney wrote:
>>> Hi, Jeffle:
>>>
>>> What kernel were you running when you observed your failures?  Does your
>>> patch resolve all observed failures, or do any remain?  Do you have a
>>> simple test script that reproduces the bug?
>>>
>>> I've made almost 1000 runs of shared/298 on various bigalloc configurations
>>> using Ted's test appliance on 5.7-rc5 and have not observed a failure.
>>> Several auto group runs have also passed without failures.  Ideally, I'd
>>> like to be able to reproduce your failure to be sure we fully understand
>>> what's going on.  It's still the case that the "2" is wrong, but I think
>>> that code in rm_leaf may be involved in an unexpected way.
>>>
>>> Thanks,
>>> Eric
>> Hi Eric,
>>
>> Following on is my test environment.
>>
>>
>> kernel: 5.7-rc4-git-eb24fdd8e6f5c6bb95129748a1801c6476492aba
>>
>> e2fsprog: latest release version 1.45.6 (20-Mar-2020)
>>
>> xfstests: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git, master
>> branch, latest commit
>>
>>
>> 1. Test device
>>
>> I run the test in a VM and the VM is setup by qemu. The size of vdb is 1G,
>>
>> ```
>>
>> #lsblk
>>
>> NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
>> vdb    254:16   0   1G  0 disk
>>
>> ```
>>
>>
>> and is initialized by:
>>
>> ```
>>
>> qemu-img create -f qcow2 /XX/disk1.qcow2 1G
>>
>> qemu-kvm -drive file=/XX/disk1.qcow2,if=virtio,format=qcow2 ...
>>
>> ```
>>
>>
>> 2. Test script
>>
>>
>> local.config of xfstests is like:
>>
>> export TEST_DEV=/dev/vdb
>> export TEST_DIR=/mnt/test
>> export SCRATCH_DEV=/dev/vdc
>> export SCRATCH_MNT=/mnt/scratch
>>
>>
>> Following on is an example script to reproduce the failure:
>>
>> ```sh
>>
>> #!/bin/bash
>>
>> for i in `seq 100`; do
>>          echo y | mkfs.ext4 -O bigalloc -C 16K /dev/vdb
>>
>>          ./check shared/298
>>          status=$?
>>
>>          if [[ $status == 1 ]]; then
>>                  echo "$i exit"
>>                  exit
>>          fi
>> done
>>
>> ```
>>
>>
>> Indeed the failure occurs occasionally. Sometimes the script stops at
>> iteration 4, or sometimes
>>
>> at iteration 2, 7, 24.
>>
>>
>> The failure occurs with the following dmesg report:
>>
>> ```
>>
>> [  387.471876] EXT4-fs error (device vdb): mb_free_blocks:1457: group 1,
>> block 158084:freeing already freed block (bit 6753); block bitmap corrupt.
>> [  387.473729] EXT4-fs error (device vdb): ext4_mb_generate_buddy:747: group
>> 1, block bitmap and bg descriptor inconsistent: 19550 vs 19551 free clusters
>>
>> ```
>>
>>
>> 3. About the applied patch
>>
>> The applied patch does fix the failure in my test environment. At least the
>> failure doesn't occur after running the full 100 iterations.
>>
>>
>> Thanks
>>
>> Jeffle
>>
>>
>>
> Hi, Jeffle:
>
> Thanks for that information.  I'm still unable to reproduce your failure,
> but by inspection your patch clearly fixes a bug, and of course, you're seeing
> that.  I suspect the code in rm_leaf that also sets the partial cluster nofree
> state is masking the bug in my testing.  In your case, my best guess is that
> your testing is occasionally getting into the retry loop for EAGAIN in
> remove_space.  This would effectively expose the bug again and could lead to
> the failure you've described.
>
> Your patch has survived all the heavy testing I've thrown at it.  So, please
> repost your RFC patch as a fix, and feel free to add:
> Reviewed-by: Eric Whitney <enwlinux@gmail.com>
>
> This points out that the cluster freeing code really needs to be cleaned up,
> so I'm working on a patch series that does that.
>
> Thanks for your patience,
> Eric
