Return-Path: <linux-ext4+bounces-6089-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17473A109E4
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 15:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817733A5DBF
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16DF1553B7;
	Tue, 14 Jan 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWZoBIcx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFB14658C
	for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866277; cv=none; b=GHqLdloCYs/7mOFBiwoU9/rPZZFTLWyxJPlRijYxjmvg480OBJNqhWt8A646OSnrh9bF64Vq1dqih7oNK667X943OtMJ3Qf/qSGdo/DzqEgYmJHi3aAO0+Zq94FD3lzfMml63768p7jLYjtvUi65DQTJPeBZVXYsKkwVrodzc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866277; c=relaxed/simple;
	bh=JbOAtelmJcbWUE7Ixh33K3ATanb//ICHOjpdXdNz9mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyRdsqt8PJBAQuCKSjyLcNr0ePdXlX3k1J7hY814j/MoIhHTcuuREAkkuI3ONJcXX0q7i5G8ue6nFYf35p2GB8pYfKbcDOUcQKp6cQH4PoGgGawQ466/nzZY2Smev3pdXkJnMZbNjLXf6Ol7mMAnFVGNf2sgLObDHPA/JspF99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWZoBIcx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736866274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=frCMXuewTKaMxoSv5HkrB79R79VgidnpZu3s0YCdJnw=;
	b=dWZoBIcx0zJ92OM3plebfMSeLJq9TcAaFdKcaabvH0IIguIB5l9bG8jnU9/ue3Upza+tvp
	tugMdrIAqB+c1ZrNcgHzNfbffxG0pXIgZ3SQfQPTsjmhFMqV5lgRLVuq7bqRF3wNWx4JDr
	9nciOhTfrWQJUDpuPx12DSQtyHUGtA4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-52tJoUG2PquLK_DAUK5SQQ-1; Tue, 14 Jan 2025 09:51:13 -0500
X-MC-Unique: 52tJoUG2PquLK_DAUK5SQQ-1
X-Mimecast-MFC-AGG-ID: 52tJoUG2PquLK_DAUK5SQQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e00ebb16so2117513f8f.3
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2025 06:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866272; x=1737471072;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=frCMXuewTKaMxoSv5HkrB79R79VgidnpZu3s0YCdJnw=;
        b=bSrXRrfyOjv3gQ6Iv/Efqh+ClFzsh489KLP36VrT5pUgQd18H7Sp+jUYE1TjVCNtm3
         JEnrkR+OB5ufTv3meBHKGAUukqKtzUkWQP7tNcVT8w+3QW5Qh0NL4bfEPu/LMeqRKtg3
         FZOC7VSYMa6vtKlU7v6i+aGj+wGh1x5wDHXC3ao8PHkKzo7cuqoz6yuKSD7VoDa85xK8
         Ng+XRCP7rwWbaONvm1OUoYBKVCh9ACHen+kQ20zeU9JVthOJTJ6LC0jFE3l3mDZbqjWc
         bolaDL86zPxQMcjDnpwG2bG+0WFwNgPlzIbLC7PMnVfqK2UbG7BX3aDCCzd2P97caq+8
         n4VA==
X-Forwarded-Encrypted: i=1; AJvYcCWRIedkY1+zFAZadSsCGr37fFhhlSZjcGFaJ3R4FgWduVBngYUIpV0KpY3M1SV+d4g+nSmxy8jH19++@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGLm2B2qefPBDOWXRSOVWKNxW5hFZ/Ai1vMaAooAzQQEgdnDk
	y/7si4ta7XJhKj6v+KiV9MwQrSHH5EXSEHKYW0qn5NUHAwB8lCSeomYUB9ERSeB7cbwM7dI81vA
	EOQY2h3dN2DswVhkd3K1yajqfTj/zwmVwbMwDXl80/nwPwtG+G4dQCQT8mrg=
X-Gm-Gg: ASbGncuepXY+J8uEgjmTpExHQi3EaGfJZzRNBD7NcUBCD75Wwb7Ywrx4Q4485ePclRQ
	NtdjYI2QSwOp/5uj6SAqpzfXRCMsOK1cUhPygB+okAO9ApX5ADHQFKMLpam6ltQjIcjCYoiWN1l
	WbE4+ZNGQRi9TbqX3pLDSiGHiIKOf0eSlui1cEKvSaDVDhHru4ktaeXpZnqQW25t4fAzox9ir1V
	QVKkyhxkdz3i/TEYhv1kcIwZ1c3a1YLRM8vSzlQsBxW7H3orfp5Qd+u2S5VzwnLyDTR+GqwFnIX
	1rNCCY87MpoX9F2p+6UHqbwe3MYn6BZQ4Jb4S09E0MuKJeusvLd0Er7gSCK2DMo6CjPtm0w3J+P
	QCbkPHTtw
X-Received: by 2002:a05:6000:18a2:b0:382:49f9:74bb with SMTP id ffacd0b85a97d-38a872f3202mr24489636f8f.35.1736866272082;
        Tue, 14 Jan 2025 06:51:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7GJ1+W/uNTlLNM/+qMUx1r19EPlEDmBQ7z7UMM/B1+0DtBI15xOV7jFVV7enwVcHppl6EyQ==
X-Received: by 2002:a05:6000:18a2:b0:382:49f9:74bb with SMTP id ffacd0b85a97d-38a872f3202mr24489568f8f.35.1736866271639;
        Tue, 14 Jan 2025 06:51:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c6dbsm15361588f8f.55.2025.01.14.06.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 06:51:11 -0800 (PST)
Message-ID: <9be14739-82cc-42fb-bb38-a868231cdda6@redhat.com>
Date: Tue, 14 Jan 2025 15:51:09 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/26] mm/mm_init: Move p2pdma page refcount
 initialisation to p2pdma
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com,
 gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, peterx@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com,
 hch@lst.de, david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <4f3fa1bb9cf4402d6131d0902472d8e9bae52f88.1736488799.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4f3fa1bb9cf4402d6131d0902472d8e9bae52f88.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 07:00, Alistair Popple wrote:
> Currently ZONE_DEVICE page reference counts are initialised by core
> memory management code in __init_zone_device_page() as part of the
> memremap() call which driver modules make to obtain ZONE_DEVICE
> pages. This initialises page refcounts to 1 before returning them to
> the driver.
> 
> This was presumably done because it drivers had a reference of sorts
> on the page. It also ensured the page could always be mapped with
> vm_insert_page() for example and would never get freed (ie. have a
> zero refcount), freeing drivers of manipulating page reference counts.
> 
> However it complicates figuring out whether or not a page is free from
> the mm perspective because it is no longer possible to just look at
> the refcount. Instead the page type must be known and if GUP is used a
> secondary pgmap reference is also sometimes needed.
> 
> To simplify this it is desirable to remove the page reference count
> for the driver, so core mm can just use the refcount without having to
> account for page type or do other types of tracking. This is possible
> because drivers can always assume the page is valid as core kernel
> will never offline or remove the struct page.
> 
> This means it is now up to drivers to initialise the page refcount as
> required. P2PDMA uses vm_insert_page() to map the page, and that
> requires a non-zero reference count when initialising the page so set
> that when the page is first mapped.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 

LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


