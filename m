Return-Path: <linux-ext4+bounces-6407-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DA9A2F81A
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 20:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73ECD3A880D
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E3E2566E6;
	Mon, 10 Feb 2025 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/ca8gRx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2325E446
	for <linux-ext4@vger.kernel.org>; Mon, 10 Feb 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214097; cv=none; b=JbkW3NpY2p12vV4FAJ5c8qizhlp7oN+JmIkslvc5/SOr5MflrsBBXUs9T2+JJUe480RyaZHDnPjnX0TCybsTEMJClaWOWhhkXCtLN+0uKZq8uADS8i9ikeyGPnWfl5GUKYQUDkQBQyij42XBkhj4c8/W6v8+0ttxIfuMtM6Gtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214097; c=relaxed/simple;
	bh=HCanVBKFOpmun47JOfujSAdBOhizy93bERI/UUMbepU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEjwTrswh0Bzg/lMB7mzJMfXNuj2dX371Nmdch7YgKkWpNIaB/F6y+5VyI+GQLVCnE3wHMV3Jm+RuFoSZ6tUSOS3nmbDUF32Htr54L5N80HKEKrTW6t11jV3LxCSh0lzC82RSJDjzORqA/v91ohtGVRB+yVMdKY8bjchepFpHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/ca8gRx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739214094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wzsV/nHxroBNjLXhWoD5i0vnw07P5+Zp+zulUeyeNIU=;
	b=N/ca8gRx5A+3HqwGD1/qCjoGe3DKwQSXMZyAJuX1tflVOtZywp+30F41v1szXZcxTVpn0p
	7aJgMPGtJzTyZ8d4jjeB/7UmHJ/X/TRIDTri46a8R9m70G26GRyGQyCT8UceehmQK9AWbu
	yPd6u0obaEI9zI3vaEmh6JKfuRS66tE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-qLXFogqDNx2jcT3VezaaGQ-1; Mon, 10 Feb 2025 14:01:33 -0500
X-MC-Unique: qLXFogqDNx2jcT3VezaaGQ-1
X-Mimecast-MFC-AGG-ID: qLXFogqDNx2jcT3VezaaGQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43933bdcce0so15826785e9.2
        for <linux-ext4@vger.kernel.org>; Mon, 10 Feb 2025 11:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214092; x=1739818892;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wzsV/nHxroBNjLXhWoD5i0vnw07P5+Zp+zulUeyeNIU=;
        b=TSUiDrF+v+RAv9zy20xEkD49IpXhSm7QxFJhkxhMEmvam605iQIGp+1/NwKHtOG0UF
         zWi1ea2K2z79PS32JT3hG0jArmzVDe5mHdZYr+oKKiahzDijx58pS+RoF6xGRaGaJyd3
         f2Vnvrz2MkKnzDmgTLRrZY8+lgnreyIxOqlp9K4Lec0fumg/PIBLwRVVOEnwLtiTC0eT
         8UFXpOe3H4PUy/dygBuhG5DhScSMY2p8bjkCHoBwLnZcan/y3XVTNUcjLGhiLkq+1aqK
         wryN+JyMou675nAQlrpz2ckQg20CEjNOUy32aI7C391xbPbaKTio0WH6QzxEO5rx01Hx
         P4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9raxp90TgIPTQ6v+16mUpOliSwIAdJN7UGQAles9Rt+4Bl7pw7TZSxLZvTbda5iPJHOyXegZMNU7R@vger.kernel.org
X-Gm-Message-State: AOJu0YzaqauF6H3P2QeyYohqIlw6UTcQ4RpVSReE9IkGX9O7Rsems2bn
	vGG15aXqVl5f49i4bgQ9TCY1va7xqGWVF/bO2ER/fptAXZy4UfiP5i8IQJFfGx+ZJz9pMEs7VJC
	OShHcW8xhG67O3L4K8WUT1m9mZXnmeo15gD5ymno+idcclVmnRzknzOr9NHY=
X-Gm-Gg: ASbGncs+o9dpRhUvg2UojriS8DoO6bKvd9ut/IxOkBdYr5+gJas1tfcQq63h7gMGd01
	DCO4TnA2BiDdPeieVM7S1qGL6oJhXJq71qAY0Q1lkVuCO9M+b93S7hKN/tT4+9kWu4AJ1omR0Ak
	dnl45qzDfyL/qDCYnt7OJVhjNW67KU7APpwhevXjCwZHBz6GalZMcY9T8SlbvgltA+TIujuUjIv
	t81lKh+yitvbdo+xbscG3JXaHLL5G6W68SDUQaoC4qBKWue7EzhWWcj7q5Q37SLzZMuQOaND8Y4
	ySA9YVcSxsgP2xUZriMUNBHlvah6I+Q6+FHG1ZUV8Qv7Eq9qOg7TWTNNaQsd7rlrxSO2hgzKH+F
	HfAfPaQBRRCyJMgi4VJVYYF9DjOqzZtED
X-Received: by 2002:a05:600c:190e:b0:438:a240:c55 with SMTP id 5b1f17b1804b1-4392497d5a2mr101320375e9.1.1739214092210;
        Mon, 10 Feb 2025 11:01:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqWvelv/EcWxqIdqqM8VMOUSW6z55PUGBNaBVsQSNr8P/MbW0xQgBUZTOgnOd6dY4d3UNnxA==
X-Received: by 2002:a05:600c:190e:b0:438:a240:c55 with SMTP id 5b1f17b1804b1-4392497d5a2mr101319385e9.1.1739214091737;
        Mon, 10 Feb 2025 11:01:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:b800:12c4:65cd:348a:aee6? (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc17e278bsm12112233f8f.48.2025.02.10.11.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:01:30 -0800 (PST)
Message-ID: <6a6773ae-a21a-437c-be6f-d8e53267e534@redhat.com>
Date: Mon, 10 Feb 2025 20:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/20] fs/dax: Properly refcount fs dax pages
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
 <b5c33b201b9dc0131d8bb33b31661645c68bf398.1738709036.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b5c33b201b9dc0131d8bb33b31661645c68bf398.1738709036.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>   
> -static inline unsigned long dax_page_share_put(struct page *page)
> +static inline unsigned long dax_folio_put(struct folio *folio)
>   {
> -	WARN_ON_ONCE(!page->share);
> -	return --page->share;
> +	unsigned long ref;
> +
> +	if (!dax_folio_is_shared(folio))
> +		ref = 0;
> +	else
> +		ref = --folio->share;
> +
> +	WARN_ON_ONCE(ref < 0);
> +	if (!ref) {
> +		folio->mapping = NULL;
> +		if (folio_order(folio)) {


I'd have made this easier to read by doing

if (ref)
	return ref;
folio->mapping = NULL;

order = folio_order(folio)
if (!order)
	return 0;

pgmap = page_pgmap(&folio->page);
for (i = 0; i < (1UL << order); i++) {
	// loop body see below
}
return 0;


In the context of similar split users and related discussions in the 
future with memdescs -- see 89a41a0263293856678189981e5407375261c4ff -- 
I would further do within the loop (avoiding messing with page-> 
completely):

...
	struct page *page = folio_page(folio, i);
	/* Careful: see __split_huge_page_tail() */
	struct folio *new_folio = (struct folio *)page;

	ClearPageHead(page);
	clear_compound_head(page);

	new_folio->mapping = NULL;	
	/*
	 * Reset pgmap which was over-written by
	 * prep_compound_page().
	 */
	new_folio->pgmap = pgmap;
	new_folio->share = 0;
	WARN_ON_ONCE(folio_ref_count(new_folio));
...


I scanned over the other stuff in here, but I'm not an expert on the 
pfn_t etc thingies.

-- 
Cheers,

David / dhildenb


