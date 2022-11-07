Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1578A61F618
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 15:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiKGOdX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 09:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiKGOdD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 09:33:03 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF301FFA5;
        Mon,  7 Nov 2022 06:30:50 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5YVF147wzJnWc;
        Mon,  7 Nov 2022 22:27:49 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 22:30:48 +0800
Subject: Re: [PATCH] ext4: fix possible memory leak when enable bigalloc
 feature
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
References: <20221107015415.2526414-1-yebin@huaweicloud.com>
 <20221107134638.iyihe72m2woj6chm@quack3>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com>,
        Eric Whitney <enwlinux@gmail.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63691697.8010302@huawei.com>
Date:   Mon, 7 Nov 2022 22:30:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20221107134638.iyihe72m2woj6chm@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/11/7 21:46, Jan Kara wrote:
> Let me CC Eric who wrote this code...
>
> On Mon 07-11-22 09:54:15, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Syzbot found the following issue:
>> BUG: memory leak
>> unreferenced object 0xffff8881bde17420 (size 32):
>>    comm "rep", pid 2327, jiffies 4295381963 (age 32.265s)
>>    hex dump (first 32 bytes):
>>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    backtrace:
>>      [<00000000ac6d38f8>] __insert_pending+0x13c/0x2d0
>>      [<00000000d717de3b>] ext4_es_insert_delayed_block+0x399/0x4e0
>>      [<000000004be03913>] ext4_da_map_blocks.constprop.0+0x739/0xfa0
>>      [<00000000885a832a>] ext4_da_get_block_prep+0x10c/0x440
>>      [<0000000029b7f8ef>] __block_write_begin_int+0x28d/0x860
>>      [<00000000e182ebc3>] ext4_da_write_inline_data_begin+0x2d1/0xf30
>>      [<00000000ced0c8a2>] ext4_da_write_begin+0x612/0x860
>>      [<000000008d5f27fa>] generic_perform_write+0x215/0x4d0
>>      [<00000000552c1cde>] ext4_buffered_write_iter+0x101/0x3b0
>>      [<0000000052177ae8>] do_iter_readv_writev+0x19f/0x340
>>      [<000000004b9de834>] do_iter_write+0x13b/0x650
>>      [<00000000e2401b9b>] iter_file_splice_write+0x5a5/0xab0
>>      [<0000000023aa5d90>] direct_splice_actor+0x103/0x1e0
>>      [<0000000089e00fc1>] splice_direct_to_actor+0x2c9/0x7b0
>>      [<000000004386851e>] do_splice_direct+0x159/0x280
>>      [<00000000b567e609>] do_sendfile+0x932/0x1200
>>
>> Now, 'ext4_clear_inode' don't cleanup pending tree which will lead to memory
>> leak.
>> To solve above issue, cleanup pending tree when clear inode.
>>
>> Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> So I'd think that by the time we are freeing inode all pending reservations
> should be resolved and thus the tree should be empty. In that case you'd be
> just masking some other bug where we failed to cleanup pending information
> at the right moment. But maybe I'm missing something - that's why I've
> added Eric to have a look ;)
>
> 								Honza
Yes, this is really a circumvention plan. Maybe we can check here. If 
the pending tree is
not empty, we still need to clean up resources to prevent memory leaks.
Let me analyze this process again.
>> ---
>>   fs/ext4/extents_status.c | 22 ++++++++++++++++++++++
>>   fs/ext4/extents_status.h |  1 +
>>   fs/ext4/super.c          |  1 +
>>   3 files changed, 24 insertions(+)
>>
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index cd0a861853e3..5f6b218464de 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -1947,6 +1947,28 @@ void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk)
>>   	write_unlock(&ei->i_es_lock);
>>   }
>>   
>> +void ext4_clear_inode_pending(struct inode *inode)
>> +{
>> +	struct ext4_inode_info *ei = EXT4_I(inode);
>> +	struct pending_reservation *pr;
>> +	struct ext4_pending_tree *tree;
>> +	struct rb_node *node;
>> +
>> +	if (EXT4_SB(inode->i_sb)->s_cluster_ratio == 1)
>> +		return;
>> +
>> +	write_lock(&ei->i_es_lock);
>> +	tree = &EXT4_I(inode)->i_pending_tree;
>> +	node = rb_first(&tree->root);
>> +	while (node) {
>> +		pr = rb_entry(node, struct pending_reservation, rb_node);
>> +		node = rb_next(node);
>> +		rb_erase(&pr->rb_node, &tree->root);
>> +		kmem_cache_free(ext4_pending_cachep, pr);
>> +	}
>> +	write_unlock(&ei->i_es_lock);
>> +}
>> +
>>   /*
>>    * ext4_is_pending - determine whether a cluster has a pending reservation
>>    *                   on it
>> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
>> index 4ec30a798260..25b605309c06 100644
>> --- a/fs/ext4/extents_status.h
>> +++ b/fs/ext4/extents_status.h
>> @@ -248,6 +248,7 @@ extern int __init ext4_init_pending(void);
>>   extern void ext4_exit_pending(void);
>>   extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
>>   extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
>> +extern void ext4_clear_inode_pending(struct inode *inode);
>>   extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
>>   extern int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>>   					bool allocated);
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 106fb06e24e8..160667dcf09a 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1434,6 +1434,7 @@ void ext4_clear_inode(struct inode *inode)
>>   	clear_inode(inode);
>>   	ext4_discard_preallocations(inode, 0);
>>   	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
>> +	ext4_clear_inode_pending(inode);
>>   	dquot_drop(inode);
>>   	if (EXT4_I(inode)->jinode) {
>>   		jbd2_journal_release_jbd_inode(EXT4_JOURNAL(inode),
>> -- 
>> 2.31.1
>>

