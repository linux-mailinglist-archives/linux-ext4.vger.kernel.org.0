Return-Path: <linux-ext4+bounces-11017-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B80BFAE65
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 10:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1141A010B6
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0155330BF79;
	Wed, 22 Oct 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd0gC0fK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D030ACE7
	for <linux-ext4@vger.kernel.org>; Wed, 22 Oct 2025 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121833; cv=none; b=E9iESpig/EF0iYVtC2wAn6dMGcsmZREEOA6ExecrO6w1fJkkCAN8d3gruvmFZnys5OMXxi7EKj+8Ug0C8Byp8oJYrF+kLBSY5ae1pC5H/Hg8eEqhe4KK202RrP90ibcamUI/sNR7NaB/TSM3GUymj8xFH9bknyam6wpbYHzQQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121833; c=relaxed/simple;
	bh=/IlDXvCVRxG+vA9p2J/j7XDxeC2J2jMQU1CA9jOh/7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBGCVW3vINm2MsXOI/4k2jQzgbQmxVanzfuBdlTgLOBhqK5kTrhrLD1NEsqGfRejYC2+5EIuMX3WMqhvmBzTlx9Qf6fuENpQIILf3GSDcK3qwcCKlqiJMDQaop3xyzAruA98a/dxsvmOwAdWTey+ZU2VOa2nkb+lHPf5B9KNs7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd0gC0fK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761121829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EsxLvpRfVAtzWmwD/BrE9GukZbvo8A6MtCgmoy18IPU=;
	b=Wd0gC0fK2M7DtefLZMaxzfK+jWgGWpn9sPTXOxpcfpVRkOWDdxIq9YQIRep64WBnpNtLq8
	N7h68erYZAcaftAQR4jJjIujqpg3xpF2je72iyp25b3TIE+MbLxo0RwicG8gv6cH0fVXbV
	SSCjyGVt2Qn4K1KkLCXCgRC9rf6tuXE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-TMM1tp9dODanqT__bDnoxA-1; Wed, 22 Oct 2025 04:30:27 -0400
X-MC-Unique: TMM1tp9dODanqT__bDnoxA-1
X-Mimecast-MFC-AGG-ID: TMM1tp9dODanqT__bDnoxA_1761121827
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso381040f8f.1
        for <linux-ext4@vger.kernel.org>; Wed, 22 Oct 2025 01:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121826; x=1761726626;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsxLvpRfVAtzWmwD/BrE9GukZbvo8A6MtCgmoy18IPU=;
        b=aqpDXXYpjJS3SUUnQjnIUiKdBxo7HJEdZ8v7QkRflTC+qwQ63dtETbvVvuHhOKVWbg
         aRxzzblzsh2Hr/tSLDvjtxIP3ka1cq8Io+1JEcF5spA++we2qG665rxGe4QaGw4VsEsr
         K99ZTVmruSxV1wWU/GspLd3IlD99siD6iDjAyv3GliaRObwr0wg3+Ry+nS+9VGzhCRLK
         WcIRngxT3hFJr0w9r/f3VksdCaxvngp91cs2QWyRKCnVz11UMkKF1/P3EP9palboEcUM
         l150+2RFQSD0Jm9CaPI3+jmQ1yEUGPgXk4m0HNbf9ic6g+hPbNGMjuBwm6u2sUAtLDCA
         u78Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCd9uLekn7fAVdSIPsczEXm5lsOOLKccuPrTizuaMxLPgkD9BpzS2BmFNahEh2bCaFCsoi6uV6dLZS@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxHJPFviz76t6oCapPq8xtgawlHR/PfUqSlFhVzh0gUzpRDOw
	aHpCmwiX5TlfqSiu43wGddIxO2T+jYXCHugVpHizUtUc8hhKt85E2J3yYWkuyzqLKvwEtdeHLhC
	ptEBobYTA4kUZe1CXFQY4IWRf4RnZDuwl4GRUyjrr+xmw9L08nAm1mADc3mU3akO+eIl5f38=
X-Gm-Gg: ASbGncuDKKMDoj+aCSOPyrXSG3lW515WM+xPCtNmU38B7fwVrTwe4URBxcJmbdtcqfp
	NtcZVrlZ+2j2ZTrTRm6Omsy42hkgXh3Xwt3aCtB0f/k/ULir/dm+Z//vhm1rEl88BLCuNeml/Om
	Muqz+Te8S6Uj0p5UxKe+wlAkREDhGzX9WvJxreMhUXLhWAZTSUT4smmEGU1FYQQHh9ZBdX3nLxE
	L7/KRwOK86ONBk38zl8DPgUjqO91vm3Ql2+IWlAcx25euNnXELTY3dh+BIyGQL1A2F4hCIg6cJz
	Wmfw6y8YvwAEIQ9YTgfhj0S6qgr93tPLbWGjMUF5ZoJcBV/apJo7T1fqCxxtOElx0i2q/+wtuUD
	xBHlmUelt6HPxmbyMqMp4RMmUwacLkXVpVNnfu1WZBNDYyibQSTElsGYimVf2iWl8gWOdAYOda4
	8bKKHAKLxwZcvsrWxAPEyW+gLRExo=
X-Received: by 2002:a05:6000:4025:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-42856a892b7mr507134f8f.26.1761121826482;
        Wed, 22 Oct 2025 01:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr1mFA4TypwGaJb/ZVWY2T1KbDUJFoQ4UPJFSPR1XrWyJedLY+MVkn551j2s+baXToxNihRQ==
X-Received: by 2002:a05:6000:4025:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-42856a892b7mr507111f8f.26.1761121826043;
        Wed, 22 Oct 2025 01:30:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm24596493f8f.28.2025.10.22.01.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:30:25 -0700 (PDT)
Message-ID: <43cc7217-93bc-4ee6-99d2-83d9b26eb31a@redhat.com>
Date: Wed, 22 Oct 2025 10:30:23 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible regression in pin_user_pages_fast() behavior after
 commit 7ac67301e82f ("ext4: enable large folio for regular file")
To: Zhang Yi <yi.zhang@huaweicloud.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org
References: <ebe38d8f-0b09-47b8-9503-2d8e0585672a@huaweicloud.com>
 <20251020084736.591739-1-karol.wachowski@linux.intel.com>
 <0fec500c-52ea-473d-b276-826c0f4dd76f@huaweicloud.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <0fec500c-52ea-473d-b276-826c0f4dd76f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 04:46, Zhang Yi wrote:
> [add mm list to CC]
> 
> On 10/20/2025 4:47 PM, Karol Wachowski wrote:
>> Hi,
>>
>> I can reproduce this on Intel's x86 (Meteor Lake and Lunar Lake Intel CPUs
>> but I believe it's not platform dependent). It reproduces on stable.
>> I have bisected this to the mentioned commit: 7ac67301e82f02b77a5c8e7377a1f414ef108b84
>> and it reproduces every time if that commit is present. I have attached a patch at the
>> end of this message that provides a very simple driver that creates character device
>> which calls pin_user_pages_fast() on user provided user pointer and simple test application
>> that creates 2 MB file on a filesystem (you have to ensure it's location is on ext4) and
>> does IOCTL with pointer obtained through mmap of that file with specific flags to reproduce
>> the issue.
>>
>> When it reproduces user application hangs indefinitely and has to be interrupted.
>>
>> I have also noticed that if we don't write to the file prior to mmap or the write size is less than
>> 2 MB issue does not reproduce.
>>
>> Patch with reproductor is attached at the end of this message, please let me know if that helps or
>> if there's anything else I can provide to help to determine if it's a real issue.
>>
>> -
>> Karol
>>
> Thank you for the reproducer. I can reproduce this issue on my x86 virtual
> machine. After debugging and analyzing, I found that this is not a
> filesystem issue, we can reproduce it on any filesystem that supports
> large folios, such as XFS. However, anyway, IIUC, I think it's a real
> issue.
> 
> The root cause of this issue is that calling pin_user_pages_fast() triggers
> an infinite loop in __get_user_pages() when a PMD-sized(2MB on x86) and COW
> mmaped large folio is passed to pin. To trigger this issue on x86, the
> following conditions must be met. The specific triggering process is as
> follows:
> 
> 1. Call mmap with a 2MB size in MAP_PRIVATE mode for a file that has a 2MB
>     folio installed in the page cache.
> 
>     addr = mmap(NULL, 2 * 1024 * 1024, PROT_READ, MAP_PRIVATE, file_fd, 0);
> 2. The kernel driver pass this mapped address to pin_user_pages_fast() in
>     FOLL_LONGTERM mode.
> 
>     pin_user_pages_fast(addr, nr_pages, FOLL_LONGTERM, pages);
> 
>    ->  pin_user_pages_fast()
>    |   gup_fast_fallback()
>    |    __gup_longterm_locked()
>    |     __get_user_pages_locked()
>    |      __get_user_pages()
>    |       follow_page_mask()
>    |        follow_p4d_mask()
>    |         follow_pud_mask()
>    |          follow_pmd_mask() //pmd_leaf(pmdval) is true since it's pmd
>    |                            //installed, This is normal in the first
>    |                            //round, but it shouldn't happen in the
>    |                            //second round.
>    |           follow_huge_pmd() //gup_must_unshare() is always true


FOLL_LONGTERM in a private mapping needs an anon folio, so this checks out.

>    |            return -EMLINK
>    |   faultin_page()
>    |    handle_mm_fault()
>    |     wp_huge_pmd() //split pmd and fault back to PTE

Oh, that's nasty. Indeed, we don't remap the PMD to be mapped by PTEs 
but instead zap it.

__split_huge_pmd_locked() contains that handling.

We have to do that because we did not preallocate a page table we can 
just throw in.

We could do that on this path instead: remap the PMD to be mapped by a 
PTE table. We'd have to preallocate a page table.

That would avoid the do_pte_missing() below for such faults.

that could be done later on top of this fix.

>    |     handle_pte_fault()  //
>    |      do_pte_missing()
>    |       do_fault()
>    |        do_read_fault() //FAULT_FLAG_WRITE is not set
>    |         finish_fault()
>    |          do_set_pmd() //install leaf pmd again, I think this is wrong!!!
>    |      do_wp_page() //copy private anno pages
>    <-    goto retry
> 
> Due to an incorrectly large PMD set in do_read_fault(), follow_pmd_mask()
> always returns -EMLINK, causing an infinite loop. Under normal
> circumstances, I suppose it should fall back to do_wp_page(), which installs
> the anonymous page into the PTE. This is also why mappings smaller than 2MB
> do not trigger this issue. In addition, if you add FOLL_WRITE when calling
> pin_user_pages_fast(), it also will not trigger this issue becasue do_fault()
> will call do_cow_fault() to create anonymous pages.
> 
> The above is my analysis, and I tried the following fix, which can solve
> the issue (I haven't done a full test yet). But I am not expert in the MM
> field, I might have missed something, and this needs to be reviewed by MM
> experts.
> 
> Best regards,
> Yi.
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 74b45e258323..64846a030a5b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5342,6 +5342,10 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
>   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
>   		return ret;
> 
> +	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE) &&
> +	    !pmd_write(*vmf->pmd))
> +		return ret;

Likely we would want to make this depend on is_cow_mapping().

/*
  * We're about to trigger CoW, so never map it through a PMD.
  */
if (is_cow_mapping(vma->vm_flags &&
     vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)))
	return ret;

-- 
Cheers

David / dhildenb


