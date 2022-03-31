Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BCD4ED64D
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Mar 2022 10:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiCaI5J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Mar 2022 04:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiCaI5H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Mar 2022 04:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E721101F1C
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648716918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZeceZ4MowtZcfgVk5LvYuyjG8NKEFJQ6vum/zhYc1I=;
        b=ApwXBKu75dvtElJOA1N1lRPWo6oHNElUX+bKgH1OLfO4gxNL/4cpKkkUm5ZM+YQkqjTCcR
        q+a0//mpAEYuKQgzpHdjI0gbfMTp0vZ290SjicwqK3UyF2bnGwkA/O6cB8n/xejzW8Hyyp
        nL/vy3MDNRqqRZ5KrY7BUR25Naq3KEc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-oQrZmmoQMLWRTnsdG8_plA-1; Thu, 31 Mar 2022 04:55:16 -0400
X-MC-Unique: oQrZmmoQMLWRTnsdG8_plA-1
Received: by mail-wm1-f70.google.com with SMTP id 2-20020a1c0202000000b0038c71e8c49cso1142232wmc.1
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 01:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0ZeceZ4MowtZcfgVk5LvYuyjG8NKEFJQ6vum/zhYc1I=;
        b=h4wxggfIgR9/pqI8q/QTCpCx5TfxvJRhQXo5PC0pdf1K79MKZh7zOezzKqrbb2QKJa
         H4Cjj0Az2is6fOKnd4XxlJ9TW+8ccLTEl1kEuy5lMD012/vT64T37M9AhnyxZ6FQ/VuO
         rPwSb48jNcOwaGmVYmzhywGRPuMrtOzLx969TmEF/UICZWPNrqSu1e32NXG+sLg3Uj0r
         P16hgvZBjJ5ktE4ucDUXLH+rWEnyv2MGL/x5GTpCzQwDCGh2+OqleKPtPkZIDZ45MDHZ
         Gw0a9hfyCNEEEqkjpWm7kq0hw/9hNAUtyXbfF19d+VuwvmST+nM5aoKalBXRMFM9kHz2
         6jhg==
X-Gm-Message-State: AOAM533aG3LIkO9Ooq1ZuCXsAFzA1HhDtJq1/DYbm4YoTcuAi8dzyr2k
        Y9V9oWlEHnMdZ3wiN/YtfOOF8gYBq1q5o+awwx2brWEDkVX/sEXNRCJj3wiF+qyoKMreWF9JZHa
        b/Exw3NzrAmXovSylNf9tdg==
X-Received: by 2002:a5d:6dac:0:b0:205:ccac:c676 with SMTP id u12-20020a5d6dac000000b00205ccacc676mr3304070wrs.156.1648716915695;
        Thu, 31 Mar 2022 01:55:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDW0zeqDZxqpReSRP+T3IGc5ZHXjnkjH5M+CBXHuSyrckPORChwL0jc6rBUWSqN1K/5sw+sA==
X-Received: by 2002:a5d:6dac:0:b0:205:ccac:c676 with SMTP id u12-20020a5d6dac000000b00205ccacc676mr3304051wrs.156.1648716915512;
        Thu, 31 Mar 2022 01:55:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:ac00:381c:2e8b:3b48:488e? (p200300cbc707ac00381c2e8b3b48488e.dip0.t-ipconnect.de. [2003:cb:c707:ac00:381c:2e8b:3b48:488e])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm9231563wms.26.2022.03.31.01.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 01:55:14 -0700 (PDT)
Message-ID: <709b459a-3c71-49b1-7ac1-3144ae0fa89a@redhat.com>
Date:   Thu, 31 Mar 2022 10:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/3] mm: add vm_normal_lru_pages for LRU handled pages
 only
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Alex Sierra <alex.sierra@amd.com>
Cc:     jgg@nvidia.com, Felix.Kuehling@amd.com, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, jglisse@redhat.com,
        apopple@nvidia.com, willy@infradead.org, akpm@linux-foundation.org
References: <20220330212537.12186-1-alex.sierra@amd.com>
 <20220330212537.12186-2-alex.sierra@amd.com> <20220331085341.GA22102@lst.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220331085341.GA22102@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 31.03.22 10:53, Christoph Hellwig wrote:
>> -	page = vm_normal_page(vma, addr, pte);
>> +	page = vm_normal_lru_page(vma, addr, pte);
> 
> Why can't this deal with ZONE_DEVICE pages?  It certainly has
> nothing do with a LRU I think.  In fact being able to have
> stats that count say the number of device pages here would
> probably be useful at some point.
> 
> In general I find the vm_normal_lru_page vs vm_normal_page
> API highly confusing.  An explicit check for zone device pages
> in the dozen or so spots that care has a much better documentation
> value, especially if accompanied by comments where it isn't entirely
> obvious.

What's your thought on FOLL_LRU?

-- 
Thanks,

David / dhildenb

