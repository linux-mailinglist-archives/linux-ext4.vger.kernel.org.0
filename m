Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E141F65867
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2019 16:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfGKOCa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jul 2019 10:02:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:55998 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbfGKOCa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Jul 2019 10:02:30 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hlZeT-0001YX-Il; Thu, 11 Jul 2019 17:02:25 +0300
Subject: Re: [PATCH v2] ext4: remove code duplication in free_ind_block()
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
References: <7751907d-738f-a533-8be9-78c6aff5c8be@virtuozzo.com>
 <20190529150142.GA2081@quack2.suse.cz>
 <9f64b443-3344-1fd0-ac3b-75887eb1e629@virtuozzo.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <686585ba-cd18-5187-0a3f-9eac4833be49@virtuozzo.com>
Date:   Thu, 11 Jul 2019 17:02:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9f64b443-3344-1fd0-ac3b-75887eb1e629@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear Ted,
could you please comment the state of this patch?
Should I re-new or resend it?
Do you probably have some objections or may be expect some troubles related to this patch?

On 5/30/19 10:13 AM, Vasily Averin wrote:
> On 5/29/19 6:01 PM, Jan Kara wrote:
>> On Tue 12-03-19 16:09:12, Vasily Averin wrote:
>>> free_ind_block(), free_dind_blocks() and free_tind_blocks() are replaced
>>> by a single recursive function.
>>> v2: rebase to v5.0
>>>
>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>>
>> Thanks for the patch! Nice cleanup. The patch looks good to me. Feel free
>> to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>> Just one question. How did you test this? And if you have a testcase for
>> this code, can you please add it to fstests so that it gets excercised?
> 
> Frankly speaking I've very carefully reviewed these changes,
> complied and booted, but not tested it under any real load.
> 
> Thank you,
> 	Vasily Averin
> 
>>> ---
>>>  fs/ext4/migrate.c | 115 +++++++++++++---------------------------------
>>>  1 file changed, 32 insertions(+), 83 deletions(-)
>>>
>>> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
>>> index fde2f1bc96b0..6b811b7d110c 100644
>>> --- a/fs/ext4/migrate.c
>>> +++ b/fs/ext4/migrate.c
>>> @@ -157,100 +157,43 @@ static int extend_credit_for_blkdel(handle_t *handle, struct inode *inode)
>>>  	return retval;
>>>  }
>>>  
>>> -static int free_dind_blocks(handle_t *handle,
>>> -				struct inode *inode, __le32 i_data)
>>> +static int free_ind_blocks(handle_t *handle,
>>> +				struct inode *inode, __le32 i_data, int ind)
>>>  {
>>> -	int i;
>>> -	__le32 *tmp_idata;
>>> -	struct buffer_head *bh;
>>> -	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
>>> -
>>> -	bh = ext4_sb_bread(inode->i_sb, le32_to_cpu(i_data), 0);
>>> -	if (IS_ERR(bh))
>>> -		return PTR_ERR(bh);
>>> -
>>> -	tmp_idata = (__le32 *)bh->b_data;
>>> -	for (i = 0; i < max_entries; i++) {
>>> -		if (tmp_idata[i]) {
>>> -			extend_credit_for_blkdel(handle, inode);
>>> -			ext4_free_blocks(handle, inode, NULL,
>>> -					 le32_to_cpu(tmp_idata[i]), 1,
>>> -					 EXT4_FREE_BLOCKS_METADATA |
>>> -					 EXT4_FREE_BLOCKS_FORGET);
>>> -		}
>>> -	}
>>> -	put_bh(bh);
>>> -	extend_credit_for_blkdel(handle, inode);
>>> -	ext4_free_blocks(handle, inode, NULL, le32_to_cpu(i_data), 1,
>>> -			 EXT4_FREE_BLOCKS_METADATA |
>>> -			 EXT4_FREE_BLOCKS_FORGET);
>>> -	return 0;
>>> -}
>>> -
>>> -static int free_tind_blocks(handle_t *handle,
>>> -				struct inode *inode, __le32 i_data)
>>> -{
>>> -	int i, retval = 0;
>>> -	__le32 *tmp_idata;
>>> -	struct buffer_head *bh;
>>> -	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
>>> -
>>> -	bh = ext4_sb_bread(inode->i_sb, le32_to_cpu(i_data), 0);
>>> -	if (IS_ERR(bh))
>>> -		return PTR_ERR(bh);
>>> -
>>> -	tmp_idata = (__le32 *)bh->b_data;
>>> -	for (i = 0; i < max_entries; i++) {
>>> -		if (tmp_idata[i]) {
>>> -			retval = free_dind_blocks(handle,
>>> -					inode, tmp_idata[i]);
>>> -			if (retval) {
>>> -				put_bh(bh);
>>> -				return retval;
>>> +	if (ind > 0) {
>>> +		int retval = 0;
>>> +		__le32 *tmp_idata;
>>> +		ext4_lblk_t i, max_entries;
>>> +		struct buffer_head *bh;
>>> +
>>> +		bh = ext4_sb_bread(inode->i_sb, le32_to_cpu(i_data), 0);
>>> +		if (IS_ERR(bh))
>>> +			return PTR_ERR(bh);
>>> +
>>> +		tmp_idata = (__le32 *)bh->b_data;
>>> +		max_entries = inode->i_sb->s_blocksize >> 2;
>>> +		for (i = 0; i < max_entries; i++) {
>>> +			if (tmp_idata[i]) {
>>> +				retval = free_ind_blocks(handle,
>>> +						inode, tmp_idata[i], ind - 1);
>>> +				if (retval) {
>>> +					put_bh(bh);
>>> +					return retval;
>>> +				}
>>>  			}
>>>  		}
>>> +		put_bh(bh);
>>>  	}
>>> -	put_bh(bh);
>>>  	extend_credit_for_blkdel(handle, inode);
>>>  	ext4_free_blocks(handle, inode, NULL, le32_to_cpu(i_data), 1,
>>> -			 EXT4_FREE_BLOCKS_METADATA |
>>> -			 EXT4_FREE_BLOCKS_FORGET);
>>> -	return 0;
>>> -}
>>> -
>>> -static int free_ind_block(handle_t *handle, struct inode *inode, __le32 *i_data)
>>> -{
>>> -	int retval;
>>> -
>>> -	/* ei->i_data[EXT4_IND_BLOCK] */
>>> -	if (i_data[0]) {
>>> -		extend_credit_for_blkdel(handle, inode);
>>> -		ext4_free_blocks(handle, inode, NULL,
>>> -				le32_to_cpu(i_data[0]), 1,
>>> -				 EXT4_FREE_BLOCKS_METADATA |
>>> -				 EXT4_FREE_BLOCKS_FORGET);
>>> -	}
>>> -
>>> -	/* ei->i_data[EXT4_DIND_BLOCK] */
>>> -	if (i_data[1]) {
>>> -		retval = free_dind_blocks(handle, inode, i_data[1]);
>>> -		if (retval)
>>> -			return retval;
>>> -	}
>>> -
>>> -	/* ei->i_data[EXT4_TIND_BLOCK] */
>>> -	if (i_data[2]) {
>>> -		retval = free_tind_blocks(handle, inode, i_data[2]);
>>> -		if (retval)
>>> -			return retval;
>>> -	}
>>> +			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
>>>  	return 0;
>>>  }
>>>  
>>>  static int ext4_ext_swap_inode_data(handle_t *handle, struct inode *inode,
>>>  						struct inode *tmp_inode)
>>>  {
>>> -	int retval;
>>> +	int i, retval;
>>>  	__le32	i_data[3];
>>>  	struct ext4_inode_info *ei = EXT4_I(inode);
>>>  	struct ext4_inode_info *tmp_ei = EXT4_I(tmp_inode);
>>> @@ -307,7 +250,13 @@ static int ext4_ext_swap_inode_data(handle_t *handle, struct inode *inode,
>>>  	 * We mark the inode dirty after, because we decrement the
>>>  	 * i_blocks when freeing the indirect meta-data blocks
>>>  	 */
>>> -	retval = free_ind_block(handle, inode, i_data);
>>> +	for (i = 0; i < ARRAY_SIZE(i_data); i++) {
>>> +		if (i_data[i]) {
>>> +			retval = free_ind_blocks(handle, inode, i_data[i], i);
>>> +			if (retval)
>>> +				break;
>>> +		}
>>> +	}
>>>  	ext4_mark_inode_dirty(handle, inode);
>>>  
>>>  err_out:
>>> -- 
>>> 2.17.1
>>>
