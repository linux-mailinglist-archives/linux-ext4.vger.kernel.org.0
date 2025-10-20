Return-Path: <linux-ext4+bounces-10978-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02922BEFA1E
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 09:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 321504F1EAB
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2029E2E9EA9;
	Mon, 20 Oct 2025 07:11:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A72DC76A
	for <linux-ext4@vger.kernel.org>; Mon, 20 Oct 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944287; cv=none; b=Yqrsn191qyCuS3cdclzKgk4nH3tMXbYxTtJLjQjHJTYqslO7lkp1vDBgMkwJboB4teUHIbngwhh7Zfpqn0LWBS17A4MS0oNZAhvJbaR5ff+qosg0tk3Z7/pqLBaCLWZpDe2XH0lNOayw9RCL47MRO/0RFrOMiMZt8yoDZZXkSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944287; c=relaxed/simple;
	bh=k5fL67YRPU/t5xHMjnChlFVtg2UKLO+YlA+FT6PyvAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDPyDAf2SDD9u3mb6qubDHaHAH2URJn+FuBKbbYpQoAtOlRn53Jk7KLbj+f7yqU+mJJQFmbPecfoGZfy5jTAzi0CVUo8CbQ5UlUASkszl12/1la3yi3jyPPRniUKiVMLUqQvAdncyXVkCj9TeCTQE2XsTrTvb2I9dXCPQESDMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cqmm615xjzKHLyS
	for <linux-ext4@vger.kernel.org>; Mon, 20 Oct 2025 15:10:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C3E071A16CB
	for <linux-ext4@vger.kernel.org>; Mon, 20 Oct 2025 15:11:14 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBHnESQ4PVoHKXxAw--.18657S3;
	Mon, 20 Oct 2025 15:11:14 +0800 (CST)
Message-ID: <ebe38d8f-0b09-47b8-9503-2d8e0585672a@huaweicloud.com>
Date: Mon, 20 Oct 2025 15:11:12 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible regression in pin_user_pages_fast() behavior after
 commit 7ac67301e82f ("ext4: enable large folio for regular file")
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
References: <844e5cd4-462e-4b88-b3b5-816465a3b7e3@linux.intel.com>
 <a5452767-40bf-4621-8bbd-b693224ce6fd@linux.intel.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <a5452767-40bf-4621-8bbd-b693224ce6fd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnESQ4PVoHKXxAw--.18657S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kGw1fArWDJr4fKry5CFg_yoW5CrW8pr
	1xtryrKryjq3yvkr1jk3WDtryUAw4DJr1DX398tF4UA3y5W34j9w45Xay2gF1DZr4xAFnY
	q34jgwnxuay8CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, Karol.

Thank you for the report! I am trying to figure out how this issue
occurred. Could you provide a way to reproduce it? It would also be
helpful if you could include the kernel configuration and hardware
environment information.

Thanks,
Yi

On 10/17/2025 9:30 PM, Karol Wachowski wrote:
> Actually the threshold after which is starts to hang is 2 megabytes.
> 
> On 10/17/2025 3:24 PM, Karol Wachowski wrote:
>> Hi,
>>
>> I’m not entirely sure if this is right way to report this.
>>
>> I’ve encountered what appears to be a regression (or at least a
>> behavioral change) related to pin_user_pages_fast() when used with
>> FOLL_LONGTERM on a Copy-on-Write (CoW) mapping (i.e. VM_MAYWRITE without
>> VM_SHARED). Specifically, the call never finishes when the requested
>> size exceeds 8 MB.
>>
>> The same scenario works correctly prior to the following change:
>> commit 7ac67301e82f02b77a5c8e7377a1f414ef108b84
>> Author: Zhang Yi <yi.zhang@huawei.com>
>> Date:   Mon May 12 14:33:19 2025 +0800
>>
>>     ext4: enable large folio for regular file
>>
>> It seems the issue manifests when pin_user_pages_fast() falls back to
>> _gup_longterm_locked(). In that case, we end up calling
>> handle_mm_fault() with FAULT_FLAG_UNSHARE, which splits the PMD. 
>> From ftrace, it looks like the kernel enters an apparent infinite loop
>> of handle_mm_fault() which in turn invokes filemap_map_pages() from the
>> ext4 ops.
>>
>>   1)   1.553 us    |      handle_mm_fault();
>>   1)   0.126 us    |      __cond_resched();
>>   1)   0.055 us    |      vma_pgtable_walk_begin();
>>   1)   0.057 us    |      _raw_spin_lock();
>>   1)   0.111 us    |      _raw_spin_unlock();
>>   1)   0.050 us    |      vma_pgtable_walk_end();
>>   1)   1.521 us    |      handle_mm_fault();
>>   1)   0.122 us    |      __cond_resched();
>>   1)   0.055 us    |      vma_pgtable_walk_begin();
>>   1)   0.288 us    |      _raw_spin_lock();
>>   1)   0.053 us    |      _raw_spin_unlock();
>>   1)   0.048 us    |      vma_pgtable_walk_end();
>>   1)   1.484 us    |      handle_mm_fault();
>>   1)   0.124 us    |      __cond_resched();
>>   1)   0.056 us    |      vma_pgtable_walk_begin();
>>   1)   0.272 us    |      _raw_spin_lock();
>>   1)   0.051 us    |      _raw_spin_unlock();
>>   1)   0.050 us    |      vma_pgtable_walk_end();
>>   1)   1.566 us    |      handle_mm_fault();
>>   1)   0.211 us    |      __cond_resched();
>>   1)   0.107 us    |      vma_pgtable_walk_begin();
>>   1)   0.054 us    |      _raw_spin_lock();
>>   1)   0.052 us    |      _raw_spin_unlock();
>>   1)   0.049 us    |      vma_pgtable_walk_end();
>>
>> I haven’t been able to gather more detailed diagnostics yet, but I’d
>> appreciate any guidance on whether this is a known issue, or if
>> additional debugging information would be helpful.
>>
>> -
>> Karol
>>


