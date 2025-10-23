Return-Path: <linux-ext4+bounces-11025-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95125BFFA05
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 09:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4199235A41F
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59729236453;
	Thu, 23 Oct 2025 07:34:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD90DDC3
	for <linux-ext4@vger.kernel.org>; Thu, 23 Oct 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204859; cv=none; b=igsL8zJUZrlmaXieJaCV5xcxQ/KXmIu7+heqU5V045DdYvB3TocRpcooH1j1V5nCUtnfqbfQosUSDky2RKPEEVmVqpM/kl25pC5Y1xVqN5EJ8VnnD6W46w+c7+FQO+aHm5+9EdmY7GpKVefq7b9k3JCsIR+tdftDNYpXANCYCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204859; c=relaxed/simple;
	bh=GSGuoDmEqbdfkdYvV/pZcsTdNDL3I8c2w/CapElOTGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pj4Lg9QDeavgJCAzLwl5fGHWJDOKwqgzIdjznEvJw+iyFEirNkcFuBIP8k+fyn4Z5thKAyrzcqFhYqUPAvjrwyAuSUgbv3jlgsukQI0Mv9r+3kb9GpWKpWGuAeHxMUypV3ivbt4NsCFuMHTCK8U+lvOP6b8rASZcf2dT6MnCW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4csd774GxfzKHMRH
	for <linux-ext4@vger.kernel.org>; Thu, 23 Oct 2025 15:33:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9BA6A1A0B99
	for <linux-ext4@vger.kernel.org>; Thu, 23 Oct 2025 15:34:12 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBHnERy2vlo6FxJBQ--.49363S3;
	Thu, 23 Oct 2025 15:34:12 +0800 (CST)
Message-ID: <f718868a-563f-41b0-bdef-b0a2a98877ce@huaweicloud.com>
Date: Thu, 23 Oct 2025 15:34:10 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible regression in pin_user_pages_fast() behavior after
 commit 7ac67301e82f ("ext4: enable large folio for regular file")
To: David Hildenbrand <david@redhat.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org
References: <ebe38d8f-0b09-47b8-9503-2d8e0585672a@huaweicloud.com>
 <20251020084736.591739-1-karol.wachowski@linux.intel.com>
 <0fec500c-52ea-473d-b276-826c0f4dd76f@huaweicloud.com>
 <43cc7217-93bc-4ee6-99d2-83d9b26eb31a@redhat.com>
 <610d89e2-6970-4924-824b-f27a2424979b@huaweicloud.com>
 <41f30998-e498-4c33-a4b4-99b9f7339fd7@redhat.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <41f30998-e498-4c33-a4b4-99b9f7339fd7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHnERy2vlo6FxJBQ--.49363S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur4xZF17ZF17Jr43CF4UArb_yoW3ZrXE9r
	4rZr92kw1DCF4DtrZ8KFWkGrWqgFWYqF4agry7ur1rJw1DJFyfCFnrGwn7uF1Fga9rtrn0
	vrnIqF17WF9IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/23/2025 3:24 PM, David Hildenbrand wrote:
>>> __split_huge_pmd_locked() contains that handling.
>>>
>>> We have to do that because we did not preallocate a page table we can just throw in.
>>>
>>> We could do that on this path instead: remap the PMD to be mapped by a PTE table. We'd have to preallocate a page table.
>>>
>>> That would avoid the do_pte_missing() below for such faults.
>>>
>>> that could be done later on top of this fix.
>>
>> Yeah, thank you for the explanation! I have another question, just curious.
>> Why do we have to fall back to installing the PTE table instead of creating
>> a new anonymous large folio (2M) and setting a new leaf huge PMD?
> 
> Primarily because it would waste more memory for various use cases, on a factor of 512.
> 

Ha, I got it, that makes sense! :-)

Thanks,
Yi.


