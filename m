Return-Path: <linux-ext4+bounces-8576-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE998AE272C
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jun 2025 04:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B913B17B5
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jun 2025 02:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B912CDA5;
	Sat, 21 Jun 2025 02:54:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225DC26AD9
	for <linux-ext4@vger.kernel.org>; Sat, 21 Jun 2025 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750474493; cv=none; b=om1EyS7lA4yUvd3dhFTdYO9oOdIV8fNfsBRd6OnLD5VqA11Zfyu/ROjjmXofzqv0+c7evKLFzZXcRyqv4aSfFhkOXohcqBV/kM+PS+yasOdSBuv9WtepgowJn+n4dsJDaXMsYTRLgBZbucVBQ5cWaG+L7tOZ0DSzLkycynYwnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750474493; c=relaxed/simple;
	bh=By54ncHhxcopZ8VtqnHSkUgC2cd8csYTm4m/Vp54YCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLZgWSQCLB+H5IEiUbx5eblUQxXAzbZpdG/x1DBpUnIhduFudu2s3TYO8kE2zXCH0AicHOT8nc0znxPPsMBpPYu5ZszJHZVF4FhY/Vw/KTl3m+yeD9FUw4RPXe6fZKngid9gIbZ6P3uZx1y0KGH5JpuP0HTl5NK5eyp6mmWv6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bPJpq140DzKHMmg
	for <linux-ext4@vger.kernel.org>; Sat, 21 Jun 2025 10:54:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 81BB71A115A
	for <linux-ext4@vger.kernel.org>; Sat, 21 Jun 2025 10:54:41 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDvHlZob46qQA--.12371S3;
	Sat, 21 Jun 2025 10:54:41 +0800 (CST)
Message-ID: <23915ba3-5c00-4628-a22a-3fdcd4ad0b62@huaweicloud.com>
Date: Sat, 21 Jun 2025 10:54:39 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LBS support for EXT4
To: Jan Kara <jack@suse.cz>, Pankaj Raghav <kernel@pankajraghav.com>
Cc: tytso@mit.edu, Luis Chamberlain <mcgrof@kernel.org>,
 Pankaj Raghav <p.raghav@samsung.com>, linux-ext4@vger.kernel.org
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
 <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXvGDvHlZob46qQA--.12371S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4rGr4rCr4xuFyxKr48JFb_yoW5Jw43pF
	WFka18tws7JFsxZ3Z7Ar1DtF4jv34fAay5Ja4rJrWrCw15Gr4vqrW7tFs0vrZ8Gr4Sgr42
	vw4qyrn7Za15ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi Pankaj and Jan,

On 2025/6/20 23:55, Jan Kara wrote:
> [added ext4 list and Zhang to CC]
> 
> Hi,
> 
> On Thu 19-06-25 15:05:14, Pankaj Raghav wrote:
>> Hello Jan and Ted,
>>
>> As you might know, I added LBS support to XFS sometime back. And after
>> that Luis added LBS support to block devices/buffer head path.
>>
>> And now that EXT4 supports large folios, it should be possible to add LBS
>> support to EXT4.
>>
>> I started digging in to the code, and it looks like it might require some
>> rework throughout EXT4 and lot of testing.
>>
>> My question is:
>>
>> I have seen patches from Zhang Yi to add iomap buffered IO support to EXT4.
>> If that happens, then adding LBS support should become trivial.
>>
>> Do you think it might happen soon or it is going to take more time?
>> Seeing the patches it is hard for me to say what the status is as the
>> last patches posted for them was last year.
> 
> Well, time is always relative so it's difficult to tell what do you mean by
> "soon" :). We are definitely interested in converting ext4 to iomap.
> Currently we are fixing up some remaining issues caused by conversion to
> support large order folios but after that iomap conversion would be a next
> logical step. Zhang Yi had patches for that, I'm not sure how much from
> them is left to apply after the large order folios have landed.

We have been working on the conversion of ext4 to iomap. The conversion
process for iomap has proven to be more complex than anticipated due to
numerous prerequisite issues and necessary refactors that must be
integrated. Currently, all prerequisite patches(perhaps) have been merged
into the latest 6.16-rc1 release, so I am rebasing my iomap series recently.
However, I have encountered some blocking issues during the rebase, and
I am trying to resolve them. I hope to release it as soon as possible.

> 
>> The reason I am asking is, should I take up the challenge to add LBS
>> support with buffer heads in EXT4, or should I wait until iomap patches
>> are merged.
> 
> I think better spent time would be to help with the iomap conversion. I
> don't think there will be that much coding left (perhaps some more exotic
> features need attention) but there's definitely testing needed and review
> is always welcome and most needed...
> 

My colleagues, Baokun and Zhihao, have been working on LBS support for a
couple of months, based on my two large folio series (buffer_head and
iomap convesion) and the bdev large folio series form Luis. They will
release the first version after testing as soon as possible.

Best regards,
Yi.





