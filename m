Return-Path: <linux-ext4+bounces-11031-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA5FC04D8A
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3C11AE2569
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0752EDD7A;
	Fri, 24 Oct 2025 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RC4DlXk2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D702EDD40
	for <linux-ext4@vger.kernel.org>; Fri, 24 Oct 2025 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292056; cv=none; b=WzhSvcSxLH9fAk2vGzt8H7bTY/kF/2VOgolBXMshqd5U7G/VD8wQRHxGOlQ5P72fyzI7rp00+0srZ6mucXeM6GQ5d/QuUEmIcX66FMMzM7y+OLBEQaEI8NXqvpNVO0Ege4t16+FL+DGtmVdTtGo/HV6ashEU/+1QTJlfQAfeJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292056; c=relaxed/simple;
	bh=354Rzc8WGXE7NwaWZYUhPCTxpBFnARCx8ba66VokYak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL3hqaLdPBhNHLZKTYq37Ha2fJqGow5oCzDvbM7YWXnEQ4fyRgvPG3VbL2R69eDR9BVSD+VgmM1HeMnaLXYvGk+WpPWTuUoOiZazVXakN+z+5F8dWnsol9E63M1riHR0yMoXv1e/QcgRRsMdfOwPf2nWKeZnGHacERj5ioDtPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RC4DlXk2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761292053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5ecy7KW/4Q3PaNtjQEWD2FoEZh8uYi4fefNLgyAB9zU=;
	b=RC4DlXk2k7Lbf14KKlQLA/ugjtDrz4ZDcy0FwCiHVMXHDwX2GUwBn0BtmlZFyIRFb0ZCmv
	NXqycpyxKkhVDxBkqTzjfQJgGiZ+Mk6W3ePDP0e/+UuGfCLORgXiQUoKLFU+WMxONlEQpy
	Vn9g048wctHv9HzCxF3/MD8PVfepIxc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Rcy0AGvYNjWQFYjwem90-Q-1; Fri, 24 Oct 2025 03:47:31 -0400
X-MC-Unique: Rcy0AGvYNjWQFYjwem90-Q-1
X-Mimecast-MFC-AGG-ID: Rcy0AGvYNjWQFYjwem90-Q_1761292050
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471001b980eso14667485e9.1
        for <linux-ext4@vger.kernel.org>; Fri, 24 Oct 2025 00:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292050; x=1761896850;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ecy7KW/4Q3PaNtjQEWD2FoEZh8uYi4fefNLgyAB9zU=;
        b=SIu1GyD9O4GXU23rsWnOLToYjFbKgBjveIseEPuVaDlbJkADqeZ8wQwQ5HSzAs3ygA
         y1hKcx1G0NLdxgsYfs+fVdt2twOXK+JqP0Q0ZBSncmdMFEGzc2RjArYitaZfT8v54YSX
         YhOwOl3M2EwG8o1AFtWJKNJjweVlNsq9bd50I27lUrTy9LeKnnq5FMaS0SVZFMkHivAk
         YgE9pIL/nvAqDlRXjvCqzyyHMII92dgtHRFLKG1nOLwVfTTBz3W/r7dYcr9fsGwga3DU
         JxbNsD0xEaYD249S/n3cDHyJf4IpD6BzCrsu76XuJGNPm16s4IIpziAldlvJdSHnJACh
         kjhw==
X-Gm-Message-State: AOJu0YzVB4uKAeGe7+a676EuN/tih74MLwXWl1fk8Wy2TzuUqaDX/WeR
	vvTj6D4NImmw3niMeIx7bwgQivuodB9fegNXmEHG7CuA5B9P/3GhzZWyV9l/L+/kxg+mORr80ci
	C2IFZUM/BW4f1U7Sblv0e0aLgk2xH9J8RDuXNlLTjSU8ThPHAEgAe4JYtLONK0iTgJWJG4/Y=
X-Gm-Gg: ASbGncvTRj7aR54PXGg9mJG2NPU7CGr2TEIDpiwuRhSFKt3tY6V2FdYc6Kw+s9bcwv2
	isYhovpBkOnJwe1oRFefLrXbE8YF8UDRUCeLd4zBnXyRsogKXNOZi6d0kGPXaDTlMbB1H0ptkq4
	xuWz9g872znjoI1rzh5UddMod43yaWhCuqtuLamF4pGvhhJl01fOtP/wbH2IJviirTiESfwhBG1
	1X84Ti1rgR7TtCJRu0oUn7e9WEZwmlvtdwsUaxZc0sFlzA/VyeSJj5maAKLjtYsBlZiLRU4LbTe
	pE1rDOsPUUuhvnQ44xwVcTQaU9pqQUp0VYlo5Qp54VZY1Pk8s7fYENw4CJ+bHPrOLJJrBNC1v9f
	jnKTNUoD3vYbg3j34Ua8xjQE/vb2gCkjKVFUKAghiJdarKAh292yLVzLDH051eOP0YLaNnAGVhH
	zURROiFMgAc/sPHLs77ngt1opsYv4=
X-Received: by 2002:a05:600c:3b22:b0:471:989:9d85 with SMTP id 5b1f17b1804b1-471179122eemr199555095e9.19.1761292050467;
        Fri, 24 Oct 2025 00:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCk5knVvG9aEJVjQIGNEPj71HBH+RTp0yRPtlz2moXZyXlFUc8p92AbKQUvfwnx5Ns0MFGdw==
X-Received: by 2002:a05:600c:3b22:b0:471:989:9d85 with SMTP id 5b1f17b1804b1-471179122eemr199554895e9.19.1761292050063;
        Fri, 24 Oct 2025 00:47:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae9253bsm74552055e9.1.2025.10.24.00.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:47:29 -0700 (PDT)
Message-ID: <9bfd8972-4111-4afb-b8a2-f514ae67f67f@redhat.com>
Date: Fri, 24 Oct 2025 09:47:28 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: do not install PMD mappings when handling a COW fault
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-mm@kvack.org
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, karol.wachowski@linux.intel.com,
 wangkefeng.wang@huawei.com, yangerkun@huawei.com
References: <20251024015459.2824162-1-yi.zhang@huaweicloud.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251024015459.2824162-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.25 03:54, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> During the ping of user pages in FOLL_LONGTERM on a COW VMA and a

s/ping/pin/ or better "When pinning a page with FOLL_LONGTERM in a CoW 
VMA ..."

> PMD-aligned (2MB on x86) large folio, follow_page_mask() failed to
> obtain a valid anonymous page, resulting in an infinite loop issue.
> The specific triggering process is as follows:
> 
> 1. User call mmap with a 2MB size in MAP_PRIVATE mode for a file that
>     has a 2MB large folio installed in the page cache.
> 
>     addr = mmap(NULL, 2*1024*1024, PROT_READ, MAP_PRIVATE, file_fd, 0);
> 
> 2. The kernel driver pass this mapped address to pin_user_pages_fast()
>     in FOLL_LONGTERM mode.
> 
>     pin_user_pages_fast(addr, 512, FOLL_LONGTERM, pages);
> 
>    ->  pin_user_pages_fast()
>    |   gup_fast_fallback()
>    |    __gup_longterm_locked()
>    |     __get_user_pages_locked()
>    |      __get_user_pages()
>    |       follow_page_mask()
>    |        follow_p4d_mask()
>    |         follow_pud_mask()
>    |          follow_pmd_mask() //pmd_leaf(pmdval) is true because the
>    |                            //huge PMD is installed. This is normal
>    |                            //in the first round, but it shouldn't
>    |                            //happen in the second round.
>    |           follow_huge_pmd() //require an anonymous page
>    |            return -EMLINK;
>    |   faultin_page()
>    |    handle_mm_fault()
>    |     wp_huge_pmd() //remove PMD and fall back to PTE
>    |     handle_pte_fault()
>    |      do_pte_missing()
>    |       do_fault()
>    |        do_read_fault() //FAULT_FLAG_WRITE is not set
>    |         finish_fault()
>    |          do_set_pmd() //install a huge PMD again, this is wrong!!!
>    |      do_wp_page() //create private anonymous pages
>    <-    goto retry;
> 
> Due to an incorrectly large PMD set in do_read_fault(),
> follow_pmd_mask() always returns -EMLINK, causing an infinite loop.
> 
> David pointed out that we can preallocate a page table and remap the PMD
> to be mapped by a PTE table in wp_huge_pmd() in the future. But now we
> can avoid this issue by not installing PMD mappings when handling a COW
> and unshare fault in do_set_pmd().
> 
> Fixes: a7f226604170 ("mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared anonymous page")
> Reported-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Closes: https://lore.kernel.org/linux-ext4/844e5cd4-462e-4b88-b3b5-816465a3b7e3@linux.intel.com/
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>   mm/memory.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ba4f6b71847..0748a31367df 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5212,6 +5212,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
>   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
>   		return ret;
>   
> +	/* We're about to trigger CoW, so never map it through a PMD. */
> +	if (is_cow_mapping(vma->vm_flags) &&
> +	    (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)))
> +		return ret;
> +
>   	if (folio_order(folio) != HPAGE_PMD_ORDER)
>   		return ret;
>   	page = &folio->page;

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Cheers

David / dhildenb


