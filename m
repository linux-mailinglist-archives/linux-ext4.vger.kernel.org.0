Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE61D7770D5
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHJG7i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 02:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHJG7i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 02:59:38 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C7E7E;
        Wed,  9 Aug 2023 23:59:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VpSivEd_1691650770;
Received: from 30.178.80.62(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VpSivEd_1691650770)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 14:59:32 +0800
Message-ID: <a1c67e52-75ef-77ea-1c7f-731c6ddffb47@linux.alibaba.com>
Date:   Thu, 10 Aug 2023 14:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] ext4: do not mark inode dirty which is already dirtied
 under append-write scenario
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711034256.72651-1-liusong@linux.alibaba.com>
 <20230809122529.vy5xcx4f6cghvcsu@quack3>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20230809122529.vy5xcx4f6cghvcsu@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2023/8/9 20:25, Jan Kara wrote:
> On Tue 11-07-23 11:42:56, Liu Song wrote:
>> In the append-write scenario, after ensuring that the dirty inode can be
>> seen by the writeback process, there is no need to execute
>> "mark_inode_dirty" for every write. Instead, we can rely on
>> "ext4_mark_inode_dirty" executed when updating i_disksize in
>> "mpage_map_and_submit_extent" to ensure data consistency, which can
>> significantly improve performance in high-frequency append-write
>> scenarios.
>>
>> In test scenarios of Kafka version 2.6.2, using packet size of 2K
>> resulted in a 10% performance improvement.
>>
>> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> Overall the benefit looks interesting. Nice work.
>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 9d9f414f99fe..d1aa775c9936 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3128,6 +3128,57 @@ static int ext4_da_should_update_i_disksize(struct page *page,
>>   	return 1;
>>   }
>>   
>> +/*
>> + * Copy from generic_write_end, add conditions to execute mark_inode_dirty
>> + * to avoid additional overhead caused by frequent dirty inode operations
>> + */
>> +static int ext4_da_generic_write_end(struct file *file, struct address_space *mapping,
>> +			loff_t pos, unsigned len, unsigned copied, bool need_dirty,
>> +			struct page *page, void *fsdata)
>> +{
>> +	struct inode *inode = mapping->host;
>> +	loff_t old_size = inode->i_size;
>> +	bool i_size_changed = false;
>> +	int was_dirty;
>> +
>> +	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
>> +
>> +	/*
>> +	 * No need to use i_size_read() here, the i_size cannot change under us
>> +	 * because we hold i_rwsem.
>> +	 *
>> +	 * But it's important to update i_size while still holding page lock:
>> +	 * page writeout could otherwise come in and zero beyond i_size.
>> +	 */
>> +	if (pos + copied > inode->i_size) {
>> +		i_size_write(inode, pos + copied);
>> +		i_size_changed = true;
>> +	}
>> +
>> +	unlock_page(page);
>> +	put_page(page);
>> +
>> +	if (old_size < pos)
>> +		pagecache_isize_extended(inode, old_size, pos);
>> +
> I dislike the duplication of generic_write_end() but exporting a variant of
> generic_write_end() not doing the dirtying (and additionally returning the
> i_size_changed value) doesn't look appealing either. So I guess I'll just
> live with this...
>
>> +	/*
>> +	 * In the append-write scenario, if the inode is marked as dirty,
>> +	 * it is ensured that the inode will be seen by the writeback process.
>> +	 * In the ext4_writepages process, when updating i_disksize,
>> +	 * corresponding metadata updates are also performed.
>> +	 * Therefore, it is unnecessary to repeatedly execute mark_inode_dirty
>> +	 * to improve performance.
>> +	 */
> Note that block_write_end() will mark the inode as dirty with I_DIRTY_PAGES
> flag (which all that's needed to trigger page writeback). Since i_size is
> never really written to disk by ext4, there's simply never a need to mark
> inode dirty because of that. Also if inode timestamps were updated inode
> was already properly marked dirty. Hence we can just mostly drop the code
> below.
>
>> +	if (i_size_changed) {
>> +		spin_lock(&inode->i_lock);
>> +		was_dirty = inode->i_state & I_DIRTY;
>> +		spin_unlock(&inode->i_lock);
>> +		if (!was_dirty || need_dirty)
>> +			mark_inode_dirty(inode);
>> +	}
>> +	return copied;
>> +}
>> +
>>   static int ext4_da_write_end(struct file *file,
>>   			     struct address_space *mapping,
>>   			     loff_t pos, unsigned len, unsigned copied,
>> @@ -3137,6 +3188,7 @@ static int ext4_da_write_end(struct file *file,
>>   	loff_t new_i_size;
>>   	unsigned long start, end;
>>   	int write_mode = (int)(unsigned long)fsdata;
>> +	bool need_dirty = false;
>>   
>>   	if (write_mode == FALL_BACK_TO_NONDELALLOC)
>>   		return ext4_write_end(file, mapping, pos,
>> @@ -3169,10 +3221,12 @@ static int ext4_da_write_end(struct file *file,
>>   	 */
>>   	new_i_size = pos + copied;
>>   	if (copied && new_i_size > inode->i_size &&
>> -	    ext4_da_should_update_i_disksize(page, end))
>> +	    ext4_da_should_update_i_disksize(page, end)) {
>>   		ext4_update_i_disksize(inode, new_i_size);
>> +		need_dirty = true;
>> +	}


Thank you very much for your response, and the implementation of 
"ext4_da_do_write_end" is great.
I will refer to your suggestions and send a V2 version of the patch.

Thanks


> So when we create our own new helper function anyway I'd just move all this
> logic for delalloc write end there. Something like:
>
> static int ext4_da_do_write_end(struct address_space *mapping,
> 			loff_t pos, unsigned len, unsigned copied,
> 			struct page *page)
> {
> 	struct inode *inode = mapping->host;
> 	loff_t old_size = inode->i_size;
> 	bool disksize_changed = false;
> 	loff_t new_i_size;
>
> 	copied = block_write_end(NULL, mapping, pos, len, copied, page, NULL);
>
> 	new_i_size = pos + copied;
> 	/*
> 	 * It's important to update i_size while still holding page lock:
> 	 * page writeout could otherwise come in and zero beyond i_size.
> 	 *
> 	 * Since we are holding inode lock, we are sure i_disksize <=
> 	 * i_size. We also know that if i_disksize < i_size, there are
> 	 * delalloc writes pending in the range upto i_size. If the end of
> 	 * the current write is <= i_size, there's no need to touch
> 	 * i_disksize since writeback will push i_disksize upto i_size
> 	 * eventually. If the end of the current write is > i_size and
> 	 * inside an allocated block (ext4_da_should_update_i_disksize()
> 	 * check), we need to update i_disksize here as certain
> 	 * ext4_writepages() paths not allocating blocks update i_disksize.
> 	 */
> 	if (new_i_size > inode->i_size) {
> 		unsigned long end;
>
> 		i_size_write(inode, new_i_size);
> 		end = (new_i_size - 1) & (PAGE_SIZE - 1);
> 		if (copied && ext4_da_should_update_i_disksize(folio, end)) {
> 			ext4_update_i_disksize(inode, new_i_size);
> 			disksize_changed = true;
> 		}
> 	}
>
> 	unlock_page(page);
> 	put_page(page);
>
> 	if (old_size < pos)
> 		pagecache_isize_extended(inode, old_size, pos);
>
> 	if (disksize_changed) {
> 		handle_t *handle;
>
> 		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> 		if (IS_ERR(handle))
> 			return PTR_ERR(handle);
> 		ext4_mark_inode_dirty(handle, inode);
> 		ext4_journal_stop(handle);
> 	}
>
> 	return copied;
> }
>
>
> 								Honza
