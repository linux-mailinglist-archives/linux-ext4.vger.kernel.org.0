Return-Path: <linux-ext4+bounces-3481-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE193DD86
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 08:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133501F227F9
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 06:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3CE208B0;
	Sat, 27 Jul 2024 06:35:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8D259C;
	Sat, 27 Jul 2024 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722062130; cv=none; b=KpPLJq9lbE6dEAQnwD0rD2snXlcl3QzNnb7URfjA7RfyrYIzrNQhOE+Y2QClSt7tmsBngRIocPRlCFWe7ZTl/sSMdW6yieu3wNVcJ+DgFFkHkIy+wAabfLvClIXdgLgP13B2ow+e2M+c285ZmHyROPSBE5uS/yB9dCzOb3rSHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722062130; c=relaxed/simple;
	bh=2DCsZsMgbkJqLuVAR8/p04owkkkcz+QGeBAZgUaOp9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/9g1Nwhy5jUK44bSLckIjQ2qQRWwi8e5B4YBfN8zm10E6v5dEKIYSAdHPM/4MxksgVs4sdth1OLbIOy3WWfeXIaV7H+1kPuTf1RfpkcglGkCX6fi+LffuArAOoy+O/rcyi89OvcJnEKKlIGCsPhEfA4Jp0vrCjxgtYKlDMpYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WWFH05Xyyz4f3kvF;
	Sat, 27 Jul 2024 14:35:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7A1AD1A0572;
	Sat, 27 Jul 2024 14:35:22 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgDXuTcmlaRm1_YtBQ--.27594S3;
	Sat, 27 Jul 2024 14:35:22 +0800 (CST)
Message-ID: <44337bbe-bb24-444d-a5b8-f579eceaeac5@huaweicloud.com>
Date: Sat, 27 Jul 2024 14:35:18 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] ext4: get rid of ppath in
 ext4_ext_create_new_leaf()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-11-libaokun@huaweicloud.com>
 <20240725104624.v73lgnkrojxaiuig@quack3>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240725104624.v73lgnkrojxaiuig@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXuTcmlaRm1_YtBQ--.27594S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWDJw4kuF1xGw47XFyrJFb_yoW5Ar18pr
	WrAFy8Ka1rJa4j9rZ2v3Z8W3Wa9w4fGr4UCFWfCFykJasFqFnagFyfKayYkFW5AFWxua4I
	qFW8tr17Cw12qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgARBWajXpVDgQABsb

On 2024/7/25 18:46, Jan Kara wrote:
> On Wed 10-07-24 12:06:44, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> The use of path and ppath is now very confusing, so to make the code more
>> readable, pass path between functions uniformly, and get rid of ppath.
>>
>> To get rid of the ppath in ext4_ext_create_new_leaf(), the following is
>> done here:
>>
>>   * Free the extents path when an error is encountered.
>>   * Its caller needs to update ppath if it uses ppath.
>>
>> No functional changes.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Just one nit below. Otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>> @@ -1424,28 +1423,24 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>>   		 * entry: create all needed subtree and add new leaf */
>>   		err = ext4_ext_split(handle, inode, mb_flags, path, newext, i);
>>   		if (err)
>> -			goto out;
>> +			goto errout;
>>   
>>   		/* refill path */
>>   		path = ext4_find_extent(inode,
>>   				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
>>   				    path, gb_flags);
>> -		if (IS_ERR(path))
>> -			err = PTR_ERR(path);
> So I'd rather have here:
> 		return path;
>
> That way it's obvious we will not confuse some code below with error stored
> in 'path' and we can also save one indentation level by removing 'else'
> below (probably do reindenting in a separate patch).
>
> 								Honza
Yes, that looks clearer! I'll add 'return path' in the next version, and
add a cleanup patch after this one to save indentation.

Thanks,
Baokun
>>   	} else {
>>   		/* tree is full, time to grow in depth */
>>   		err = ext4_ext_grow_indepth(handle, inode, mb_flags);
>>   		if (err)
>> -			goto out;
>> +			goto errout;
>>   
>>   		/* refill path */
>>   		path = ext4_find_extent(inode,
>>   				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
>>   				    path, gb_flags);
>> -		if (IS_ERR(path)) {
>> -			err = PTR_ERR(path);
>> -			goto out;
>> -		}
>> +		if (IS_ERR(path))
>> +			return path;
>>   
>>   		/*
>>   		 * only first (depth 0 -> 1) produces free space;
>> @@ -1457,9 +1452,11 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>>   			goto repeat;
>>   		}
>>   	}
>> -out:
>> -	*ppath = IS_ERR(path) ? NULL : path;
>> -	return err;
>> +	return path;
>> +
>> +errout:
>> +	ext4_free_ext_path(path);
>> +	return ERR_PTR(err);
>>   }
>>   
>>   /*
>> @@ -2112,10 +2109,14 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>>   	 */
>>   	if (gb_flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
>>   		mb_flags |= EXT4_MB_USE_RESERVED;
>> -	err = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
>> -				       ppath, newext);
>> -	if (err)
>> +	path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
>> +					path, newext);
>> +	if (IS_ERR(path)) {
>> +		*ppath = NULL;
>> +		err = PTR_ERR(path);
>>   		goto cleanup;
>> +	}
>> +	*ppath = path;
>>   	depth = ext_depth(inode);
>>   	eh = path[depth].p_hdr;
>>   
>> -- 
>> 2.39.2
>>
-- 
With Best Regards,
Baokun Li


