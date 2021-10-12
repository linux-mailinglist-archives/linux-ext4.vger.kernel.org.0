Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0555D42A393
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 13:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhJLLs3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 07:48:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13726 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLLs2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Oct 2021 07:48:28 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTDNc6jYCzVflZ;
        Tue, 12 Oct 2021 19:44:48 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 12 Oct 2021 19:46:24 +0800
Subject: Re: [PATCH -next v2 2/6] ext4: introduce last_check_time record
 previous check time
To:     Jan Kara <jack@suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-3-yebin10@huawei.com>
 <20211007123100.GG12712@quack2.suse.cz> <615FA55B.5070404@huawei.com>
 <615FAF27.8070000@huawei.com> <20211012084727.GF9697@quack2.suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <61657590.2050407@huawei.com>
Date:   Tue, 12 Oct 2021 19:46:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20211012084727.GF9697@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/10/12 16:47, Jan Kara wrote:
> On Fri 08-10-21 10:38:31, yebin wrote:
>> On 2021/10/8 9:56, yebin wrote:
>>> On 2021/10/7 20:31, Jan Kara wrote:
>>>> On Sat 11-09-21 17:00:55, Ye Bin wrote:
>>>>> kmmpd:
>>>>> ...
>>>>>       diff = jiffies - last_update_time;
>>>>>       if (diff > mmp_check_interval * HZ) {
>>>>> ...
>>>>> As "mmp_check_interval = 2 * mmp_update_interval", 'diff' always little
>>>>> than 'mmp_update_interval', so there will never trigger detection.
>>>>> Introduce last_check_time record previous check time.
>>>>>
>>>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>>> I think the check is there only for the case where write_mmp_block() +
>>>> sleep took longer than mmp_check_interval. I agree that should rarely
>>>> happen but on a really busy system it is possible and in that case
>>>> we would
>>>> miss updating mmp block for too long and so another node could have
>>>> started
>>>> using the filesystem. I actually don't see a reason why kmmpd should be
>>>> checking the block each mmp_check_interval as you do -
>>>> mmp_check_interval
>>>> is just for ext4_multi_mount_protect() to know how long it should wait
>>>> before considering mmp block stale... Am I missing something?
>>>>
>>>>                                  Honza
>>> I'm sorry, I didn't understand the detection mechanism here before. Now
>>> I understand
>>> the detection mechanism here.
>>> As you said, it's just an abnormal protection. There's really no problem.
>>>
>> Yeah, i did test as following steps
>> hostA                        hostB
>>     mount
>>       ext4_multi_mount_protect  -> seq == EXT4_MMP_SEQ_CLEAN
>>          delay 5s after label "skip" so hostB will see seq is
>> EXT4_MMP_SEQ_CLEAN
>>                         mount
>>                         ext4_multi_mount_protect -> seq == EXT4_MMP_SEQ_CLEAN
>>                                 run  kmmpd
>>      run kmmpd
>>
>> Actually，in this  situation kmmpd will not detect  confliction.
>> In ext4_multi_mount_protect function we write mmp data first and wait
>> 'wait_time * HZ'  seconds,
>> read mmp data do check. Most of the time, If 'wait_time' is zero, it can pass
>> check.
> But how can be wait_time zero? As far as I'm reading the code, wait_time
> must be at least EXT4_MMP_MIN_CHECK_INTERVAL...
>
> 								Honza
  int ext4_multi_mount_protect(struct super_block *sb,
                                      ext4_fsblk_t mmp_block)
  {
          struct ext4_super_block *es = EXT4_SB(sb)->s_es;
          struct buffer_head *bh = NULL;
          struct mmp_struct *mmp = NULL;
          u32 seq;
          unsigned int mmp_check_interval = 
le16_to_cpu(es->s_mmp_update_interval);
          unsigned int wait_time = 0;                    --> wait_time 
is equal with zero
          int retval;

          if (mmp_block < le32_to_cpu(es->s_first_data_block) ||
              mmp_block >= ext4_blocks_count(es)) {
                  ext4_warning(sb, "Invalid MMP block in superblock");
                  goto failed;
          }

          retval = read_mmp_block(sb, &bh, mmp_block);
          if (retval)
                  goto failed;

          mmp = (struct mmp_struct *)(bh->b_data);

          if (mmp_check_interval < EXT4_MMP_MIN_CHECK_INTERVAL)
                  mmp_check_interval = EXT4_MMP_MIN_CHECK_INTERVAL;

          /*
           * If check_interval in MMP block is larger, use that instead of
           * update_interval from the superblock.
           */
          if (le16_to_cpu(mmp->mmp_check_interval) > mmp_check_interval)
                  mmp_check_interval = le16_to_cpu(mmp->mmp_check_interval);

          seq = le32_to_cpu(mmp->mmp_seq);
          if (seq == EXT4_MMP_SEQ_CLEAN)   --> If hostA and hostB mount 
the same block device at the same time,
--> HostA and hostB  maybe get 'seq' with the same value 
EXT4_MMP_SEQ_CLEAN.
                  goto skip;
...
skip:
         /*
          * write a new random sequence number.
          */
         seq = mmp_new_seq();
         mmp->mmp_seq = cpu_to_le32(seq);

         retval = write_mmp_block(sb, bh);
         if (retval)
                 goto failed;

         /*
          * wait for MMP interval and check mmp_seq.
          */
         if (schedule_timeout_interruptible(HZ * wait_time) != 0) 
{        --> If seq is equal with EXT4_MMP_SEQ_CLEAN, wait_time is zero.
                 ext4_warning(sb, "MMP startup interrupted, failing mount");
                 goto failed;
         }

         retval = read_mmp_block(sb, &bh, mmp_block); -->We may get the 
same data with which we wrote, so we can't detect conflict at here.
         if (retval)
                 goto failed;
         mmp = (struct mmp_struct *)(bh->b_data);
         if (seq != le32_to_cpu(mmp->mmp_seq)) {
                 dump_mmp_msg(sb, mmp,
                              "Device is already active on another node.");
                 goto failed;
         }
...
}

