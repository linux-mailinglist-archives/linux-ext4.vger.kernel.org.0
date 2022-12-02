Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5237640015
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 07:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiLBGAJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 01:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiLBGAH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 01:00:07 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3327B57F;
        Thu,  1 Dec 2022 22:00:06 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NNhyt4SPFzJp4n;
        Fri,  2 Dec 2022 13:56:38 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 14:00:03 +0800
Subject: Re: [PATCH v2 1/3] ext4: fix incorrect calculate 'reserved' in
 '__es_remove_extent' when enable bigalloc feature
To:     Eric Whitney <enwlinux@gmail.com>, Ye Bin <yebin@huaweicloud.com>
References: <20221121121434.1061725-1-yebin@huaweicloud.com>
 <20221121121434.1061725-2-yebin@huaweicloud.com>
 <Y4ko3OL57iyiRC0W@debian-BULLSEYE-live-builder-AMD64>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jack@suse.cz>,
        <syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63899462.6030100@huawei.com>
Date:   Fri, 2 Dec 2022 14:00:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <Y4ko3OL57iyiRC0W@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2022/12/2 6:21, Eric Whitney wrote:
> * Ye Bin <yebin@huaweicloud.com>:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Syzbot report issue as follows:
>> EXT4-fs error (device loop0): ext4_validate_block_bitmap:398: comm rep: bg 0: block 5: invalid block bitmap
>> EXT4-fs (loop0): Delayed block allocation failed for inode 18 at logical offset 0 with max blocks 32 with error 28
>> EXT4-fs (loop0): This should not happen!! Data will be lost
>>
>> EXT4-fs (loop0): Total free blocks count 0
>> EXT4-fs (loop0): Free/Dirty block details
>> EXT4-fs (loop0): free_blocks=0
>> EXT4-fs (loop0): dirty_blocks=32
>> EXT4-fs (loop0): Block reservation details
>> EXT4-fs (loop0): i_reserved_data_blocks=2
>> EXT4-fs (loop0): Inode 18 (00000000845cd634): i_reserved_data_blocks (1) not cleared!
>>
>> Above issue happens as follows:
>> Assume:
>> sbi->s_cluster_ratio = 16
>> Step1: Insert delay block [0, 31] -> ei->i_reserved_data_blocks=2
>> Step2:
>> ext4_writepages
>>    mpage_map_and_submit_extent -> return failed
>>    mpage_release_unused_pages -> to release [0, 30]
>>      ext4_es_remove_extent -> remove lblk=0 end=30
>>        __es_remove_extent -> len1=0 len2=31-30=1
>>   __es_remove_extent:
>>   ...
>>   if (len2 > 0) {
>>    ...
>> 	  if (len1 > 0) {
>> 		  ...
>> 	  } else {
>> 		es->es_lblk = end + 1;
>> 		es->es_len = len2;
>> 		...
>> 	  }
>>    	if (count_reserved)
>> 		count_rsvd(inode, lblk, orig_es.es_len - len1 - len2, &orig_es, &rc);
>> 	goto out; -> will return but didn't calculate 'reserved'
>>   ...
>> Step3: ext4_destroy_inode -> trigger "i_reserved_data_blocks (1) not cleared!"
>>
>> To solve above issue if 'len2>0' call 'get_rsvd()' before goto out.
>>
>> Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/extents_status.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index cd0a861853e3..4684eaea9471 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -1371,7 +1371,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>>   		if (count_reserved)
>>   			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
>>   				   &orig_es, &rc);
>> -		goto out;
>> +		goto count;
>>   	}
>>   
>>   	if (len1 > 0) {
>> @@ -1413,6 +1413,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>>   		}
>>   	}
>>   
>> +count:
>>   	if (count_reserved)
>>   		*reserved = get_rsvd(inode, end, es, &rc);
>>   out:
>> -- 
>> 2.31.1
>>
> I'm unable to find the sysbot report for this patch, so I can't verify that
> this fix works.  The more serious problem would be whatever is causing
> the invalid block bitmap and delayed allocation failure messages before the
> i_reserved_data_blocks message.  Perhaps that's simply what syzkaller set
> up, but it's not clear from this posting.  Have you looked for the cause
> of those first two messages?
>
> However, by inspection this patch should fix an obvious bug causing that last
> message, introduced by 8fcc3a580651 ("ext4: rework reserved cluster accounting
> when invalidating pages").  A Fixes tag should be added to the patch.  Also,
> the readability of the code should be improved by changing the label "count" to
> the more descriptive "out_get_reserved".
>
> With those two changes, feel free to add:
>
> Reviewed-by: Eric Whitney <enwlinux@gmail.com>
>
> Eric
> .

Thanks for your suggestion. I will send another version.


