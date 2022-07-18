Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F183E578028
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Jul 2022 12:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiGRKuj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Jul 2022 06:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiGRKuj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Jul 2022 06:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BB561EC60
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 03:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658141437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GELRdaJJQzNGu42HwXNvH14oS2HiNBL5HZCcGuN9ch4=;
        b=HjG6XownoJIGB9yL6tcxVNkAa/mj2slwD0GF7RDg/AuUCHbonqGSa2lOjrE+zjMWPtGF6Q
        Qa29JmKrw2P5FI7C/1MpwoMDYvkhLON6GVhNDSmAV5LnuB5L62GdiN5RQjwcmGNDU5uXH8
        OSJAY1w7tQ2bbxrNdeVKxL0TI7sInQM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-sc5QaOFvMYaFwZKTlHLysA-1; Mon, 18 Jul 2022 06:50:36 -0400
X-MC-Unique: sc5QaOFvMYaFwZKTlHLysA-1
Received: by mail-wm1-f71.google.com with SMTP id a18-20020a05600c225200b003a30355c0feso3810330wmm.6
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 03:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=GELRdaJJQzNGu42HwXNvH14oS2HiNBL5HZCcGuN9ch4=;
        b=a0A2LwdWjc9dIszQehULZjDXr4A3aGBNRzd1wYe11IxA2y/WxIOnfWsBkd4Dpoo1cI
         pUXG0OQIemYZbppv7a7DbOLzFtU5tbv79/nv7DTLPuXKEk6Wg/7+ieMndTlllYiWMF62
         DpwXCoZ+rLQ5qRKGE6LhAKk0tES7pxeNZb9y2rdO958TgIY3yGcIdPgy3nnS8NPc17BO
         8kc5gtPFdSMuHlWyOuE/oE0jkzOS+yvAuRBLNK9zbddmuDJATZhmQ+yWDq1Nb5HYltC3
         K97zKLMzLi/nLVVmb0yx8F49m1cBETAE6N8/vbF0zGNdM4hxx2pGlm3Tpy0GSWw1XiB5
         5mKA==
X-Gm-Message-State: AJIora8sQ65JtkfQwz2/RjiDxo+/jdQuJe8dCASE9sTwR5Ogh1Q/hGQS
        s0IWMH7wCJFynS+GmEzUuy6oVhMHNzPtMbEcxEp9cGyNMzj6HVaTp8gQ3FJ1oIBBDMfm8NNaxhE
        5QDtclfJ4uMDXYF08kLiKFg==
X-Received: by 2002:a05:600c:4f43:b0:3a2:ee79:2dd5 with SMTP id m3-20020a05600c4f4300b003a2ee792dd5mr25587638wmq.143.1658141435075;
        Mon, 18 Jul 2022 03:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t3TjHUzmOv6ybcclnybN9UPY7Bi+An5DlmuQSPxVe4SOYbaL5tYKsRuXtw0aDU3ti4mHhI6A==
X-Received: by 2002:a05:600c:4f43:b0:3a2:ee79:2dd5 with SMTP id m3-20020a05600c4f4300b003a2ee792dd5mr25587621wmq.143.1658141434838;
        Mon, 18 Jul 2022 03:50:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018? (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de. [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b0021bae66362esm10526543wrw.58.2022.07.18.03.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:50:34 -0700 (PDT)
Message-ID: <12b40848-2e38-df0b-8300-0d338315e9b2@redhat.com>
Date:   Mon, 18 Jul 2022 12:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 02/14] mm: move page zone helpers from mm.h to mmzone.h
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-3-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220715150521.18165-3-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 15.07.22 17:05, Alex Sierra wrote:
> [WHY]
> It makes more sense to have these helpers in zone specific header
> file, rather than the generic mm.h
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

