Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF825704E2
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jul 2022 16:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiGKOBD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jul 2022 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKOBC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Jul 2022 10:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABC2B24F38
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jul 2022 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657548060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=th2buvr24d07qJGzIS/AKju5zI095zK3996wlFgRrAE=;
        b=UzYqXImoTryqVmnH9ulqx1t2YJDWqFffzeUwirRhSErQzBBhMOZ0a7Xr+cMp568rMHyCR3
        vv2LTIuzjdLSUS3+RjgRbH4g40NCsAp3BpSV3jdZp2kaMiTUUH34cEAkABlJrUiO68dBa0
        8ADiQpYmeZzu2nZXRCDfdL8/jgjwY5E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-ze0yj_4cNwaNsL32PaeUIQ-1; Mon, 11 Jul 2022 10:00:57 -0400
X-MC-Unique: ze0yj_4cNwaNsL32PaeUIQ-1
Received: by mail-wr1-f69.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so668193wrg.14
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jul 2022 07:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=th2buvr24d07qJGzIS/AKju5zI095zK3996wlFgRrAE=;
        b=nlV5ngkyuI6n8XiNYep5+DDauzU1kILNE4A0JSFZYNG8/HOzU0232/FWrLBB+cA4uk
         3HhTITxORW97f+CZJeRnWGeO4y4kyKHDV/UfqrnemwTGUj3bRZblXIWfj/Sq0hryJD6m
         3cAUct3WrWVf+ZtBxwqFClTcq27E0m+Jsbka7IGnrBKhrL58Q58vmYWCSVizrgpFg6cE
         YzHZdZ7UVvAyd07f29Guw9v3e2NAmnJwnq4pmmditd+7uPYWpYVUWBhwEmpAWZ69FHfG
         oP8Ai7z3WENwpH9U87G2NL7Cxsptg4HLky2rhHB1gt8WeIkm2uaQkN+1MwaMa5hJ/paO
         7pkQ==
X-Gm-Message-State: AJIora8DqSg9oE39oc1KkpZepR5fEBdEX9PRYSXTdPhNjLBEMXglZ4JI
        w5R7O1fUA8nZYFjogDIct6AgU0hSE1rM9va8E0wPJlltjMLmWNLwxgxbcD+1IxDHmiYyXUl4pQH
        FY1ERjU2b+FZQMP8ibvANXw==
X-Received: by 2002:a5d:6dab:0:b0:21d:9fc8:3029 with SMTP id u11-20020a5d6dab000000b0021d9fc83029mr8016755wrs.172.1657548056006;
        Mon, 11 Jul 2022 07:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tHUpdQt0jOB6/Le/88y5FMlWl7A0VwJVjWJ8qwyFnogYLhO4qiJJpxW2UhqlLHOVvPkjmbsQ==
X-Received: by 2002:a5d:6dab:0:b0:21d:9fc8:3029 with SMTP id u11-20020a5d6dab000000b0021d9fc83029mr8016733wrs.172.1657548055721;
        Mon, 11 Jul 2022 07:00:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1400:c3:4ae0:6d5c:1ab2? (p200300cbc702140000c34ae06d5c1ab2.dip0.t-ipconnect.de. [2003:cb:c702:1400:c3:4ae0:6d5c:1ab2])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b003a2cf17a894sm11063409wmq.41.2022.07.11.07.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:00:55 -0700 (PDT)
Message-ID: <4b2f9a61-ca67-6a34-41c9-c191cac756b3@redhat.com>
Date:   Mon, 11 Jul 2022 16:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 07/15] mm/gup: migrate device coherent pages when
 pinning instead of failing
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        akpm@linux-foundation.org
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-8-alex.sierra@amd.com>
 <2c4dd559-4fa9-f874-934f-d6b674543d0f@redhat.com>
 <Ysws7LOirtQ07JG/@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ysws7LOirtQ07JG/@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11.07.22 16:00, Matthew Wilcox wrote:
> On Mon, Jul 11, 2022 at 03:35:42PM +0200, David Hildenbrand wrote:
>>> +		/*
>>> +		 * Device coherent pages are managed by a driver and should not
>>> +		 * be pinned indefinitely as it prevents the driver moving the
>>> +		 * page. So when trying to pin with FOLL_LONGTERM instead try
>>> +		 * to migrate the page out of device memory.
>>> +		 */
>>> +		if (folio_is_device_coherent(folio)) {
>>> +			WARN_ON_ONCE(PageCompound(&folio->page));
>>
>> Maybe that belongs into migrate_device_page()?
> 
> ... and should be simply WARN_ON_ONCE(folio_test_large(folio)).
> No need to go converting it back into a page in order to test things
> that can't possibly be true.
> 

Good point.

-- 
Thanks,

David / dhildenb

