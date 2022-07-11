Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37555704C6
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jul 2022 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiGKN4L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jul 2022 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiGKN4K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Jul 2022 09:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D40736069F
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jul 2022 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657547768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE4NfC1H6uTSXnC9kdw86YADNW6bGnH63De3NmdMle8=;
        b=iwGnZJ5muhnMIngn+p2ClEYU5Y0mKylf0YCvwe1jhIpOOxbDtKy6HkHJWYYiuOimT7XWea
        /ZHoiiYqvOkeJKqU2+jTDL72SneMK6QsmF1y2COf8F+nF38J148WUxznXz6RzDrKIwbiCu
        XUU612GH+kVvhvDkD87iboRYFPgasyM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-ZA9EaCwmOYujhPTVc2d59A-1; Mon, 11 Jul 2022 09:56:06 -0400
X-MC-Unique: ZA9EaCwmOYujhPTVc2d59A-1
Received: by mail-wm1-f69.google.com with SMTP id az38-20020a05600c602600b003a2dff426aeso3915104wmb.0
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jul 2022 06:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=aE4NfC1H6uTSXnC9kdw86YADNW6bGnH63De3NmdMle8=;
        b=Rc+3mqfFtU1V4/jk2bKZmx2lb9LnzVVphEltx2M5pqn7aAK5bdYw31YyHQpEWM2l8a
         bi1kSxNzO1AKqvqJWL92/yWWFWkjeYwJtZHQ5t3ukH1VH9jrn0SRwY1reZBF3kNahBSW
         C+UyerapriJrWXMvLb9b3JYeBrpjN1Yub8QXL5dDX6vGLwrVPE5Z80mlxGP/NGI9/CwO
         p+U9uTDs6jx+O0t9L7IvhV8komXePxWxeCogJirO+e/sH2zicPhd9dXu9q4f/2HBe/Q3
         B0cRd7UPHI04OFC6lggIHpnLbbTLlA9dNln/ArvJFnPs2Fe3S11ipKS9iE1xDSm/KV01
         1S3g==
X-Gm-Message-State: AJIora+b8uyAdlJ/mKOJ9F75ItBWdx24afnTKX4XDTkIDpMQq0tvhllA
        GpE6fhRzuI+qdrKVsCd+pJvBRhHp77S04344WLKrBOcd9iIxVrCTf1y4VLmf66VXiXrGnANGq7h
        IxOydpjB+IQP+U+qB84ACHA==
X-Received: by 2002:a5d:6e85:0:b0:21d:65ec:22d with SMTP id k5-20020a5d6e85000000b0021d65ec022dmr17110881wrz.435.1657547765483;
        Mon, 11 Jul 2022 06:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1twv2L3ZevD/RVvtfPY4LjhC4WGJFMlZ2FQQkXXNrSvlcGGqG7Pzzjip3VPLrNidVEXGx3eVw==
X-Received: by 2002:a5d:6e85:0:b0:21d:65ec:22d with SMTP id k5-20020a5d6e85000000b0021d65ec022dmr17110860wrz.435.1657547765208;
        Mon, 11 Jul 2022 06:56:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1400:c3:4ae0:6d5c:1ab2? (p200300cbc702140000c34ae06d5c1ab2.dip0.t-ipconnect.de. [2003:cb:c702:1400:c3:4ae0:6d5c:1ab2])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b003a2e2ba94ecsm5925143wmq.40.2022.07.11.06.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 06:56:04 -0700 (PDT)
Message-ID: <2ff85751-b0b6-eaa6-8338-2bf03ba6e973@redhat.com>
Date:   Mon, 11 Jul 2022 15:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/15] mm: move page zone helpers into new
 header-specific file
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-3-alex.sierra@amd.com>
 <97816c26-d2dd-1102-4a13-fafb0b1a4bc3@redhat.com>
 <715fc1ae-7bd3-5b96-175c-e1cc74920739@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <715fc1ae-7bd3-5b96-175c-e1cc74920739@amd.com>
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

On 08.07.22 23:25, Felix Kuehling wrote:
> On 2022-07-08 07:28, David Hildenbrand wrote:
>> On 07.07.22 21:03, Alex Sierra wrote:
>>> [WHY]
>>> Have a cleaner way to expose all page zone helpers in one header
>> What exactly is a "page zone"? Do you mean a buddy zone as in
>> include/linux/mmzone.h ?
>>
> Zone as in ZONE_DEVICE. Maybe we could extend mmzone.h instead of 

Yes, I think so. And try moving as little as possible in this patch.

> creating page_zone.h? That should work as long as it's OK to include 
> mmzone.h in memremap.h.

I think so.

-- 
Thanks,

David / dhildenb

