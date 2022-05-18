Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16C52BE93
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiEROTX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbiEROTW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 10:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DDD64CD40
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652883560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfckOg9nc/G1Pfdg8hFEzkjneT+SXrT9/xnBgJMJNjw=;
        b=BtK6uANpbrKHRfqnQCeAwB4qcpxGo4hFuTl1cepGigKRq59CeLFnbgvF1O74nzEKTP0cJE
        kEz05Iu01cewQKLbElBBApsP5KrgP6ua6s8T2La9y8HIJwFVqDf8+1XrlfGblb5O1WMqQ0
        cXlj+Np8DAKdyK/TlSKB9nDIGo7FzNQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-2PyLEd6TMO6t5F6J9WNOkg-1; Wed, 18 May 2022 10:19:18 -0400
X-MC-Unique: 2PyLEd6TMO6t5F6J9WNOkg-1
Received: by mail-qv1-f69.google.com with SMTP id t10-20020a0cd40a000000b00461c0375015so1756442qvh.0
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 07:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=VfckOg9nc/G1Pfdg8hFEzkjneT+SXrT9/xnBgJMJNjw=;
        b=2FmYEuJEJCfYS6ufLY64wrpjU/yBnhvhUiig3lJyeC5wnPN9usd9jsliIjmesE+58/
         vhfVyTo2s8cCqFlEWKAZ889J4kMem6RKzrtQ3Z8vVWcainpk6LlE12GNlNKdGGwSTLV0
         aRW9rJA5qBusavsHqHqm6WW6QDBTnozj1CFiw+IDIJ1HvgjJP7g9276LSm34QZ+yPM5D
         0CBOyS9urzBFKwGod1wfxXSsG88Uml97CP6FYyc3CSRsJYbzLItG3sntbOTfQGHaPV7/
         1S8GTPHQVZQg7mqTJG751Oregl0KvN+NUgyDaPiOJfKS9/rWIhj/rgJjvfNmc76XFZLp
         v/8Q==
X-Gm-Message-State: AOAM531bglGNp26C1D0j1g1WtkeG+LRyioAd990QPqVxiRA6ddSAAPmX
        xl9dZdx93qzAQFSrd7Zea08qfHtWKZXiE5cre+cj9WkjT6r4QG8JQeO7bvmnNv10BociwdhScFM
        1OfNDLMj/vFkyBjUOhdKmHg==
X-Received: by 2002:a05:620a:400f:b0:6a0:5a16:69f3 with SMTP id h15-20020a05620a400f00b006a05a1669f3mr20337009qko.103.1652883557916;
        Wed, 18 May 2022 07:19:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylKGmaR4h+fKRUx8ZDF0bpMUiS7wkjGXnxRlpZU9EGGNOWc9WDXcuIvIad24ACm2E8HEwu0A==
X-Received: by 2002:a05:620a:400f:b0:6a0:5a16:69f3 with SMTP id h15-20020a05620a400f00b006a05a1669f3mr20336985qko.103.1652883557661;
        Wed, 18 May 2022 07:19:17 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s62-20020a372c41000000b0069fc13ce1e9sm1560424qkh.26.2022.05.18.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 07:19:17 -0700 (PDT)
Date:   Wed, 18 May 2022 22:19:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH 0/2] update test_dummy_encryption testing in
 ext4/053
Message-ID: <20220518141911.zg73znk2o2krxxwk@zlang-mailbox>
Mail-Followup-To: Eric Biggers <ebiggers@kernel.org>,
        fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20220501051928.540278-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501051928.540278-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Apr 30, 2022 at 10:19:26PM -0700, Eric Biggers wrote:
> This series updates the testing of the test_dummy_encryption mount
> option in ext4/053.
> 
> The first patch will be needed for the test to pass if the kernel patch
> "ext4: only allow test_dummy_encryption when supported"
> (https://lore.kernel.org/r/20220501050857.538984-2-ebiggers@kernel.org)
> is applied.
> 
> The second patch starts testing a case that previously wasn't tested.
> It reproduces a bug that was introduced in the v5.17 kernel and will
> be fixed by the kernel patch
> "ext4: fix up test_dummy_encryption handling for new mount API"
> (https://lore.kernel.org/r/20220501050857.538984-6-ebiggers@kernel.org).
> 
> This applies on top of my recent patch
> "ext4/053: fix the rejected mount option testing"
> (https://lore.kernel.org/r/20220430192130.131842-1-ebiggers@kernel.org).

Hi Eric,

Your "ext4/053: fix the rejected mount option testing" has been merged. As the
two kernel patches haven't been merged by upstream linux, I'd like to merge
this patchset after the kernel patches be merged. (feel free to ping me, if
I forget this:)

And I saw some discussion under this patchset, and no any RVB, so I'm wondering
if you are still working/changing on it?

Thanks,
Zorro

> 
> Eric Biggers (2):
>   ext4/053: update the test_dummy_encryption tests
>   ext4/053: test changing test_dummy_encryption on remount
> 
>  tests/ext4/053 | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> -- 
> 2.36.0
> 

