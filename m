Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1902B2AE5C
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2019 08:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfE0GHj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 May 2019 02:07:39 -0400
Received: from relay.sw.ru ([185.231.240.75]:37332 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfE0GHj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 May 2019 02:07:39 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hV8nH-0007WB-9F; Mon, 27 May 2019 09:07:35 +0300
Subject: Re: [PATCH v3] ext4: remove code duplication in
 update_ind/bind/tind_extent_range
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <3ac55ceb-729c-52f9-1cfe-690a62be85ec@virtuozzo.com>
 <11B3D627-92DC-4EF9-877E-248776B967A6@dilger.ca>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <764d6c09-640c-1129-7abe-da8fab9f451f@virtuozzo.com>
Date:   Mon, 27 May 2019 09:07:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <11B3D627-92DC-4EF9-877E-248776B967A6@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear Ted,
could you please clarify status of this patch 
(and  "[PATCH v2] ext4: remove code duplication in free_ind_block()" as well) ?

Do you probably have some objections, should I re-make or re-base or re-send them again?

Thank you,
	Vasily Averin

On 3/14/19 3:31 AM, Andreas Dilger wrote:
> On Mar 12, 2019, at 7:09 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
>>
>> update_ind/bind/tind_extent_page() differs by one variable and can be
>> replaced by unified function. These functions are called by similar way
>> and their caller function can be simplified too.
>>
>> v2: minor style changes, thanks to Andreas Dilger
>> v3: rebase to v5.0
>>
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> Always good to see patches that remove more lines than they add.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> 
>> ---
>> fs/ext4/migrate.c | 112 ++++++++++------------------------------------
>> 1 file changed, 24 insertions(+), 88 deletions(-)
>>
>> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
>> index b1e4d359f73b..fde2f1bc96b0 100644
>> --- a/fs/ext4/migrate.c
>> +++ b/fs/ext4/migrate.c
>> @@ -109,12 +109,13 @@ static int update_extent_range(handle_t *handle, struct inode *inode,
>>
>> static int update_ind_extent_range(handle_t *handle, struct inode *inode,
>> 				   ext4_fsblk_t pblock,
>> -				   struct migrate_struct *lb)
>> +				   struct migrate_struct *lb,
>> +				   ext4_lblk_t inc)
>> {
>> 	struct buffer_head *bh;
>> 	__le32 *i_data;
>> 	int i, retval = 0;
>> -	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
>> +	ext4_lblk_t max_entries = inode->i_sb->s_blocksize >> 2;
>>
>> 	bh = ext4_sb_bread(inode->i_sb, pblock, 0);
>> 	if (IS_ERR(bh))
>> @@ -128,67 +129,7 @@ static int update_ind_extent_range(handle_t *handle, struct inode *inode,
>> 			if (retval)
>> 				break;
>> 		} else {
>> -			lb->curr_block++;
>> -		}
>> -	}
>> -	put_bh(bh);
>> -	return retval;
>> -
>> -}
>> -
>> -static int update_dind_extent_range(handle_t *handle, struct inode *inode,
>> -				    ext4_fsblk_t pblock,
>> -				    struct migrate_struct *lb)
>> -{
>> -	struct buffer_head *bh;
>> -	__le32 *i_data;
>> -	int i, retval = 0;
>> -	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
>> -
>> -	bh = ext4_sb_bread(inode->i_sb, pblock, 0);
>> -	if (IS_ERR(bh))
>> -		return PTR_ERR(bh);
>> -
>> -	i_data = (__le32 *)bh->b_data;
>> -	for (i = 0; i < max_entries; i++) {
>> -		if (i_data[i]) {
>> -			retval = update_ind_extent_range(handle, inode,
>> -						le32_to_cpu(i_data[i]), lb);
>> -			if (retval)
>> -				break;
>> -		} else {
>> -			/* Only update the file block number */
>> -			lb->curr_block += max_entries;
>> -		}
>> -	}
>> -	put_bh(bh);
>> -	return retval;
>> -
>> -}
>> -
>> -static int update_tind_extent_range(handle_t *handle, struct inode *inode,
>> -				    ext4_fsblk_t pblock,
>> -				    struct migrate_struct *lb)
>> -{
>> -	struct buffer_head *bh;
>> -	__le32 *i_data;
>> -	int i, retval = 0;
>> -	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
>> -
>> -	bh = ext4_sb_bread(inode->i_sb, pblock, 0);
>> -	if (IS_ERR(bh))
>> -		return PTR_ERR(bh);
>> -
>> -	i_data = (__le32 *)bh->b_data;
>> -	for (i = 0; i < max_entries; i++) {
>> -		if (i_data[i]) {
>> -			retval = update_dind_extent_range(handle, inode,
>> -						le32_to_cpu(i_data[i]), lb);
>> -			if (retval)
>> -				break;
>> -		} else {
>> -			/* Only update the file block number */
>> -			lb->curr_block += max_entries * max_entries;
>> +			lb->curr_block += inc;
>> 		}
>> 	}
>> 	put_bh(bh);
>> @@ -433,7 +374,7 @@ int ext4_ext_migrate(struct inode *inode)
>> 	struct ext4_inode_info *ei;
>> 	struct inode *tmp_inode = NULL;
>> 	struct migrate_struct lb;
>> -	unsigned long max_entries;
>> +	ext4_lblk_t max_entries, inc, mult;
>> 	__u32 goal;
>> 	uid_t owner[2];
>>
>> @@ -523,34 +464,29 @@ int ext4_ext_migrate(struct inode *inode)
>>
>> 	/* 32 bit block address 4 bytes */
>> 	max_entries = inode->i_sb->s_blocksize >> 2;
>> -	for (i = 0; i < EXT4_NDIR_BLOCKS; i++) {
>> +
>> +	inc = 1; mult = 1;
>> +	for (i = 0; i < EXT4_N_BLOCKS; i++) {
>> +		inc *= mult;
>> +		if (i == EXT4_IND_BLOCK)
>> +			mult = max_entries;
>> +
>> 		if (i_data[i]) {
>> -			retval = update_extent_range(handle, tmp_inode,
>> +			if (i < EXT4_IND_BLOCK)
>> +				retval = update_extent_range(handle, tmp_inode,
>> 						le32_to_cpu(i_data[i]), &lb);
>> +			else
>> +				retval = update_ind_extent_range(handle,
>> +						tmp_inode,
>> +						le32_to_cpu(i_data[i]),
>> +						&lb, inc);
>> 			if (retval)
>> 				goto err_out;
>> -		} else
>> -			lb.curr_block++;
>> -	}
>> -	if (i_data[EXT4_IND_BLOCK]) {
>> -		retval = update_ind_extent_range(handle, tmp_inode,
>> -				le32_to_cpu(i_data[EXT4_IND_BLOCK]), &lb);
>> -		if (retval)
>> -			goto err_out;
>> -	} else
>> -		lb.curr_block += max_entries;
>> -	if (i_data[EXT4_DIND_BLOCK]) {
>> -		retval = update_dind_extent_range(handle, tmp_inode,
>> -				le32_to_cpu(i_data[EXT4_DIND_BLOCK]), &lb);
>> -		if (retval)
>> -			goto err_out;
>> -	} else
>> -		lb.curr_block += max_entries * max_entries;
>> -	if (i_data[EXT4_TIND_BLOCK]) {
>> -		retval = update_tind_extent_range(handle, tmp_inode,
>> -				le32_to_cpu(i_data[EXT4_TIND_BLOCK]), &lb);
>> -		if (retval)
>> -			goto err_out;
>> +
>> +		} else {
>> +			if (i < EXT4_TIND_BLOCK)
>> +				lb.curr_block += inc * mult;
>> +		}
>> 	}
>> 	/*
>> 	 * Build the last extent
>> --
>> 2.17.1
>>
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 
