Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D74B29EC
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Feb 2022 17:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346901AbiBKQPc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Feb 2022 11:15:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbiBKQPc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Feb 2022 11:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2CE0B70
        for <linux-ext4@vger.kernel.org>; Fri, 11 Feb 2022 08:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644596130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCRcaleTGgKZtCPcAf/F4rdGaJxNLIOVjEVDZ1rkuA8=;
        b=ZMOaPJX0suHtoX5wZ/XZylqdA1qglUQW62fMDpIidgOdUFTs14G1bspDCy5HLrc7k10/oi
        kKY4OFyJ6oR5tIh29a/VDEN6ZMvT+WOwnkLvlf+Ai+/yR67c/55rWBxNEniiDlY1twrmjM
        rnDNxxHY6hvvBUxyDm4UDFgD7NeuOEI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-duQZjpZ0Nsmw_Gh0JrJ7Hw-1; Fri, 11 Feb 2022 11:15:28 -0500
X-MC-Unique: duQZjpZ0Nsmw_Gh0JrJ7Hw-1
Received: by mail-wm1-f71.google.com with SMTP id r8-20020a7bc088000000b0037bbf779d26so2702260wmh.7
        for <linux-ext4@vger.kernel.org>; Fri, 11 Feb 2022 08:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=bCRcaleTGgKZtCPcAf/F4rdGaJxNLIOVjEVDZ1rkuA8=;
        b=imtT/SwBgsUQA62k0cumh0a3lrMXQ/QiQvBHsXhKNcI0Ld3cd0IGjuyfbHb8vGPN4V
         0ULJ9hYOkVnltjAfuZpg4YnyoVQdN1tSw0ga4YZvKxkbtI9eKDh/tYxB/yD7iIikGAxt
         J+PzpLhJ9ey4pG3hPhbSst5f8aqzJXR9bL3zFnqQ0J2qB2Q92WVVmdw2YPUumjeFY042
         Mly3ib2XVKK7yN/sH138XbSkgsASP36czlsZkOb2aw+ayOB8yQnb+wVmCIZ7R7q9Ggh5
         YZpd7FlSQoD4w0SD7dSTZsS8FvXJ0K9Jr+9tMa4VNX8M682o9Lqs5yJZO73ajUuGye9p
         tfKw==
X-Gm-Message-State: AOAM530DUKO/H2nzVCqS8zU61D/qpOJXJW0KstOr017aT+2cxu5sGDFc
        94ja79vniQn1osdm6924bkDgxCW40QryZGPDqJajtsHfgtg/EcjNQOqggwt6YYQLIq/uCeNqokN
        7eJiEifZI9fuW6Txvwcd4xQ==
X-Received: by 2002:adf:f904:: with SMTP id b4mr1897408wrr.183.1644596127726;
        Fri, 11 Feb 2022 08:15:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxWjE7RoWsgISgQBtP4hRDQ/YRVeK6b5oKT74teyBVgT9eGeQ23Quvk5zgwZNMOVVwPpSm9A==
X-Received: by 2002:adf:f904:: with SMTP id b4mr1897388wrr.183.1644596127444;
        Fri, 11 Feb 2022 08:15:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:aa00:4cc6:d24a:90ae:8c1f? (p200300cbc70caa004cc6d24a90ae8c1f.dip0.t-ipconnect.de. [2003:cb:c70c:aa00:4cc6:d24a:90ae:8c1f])
        by smtp.gmail.com with ESMTPSA id l21sm4770865wms.0.2022.02.11.08.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 08:15:26 -0800 (PST)
Message-ID: <beb38138-2266-1ff8-cc82-8fe914bed862@redhat.com>
Date:   Fri, 11 Feb 2022 17:15:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
References: <20220201154901.7921-1-alex.sierra@amd.com>
 <20220201154901.7921-2-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 01/10] mm: add zone device coherent type memory support
In-Reply-To: <20220201154901.7921-2-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 01.02.22 16:48, Alex Sierra wrote:
> Device memory that is cache coherent from device and CPU point of view.
> This is used on platforms that have an advanced system bus (like CAPI
> or CXL). Any page of a process can be migrated to such memory. However,
> no one should be allowed to pin such memory so that it can always be
> evicted.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

So, I'm currently messing with PageAnon() pages and CoW semantics ...
all these PageAnon() ZONE_DEVICE variants don't necessarily make my life
easier but I'm not sure yet if they make my life harder. I hope you can
help me understand some of that stuff.

1) What are expected CoW semantics for DEVICE_COHERENT?

I assume we'll share them just like other PageAnon() pages during fork()
readable, and the first sharer writing to them receives an "ordinary"
!ZONE_DEVICE copy.

So this would be just like DEVICE_EXCLUSIVE CoW handling I assume, just
that we don't have to go through the loop of restoring a device
exclusive entry?

2) How are these pages freed to clear/invalidate PageAnon() ?

I assume for PageAnon() ZONE_DEVICE pages we'll always for via
free_devmap_managed_page(), correct?


3) FOLL_PIN

While you write "no one should be allowed to pin such memory", patch #2
only blocks FOLL_LONGTERM. So I assume we allow ordinary FOLL_PIN and
you might want to be a bit more precise?


... I'm pretty sure we cannot FOLL_PIN DEVICE_PRIVATE pages, but can we
FILL_PIN DEVICE_EXCLUSIVE pages? I strongly assume so?


Thanks for any information.

-- 
Thanks,

David / dhildenb

