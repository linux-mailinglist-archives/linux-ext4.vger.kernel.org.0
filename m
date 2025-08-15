Return-Path: <linux-ext4+bounces-9382-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D65B2769D
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Aug 2025 05:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFDC6836CE
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Aug 2025 03:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79129B8D0;
	Fri, 15 Aug 2025 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gw62hP/C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EC929B78E;
	Fri, 15 Aug 2025 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227628; cv=none; b=Arvc2gL435MEGfMC0Kz3HWeygtoYAsuciLtKjLZ5imFrdL+Dpv+BwbNhUtJ98EDWEUZW5mrC0NMU1koz4MVeOqXO64DlJlDdJaRnJKA+Q5kzCgELDmY3znjNVkSqxGjVkCW98dlC2nTyizNBxHmaikQu8DNj9OfIZUyr4uHgNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227628; c=relaxed/simple;
	bh=Qux1qaXvoP1E3yNE3nseNjWIBjZvN1z5Vw6ye0F3+lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UL8AUPrNpj+HMfowDgSyqgrgX6iG6K0uHK4hY+bjS8Oj3z5pcbtH/n+NLRzGXskAaEotQi2QrNNzHpDYW98hw+XSwdFEz/p6YjnZGQm6WVKOueWDU4HtvNqoubPhv57gVGC9877kFQxALvtKs9SOfYjDuzHzTFORP+a/w5XIxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gw62hP/C; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wCLuGIqd+jl6zft6bxHC9f9AT1pfAEgGKmHtiVEy924=;
	b=gw62hP/CsEJXHvz1stnPeTSiI9olmemQoCZAKpRrdl1H77dYy23WpioKUl51+q
	yR4wzLGRh8EH15QgK11bFGdO3FMeMDe8QWaHT2v99Q7SHcPUv09wW1sV9CHSJe6R
	wgql8HeBkn0+dAWTT3jdGe3td37CRVG9G1OgpJe8Rhmwc=
Received: from [192.168.252.68] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHBuXTpZ5o43YDCA--.59839S2;
	Fri, 15 Aug 2025 11:13:25 +0800 (CST)
Message-ID: <ed023dce-e29c-4532-98b5-dd468ab9a9fe@163.com>
Date: Fri, 15 Aug 2025 11:13:23 +0800
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
X-CM-TRANSID:_____wCHBuXTpZ5o43YDCA--.59839S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw13KFWfJrWDXF1DJryUAwb_yoW8Gr1Upr
	WUKF1vkrnFvw129Fn7WF15ZFy2g3yq93y7JFyYgr12vF98Xwn3KF4vgr98tF1YqrZrA395
	XF4Ivr93uF13ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4SoAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiMRGpymid8yJ7pwABs6

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


