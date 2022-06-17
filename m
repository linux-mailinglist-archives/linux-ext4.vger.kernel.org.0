Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F9854F224
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jun 2022 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiFQHoy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380340AbiFQHoy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 03:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 313B6674EF
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655451892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coda/CWfS7jjnpuHvtDQX0ASaEE3SWk0zKx/CPt1NF8=;
        b=cLouWCvzKAqdezRXggX+P8aCyG64WvmL864GD5PUV/OBrJIqcat5FMsabqQK2RBJ50tLbR
        lmTVnsM+wQ2Q/T9/M77hXFXHablJQNhUPz9nAwiZgg3NxQ2lR68uvJN9uX9mVbhGdvf0nm
        mPWFrz5r22JCMUwdQwB6nHHY3Op36Xg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-kvu57e4-MTO0919zeuYk9g-1; Fri, 17 Jun 2022 03:44:50 -0400
X-MC-Unique: kvu57e4-MTO0919zeuYk9g-1
Received: by mail-wr1-f70.google.com with SMTP id b10-20020adf9b0a000000b0021a0c74738aso748366wrc.7
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 00:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=coda/CWfS7jjnpuHvtDQX0ASaEE3SWk0zKx/CPt1NF8=;
        b=L3zeikXflCG3ADbUqjuzOVzFklMGyKEPBq81gXWYkIqpTcIxpoqMJ09KLfLUmclwiu
         g5xC/GBO0CcbKtyxGGU0MbbMb6chTuLqaaRFBitNIUaAIE6ZBJVrqyz5DSxhhH5DhNPY
         FLM3sxD8yWWiCdcSIiYH4RjaXGeoCbxAbQcisjp0/tmKXzT/djij4I8eR8tp5OtmcWrY
         HJLfVIzvzN8k0GQ2WX9aKe+AjigMow3okEoRmu7fKk/qvVUdhM2fQRcwL1FKF7mxFuKY
         CkQdd0IKwxu4I0evYO4H9jT2PvnBR7BWfEgWezr6gD5dnlDKm0TPqBBxJ8MEvnJNXjGc
         qDzg==
X-Gm-Message-State: AJIora8RJ9DVmc3HUv0q9CSgwrzAjdMJAZ4y9IGNNfTUID7OM3/Sdlz2
        aLENxc/eaxhfuJpnwQsoWnHLAET3GUjbdcUM+LSRQtYg5tA/2x4550YO9cpHMTqtZ3T/bBNeQmr
        BLue1YIIw4eWXMtzT4O0ITw==
X-Received: by 2002:a5d:5272:0:b0:210:33b8:ac4a with SMTP id l18-20020a5d5272000000b0021033b8ac4amr7953169wrc.483.1655451889277;
        Fri, 17 Jun 2022 00:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sotrEWyKnX0mzmXO2tbcDqW4so5zlYrKlmkTzzX5Yo7fZTIXTe3SZOKyKoq4h2kvU8N2TdcQ==
X-Received: by 2002:a5d:5272:0:b0:210:33b8:ac4a with SMTP id l18-20020a5d5272000000b0021033b8ac4amr7953151wrc.483.1655451889025;
        Fri, 17 Jun 2022 00:44:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:7e00:bb5b:b526:5b76:5824? (p200300cbc70a7e00bb5bb5265b765824.dip0.t-ipconnect.de. [2003:cb:c70a:7e00:bb5b:b526:5b76:5824])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d474b000000b002185631adf0sm3851245wrs.23.2022.06.17.00.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:44:48 -0700 (PDT)
Message-ID: <bd8b3eeb-4951-e3e9-8ee5-94f573ec815f@redhat.com>
Date:   Fri, 17 Jun 2022 09:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 00/13] Add MEMORY_DEVICE_COHERENT for coherent device
 memory mapping
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Sierra <alex.sierra@amd.com>
Cc:     jgg@nvidia.com, Felix.Kuehling@amd.com, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hch@lst.de, jglisse@redhat.com,
        apopple@nvidia.com, willy@infradead.org
References: <20220531200041.24904-1-alex.sierra@amd.com>
 <20220616191927.b4500e2f73500b9241009788@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220616191927.b4500e2f73500b9241009788@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 17.06.22 04:19, Andrew Morton wrote:
> On Tue, 31 May 2022 15:00:28 -0500 Alex Sierra <alex.sierra@amd.com> wrote:
> 
>> This is our MEMORY_DEVICE_COHERENT patch series rebased and updated
>> for current 5.18.0
> 
> I plan to move this series into the non-rebasing mm-stable branch in a
> few days.  Unless sternly told not to do so!
> 

I want to double-check some things regarding PageAnonExclusive
interaction. I'm busy, but I'll try prioritizing it.

-- 
Thanks,

David / dhildenb

