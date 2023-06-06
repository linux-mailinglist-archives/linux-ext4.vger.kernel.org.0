Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3F7241F1
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 14:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjFFMTd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFFMTc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 08:19:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF9AE54;
        Tue,  6 Jun 2023 05:19:31 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qb8YG60SnzqTgh;
        Tue,  6 Jun 2023 20:14:42 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 20:19:29 +0800
Message-ID: <d704ce55-321a-9c1d-1f8b-3360a0fdf978@huawei.com>
Date:   Tue, 6 Jun 2023 20:19:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <jun.nie@linaro.org>,
        <ebiggers@kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        <syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com>,
        <stable@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20230530134405.322194-1-libaokun1@huawei.com>
 <20230604030445.GF1128744@mit.edu> <20230604210821.GA1257572@mit.edu>
 <ZH1BN+H1/Sa4eLQ4@casper.infradead.org>
 <20230605091655.24vl5fjesfskt3o5@quack3>
 <20230605122141.4njwwx3mrapqhvt4@quack3>
 <ZH33ZzwyLFY48tfA@casper.infradead.org>
 <20230605150855.7oaiplp7r57dcww3@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230605150855.7oaiplp7r57dcww3@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2023/6/5 23:08, Jan Kara wrote:
> On Mon 05-06-23 15:55:35, Matthew Wilcox wrote:
>> On Mon, Jun 05, 2023 at 02:21:41PM +0200, Jan Kara wrote:
>>> On Mon 05-06-23 11:16:55, Jan Kara wrote:
>>>> Yeah, I agree, that is also the conclusion I have arrived at when thinking
>>>> about this problem now. We should be able to just remove the conversion
>>>> from ext4_page_mkwrite() and rely on write(2) or truncate(2) doing it when
>>>> growing i_size.
>>> OK, thinking more about this and searching through the history, I've
>>> realized why the conversion is originally in ext4_page_mkwrite(). The
>>> problem is described in commit 7b4cc9787fe35b ("ext4: evict inline data
>>> when writing to memory map") but essentially it boils down to the fact that
>>> ext4 writeback code does not expect dirty page for a file with inline data
>>> because ext4_write_inline_data_end() should have copied the data into the
>>> inode and cleared the folio's dirty flag.
>>>
>>> Indeed messing with xattrs from the writeback path to copy page contents
>>> into inline data xattr would be ... interesting. Hum, out of good ideas for
>>> now :-|.
>> Is it so bad?  Now that we don't have writepage in ext4, only
>> writepages, it seems like we have a considerably more benign locking
>> environment to work in.
> Well, yes, without ->writepage() it might be *possible*. But still rather
> ugly. The problem is that in ->writepages() i_size is not stable. Thus also
> whether the inode data is inline or not is not stable. We'd need inode_lock
> for that but that is not easily doable in the writeback path - inode lock
> would then become fs_reclaim unsafe...
>
> 								Honza

If we try to add inode_lock to ext4_writepages to complete the
conversion, there may be a deadlock as follows:

       CPU0             CPU1
writeback_single_inode
  spin_lock(&inode->i_lock) ---> LOCK B
                    enable_verity
                     inode_lock(inode)  ---> LOCK A
                     vops->begin_enable_verity
                     ext4_begin_enable_verity
                      ext4_inode_attach_jinode
                       spin_lock(&inode->i_lock)   ---> try LOCK B
  __writeback_single_inode          |
   do_writepages                ABBA deadlock
    ext4_writepages                 |
     inode_lock(inode)  ---> try LOCK A

If we add inode_lock to the write back process to complete the inline 
conversion,
it seems that we still have to add an ops ...

I've been going over this problem for a long time, but I can't think of 
a good way
to solve it.

-- 
With Best Regards,
Baokun Li
.
