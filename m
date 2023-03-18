Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE666BF868
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Mar 2023 08:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCRHDk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Mar 2023 03:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRHDj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Mar 2023 03:03:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E5930B12;
        Sat, 18 Mar 2023 00:03:35 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PdsMf1PrnznX9d;
        Sat, 18 Mar 2023 15:00:30 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 15:03:31 +0800
Subject: Re: [PATCH] ext4: Fix i_disksize exceeding i_size problem in
 paritally written case
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20230317013553.1009553-1-chengzhihao1@huawei.com>
 <20230317124513.drx3wywcjnap5jme@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <884950ac-e60a-d331-9f68-310ab81ee595@huawei.com>
Date:   Sat, 18 Mar 2023 15:03:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230317124513.drx3wywcjnap5jme@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Hi, Jan
> On Fri 17-03-23 09:35:53, Zhihao Cheng wrote:
>> Following process makes i_disksize exceed i_size:
>>
>> generic_perform_write
>>   copied = iov_iter_copy_from_user_atomic(len) // copied < len
>>   ext4_da_write_end
>>   | ext4_update_i_disksize
>>   |  new_i_size = pos + copied;
>>   |  WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize) // update i_disksize
>>   | generic_write_end
>>   |  copied = block_write_end(copied, len) // copied = 0
>>   |   if (unlikely(copied < len))
>>   |    if (!PageUptodate(page))
>>   |     copied = 0;
>>   |  if (pos + copied > inode->i_size) // return false
>>   if (unlikely(copied == 0))
>>    goto again;
>>   if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
>>    status = -EFAULT;
>>    break;
>>   }
>>
>> We get i_disksize greater than i_size here, which could trigger WARNING
>> check 'i_size_read(inode) < EXT4_I(inode)->i_disksize' while doing dio:
>>
>> ext4_dio_write_iter
>>   iomap_dio_rw
>>    __iomap_dio_rw // return err, length is not aligned to 512
>>   ext4_handle_inode_extension
>>    WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize) // Oops
>>
>>   WARNING: CPU: 2 PID: 2609 at fs/ext4/file.c:319
>>   CPU: 2 PID: 2609 Comm: aa Not tainted 6.3.0-rc2
>>   RIP: 0010:ext4_file_write_iter+0xbc7
>>   Call Trace:
>>    vfs_write+0x3b1
>>    ksys_write+0x77
>>    do_syscall_64+0x39
>>
>> Fix it by putting block_write_end() before i_disksize updating just
>> like ext4_write_end() does.
>>
>> Fetch a reproducer in [Link].
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217209
>> Fixes: 64769240bd07f ("ext4: Add delayed allocation support in data=writeback mode")
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Good catch (although practically this will hardly have any negative
> effect). But rather than opencoding generic_write_end() I'd do:
> 
>          if (unlikely(copied < len) && !PageUptodate(page))
>                  copied = 0;
> 
> at the beginning of ext4_da_write_end() and that should solve these
> problems as well?
> 

Yes, your suggestion looks good, and I think we can put the checking 
just after ext4_write_inline_data_end(Line 3150)? On the one hand, we 
can pass original 'copied' value in trace_ext4_da_write_end(), one the 
other hand, ext4_write_inline_data_end() already has this checking.
