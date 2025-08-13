Return-Path: <linux-ext4+bounces-9354-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E046B24960
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 14:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3AD17A163
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586901D8E10;
	Wed, 13 Aug 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hm5Khmsc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044751CDFAC;
	Wed, 13 Aug 2025 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087454; cv=none; b=fJU6fJD9tLXybipWZqFykrDXOYvVYkD/Al5ZW0BWM0dlx4TYnAiWx5b764PXhr1aWKHg9VrM66bdrX/0wk9v+I2Kzum9HrIvbk3nqwqVj+MFLIRLsGyabZtPAAX9lnArc7ZnzyuPGBk/C7QTbOagzYHYsJ32mLtCyyckmPoHnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087454; c=relaxed/simple;
	bh=W7yg20+02avb9QD9u1FdJPuwQwYSnP42MxnPkIk1Z2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogUYBlD3fQzbW6yIRIdkuHCuOTXKATEyk/HTVc03WWCqG/EKKNBMuRf1fwFpp/Uzlf7DA4to86RFCXOoIy6OMDAgJEQMeNEopl6jLxKUxyxrN3GXnMwiJsismixIWVnEaweyUwIcOzEH4lDZipvuIu2zn1UwgDnB5kX/0va1kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hm5Khmsc; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Gsg8+wArwvxttjUWSboN7FNajLb5e3rgHX61TB1Yz6M=;
	b=Hm5KhmscLOrwGhAdGsgWJxxu8YGfk/bWiUBwE7ItBW7hoFQPuGM898+alWgjb6
	GxdMPJyr+H00H996iv+9vzT4EJJ2DFLpHoyAzsSK6f2igfVyCaCzWevOW4KSuxOS
	0cMJNb+PL8XuDQmrZZ+8rjI6O/9KQkGUVZcX6PZ0uZoiw=
Received: from [192.168.194.68] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnzyZGgpxonX85AA--.8033S2;
	Wed, 13 Aug 2025 20:17:11 +0800 (CST)
Message-ID: <e3c2e886-3810-40b2-b2c1-fa6b27c0968d@163.com>
Date: Wed, 13 Aug 2025 20:17:10 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ext4: fix incorrect function name in comment
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20250812021709.1120716-1-liubaolin12138@163.com>
 <20250812172009.GE7938@frogsfrogsfrogs>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20250812172009.GE7938@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBnzyZGgpxonX85AA--.8033S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw13KFWfJrWDXF1DJryUAwb_yoW8Gr1Upr
	WUKF1vkrnFvw129Fn7WF15ZFy2g3yq93y7JFyYgr12vF98Xwn3KF4vgr98tF1YqrZrA395
	XF4Ivr93uF13ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4SoAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiUgyoymicfvZVDwAAsa

> Since commit 6b730a405037 “ext4: hoist ext4_block_write_begin and replace the __block_write_begin”, the comment should be updated accordingly from '__block_write_begin' to 'ext4_block_write_begin'.


在 2025/8/13 1:20, Darrick J. Wong 写道:
> On Tue, Aug 12, 2025 at 10:17:09AM +0800, Baolin Liu wrote:
>> From: Baolin Liu <liubaolin@kylinos.cn>
>>
>> The comment mentions block_write_begin(), but the actual function
>> called is ext4_block_write_begin().
>> Fix the comment to match the real function name.
>>
>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
> 
> Heh, that comment was copy-pasted too :/
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
>> ---
>>   fs/ext4/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index ed54c4d0f2f9..b0e3814f8502 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3155,7 +3155,7 @@ static int ext4_da_write_begin(const struct kiocb *iocb,
>>   		folio_unlock(folio);
>>   		folio_put(folio);
>>   		/*
>> -		 * block_write_begin may have instantiated a few blocks
>> +		 * ext4_block_write_begin may have instantiated a few blocks
>>   		 * outside i_size.  Trim these off again. Don't need
>>   		 * i_size_read because we hold inode lock.
>>   		 */
>> -- 
>> 2.39.2
>>
>>


