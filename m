Return-Path: <linux-ext4+bounces-3084-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0C923CF4
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jul 2024 13:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19FBB241BF
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jul 2024 11:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72016F0FE;
	Tue,  2 Jul 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok4G4Bih"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5F16D4CE
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jul 2024 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921203; cv=none; b=uQc6LagwnSxQBzMWz4x+eN7FVSBn98doA3Jyf5/P7VwtLM5Shz5kYvkhk0S3I8L797J5ZNJioWGOPzTikhU+RP/GAvUiMJc66whmFSYAC5MN3PWXk55N0VMwKw1F6vSS54BBmuo6QOcKybRiAwTkEn4dNRHh9rSDkksbzZir4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921203; c=relaxed/simple;
	bh=Y+euLA9CMrGua2o5ytSU834QYAQblxx+Y9QmTyCdmoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHlbfh9f8RacMDpc+Fin3KZ9Q4t4kdC20qz8DQJEw+D/cCT9OE3XP3flC6vbOO5XSq8ERTMFO/Yfh4a9wsUbisd7lXHeLmrMljg8IrDpF8SRXTqo2NAlwFSwKlwiyepxVGhlU2q93Ixin5SqgtBbo1/iVTjTTTQmxTdjeDtpSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ok4G4Bih; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719921201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CLzIS6/xqvBtE7oUGCvw27/2uQHcsttu4uuLNGJydEo=;
	b=Ok4G4BihRFOX2tmCFXbR4vKBTpDbZRciJio70WFpheNUIAsVDd28frd26s2TtOFW/dUmfB
	iyVoqT6GMxEZiX2KRy0FxX+rNl1ikIckvthVMhdzCgfJrHsixm/m4NOs8fgBoshKAXCYHg
	EUd2A+CfQMnW6icFAx3oVDg1JmcX1Eg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-2ZP1M1DGN36I0T-jqYlilQ-1; Tue, 02 Jul 2024 07:53:17 -0400
X-MC-Unique: 2ZP1M1DGN36I0T-jqYlilQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3625b8355b5so3302996f8f.3
        for <linux-ext4@vger.kernel.org>; Tue, 02 Jul 2024 04:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719921197; x=1720525997;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CLzIS6/xqvBtE7oUGCvw27/2uQHcsttu4uuLNGJydEo=;
        b=eB1K6+9ecYRDbHewnXLHsQ0y14jBrORIxIsyyWcMkUBxBBq11o+mrewWF9I5PrSFHQ
         yDt/IPsXoCDbNjcZpWfoL4xufWkhrE0B+Gjv8zmRXJwgu5VsDRsCSBZP565uJ0LQGEhh
         KGHimKvIGZju0gP3J3lk3qDKQkfsNz0k9Qbh7UK4cwHl8vg7oaKhWu4Yn9IdxidXaNye
         3KEN+WOW/u7aXnbMknQEqBxJ5oo5Ivp57E05UWKvDGHprsX2MZjgORaAZI5Tpzw02cRI
         VtSLZPMurpHxZu78lIdNLAACsPQPAWWj6CYdghcyVxHTwKHIrXITKezc8ufigNLocWsu
         2r5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMYAazgedynO6gEKcwFXpJneXHRGmxJGpnGQW8OtPg3+jMRXWS6uKobLx8KdLItwpdF5QBQG2wM3rxrAm2Rb78uM7AcN6YrmQ+wg==
X-Gm-Message-State: AOJu0YyKUdFxiQFvLNX6CKuc7hUdTkXNjb2HsKg0YvSa8YauG3YulcRB
	/vbTZiZH6P6xVXPk0P9wQ2dzcflSrJ3ZL5y6CaRl1N0u16Mn4PQ8DKmQYgIebMEp9B+Nz+Ad5Mv
	o2f1q7/v3FPn9oQa7xyR1UhRnAZe+rQtQoHfCaUJcJzOXkTXe5Stl6AzYGIsUykp/z1k=
X-Received: by 2002:adf:db48:0:b0:35e:ebe7:de43 with SMTP id ffacd0b85a97d-367756aaa04mr5978286f8f.21.1719921196810;
        Tue, 02 Jul 2024 04:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQMF0a8Br6+lHUnDLVeQ1xr6zVjHgN/vKj9wCtu/b+UZ8WneOYrvFC2+PloSAW0ikkuhAeCg==
X-Received: by 2002:adf:db48:0:b0:35e:ebe7:de43 with SMTP id ffacd0b85a97d-367756aaa04mr5978267f8f.21.1719921196375;
        Tue, 02 Jul 2024 04:53:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257dee5f2asm106204245e9.22.2024.07.02.04.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 04:53:15 -0700 (PDT)
Message-ID: <0c701d72-2f9c-405c-8e64-ec058568845a@redhat.com>
Date: Tue, 2 Jul 2024 13:53:13 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] mm/memory: Add dax_insert_pfn
To: Christoph Hellwig <hch@lst.de>
Cc: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com,
 david@fromorbit.com
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <50013c1ee52b5bb1213571bff66780568455f54c.1719386613.git-series.apopple@nvidia.com>
 <eb3120fd-44db-4cb3-af3c-a13f9e71380b@redhat.com>
 <20240702114601.GA15426@lst.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240702114601.GA15426@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.24 13:46, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 09:18:31AM +0200, David Hildenbrand wrote:
>> We have this comparably nasty vmf_insert_mixed() that FS dax abused to
>> insert into !VM_MIXED VMAs. Is that abuse now stopping and are there maybe
>> ways to get rid of vmf_insert_mixed()?
> 
> Unfortunately it is also used by a few drm drivers and not just DAX.

At least they all seem to set VM_MIXED:

* fs/cramfs/inode.c does
* drivers/gpu/drm/gma500/fbdev.c does
* drivers/gpu/drm/omapdrm/omap_gem.c does

Only DAX (including drivers/dax/device.c) doesn't.

VM_MIXEDMAP handling for DAX was changed in

commit e1fb4a0864958fac2fb1b23f9f4562a9f90e3e8f
Author: Dave Jiang <dave.jiang@intel.com>
Date:   Fri Aug 17 15:43:40 2018 -0700

     dax: remove VM_MIXEDMAP for fsdax and device dax

After prepared by

commit 785a3fab4adbf91b2189c928a59ae219c54ba95e
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Mon Oct 23 07:20:00 2017 -0700

     mm, dax: introduce pfn_t_special()

     In support of removing the VM_MIXEDMAP indication from DAX VMAs,
     introduce pfn_t_special() for drivers to indicate that _PAGE_SPECIAL
     should be used for DAX ptes.

I wonder if there are ways forward to either remove vmf_insert_mixed() 
or at least require it (as the name suggests) to have VM_MIXEDMAP set.

-- 
Cheers,

David / dhildenb


