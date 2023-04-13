Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3976E03EF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Apr 2023 04:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDMCBE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 22:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDMCBC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 22:01:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B2530C7;
        Wed, 12 Apr 2023 19:00:59 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PxjSP6M86zrbGf;
        Thu, 13 Apr 2023 09:59:33 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 10:00:57 +0800
Message-ID: <22b3bfef-7a47-036d-125b-180040a0c743@huawei.com>
Date:   Thu, 13 Apr 2023 10:00:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 2/8] ext4: add a new helper to check if es must be kept
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230412124126.2286716-1-libaokun1@huawei.com>
 <20230412124126.2286716-3-libaokun1@huawei.com>
 <20230412185300.rpfwdlxeiptqaxes@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230412185300.rpfwdlxeiptqaxes@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/13 2:53, Jan Kara wrote:
> On Wed 12-04-23 20:41:20, Baokun Li wrote:
>> A helper function is added to help determine if the current extent can
>> be dropped, although only ext4_es_is_delayed() extents cannot be dropped
>> currently.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Looks good. Just some small suggestions below...
Thank you very much for your review!
>
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index 7bc221038c6c..f9dab2510bdc 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -448,6 +448,20 @@ static void ext4_es_list_del(struct inode *inode)
>>   	spin_unlock(&sbi->s_es_lock);
>>   }
>>   
>> +/*
>> + * Returns 1 indicates that we cannot fail to allocate memory for this
>> + * extent_status and cannot reclaim, clear, or free the extent until
>> + * its status changes.
>> + */
>> +static inline int ext4_es_must_keep(struct extent_status *es)
> Maybe we can return bool? Also I'd rephrase the comment as:

Totally agree! I tried to move it to fs/ext4/extents_status.h before, so I
changed the function type to int, but later I realized that it was not 
necessary
to move it to the header file, but the function type was not changed back.

>
> /*
>   * Returns true if we cannot fail to allocate memory for this extent_status
>   * entry and cannot reclaim it until its status changes.
>   */
OK, looks good, thanks!
>> +{
>> +	/* filemap, bigalloc, and seek_data/hole need to use it. */
>> +	if (ext4_es_is_delayed(es))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>>   static struct extent_status *
>>   ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
>>   		     ext4_fsblk_t pblk)
>> @@ -460,10 +474,8 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
>>   	es->es_len = len;
>>   	es->es_pblk = pblk;
>>   
>> -	/*
>> -	 * We don't count delayed extent because we never try to reclaim them
>> -	 */
>> -	if (!ext4_es_is_delayed(es)) {
>> +	/* We never try to reclaim a must kept extent, so we don't count it. */
>> +	if (!ext4_es_must_keep(es)) {
>>   		if (!EXT4_I(inode)->i_es_shk_nr++)
>>   			ext4_es_list_add(inode);
>>   		percpu_counter_inc(&EXT4_SB(inode->i_sb)->
>> @@ -481,8 +493,8 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
>>   	EXT4_I(inode)->i_es_all_nr--;
>>   	percpu_counter_dec(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
>>   
>> -	/* Decrease the shrink counter when this es is not delayed */
>> -	if (!ext4_es_is_delayed(es)) {
>> +	/* Decrease the shrink counter when this es is not a must be kept */
> Let's rephrase the comment as:
> 	/* Decrease the shrink counter when we can reclaim the extent */

Okay, this is very nice!

>
>> +	if (!ext4_es_must_keep(es)) {
>>   		BUG_ON(EXT4_I(inode)->i_es_shk_nr == 0);
>>   		if (!--EXT4_I(inode)->i_es_shk_nr)
>>   			ext4_es_list_del(inode);
>> @@ -853,7 +865,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>   	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
>>   					  128, EXT4_I(inode)))
>>   		goto retry;
>> -	if (err == -ENOMEM && !ext4_es_is_delayed(&newes))
>> +	if (err == -ENOMEM && !ext4_es_must_keep(&newes))
>>   		err = 0;
>>   
>>   	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
>> @@ -1706,11 +1718,8 @@ static int es_do_reclaim_extents(struct ext4_inode_info *ei, ext4_lblk_t end,
>>   
>>   		(*nr_to_scan)--;
>>   		node = rb_next(&es->rb_node);
>> -		/*
>> -		 * We can't reclaim delayed extent from status tree because
>> -		 * fiemap, bigallic, and seek_data/hole need to use it.
>> -		 */
>> -		if (ext4_es_is_delayed(es))
>> +		/* We can't reclaim a must be kept extent from status tree. */
> I guess we can just drop this comment. The function name explains enough...

Totally agree!

>
>> +		if (ext4_es_must_keep(es))
>>   			goto next;
>>   		if (ext4_es_is_referenced(es)) {
>>   			ext4_es_clear_referenced(es);
> 								Honza

Can you please help review the remaining patches for any problems?
If you have any suggestions, I'll fix them together and post another 
version of v4.

Thanks again for your review!
-- 
With Best Regards,
Baokun Li
.
