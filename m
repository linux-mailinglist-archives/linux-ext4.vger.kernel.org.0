Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779664B8310
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Feb 2022 09:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiBPIbm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Feb 2022 03:31:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiBPIbl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Feb 2022 03:31:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EC952A520F
        for <linux-ext4@vger.kernel.org>; Wed, 16 Feb 2022 00:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645000267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMr7qMjbySmB3FKzyMaIvMtNvTUPHIVGxBY8lAVP/YQ=;
        b=Css8yhuH6bPauD/GhKsMyoxVUh41GM4/Y8tVvtOFz+I+u0YYoP60x5eo1u5ww4ivRD215p
        qEHbB0OX7bf8OG5AiF8k2HzPITogxfAoyXFSGw+WRXy+RdSuB8PUkg+d9BVtdrHYhTgHdC
        4PycnhRUGkvGnpPgnp5kFJqd/v6QjOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-JJzjbWSCPKKVFWrqUgCtuw-1; Wed, 16 Feb 2022 03:31:06 -0500
X-MC-Unique: JJzjbWSCPKKVFWrqUgCtuw-1
Received: by mail-wr1-f72.google.com with SMTP id t14-20020adfa2ce000000b001e1ad2deb3dso774286wra.0
        for <linux-ext4@vger.kernel.org>; Wed, 16 Feb 2022 00:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=dMr7qMjbySmB3FKzyMaIvMtNvTUPHIVGxBY8lAVP/YQ=;
        b=T6k8sdMNUYECXgCGPO2gLOmalFxDd2WK3g3JPEDgIMStMUPkDWb146r6U4ue6atkEv
         2wHv/X22r36cC77rT89OhBV9uV5wowgoW8doktDWBDWx9P81S+MinH65wXkxj/phzVHf
         VRrNEobJgTGmbybP+bpHVv5AohfKlFhcIusqBo90so++Bn3Lm5qo9i/pFPw+i56evteF
         t/lcTC7e1XWluydjX7ZGog/8HBeXGGobAwd1HKhp/AJmsoRzDCmJd5/9RMYH5bdI6Nwg
         a72NqyfjHWVXfkP8Q+yBO4Zp1yRfq1QrAJXfL0e2VbNMxD1Bhmx0J4Dy06I7vcUnQirm
         /5nQ==
X-Gm-Message-State: AOAM531jRcvk2jc4R4nWSL+6QZZzMt/9cZeVyvZ4UEW8RPdTlKy0ULuZ
        FxWqf6p3tGSQjhS3oazt5HkHNv/wPO3L17SHlDVbS7NSsTHSjriWaWkhgoaWXytfoe0g+iPlvDR
        rB9SaDa33BfsqBAL2c4pFrw==
X-Received: by 2002:a5d:6a03:0:b0:1e4:4055:7e35 with SMTP id m3-20020a5d6a03000000b001e440557e35mr1391869wru.495.1645000264839;
        Wed, 16 Feb 2022 00:31:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzw1zMgqtvBG1B1Fs/z6twGtOuFvl241Tm8Z6QUAB1L998Nv+s1BS79V+EKfFEFJWSxdpuYnw==
X-Received: by 2002:a5d:6a03:0:b0:1e4:4055:7e35 with SMTP id m3-20020a5d6a03000000b001e440557e35mr1391848wru.495.1645000264537;
        Wed, 16 Feb 2022 00:31:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:600:4ff7:25c:5aad:2711? (p200300cbc70b06004ff7025c5aad2711.dip0.t-ipconnect.de. [2003:cb:c70b:600:4ff7:25c:5aad:2711])
        by smtp.gmail.com with ESMTPSA id y17sm17260030wma.5.2022.02.16.00.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 00:31:04 -0800 (PST)
Message-ID: <98d8bbc5-ffc2-8966-fdc1-a844874e7ae8@redhat.com>
Date:   Wed, 16 Feb 2022 09:31:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jglisse@redhat.com, willy@infradead.org
References: <beb38138-2266-1ff8-cc82-8fe914bed862@redhat.com>
 <877d9vd10u.fsf@nvdebian.thelocal> <20220216020357.GD4160@nvidia.com>
 <6156515.kVgMqSaHHm@nvdebian>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 01/10] mm: add zone device coherent type memory support
In-Reply-To: <6156515.kVgMqSaHHm@nvdebian>
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

On 16.02.22 03:36, Alistair Popple wrote:
> On Wednesday, 16 February 2022 1:03:57 PM AEDT Jason Gunthorpe wrote:
>> On Wed, Feb 16, 2022 at 12:23:44PM +1100, Alistair Popple wrote:
>>
>>> Device private and device coherent pages are not marked with pte_devmap and they
>>> are backed by a struct page. The only way of inserting them is via migrate_vma.
>>> The refcount is decremented in zap_pte_range() on munmap() with special handling
>>> for device private pages. Looking at it again though I wonder if there is any
>>> special treatment required in zap_pte_range() for device coherent pages given
>>> they count as present pages.
>>
>> This is what I guessed, but we shouldn't be able to just drop
>> pte_devmap on these pages without any other work?? Granted it does
>> very little already..
> 
> Yes, I agree we need to check this more closely. For device private pages
> not having pte_devmap is fine, because they are non-present swap entries so
> they always get special handling in the swap entry paths but the same isn't
> true for coherent device pages.

I'm curious, how does the refcount of a PageAnon() DEVICE_COHERENT page
look like when mapped? I'd assume it's also (currently) still offset by
one, meaning, if it's mapped into a single page table it's always at
least 2.

Just a note that if my assumption is correct and if we'd have such a
page mapped R/O, do_wp_page() would always have to copy it
unconditionally and would not be able to reuse it on write faults.
(while I'm working on improving the reuse logic, I think there is also
work in progress to avoid this additional reference on some ZONE_DEVICE
stuff -- I'd assume that would include DEVICE_COHERENT ?)

> 
>> I thought at least gup_fast needed to be touched or did this get
>> handled by scanning the page list after the fact?
> 
> Right, for gup I think the only special handling required is to prevent
> pinning. I had assumed that check_and_migrate_movable_pages() would still get
> called for gup_fast but unless I've missed something I don't think it does.
> That means gup_fast could still pin movable and coherent pages. Technically
> that is ok for coherent pages, but it's undesirable.

We really should have the same pinning rules for GUP vs. GUP-fast.
is_pinnable_page() should be the right place for such checks (similarly
as indicated in my reply to the migration series).

-- 
Thanks,

David / dhildenb

