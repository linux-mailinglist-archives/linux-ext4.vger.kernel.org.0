Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDB95BB324
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIPUBX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIPUBO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 16:01:14 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338CE85AA3;
        Fri, 16 Sep 2022 13:01:13 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d82so22214916pfd.10;
        Fri, 16 Sep 2022 13:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aI55elBM47AbpRIfEoRwcS12RWAxkruf3PuVmLaNsIw=;
        b=F93+3ZCuhoW4ubfMQpiKJx3jYO2YUlD99AS4TKVJFHr2cITbQE1c4KZZRs/b07IsrF
         71vE+0oKcC+g33vygMudbCM9cwLfEffrCHL8/A/+L/clX/M+Y9qZPw4M/qjDFlIgXdu4
         QiO4Re/9Ms2VZfqmDL+rR2Vc0KfXNS97qFssyM8LltJkjy0UzXrAgw7IfaoaWtutTmPU
         i42jQJyTI0fiwaWDcW6yNDeBQ7uzf4Q7b4FmBsIt3OmzSMNf0HxsoeQSuyI6hq4igsq5
         qPNbUBmnVVZqo5KKMlr1eusMZHJQQlmIRO2tUv5DYbp0P95iFjeEvAADhNcuahj3X1zI
         PSFg==
X-Gm-Message-State: ACrzQf38Z+mWYa2pf9O4zTOOmr4B3B0I5QexSTkZ0OfBjQqItPY8DDxb
        tshmutsszHKV1RTldP+BpHQ=
X-Google-Smtp-Source: AMsMyM7BtRpoBGm+25ZIcjQ1eDg7usENuczHgm9wgE8Sus1sUlVcptKPjg/7yVuSQ/Mc/WEtnHJpcQ==
X-Received: by 2002:a63:e452:0:b0:42c:60ce:8b78 with SMTP id i18-20020a63e452000000b0042c60ce8b78mr5917990pgk.453.1663358472565;
        Fri, 16 Sep 2022 13:01:12 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e470:c0f8:8896:5368? ([2620:15c:211:201:e470:c0f8:8896:5368])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b00174c235e1fdsm15550309plc.199.2022.09.16.13.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 13:01:11 -0700 (PDT)
Message-ID: <0be0e378-1601-678c-247a-ba24d111b934@acm.org>
Date:   Fri, 16 Sep 2022 13:01:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Content-Language: en-US
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 9/16/22 11:48, Sarthak Kukreti wrote:
> Yes. On ChromiumOS, we regularly deal with storage devices that don't
> support WRITE_ZEROES or that need to have it disabled, via a quirk,
> due to a bug in the vendor's implementation. Using WRITE_ZEROES for
> allocation makes the allocation path quite slow for such devices (not
> to mention the effect on storage lifetime), so having a separate
> provisioning construct is very appealing. Even for devices that do
> support an efficient WRITE_ZEROES implementation but don't support
> logical provisioning per-se, I suppose that the allocation path might
> be a bit faster (the device driver's request queue would report
> 'max_provision_sectors'=0 and the request would be short circuited
> there) although I haven't benchmarked the difference.

Some background information about why ChromiumOS uses thin provisioning 
instead of a single filesystem across the entire storage device would be 
welcome. Although UFS devices support thin provisioning I am not aware 
of any use cases in Android that would benefit from UFS thin 
provisioning support.

Thanks,

Bart.
