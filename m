Return-Path: <linux-ext4+bounces-3482-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D10C93DD94
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 08:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FDAB21A65
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 06:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A1208DA;
	Sat, 27 Jul 2024 06:43:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFC14A85;
	Sat, 27 Jul 2024 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722062582; cv=none; b=PjEBpteTPo+MhRmH69mXMRsnzv74zRuKeE91uaNm+w6d9pUpO7R8vePJQkneBQHo37vqjh61fVJ0v/9BroYKUi34rKLPKYnuE00q9KsolyLkUeLSCSZhgAFvQiklvY4DkeNOgDucpKwKCdLfxXHmNcn+l8pQkKQAjwDT5gggeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722062582; c=relaxed/simple;
	bh=3wZYqDVGE42T53Wdlc7dDNpSBdpre5BBtcEW0BR0sOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obYFtfZjrM+Epuy10mTZKFSEgPi61CfTW/RlJ/wtufhbGPqP4yMGTwvsL3rDkvVjk+YbKxbAswyAvziAJkvmQSDxe1uapIUlOc6YXgrmIJACwd9GF+FGWdE+rkak7+sacv4t8PYT5A5nCvrYpEWnZ8hP3o8MtCriuhweCsqkD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WWFRn1J6dz4f3jk0;
	Sat, 27 Jul 2024 14:42:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A23911A162D;
	Sat, 27 Jul 2024 14:42:53 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCHaTfqlqRmTXguBQ--.2624S3;
	Sat, 27 Jul 2024 14:42:53 +0800 (CST)
Message-ID: <84d1cae3-1939-463c-b1f9-344e02f87a9c@huaweicloud.com>
Date: Sat, 27 Jul 2024 14:42:50 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/20] ext4: get rid of ppath in ext4_split_extent_at()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-13-libaokun@huaweicloud.com>
 <20240725110756.fuyjfdvgbprma5ml@quack3>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240725110756.fuyjfdvgbprma5ml@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHaTfqlqRmTXguBQ--.2624S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1kCry3KrW8CF15JF43KFg_yoW8Xr1Up3
	y3C3Wqkr1jq3ykCFZ2qFyDZa4rGw47Wr4UG395Wa40gFyDtrya9F1xK3WjkF43Jr4xC3yI
	yFWIg3yfu3W2vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQARBWajXfxD2AAAsq

On 2024/7/25 19:07, Jan Kara wrote:
> On Wed 10-07-24 12:06:46, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> The use of path and ppath is now very confusing, so to make the code more
>> readable, pass path between functions uniformly, and get rid of ppath.
>>
>> To get rid of the ppath in ext4_split_extent_at(), the following is done
>> here:
>>
>>   * Free the extents path when an error is encountered.
>>   * Its caller needs to update ppath if it uses ppath.
>>   * Teach ext4_ext_show_leaf() to skip error pointer.
>>   * Propagate ext4_find_extent() error return value in ext4_insert_range().
>>
>> No functional changes.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> One nit below:
>
>> @@ -5596,6 +5606,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>>   	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
>>   	if (IS_ERR(path)) {
>>   		up_write(&EXT4_I(inode)->i_data_sem);
>> +		ret = PTR_ERR(path);
>>   		goto out_stop;
>>   	}
> AFAICT this actually fixes a bug where we could have returned 0 although
> ext4_find_extent() spotted an error?
Yeah, exactly.
> This would deserve a separate patch so
> that it could be easily pulled into stable.
>
> Otherwise looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
Ok, I'll put this in a separate patch in the next version.

Thank you very much for your review!

-- 
With Best Regards,
Baokun Li


