Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BED5AA672
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Sep 2022 05:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiIBDbz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 23:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiIBDba (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 23:31:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF96C6CF6D;
        Thu,  1 Sep 2022 20:31:27 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJjz417F6zkWrf;
        Fri,  2 Sep 2022 11:27:44 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 11:31:25 +0800
Subject: Re: [PATCH -next] ext4: ensure data forced to disk when rename
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220901062657.1192732-1-yebin10@huawei.com>
 <20220901083706.mjewb45dufzxcfdk@quack3>
 <ce8666e2-c224-79f9-7770-f87b31d122e3@huawei.com> <YxDFewyU6orvSfZX@mit.edu>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <015e74f3-edcf-7f01-2207-080ff635fdc5@huawei.com>
Date:   Fri, 2 Sep 2022 11:31:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YxDFewyU6orvSfZX@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/9/1 22:45, Theodore Ts'o wrote:
> On Thu, Sep 01, 2022 at 09:19:04PM +0800, Zhang Yi wrote:
>>
>> Our case is modifing a no-empty file names "data.conf" through vim, it will
>> cp "data.conf" to ".data.conf.swp" firstly, overwrite rename ".data.conf.swp"
>> back to "data.conf" and fsync after modifying. If we power down between rename
>> and fsync, we may lose all data in the original "data.conf" and get a whole
>> zero file. Before we enable dioread_nolock by defalut, the newly appending data
>> may lost, but at least we will not lose the original data in the default
>> data=ordered and auto_da_alloc mode. It seems that dioread_nolock breaks the
>> guarantee provide by auto_da_alloc. Maybe we should add a fsync before rename
>> in vim ?
> > What I normally recommend is to write the new contents of "data.conf"
> to "data.conf.new".  Then fsync the file descriptor corresponding to
> data.conf.new.  If you want to backup data.conf, you can create a hard
> link of data.conf to data.conf.bak, then rename data.conf.new on top
> of data.conf.
> 
> The auto_da_alloc mode is a best effort attempt to protect against bad
> application programs, and it never was a guarantee that it would
> *always* protect against data loss if you had a overwriting rename
> racing against a power failure.  Without auto_da_alloc mode, the
> window where the user might lose data if they application failed to do
> the fsync() was 30 seconds.  With auto_da_alloc (and if dioread_nolock
> was disabled), that window was reduced to say, a few hundred

Thanks for the explanation and suggestions, I totally agree with you that
applications SHOULD be calling fsync() before an overwriting rename() and
the filesystem just do best efforts.

For the above "with auto_da_alloc and no dioread_nolock" case, I'm not sure
I understand right, please correct me if I say wrong. With auto_da_alloc,
data=ordered and no dioread_nolock, it separates into two cases: 1) the new
written contents was appended to an allocated block; 2) the new contents
was written to a new block.

For case 1, we have a few hundred milliseconds window as you said,
because the inode will not be added to transaction->t_inode_list, so
the transaction committing progress does not wait data blocks to
write to complete. For case 2, the inode will be added to
transaction->t_inode_list, we can guarantee that data write to disk
before the rename() completes, so there is no window for this case.

Thanks,
Yi.

> milliseconds.  With dioread_nolock, that window was increased to
> somehwere between 0 and 5 seconds (on average, 2.5 seconds) plus the
> time for the write to complete (a few hundred milliseconds).
> 
> But note that your proposed patch doesn't actually really improve
> things all that much.  That's because calling filemap_datawrite() only
> waits for the write request to complete.  But you still need to update
> the metadata before the blocks become visible after a crash.  That
> requires forcing a journal commit, and waiting for that commit to
> complete, which is what ext4_sync_file() does, and which is of course,
> quite expensive.
> 
> We could add something to the end of ext4_convert_unwritten_io_end_vec()
> where if the inode is da_alloc eligible, we trigger an asynchronous
> journal commit; that is, once we converted all of the unwritten extents,
> if the file has been closed after being opened with O_TRUNC, or the file has
> been renamed on top of a pre-existing file and there were dirty blocks
> that were flushed out when we called ext4_alloc_da_blocks(), that
> ext4_convert_unwritten_io_end_vec() would then request that a journal
> commit be started.   But we'd want to see what sort of performance regression
> this adds, since nothing is for free, and the goal here is to paper over
> buggy applications without imposing too much of a performance cost.
> 
> But it should be clear that this is *buggy* applications, and
> applications SHOULD be calling fsync() before an overwriting rename()
> if they care about data not being lost if there is a power failure at
> an inconvenient point.   All we are trying to do here is to reduce the
> probability of data loss caused by buggy applications.  There was never
> any guarantees.
> 
> Cheers,
> 
> 						- Ted
> 
> .
> 
