Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA654C903E
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 17:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiCAQXT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Mar 2022 11:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiCAQWz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Mar 2022 11:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 091E12DA8F
        for <linux-ext4@vger.kernel.org>; Tue,  1 Mar 2022 08:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646151733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VpcEjZ3pDaEx12dH+BduTDFR/D5IwkR6BCpw7XkWHU0=;
        b=gPj0/G4JttlA8PIQES5HkDDGyu7uuI/AAEmsvq0Hk8ohCU/RLGKsP6/YiL2g4O6GUdD0bB
        loFPbqzt5gEdJqWOCGMDiBbKONP0mEFjxO8onZ2mdXfY8q275EqPgcN5ya+iLPK4ku16Bw
        UxKS7T4cqfJkfG1cr4i1U0AdoJ+VRZo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-mmqLtKSOM5urZg5wPZ3hqg-1; Tue, 01 Mar 2022 11:22:12 -0500
X-MC-Unique: mmqLtKSOM5urZg5wPZ3hqg-1
Received: by mail-wm1-f70.google.com with SMTP id o21-20020a05600c511500b003818c4b98b5so349899wms.0
        for <linux-ext4@vger.kernel.org>; Tue, 01 Mar 2022 08:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VpcEjZ3pDaEx12dH+BduTDFR/D5IwkR6BCpw7XkWHU0=;
        b=LZydXQJ/OGkyHfVb4m/95Iuj2SltF9UtOqYtTVn8DEb9WRyFuhz34NSJ8Z+D6mziRS
         wbU4e6poyEWwmr1Lgz/m1tUGYBkCcldVFDqbPG7Ss/Muoet2/Mt0VW91dDs2QM4FOgVT
         /5DZ/DqBe+zQ1947tEX9ulkZflyp1HapSDndBr6vylQurio7Q1FsLZ0sPzfGv/27OklZ
         cxmQbPmOBdv3w90+SYM2E4y0SE73l01iTEXaafWpAZsXD+dwe1ET/8ywxKz+x7eQLXkE
         QQgKef56NjpqJSF+l/jRvtMGAz7LRBdQe5ziJ3Ntp/qC3+3jzjG0tiGX+9t+w0MUEhTM
         RQDQ==
X-Gm-Message-State: AOAM530fPWwiDQa3c/miXQDHqRn8PXtkWdgdjyvDGTLSg/zE7rBU55A4
        Fz5S2ZYoE4+Q3n15uxAhlNgM7efpzPt1pdu3YyGal5lPkCGMQjApSuygveqsBF13sTHKSVimvLY
        NsOeIcuztov8G+zRZtIL1Dw==
X-Received: by 2002:a05:600c:1e03:b0:381:4134:35ca with SMTP id ay3-20020a05600c1e0300b00381413435camr14983719wmb.145.1646151730956;
        Tue, 01 Mar 2022 08:22:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYfHVRSOGMfPLPfHkM21n2ADlCruTETrhJPt1WIhsU9tWlvnq+Hh/dL+h6goFY71nLBUFD/w==
X-Received: by 2002:a05:600c:1e03:b0:381:4134:35ca with SMTP id ay3-20020a05600c1e0300b00381413435camr14983702wmb.145.1646151730682;
        Tue, 01 Mar 2022 08:22:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5e00:88ce:ad41:cb1b:323? (p200300cbc70e5e0088cead41cb1b0323.dip0.t-ipconnect.de. [2003:cb:c70e:5e00:88ce:ad41:cb1b:323])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0037bf934bca3sm3706698wmq.17.2022.03.01.08.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 08:22:10 -0800 (PST)
Message-ID: <bfae7d17-eb50-55b1-1275-5ba0f86a5273@redhat.com>
Date:   Tue, 1 Mar 2022 17:22:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: split vm_normal_pages for LRU and non-LRU handling
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220218192640.GV4160@nvidia.com>
 <20220228203401.7155-1-alex.sierra@amd.com>
 <2a042493-d04d-41b1-ea12-b326d2116861@redhat.com>
 <41469645-55be-1aaa-c1ef-84a123fdb4ea@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <41469645-55be-1aaa-c1ef-84a123fdb4ea@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


>>
>>>   		if (PageReserved(page))
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index c31d04b46a5e..17d049311b78 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1614,7 +1614,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>   		goto out;
>>>   
>>>   	/* FOLL_DUMP to ignore special (like zero) pages */
>>> -	follflags = FOLL_GET | FOLL_DUMP;
>>> +	follflags = FOLL_GET | FOLL_DUMP | FOLL_LRU;
>>>   	page = follow_page(vma, addr, follflags);
>> Why wouldn't we want to dump DEVICE_COHERENT pages? This looks wrong.
> 
> This function later calls isolate_lru_page, which is something you can't 
> do with a device page.
> 

Then, that code might require care instead. We most certainly don't want
to have random memory holes in a dump just because some anonymous memory
was migrated to DEVICE_COHERENT.

-- 
Thanks,

David / dhildenb

