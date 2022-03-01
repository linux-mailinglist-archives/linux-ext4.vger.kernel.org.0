Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36CC4C85DD
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 09:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiCAIDz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Mar 2022 03:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiCAIDy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Mar 2022 03:03:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 245A227148
        for <linux-ext4@vger.kernel.org>; Tue,  1 Mar 2022 00:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646121792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g5HcmxS711SnBUiFSO6QPeyhMTExbS2pi4xO3biwyng=;
        b=QwekiK8GmAri3TS3n7TewZAm7BlmHA084g8Cjf1KZYUwXTSnFUxx9BXEWl1Lx1HUGTyRBT
        /jPjbn8OQREaStKlta91gWCkpvXZew3m55viraLJyDVprI1azvpxY76JtPGCgOGkqXyQ3S
        +3parVm/buw0MnMY4roB4lvNZGKou7Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-cCw3IuzMNj6i105EyEqLgw-1; Tue, 01 Mar 2022 03:03:11 -0500
X-MC-Unique: cCw3IuzMNj6i105EyEqLgw-1
Received: by mail-wm1-f70.google.com with SMTP id p35-20020a05600c1da300b0038151176781so820740wms.7
        for <linux-ext4@vger.kernel.org>; Tue, 01 Mar 2022 00:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=g5HcmxS711SnBUiFSO6QPeyhMTExbS2pi4xO3biwyng=;
        b=B87ByPF7DaqJ2KyeEBJ/Zk30fWKiqTUbEmnZrnwW+1Ipuly7ViJ0VTIF0Po9VjFFju
         Wl68xegSm+QSeHDF1INWbQ1svcLIzY2H4+jTImLqdVMyc2JWiF+/jvtJrrQqGggMdR3e
         bVfwAv9yhWn+ckngVA6iRlpe+KEfAvR29C8cVyD0Fiib3caZUDSndjH2Gn8HArkEm7dN
         DdhM2Py3C2/hwa0sSzacuapws6X9eUYIWJOl88jwnqZOtNPOFosy4Bz61A1K9zviGZtC
         zmVnmXpx+eX6N9UfL4KkEA77F4nAiCSDf2LwBnRY9n9MMm0Yncca4Rrrl2GegA66oF+n
         6Dcg==
X-Gm-Message-State: AOAM532d65iTU1dK2jz2gju2vLeYKeiDmQNI9/EPR5+S039DsUZUuNPn
        vKSgeuuKCqXI7cc9HyEt16e7HpbfUAdNvxLTMxNmtiUsuZBsk8m8nHEDjfOfVjU4zrNYOhFfjjC
        yHyMFAmNpqbIXbgabQW1GVQ==
X-Received: by 2002:adf:f049:0:b0:1ee:7523:ed53 with SMTP id t9-20020adff049000000b001ee7523ed53mr17566907wro.586.1646121789943;
        Tue, 01 Mar 2022 00:03:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpcJ4TqolQDE6BE7vD6rbCwoSwmTCrugFFkBxu6/s97N/cr/HBlvpSmDNAY1B2ylV7rKaSQQ==
X-Received: by 2002:adf:f049:0:b0:1ee:7523:ed53 with SMTP id t9-20020adff049000000b001ee7523ed53mr17566887wro.586.1646121789674;
        Tue, 01 Mar 2022 00:03:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5e00:88ce:ad41:cb1b:323? (p200300cbc70e5e0088cead41cb1b0323.dip0.t-ipconnect.de. [2003:cb:c70e:5e00:88ce:ad41:cb1b:323])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c2c4c00b003816932de9csm1668126wmg.24.2022.03.01.00.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:03:09 -0800 (PST)
Message-ID: <2a042493-d04d-41b1-ea12-b326d2116861@redhat.com>
Date:   Tue, 1 Mar 2022 09:03:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: split vm_normal_pages for LRU and non-LRU handling
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220218192640.GV4160@nvidia.com>
 <20220228203401.7155-1-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220228203401.7155-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 28.02.22 21:34, Alex Sierra wrote:
> DEVICE_COHERENT pages introduce a subtle distinction in the way
> "normal" pages can be used by various callers throughout the kernel.
> They behave like normal pages for purposes of mapping in CPU page
> tables, and for COW. But they do not support LRU lists, NUMA
> migration or THP. Therefore we split vm_normal_page into two
> functions vm_normal_any_page and vm_normal_lru_page. The latter will
> only return pages that can be put on an LRU list and that support
> NUMA migration and THP.

Why not s/vm_normal_any_page/vm_normal_page/ and avoid code churn?

> 
> We also introduced a FOLL_LRU flag that adds the same behaviour to
> follow_page and related APIs, to allow callers to specify that they
> expect to put pages on an LRU list.

[...]
> -#define FOLL_WRITE	0x01	/* check pte is writable */
> -#define FOLL_TOUCH	0x02	/* mark page accessed */
> -#define FOLL_GET	0x04	/* do get_page on page */
> -#define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
> -#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
> -#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
> -				 * and return without waiting upon it */
> -#define FOLL_POPULATE	0x40	/* fault in pages (with FOLL_MLOCK) */
> -#define FOLL_NOFAULT	0x80	/* do not fault in pages */
> -#define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
> -#define FOLL_NUMA	0x200	/* force NUMA hinting page fault */
> -#define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
> -#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
> -#define FOLL_MLOCK	0x1000	/* lock present pages */
> -#define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
> -#define FOLL_COW	0x4000	/* internal GUP flag */
> -#define FOLL_ANON	0x8000	/* don't do file mappings */
> -#define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
> -#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
> -#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
> -#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
> +#define FOLL_WRITE	0x01	 /* check pte is writable */
> +#define FOLL_TOUCH	0x02	 /* mark page accessed */
> +#define FOLL_GET	0x04	 /* do get_page on page */
> +#define FOLL_DUMP	0x08	 /* give error on hole if it would be zero */
> +#define FOLL_FORCE	0x10	 /* get_user_pages read/write w/o permission */
> +#define FOLL_NOWAIT	0x20	 /* if a disk transfer is needed, start the IO
> +				  * and return without waiting upon it */
> +#define FOLL_POPULATE	0x40	 /* fault in pages (with FOLL_MLOCK) */
> +#define FOLL_NOFAULT	0x80	 /* do not fault in pages */
> +#define FOLL_HWPOISON	0x100	 /* check page is hwpoisoned */
> +#define FOLL_NUMA	0x200	 /* force NUMA hinting page fault */
> +#define FOLL_MIGRATION	0x400	 /* wait for page to replace migration entry */
> +#define FOLL_TRIED	0x800	 /* a retry, previous pass started an IO */
> +#define FOLL_MLOCK	0x1000	 /* lock present pages */
> +#define FOLL_REMOTE	0x2000	 /* we are working on non-current tsk/mm */
> +#define FOLL_COW	0x4000	 /* internal GUP flag */
> +#define FOLL_ANON	0x8000	 /* don't do file mappings */
> +#define FOLL_LONGTERM	0x10000	 /* mapping lifetime is indefinite: see below */
> +#define FOLL_SPLIT_PMD	0x20000	 /* split huge pmd before returning */
> +#define FOLL_PIN	0x40000	 /* pages must be released via unpin_user_page */
> +#define FOLL_FAST_ONLY	0x80000	 /* gup_fast: prevent fall-back to slow gup */
> +#define FOLL_LRU	0x100000 /* return only LRU (anon or page cache) */
>  

Can we minimize code churn, please?


>  		if (PageReserved(page))
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c31d04b46a5e..17d049311b78 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1614,7 +1614,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  		goto out;
>  
>  	/* FOLL_DUMP to ignore special (like zero) pages */
> -	follflags = FOLL_GET | FOLL_DUMP;
> +	follflags = FOLL_GET | FOLL_DUMP | FOLL_LRU;
>  	page = follow_page(vma, addr, follflags);

Why wouldn't we want to dump DEVICE_COHERENT pages? This looks wrong.


-- 
Thanks,

David / dhildenb

