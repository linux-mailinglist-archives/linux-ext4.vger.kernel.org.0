Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ADC721BE4
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 04:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjFECRf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 4 Jun 2023 22:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjFECRf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 4 Jun 2023 22:17:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3808AB4;
        Sun,  4 Jun 2023 19:17:33 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QZHFB2xPbz18LVd;
        Mon,  5 Jun 2023 10:12:46 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 10:17:30 +0800
Message-ID: <c20befb7-cd2e-019a-57d4-35da70e0f534@huawei.com>
Date:   Mon, 5 Jun 2023 10:17:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <jun.nie@linaro.org>,
        <ebiggers@kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        <syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com>,
        <stable@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20230530134405.322194-1-libaokun1@huawei.com>
 <20230604030445.GF1128744@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230604030445.GF1128744@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/4 11:04, Theodore Ts'o wrote:
> I tried testing to see if this fixed [1], and it appears to be
> triggering a lockdep warning[2] at this line in the patch:
>
> [1] https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517
> [2] https://syzkaller.appspot.com/x/report.txt?x=17260843280000
>
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index d101b3b0c7da..9df82d72eb90 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -808,6 +809,27 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>>   	if (!daxdev_mapping_supported(vma, dax_dev))
>>   		return -EOPNOTSUPP;
>>   
>> +	/*
>> +	 * Writing via mmap has no logic to handle inline data, so we
>> +	 * need to call ext4_convert_inline_data() to convert the inode
>> +	 * to normal format before doing so, otherwise a BUG_ON will be
>> +	 * triggered in ext4_writepages() due to the
>> +	 * EXT4_STATE_MAY_INLINE_DATA flag. Moreover, we need to grab
>> +	 * i_rwsem during conversion, since clearing and setting the
>> +	 * inline data flag may race with ext4_buffered_write_iter()
>> +	 * to trigger a BUG_ON.
>> +	 */
>> +	if (ext4_has_feature_inline_data(sb) &&
>> +	    vma->vm_flags & VM_SHARED && vma->vm_flags & VM_MAYWRITE) {
>> +		int err;
>> +
>> +		inode_lock(inode); <=================== LOCKDEP warning
>> +		err = ext4_convert_inline_data(inode);
>> +		inode_unlock(inode);
>> +		if (err)
>> +			return err;
>> +	}
>
> The details of the lockdep warning from [2], which appears to be a
> mmap(2) racing with a buffered write(2) are below.  Could you take a
> look?
>
> Thanks!
>
> 					- Ted

Sorry for the late reply!

Had a look at this question which is similar to the one Honza mentioned 
earlier.
Concurrency between write and mmap as follows can lead to ABBA deadlocks:

     CPU0                   CPU1
   write(2)                mmap(2)
ext4_file_write_iter
  ext4_buffered_write_iter
   inode_lock(inode)  ---> LOCK A
   generic_perform_write
                          ksys_mmap_pgoff
                           vm_mmap_pgoff
                            mmap_write_lock_killable(mm) ---> LOCK B
                            do_mmap
                             mmap_region
                              call_mmap
                               ext4_file_mmap
                                inode_lock(inode)  ---> try LOCK A again
    fault_in_iov_iter_readable              |
     fault_in_readable                      |
      asm_exc_page_fault                ABBA deadlock
       handle_page_fault                    |
        do_user_addr_fault                  |
         mmap_read_lock(mm) ---> try LOCK B again


Thanks!
-- 
With Best Regards,
Baokun Li
.
