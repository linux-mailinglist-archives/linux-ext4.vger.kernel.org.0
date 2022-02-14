Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851244B5391
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Feb 2022 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiBNOnd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Feb 2022 09:43:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBNOnd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Feb 2022 09:43:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AA649FB8
        for <linux-ext4@vger.kernel.org>; Mon, 14 Feb 2022 06:43:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j26so16403309wrb.7
        for <linux-ext4@vger.kernel.org>; Mon, 14 Feb 2022 06:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8k2aplyYI1OYSbtp/sgTQSaIuXBRyilQhTxzdkcz5oM=;
        b=Kc2NhjEECM3Ike+mng8fkAJ0mNxNc5SBRyB1PT/O3H3V73wWQu3kwBEGUi5ElHSAO6
         q/catBw7mYZcPXvpUSNGnDCmFkfOprjpwGMz6wSXWiaoqXAACWp7PtLen87Y+bonxIN1
         43L0PWcSripPNaWQR0fPqEBkHOT6yEI9uerxrKLq7QvgKav7FpvSEmgITr/+K7GNiY7B
         iGv1xfjWwKDDpaeAFwxKWhda453SESLLxjeVVCBBsqVXsGNJhNOf5ctlwJ+geYh8BJzm
         +M1D4w1q9VU+f7mXbY+O6oCCD3RJ0jSdWtuGak4JKBjXo3YRHbJI8Le+vdXU7RVyZi3f
         3Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8k2aplyYI1OYSbtp/sgTQSaIuXBRyilQhTxzdkcz5oM=;
        b=8SLsASLOzftPSA94mzJMv9RayZ03rODZnTZQYaxa+SB92vqlz3mWOHe/ZnalRMIPIF
         W1ed4ei1fsd/A+pivHqbKhj2OFdIpOsJL4OxDGT8YRilrpxKaBPlbqCXz9t63VEpRB+2
         n4cI4wssZr+cCdurKQTnKAkTnpYtJhhrDEGVQqqoll7ESF2NkL8wNkYtxeQ/9o0dUrU0
         SBiJy6DOh9sFNuxmu9hwmhNNdonqQ8H9LK4MT/nCQR6WkOSu40AVFUI563sWf4m3TkwC
         5Ylth5ttQHnoDegmmmhxc3GvgfqLS0YNU2dQ3YXciNYOQHq/ej7fWtjOkdelw3R2hVE1
         kiLA==
X-Gm-Message-State: AOAM532Ul9+jrd5KdDfqjKmLM2Ip9nKgdwPuSXHqCf5B3OQrNlT5+QNT
        24t6fDiMzHHZqR1MI5gtP2L6yg==
X-Google-Smtp-Source: ABdhPJw7yRUYoEyGu9ey4dIfTWZqAtG97B1/NFiN85MQVuWJ6su5QCeF3PBi//ZfG99hTeOE+wDSOA==
X-Received: by 2002:a5d:52c9:: with SMTP id r9mr11422010wrv.449.1644849803276;
        Mon, 14 Feb 2022 06:43:23 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o16sm12358972wmc.25.2022.02.14.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:43:22 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:43:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, Stable <stable@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com,
        syzbot+0ed9f769264276638893@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] Revert "iomap: fall back to buffered writes for
 invalidation failures"
Message-ID: <YgpqiG7fvX7pHEHO@google.com>
References: <20220209085243.3136536-1-lee.jones@linaro.org>
 <20220210045911.GF8338@magnolia>
 <YgTl2Lm9Vk50WNSj@google.com>
 <YgZ0lyr91jw6JaHg@casper.infradead.org>
 <YgowAl01rq5A8Sil@google.com>
 <20220214134206.GA29930@lst.de>
 <YgpjIustbUeRqvR2@google.com>
 <YgpmN/R7jAf97PBU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgpmN/R7jAf97PBU@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 14 Feb 2022, Matthew Wilcox wrote:
> On Mon, Feb 14, 2022 at 02:11:46PM +0000, Lee Jones wrote:
> > On Mon, 14 Feb 2022, Christoph Hellwig wrote:
> > 
> > > Let me repeat myself:  Please send a proper bug report to the linux-ext4
> > > list.  Thanks!
> > 
> > Okay, so it is valid.  Question answered, thanks.
> > 
> > I still believe that I am unqualified to attempt to debug this myself.
> 
> Nobody's asking you to debug it yourself.

Not meaning to drag this out any longer than is absolutely necessary,
but that's exactly what I was asked to do.

I fully appreciate how complex this subsystem is and am aware of my
inadequacy in the area.

> instead of wasting everybody's time.

That was never the intention.

> We're asking you to file a clear bug report

No problem.  Will comply.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
