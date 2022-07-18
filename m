Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5B5789C2
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Jul 2022 20:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbiGRSqo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Jul 2022 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiGRSqn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Jul 2022 14:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E50A2ED75
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658170001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvtwFmzJQydskGdmMkAzcYmgFVg8zBkka0UIgO8GwDg=;
        b=hDpW7Y03pkrONEiOOpxCgjfSHoVyTCZIMjQyMCpkoNxv36Et9PLx9jzHvSL5OzRSzKitoj
        +4Hl9fr2LQDcIOOLEbUNwk9qwKjMAkpRza0endebgCSWu/b9jzfhs9uxKjp5ZI7YCGkQOB
        rqFqabmk+2L0V8l1Ukefk1JLQ7E7354=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-w0NUAcTrO7W83hVwl_toZQ-1; Mon, 18 Jul 2022 14:46:40 -0400
X-MC-Unique: w0NUAcTrO7W83hVwl_toZQ-1
Received: by mail-wm1-f69.google.com with SMTP id ay19-20020a05600c1e1300b003a315c2c1c0so3661926wmb.7
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 11:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=gvtwFmzJQydskGdmMkAzcYmgFVg8zBkka0UIgO8GwDg=;
        b=V92q63FkVMhn0wwLpc7EEQUspoH9QwzeMFQglEN9m3cna2yFyE1SzY5oXrjLbm0ByI
         3g3764xbfLd4NO1FwQWXLx8A1vED9/2TCX/lLjUiLy2+xnBmRMzTb/lOV5CV1OJ0z+ib
         g9TD0PJv66sKIFzraOs21K/8ZEmz+2PXcqsljchQTZa3lrtTTUpl6SX6liWH8Ltcd+Tm
         QMWZkez42VbhR9jRaRLI4g/JKubXbEpwraXvQDYY+1Kmhxr8pd7KE0L91nqPzKq9rUCt
         BY+0JQ/MfNFe9r49t7Ltz8blF2yd+XqYjPD07sH6+cb0j8SM/HNqsw0NSG/bdXVcKVqs
         pOBA==
X-Gm-Message-State: AJIora9zN+XF48FImquYi6PlFHQRG087WxfTPK1FDqvh3CNn9qOqaGY0
        2sXmnQQURcmCEyZzTAEusvF5wOvA4cSoIUQu1v/S0U6lOMtsyPDA+ovgp4sJlIktf5vTtiX4tkj
        FMIMsY4sVJSI3FU+HhdO2eA==
X-Received: by 2002:adf:e949:0:b0:21d:89d4:91b3 with SMTP id m9-20020adfe949000000b0021d89d491b3mr23742722wrn.162.1658169999185;
        Mon, 18 Jul 2022 11:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOmE4vOGnFiuTP5c2pPtTPJoK81mepVV/JGhoKaECLpmofr++mZLUmicLoz+0bKYGOcrodww==
X-Received: by 2002:adf:e949:0:b0:21d:89d4:91b3 with SMTP id m9-20020adfe949000000b0021d89d491b3mr23742711wrn.162.1658169998936;
        Mon, 18 Jul 2022 11:46:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018? (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de. [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bce0f000000b003a31169a7f4sm10007971wmc.12.2022.07.18.11.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 11:46:38 -0700 (PDT)
Message-ID: <0483651e-d3ae-d5b4-722b-26dc088da2be@redhat.com>
Date:   Mon, 18 Jul 2022 20:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 02/14] mm: move page zone helpers from mm.h to mmzone.h
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-3-alex.sierra@amd.com>
 <12b40848-2e38-df0b-8300-0d338315e9b2@redhat.com>
 <f6834736-3b68-d6e0-ddb2-9d51b8e720b6@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f6834736-3b68-d6e0-ddb2-9d51b8e720b6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 18.07.22 19:52, Felix Kuehling wrote:
> On 2022-07-18 06:50, David Hildenbrand wrote:
>> On 15.07.22 17:05, Alex Sierra wrote:
>>> [WHY]
>>> It makes more sense to have these helpers in zone specific header
>>> file, rather than the generic mm.h
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thank you! I don't think I have the authority to give this a 
> Reviewed-by. Who does?


Sure you can. Everybody can give Reviewed-by/Tested-by ... tags. :)


-- 
Thanks,

David / dhildenb

