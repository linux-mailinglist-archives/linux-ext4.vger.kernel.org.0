Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93053C33AD
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jul 2021 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhGJIQV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 10 Jul 2021 04:16:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:10348 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhGJIQV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 10 Jul 2021 04:16:21 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GMN355pQyz77tg;
        Sat, 10 Jul 2021 16:09:05 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 10 Jul 2021 16:13:29 +0800
Subject: Re: [RFC PATCH 3/4] ext4: factor out write end code of inline file
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20210706024210.746788-1-yi.zhang@huawei.com>
 <20210706024210.746788-4-yi.zhang@huawei.com>
 <20210707164905.GA18396@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <842562dd-6c20-721e-f106-52ba23315aa3@huawei.com>
Date:   Sat, 10 Jul 2021 16:13:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210707164905.GA18396@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/7/8 0:49, Jan Kara wrote:
> On Tue 06-07-21 10:42:09, Zhang Yi wrote:
>> Now that the inline_data file write end procedure are falled into the
>> common write end functions, it is not clear. Factor them out and do
>> some cleanup. This patch also drop ext4_da_write_inline_data_end()
>> and switch to use ext4_write_inline_data_end() instead because we also
>> need to do the same error processing if we failed to write data into
>> inline entry.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks good. Just two nits below.
>  
>> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
>> index 28b666f25ac2..8fbf8ec05bd5 100644
>> --- a/fs/ext4/inline.c
>> +++ b/fs/ext4/inline.c
>> @@ -729,34 +729,80 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
>>  int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>>  			       unsigned copied, struct page *page)
>>  {
>> -	int ret, no_expand;
>> +	handle_t *handle = ext4_journal_current_handle();
>> +	int i_size_changed = 0;
>> +	int no_expand;
>>  	void *kaddr;
>>  	struct ext4_iloc iloc;
>> +	int ret, ret2;
>>  
>>  	if (unlikely(copied < len) && !PageUptodate(page))
>> -		return 0;
>> +		copied = 0;
>>  
>> -	ret = ext4_get_inode_loc(inode, &iloc);
>> -	if (ret) {
>> -		ext4_std_error(inode->i_sb, ret);
>> -		return ret;
>> -	}
>> +	if (likely(copied)) {
>> +		ret = ext4_get_inode_loc(inode, &iloc);
>> +		if (ret) {
>> +			unlock_page(page);
>> +			put_page(page);
>> +			ext4_std_error(inode->i_sb, ret);
>> +			goto out;
>> +		}
>> +		ext4_write_lock_xattr(inode, &no_expand);
>> +		BUG_ON(!ext4_has_inline_data(inode));
>>  
>> -	ext4_write_lock_xattr(inode, &no_expand);
>> -	BUG_ON(!ext4_has_inline_data(inode));
>> +		kaddr = kmap_atomic(page);
>> +		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
>> +		kunmap_atomic(kaddr);
>> +		SetPageUptodate(page);
>> +		/* clear page dirty so that writepages wouldn't work for us. */
>> +		ClearPageDirty(page);
>>  
>> -	kaddr = kmap_atomic(page);
>> -	ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
>> -	kunmap_atomic(kaddr);
>> -	SetPageUptodate(page);
>> -	/* clear page dirty so that writepages wouldn't work for us. */
>> -	ClearPageDirty(page);
>> +		ext4_write_unlock_xattr(inode, &no_expand);
>> +		brelse(iloc.bh);
>> +	}
>>  
>> -	ext4_write_unlock_xattr(inode, &no_expand);
>> -	brelse(iloc.bh);
>> -	mark_inode_dirty(inode);
>> +	/*
>> +	 * It's important to update i_size while still holding page lock:
>> +	 * page writeout could otherwise come in and zero beyond i_size.
>> +	 */
>> +	i_size_changed = ext4_update_inode_size(inode, pos + copied);
>> +	if (ext4_should_journal_data(inode)) {
>> +		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
>> +		EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
>> +	}
> 
> I think this hunk should also go into the "if (copied)" block. There's no
> point in changing i_size or i_disksize when nothing was written.
> 

Yeah, I will put ext4_update_inode_size() into the "if (copied)" block.
Thinking about it again, IIUC, the hunk in "if (ext4_should_journal_data(inode))"
also seems useless for inline inode, and could be dropped.

Thanks,
Yi.
