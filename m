Return-Path: <linux-ext4+bounces-3480-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347893DD7B
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 08:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097291F21B35
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 06:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC31CF90;
	Sat, 27 Jul 2024 06:18:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A23179A3;
	Sat, 27 Jul 2024 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722061125; cv=none; b=hBucIeCcQqGPmoXnNZhjUNfcN1kTSZk865O/pHtONZ2y8WTmY+2b7vl3RVIrAF+hga8N+rwGO+LQeSnnMka5JTdD5ADOK3wLFTq8W6Wv637oDci1vTEn9uX0p3+WomvEaECbnrIfJDcYfZ/Dh4qLG2j3G269g2cP9EWjT85yDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722061125; c=relaxed/simple;
	bh=XnB7eF1idtqMlUAHZPALwQO/j32z2jCcdvS16GgaLPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0aqH1Z4vAezUZmFSZQcu36lP8YkYYWqs2idJhx4B/FCToGGKGI6y/vkHrl2G+ulsnRgUxrVPkeSdFAv3/R5OfBB/sTY0cVBg7GCWoAHgRaK01n78oZ0NjpygiSL11DxNcEY01H/QclbHFzfaJD+DUM2xKmmwhUdiutVAlEzbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WWDvh1PGdz4f3kvL;
	Sat, 27 Jul 2024 14:18:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E33911A0359;
	Sat, 27 Jul 2024 14:18:37 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCHazk5kaRmA9wsBQ--.26184S3;
	Sat, 27 Jul 2024 14:18:37 +0800 (CST)
Message-ID: <0046d3b3-24ce-4cdb-a40a-4022b79a5a7b@huaweicloud.com>
Date: Sat, 27 Jul 2024 14:18:33 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] ext4: get rid of ppath in ext4_find_extent()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-9-libaokun@huaweicloud.com>
 <20240725103823.fvvinixcctacf4fx@quack3>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240725103823.fvvinixcctacf4fx@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazk5kaRmA9wsBQ--.26184S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1kKF1fXw1fJF4xWFWxWFg_yoW8tFy7pr
	48AF18G34Utr18CrWxJr1UXry7ua1UJw4UJr48JFyUAF1UJrnIgF12qw1YgF15Xr4xGry2
	yr18Jr17uw1Ut37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQARBWajXfxCnQABsv

On 2024/7/25 18:38, Jan Kara wrote:
> On Wed 10-07-24 12:06:42, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> The use of path and ppath is now very confusing, so to make the code more
>> readable, pass path between functions uniformly, and get rid of ppath.
>>
>> Getting rid of ppath in ext4_find_extent() requires its caller to update
>> ppath. These ppaths will also be dropped later. No functional changes.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> One nit below, otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>> @@ -3260,11 +3257,12 @@ static int ext4_split_extent_at(handle_t *handle,
>>   	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
>>   	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
>>   	 */
>> -	path = ext4_find_extent(inode, ee_block, ppath,
>> +	path = ext4_find_extent(inode, ee_block, *ppath,
>>   				flags | EXT4_EX_NOFAIL);
>>   	if (IS_ERR(path)) {
>>   		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
>>   				 split, PTR_ERR(path));
>> +		*ppath = NULL;
>>   		return PTR_ERR(path);
>>   	}
> I think here you forgot to update ppath on success case. It will go away by
> the end of the series but still it's good to keep thing consistent...
>
> 								Honza

Hi Honza,

Thank you for your review！

In patch 5, the ppath is already updated in case of success, so there
is no need to add it here. This update was not shown when the patch
was made and it looks like this：

-       path = ext4_find_extent(inode, ee_block, ppath,
+       path = ext4_find_extent(inode, ee_block, *ppath,
                                 flags | EXT4_EX_NOFAIL);
         if (IS_ERR(path)) {
                 EXT4_ERROR_INODE(inode, "Failed split extent on %u, err 
%ld",
                                  split, PTR_ERR(path));
+               *ppath = NULL;
                 return PTR_ERR(path);
         }
         depth = ext_depth(inode);
         ex = path[depth].p_ext;
         *ppath = path;

-- 
With Best Regards,
Baokun Li


