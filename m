Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809134B6B9D
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Feb 2022 13:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiBOMDc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Feb 2022 07:03:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiBOMDb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Feb 2022 07:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F0E0D1091
        for <linux-ext4@vger.kernel.org>; Tue, 15 Feb 2022 04:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644926600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJ2zSixnYCAtbdhrKQS4IEmcF85JqpZRJkneSkqAfms=;
        b=YpH0T7+vp66qFgwTCuxazvN4c5ATYeplbLqEoKUSu6gv0lva2O2UlbsDLahEyqsokAwZ0D
        RwQtGSTXr+FVHJm3CpmzOL9mWfRQw9Rnst7UvfYolET4lBYG/jepp1PrFs5xjo2657cj9x
        fkwPPiKZCOsBDki/O+Pf7wYOKj+enzQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-P9ccl9BNOVGZrx3NwjMSug-1; Tue, 15 Feb 2022 07:03:19 -0500
X-MC-Unique: P9ccl9BNOVGZrx3NwjMSug-1
Received: by mail-wr1-f71.google.com with SMTP id j8-20020adfc688000000b001e3322ced69so8269095wrg.13
        for <linux-ext4@vger.kernel.org>; Tue, 15 Feb 2022 04:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=eJ2zSixnYCAtbdhrKQS4IEmcF85JqpZRJkneSkqAfms=;
        b=PJVbMa2X8qp8Ba9j5BIhaHoPJYDQ2hppAG/HdCKyyefuYHg6JpwOYbE4Y/PUHAwZRl
         cng2NQahtddu7V9dhs9IdeZV9gnIIXfSsrPUcqzoGOim2bKFxt3PNqZ9Qq+oz5Vn/wOH
         DAfFskXdY0ujSk9nCEvsVzyImzB1LBm6uvQipuAWAK+AKryDnHWZKPzEqR0n6pI3nL64
         TjUMdjRQzoDy4juSlmBlIRrQYUBPYfYdzN/gyk9aWo0iEDbLObYv+jcqNtSxbHeuIKJJ
         WUtPH9THpb/0A73TTdlLZHdk/8xy1JCdSTO8DaGtmrGguQFJ60Z2sxCyF4K11OOHcy3U
         tn+g==
X-Gm-Message-State: AOAM533kSiO6V0JmVaso1lMOEgdvAg0vptin/goWkZZ4ox8gi80pYibf
        75Jf+mWXIIEbrHKvtfHx6g5qsYi/MYqHDa89AOO5BzByyDb9eP0J/0XOMxixjfcI0nDHxSTVkC5
        Je9wjWZPOxN1tIVhF2Efsnw==
X-Received: by 2002:a7b:cf29:0:b0:34c:744b:9145 with SMTP id m9-20020a7bcf29000000b0034c744b9145mr2860007wmg.2.1644926598084;
        Tue, 15 Feb 2022 04:03:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVn6arGJnSNGfD+b4A3E/kx0IOIn+MKt17+0+8YvZsz8aYYMdhfF9xxDoZPpXOOhK1bges5w==
X-Received: by 2002:a7b:cf29:0:b0:34c:744b:9145 with SMTP id m9-20020a7bcf29000000b0034c744b9145mr2859969wmg.2.1644926597804;
        Tue, 15 Feb 2022 04:03:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:3700:9260:2fb2:742d:da3e? (p200300cbc70e370092602fb2742dda3e.dip0.t-ipconnect.de. [2003:cb:c70e:3700:9260:2fb2:742d:da3e])
        by smtp.gmail.com with ESMTPSA id c8sm18784645wmq.39.2022.02.15.04.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:03:17 -0800 (PST)
Message-ID: <50e2ee65-98a5-fd2f-3b58-b5be5c13c18b@redhat.com>
Date:   Tue, 15 Feb 2022 13:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     Felix.Kuehling@amd.com, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com,
        willy@infradead.org, alex.sierra@amd.com, jhubbard@nvidia.com
References: <cover.0d3c846b1c6c294e055ff7ebe221fab9964c1436.1644207242.git-series.apopple@nvidia.com>
 <1894939.704c7Wv018@nvdebian>
 <fb557284-bcab-6d95-ac60-acd7459e9e80@redhat.com>
 <5251686.PpEh1BJ82l@nvdebian>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] mm/gup.c: Migrate device coherent pages when
 pinning instead of failing
In-Reply-To: <5251686.PpEh1BJ82l@nvdebian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11.02.22 00:41, Alistair Popple wrote:
> On Thursday, 10 February 2022 10:47:35 PM AEDT David Hildenbrand wrote:
>> On 10.02.22 12:39, Alistair Popple wrote:
>>> On Thursday, 10 February 2022 9:53:38 PM AEDT David Hildenbrand wrote:
>>>> On 07.02.22 05:26, Alistair Popple wrote:
>>>>> Currently any attempts to pin a device coherent page will fail. This is
>>>>> because device coherent pages need to be managed by a device driver, and
>>>>> pinning them would prevent a driver from migrating them off the device.
>>>>>
>>>>> However this is no reason to fail pinning of these pages. These are
>>>>> coherent and accessible from the CPU so can be migrated just like
>>>>> pinning ZONE_MOVABLE pages. So instead of failing all attempts to pin
>>>>> them first try migrating them out of ZONE_DEVICE.
>>>>>
>>>>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>>>>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>> ---
>>>>>
>>>>> Changes for v2:
>>>>>
>>>>>  - Added Felix's Acked-by
>>>>>  - Fixed missing check for dpage == NULL
>>>>>
>>>>>  mm/gup.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>>>>>  1 file changed, 95 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>> index 56d9577..5e826db 100644
>>>>> --- a/mm/gup.c
>>>>> +++ b/mm/gup.c
>>>>> @@ -1861,6 +1861,60 @@ struct page *get_dump_page(unsigned long addr)
>>>>>  
>>>>>  #ifdef CONFIG_MIGRATION
>>>>>  /*
>>>>> + * Migrates a device coherent page back to normal memory. Caller should have a
>>>>> + * reference on page which will be copied to the new page if migration is
>>>>> + * successful or dropped on failure.
>>>>> + */
>>>>> +static struct page *migrate_device_page(struct page *page,
>>>>> +					unsigned int gup_flags)
>>>>> +{
>>>>> +	struct page *dpage;
>>>>> +	struct migrate_vma args;
>>>>> +	unsigned long src_pfn, dst_pfn = 0;
>>>>> +
>>>>> +	lock_page(page);
>>>>> +	src_pfn = migrate_pfn(page_to_pfn(page)) | MIGRATE_PFN_MIGRATE;
>>>>> +	args.src = &src_pfn;
>>>>> +	args.dst = &dst_pfn;
>>>>> +	args.cpages = 1;
>>>>> +	args.npages = 1;
>>>>> +	args.vma = NULL;
>>>>> +	migrate_vma_setup(&args);
>>>>> +	if (!(src_pfn & MIGRATE_PFN_MIGRATE))
>>>>> +		return NULL;
>>>>> +
>>>>> +	dpage = alloc_pages(GFP_USER | __GFP_NOWARN, 0);
>>>>> +
>>>>> +	/*
>>>>> +	 * get/pin the new page now so we don't have to retry gup after
>>>>> +	 * migrating. We already have a reference so this should never fail.
>>>>> +	 */
>>>>> +	if (dpage && WARN_ON_ONCE(!try_grab_page(dpage, gup_flags))) {
>>>>> +		__free_pages(dpage, 0);
>>>>> +		dpage = NULL;
>>>>> +	}
>>>>> +
>>>>> +	if (dpage) {
>>>>> +		lock_page(dpage);
>>>>> +		dst_pfn = migrate_pfn(page_to_pfn(dpage));
>>>>> +	}
>>>>> +
>>>>> +	migrate_vma_pages(&args);
>>>>> +	if (src_pfn & MIGRATE_PFN_MIGRATE)
>>>>> +		copy_highpage(dpage, page);
>>>>> +	migrate_vma_finalize(&args);
>>>>> +	if (dpage && !(src_pfn & MIGRATE_PFN_MIGRATE)) {
>>>>> +		if (gup_flags & FOLL_PIN)
>>>>> +			unpin_user_page(dpage);
>>>>> +		else
>>>>> +			put_page(dpage);
>>>>> +		dpage = NULL;
>>>>> +	}
>>>>> +
>>>>> +	return dpage;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>>   * Check whether all pages are pinnable, if so return number of pages.  If some
>>>>>   * pages are not pinnable, migrate them, and unpin all pages. Return zero if
>>>>>   * pages were migrated, or if some pages were not successfully isolated.
>>>>> @@ -1888,15 +1942,40 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>>>>  			continue;
>>>>>  		prev_head = head;
>>>>>  		/*
>>>>> -		 * If we get a movable page, since we are going to be pinning
>>>>> -		 * these entries, try to move them out if possible.
>>>>> +		 * Device coherent pages are managed by a driver and should not
>>>>> +		 * be pinned indefinitely as it prevents the driver moving the
>>>>> +		 * page. So when trying to pin with FOLL_LONGTERM instead try
>>>>> +		 * migrating page out of device memory.
>>>>>  		 */
>>>>>  		if (is_dev_private_or_coherent_page(head)) {
>>>>> +			/*
>>>>> +			 * device private pages will get faulted in during gup
>>>>> +			 * so it shouldn't be possible to see one here.
>>>>> +			 */
>>>>>  			WARN_ON_ONCE(is_device_private_page(head));
>>>>> -			ret = -EFAULT;
>>>>> -			goto unpin_pages;
>>>>> +			WARN_ON_ONCE(PageCompound(head));
>>>>> +
>>>>> +			/*
>>>>> +			 * migration will fail if the page is pinned, so convert
>>>>> +			 * the pin on the source page to a normal reference.
>>>>> +			 */
>>>>> +			if (gup_flags & FOLL_PIN) {
>>>>> +				get_page(head);
>>>>> +				unpin_user_page(head);
>>>>> +			}
>>>>> +
>>>>> +			pages[i] = migrate_device_page(head, gup_flags);
>>>>
>>>> For ordinary migrate_pages(), we'll unpin all pages and return 0 so the
>>>> caller will retry pinning by walking the page tables again.
>>>>
>>>> Why can't we apply the same mechanism here? This "let's avoid another
>>>> walk" looks unnecessary complicated to me, but I might be wrong.
>>>
>>> There's no reason we couldn't. I figured we have the page in the right spot
>>> anyway so it was easy to do, and looking at this rebased on top of Christoph's
>>> ZONE_DEVICE refcount simplification I'm not sure it would be any simpler
>>> anyway.
>>>
>>> It would remove the call to try_grab_page(), but we'd still have to return an
>>> error on migration failures whilst also ensuring we putback any non-device
>>> pages that may have been isolated. I might have overlooked something though,
>>> so certainly happy for suggestions.
>>
>> Staring at the code, I was wondering if we could either
>>
>> * build a second list of device coherent pages to migrate and call a
>>   migrate_device_pages() bulk function
>> * simply use movable_page_list() and teach migrate_pages() how to handle
>>   them.
> 

(sorry for the late reply)

> I did consider that approach. The problem is zone device pages are not LRU
> pages. In particular page->lru is not available to add the page to a list, and
> as an external API and internally migrate_pages() relies heavily on moving
> pages between lists.

I see, so I assume there is no way we could add them to a list? We could
use a temporary array we'd try allocating once we stumble over over such
a device page that needs migration.

The you'd teach is_pinnable_page() to reject
is_dev_private_or_coherent_page() and special case
is_dev_private_or_coherent_page() under the "if
(!is_pinnable_page(head))" check.

You'd grab an additional reference and add them to the temp array. The
you'd just proceed as normal towards the end of the function (reverting
the pin/ref from the input array) and would try to migrate all device
pages in the temp array just before migrate_pages() --
migrate_device_pages(), properly handling/indicating if either migration
path fails.

Instead of putback_movable_pages() on the list you'd had
unref_device_pages() and supply the array.


Just a thought to limit the impact and eventually make it a bit nicer to
read, avoiding modifications of the input array.

> 
>> I'd really appreciate as little special casing as possible for the ever
>> growing list of new DEVICE types all over the place. E.g., just staring
>> at fork even before the new device coherent made my head spin.
> 
> That's fair. We could pull the checks for device pages out into a self
> contained function (eg. check_and_migrate_device_pages()) called before
> check_and_migrate_movable_pages(). The down side of that is we'd always have an
> extra loop over all the pages just to scan for device pages, but perhaps that's
> not a concern?

I mean, they are movable ... just not "ordinarily" movable, so it smells
like this logic belongs into check_and_migrate_movable_pages() :)


-- 
Thanks,

David / dhildenb

