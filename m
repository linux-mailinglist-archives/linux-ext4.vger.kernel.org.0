Return-Path: <linux-ext4+bounces-12643-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00AD02DA5
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 14:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 309DC30BD0E1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 13:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5D14E76C4;
	Thu,  8 Jan 2026 12:54:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5A3876C4;
	Thu,  8 Jan 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876853; cv=none; b=CgU0rAs+BbkUOvFIW6wfdG8qln85E0ATWKwKGYbpV4jLHg5PE0JLTLzJN4Y5LN/8Jh9RPOa3Z5FZFRJwP1Y7efKfzlQkwMUQ6z1NGpaU+mmWEFKMYAV38+AOhMHsoTJMdTyq7ohpNCgm3oHMtxMgrfxjUnInAAr0xuG25thcE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876853; c=relaxed/simple;
	bh=+GUGxL96/TMaB7wjednyuclWQsznQhSxHStz6bblUhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlXXMu4vyNPSfdemXHLb9/vjpSQbYOPoM+Cp1erqpZ86jWK5+k3sIfOImh2L1AK4jo+z74NbPdKaAE8giG73o4mtStGTwIH8O3Pk/I42sO+E1i877yncbDQ380DLk8PMYtdFdzv034KSeglW51LVesTXST9IXZynqRr2U7wJ09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dn4bZ4JnYzYQtmf;
	Thu,  8 Jan 2026 20:54:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3C12A4058F;
	Thu,  8 Jan 2026 20:54:06 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgBHqPjsqF9pbhVKDA--.52127S3;
	Thu, 08 Jan 2026 20:54:06 +0800 (CST)
Message-ID: <ae308d42-fd15-45e6-9cf8-fb3c8f3d0671@huaweicloud.com>
Date: Thu, 8 Jan 2026 20:54:04 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] ext4: Refactor zeroout path and handle all cases
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
 libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <1ecffaf1edd7a37d90a7fcc8808b9b6e4e7a1245.1767528171.git.ojaswin@linux.ibm.com>
 <c715795a-12d7-4d52-9f44-a7abe4b9cc56@huaweicloud.com>
 <aV-mJci2dxojEFMY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aV-mJci2dxojEFMY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHqPjsqF9pbhVKDA--.52127S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AryUWrWrWr4kAFyDWF13twb_yoWxXr1kpr
	9IkFn7KF4Utr17Kw1xXF4qqr1akw18Kryxury3G3s5Ga4q9r13tr1UKF109Fy0kr48Gw1Y
	vFWUKasxCas5CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 1/8/2026 8:42 PM, Ojaswin Mujoo wrote:
> On Thu, Jan 08, 2026 at 07:58:21PM +0800, Zhang Yi wrote:
>> On 1/4/2026 8:19 PM, Ojaswin Mujoo wrote:
>>> Currently, zeroout is used as a fallback in case we fail to
>>> split/convert extents in the "traditional" modify-the-extent-tree way.
>>> This is essential to mitigate failures in critical paths like extent
>>> splitting during endio. However, the logic is very messy and not easy to
>>> follow. Further, the fragile use of various flags has made it prone to
>>> errors.
>>>
>>> Refactor zeroout out logic by moving it up to ext4_split_extents().
>>> Further, zeroout correctly based on the type of conversion we want, ie:
>>> - unwritten to written: Zeroout everything around the mapped range.
>>> - unwritten to unwritten: Zeroout everything
>>> - written to unwritten: Zeroout only the mapped range.
>>>
>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>
>> Hi, Ojaswin!
>>
>> The refactor overall looks good to me. After this series, the split
>> logic becomes more straightforward and clear. :)
>>
>> I have some comments below.
>>
>>> ---
>>>  fs/ext4/extents.c | 287 +++++++++++++++++++++++++++++++---------------
>>>  1 file changed, 195 insertions(+), 92 deletions(-)
>>>
>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>> index 460a70e6dae0..8082e1d93bbf 100644
>>> --- a/fs/ext4/extents.c
>>> +++ b/fs/ext4/extents.c
>>
>> [...]
>>
>>> @@ -3365,6 +3313,115 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>>>  	return path;
>>>  }
>>>  
>>> +static struct ext4_ext_path *
>>> +ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
>>> +			  struct ext4_ext_path *path,
>>> +			  struct ext4_map_blocks *map, int flags)
>>> +{
>>> +	struct ext4_extent *ex;
>>> +	unsigned int ee_len, depth;
>>> +	ext4_lblk_t ee_block;
>>> +	uint64_t lblk, pblk, len;
>>> +	int is_unwrit;
>>> +	int err = 0;
>>> +
>>> +	depth = ext_depth(inode);
>>> +	ex = path[depth].p_ext;
>>> +	ee_block = le32_to_cpu(ex->ee_block);
>>> +	ee_len = ext4_ext_get_actual_len(ex);
>>> +	is_unwrit = ext4_ext_is_unwritten(ex);
>>> +
>>> +	if (flags & EXT4_GET_BLOCKS_CONVERT) {
>>> +		/*
>>> +		 * EXT4_GET_BLOCKS_CONVERT: Caller wants the range specified by
>>> +		 * map to be initialized. Zeroout everything except the map
>>> +		 * range.
>>> +		 */
>>> +
>>> +		loff_t map_end = (loff_t) map->m_lblk + map->m_len;
>>> +		loff_t ex_end = (loff_t) ee_block + ee_len;
>>> +
>>> +		if (!is_unwrit)
>>> +			/* Shouldn't happen. Just exit */
>>> +			return ERR_PTR(-EINVAL);
>>
>> For cases that are should not happen, I'd suggest adding a WARN_ON_ONCE or
>> a message to facilitate future problem identification. Same as below.
> 
> Hi Yi,
> 
> Thanks for the review! Sure I can do that in v2.
>>
>>> +
>>> +		/* zeroout left */
>>> +		if (map->m_lblk > ee_block) {
>>> +			lblk = ee_block;
>>> +			len = map->m_lblk - ee_block;
>>> +			pblk = ext4_ext_pblock(ex);
>>> +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
>>> +			if (err)
>>> +				/* ZEROOUT failed, just return original error */
>>> +				return ERR_PTR(err);
>>> +		}
>>> +
>>> +		/* zeroout right */
>>> +		if (map->m_lblk + map->m_len < ee_block + ee_len) {
>>> +			lblk = map_end;
>>> +			len = ex_end - map_end;
>>> +			pblk = ext4_ext_pblock(ex) + (map_end - ee_block);
>>> +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
>>> +			if (err)
>>> +				/* ZEROOUT failed, just return original error */
>>> +				return ERR_PTR(err);
>>> +		}
>>> +	} else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
>>> +		/*
>>> +		 * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Caller wants the
>>> +		 * range specified by map to be marked unwritten.
>>> +		 * Zeroout the map range leaving rest as it is.
>>> +		 */
>>> +
>>> +		if (is_unwrit)
>>> +			/* Shouldn't happen. Just exit */
>>> +			return ERR_PTR(-EINVAL);
>>> +
>>> +		lblk = map->m_lblk;
>>> +		len = map->m_len;
>>> +		pblk = ext4_ext_pblock(ex) + (map->m_lblk - ee_block);
>>> +		err = ext4_issue_zeroout(inode, lblk, pblk, len);
>>> +		if (err)
>>> +			/* ZEROOUT failed, just return original error */
>>> +			return ERR_PTR(err);
>>> +	} else if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
>>> +		/*
>>> +		 * EXT4_GET_BLOCKS_UNWRIT_EXT: Today, this flag
>>> +		 * implicitly implies that callers when wanting an
>>> +		 * unwritten to unwritten split. So zeroout the whole
>>> +		 * extent.
>>> +		 *
>>> +		 * TODO: The implicit meaning of the flag is not ideal
>>> +		 * and eventually we should aim for a more well defined
>>> +		 * behavior
>>> +		 */
>>> +
>>
>> I don't think we need this branch anymore. After applying my patch "ext4:
>> don't split extent before submitting I/O", we will no longer encounter
>> situations where doing an unwritten to unwritten split. It means that at
>> all call sites of ext4_split_extent(), only EXT4_GET_BLOCKS_CONVERT or
>> EXT4_GET_BLOCKS_CONVERT_UNWRITTEN flags are passed. What do you think?
> 
> Yes, I did notice that as well after rebasing on your changes. 
> 
> So the next patch enforces the behavior that if no flag is passed to
> ext4_split_extent() -> ext4_split_extent_zeroout() then we assume a
> split without conversion. As you mentioned, there is no remaining caller
> that does this but I thought of handling it here so that in future if we
> ever need to use unwrit to unwrit splits we handle it correctly.
> 
> Incase you still feel this makes it confusing or is uneccessary I can
> remove the else part altoghether and add a WARN_ON.
> 

Yes, my personal suggestion is to add this part of the logic only when it
is really needed. :)

Cheers,
Yi.

> Thanks,
> ojaswin
> 
>>
>> Thanks,
>> Yi.
>>
>>> +		if (!is_unwrit)
>>> +			/* Shouldn't happen. Just exit */
>>> +			return ERR_PTR(-EINVAL);
>>> +
>>> +		lblk = ee_block;
>>> +		len = ee_len;
>>> +		pblk = ext4_ext_pblock(ex);
>>> +		err = ext4_issue_zeroout(inode, lblk, pblk, len);
>>> +		if (err)
>>> +			/* ZEROOUT failed, just return original error */
>>> +			return ERR_PTR(err);
>>> +	}
>>> +
>>> +	err = ext4_ext_get_access(handle, inode, path + depth);
>>> +	if (err)
>>> +		return ERR_PTR(err);
>>> +
>>> +	ext4_ext_mark_initialized(ex);
>>> +
>>> +	ext4_ext_dirty(handle, inode, path + path->p_depth);
>>> +	if (err)
>>> +		return ERR_PTR(err);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  /*
>>>   * ext4_split_extent() splits an extent and mark extent which is covered
>>>   * by @map as split_flags indicates
>>
>> [...]
>>


