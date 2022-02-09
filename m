Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200BB4AF5E5
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 16:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiBIP7t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 10:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiBIP7t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 10:59:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F40C0613C9
        for <linux-ext4@vger.kernel.org>; Wed,  9 Feb 2022 07:59:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s18so4853180wrv.7
        for <linux-ext4@vger.kernel.org>; Wed, 09 Feb 2022 07:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wf8pBHPnIbwBS8l1ga7IlePPb2NVs+dEhjuVljUBPL0=;
        b=uoZQFZFTh4MWC1dtmAROvUGhJHmAVYXfRYOAWo8gKyK62YWvPbxBb/FtR7u0hgWHM+
         pIHKzcAPIBus0KV7+mL3D5j14qeOkWhNlhbJ27iaSBhTl/LjI4HHKacQLeaP0W27kYi4
         S3IY7DwzPAuE8oLpegUUjChlpPOLw2uSQqJ+5BKLAuffbk7cd8egzMzWrTEY9KtgoRa8
         lhCJFlR9ZXDT3UoxC0gXTD0HcsmKfyMcum4z3NXlytG7Avl6gstXNUE/R3zGzn6Ti6rI
         nfSuSby+RBkqpUK/2NHWt/I4qhdA9CqPByEjJEcUJtu45v7exquNrCxUmMMhRNRl4LwZ
         9QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wf8pBHPnIbwBS8l1ga7IlePPb2NVs+dEhjuVljUBPL0=;
        b=6A5PZlwcJL7ZI65z6pq0J9puv5+7bbH1JuGR4DeIGX/V8If/IOtjw40ZuFI7w8mwuo
         uhmOa3kWg9aV0B9j4MIIiDSw9fdRu0Am0QW44somqJ38omLmlygCaET2p28D13xqGpVW
         68PrduIUupH/w7drxxC4isXq3zqZWcogQSkYTrJ54KvhmAhDxVvjCQ5eDjhblNYFDet2
         xg2qA0lagWbosQ8UCOAEIfp/Iw9KOn0sFIAuTpOLACcAS+npsVx8wHV6mxG95wX7vUL8
         OUjH9UCD+/DpV2/BcGvcmDXFJ4efe/LuSAvdeUEWI0qvRzSJ3I63iTCdikPGNyLPUKW+
         m/7A==
X-Gm-Message-State: AOAM533AJo7+j2hka6/wSI2Hikam/P6APdPYwqh8JiK+gzCz65glzEbI
        WN7zR/GCd56EtpRBwROcIj8Fhg==
X-Google-Smtp-Source: ABdhPJzrsU/yGaq1wonWpTsPZOGFI2x3Kw84cs8UYaEe/84fhhkIxX9wA9KdK4C49JCW0SYDnFQlaw==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr2519928wry.504.1644422390765;
        Wed, 09 Feb 2022 07:59:50 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g22sm5098170wmh.7.2022.02.09.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:59:50 -0800 (PST)
Date:   Wed, 9 Feb 2022 15:59:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Stable <stable@vger.kernel.org>,
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
Message-ID: <YgPk9HhIeFM43b/a@google.com>
References: <20220209085243.3136536-1-lee.jones@linaro.org>
 <20220209150904.GA22025@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220209150904.GA22025@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 09 Feb 2022, Christoph Hellwig wrote:

> On Wed, Feb 09, 2022 at 08:52:43AM +0000, Lee Jones wrote:
> > This reverts commit 60263d5889e6dc5987dc51b801be4955ff2e4aa7.
> > 
> > Reverting since this commit opens a potential avenue for abuse.
> > 
> > The C-reproducer and more information can be found at the link below.
> > 
> > With this patch applied, I can no longer get the repro to trigger.
> 
> Well, maybe you should actually debug and try to understand what is
> going on before blindly reverting random commits.

That is not a reasonable suggestion.

Requesting that someone becomes an area expert on a huge and complex
subject such as file systems (various) in order to fix your broken
code is not rational.

If you'd like to use the PoC provided as a basis to test your own
solution, then go right ahead.  However, as it stands this API should
be considered to contain security risk and should be patched as
quickly as can be mustered.  Reversion of the offending commit seems
to be the fastest method to achieve that currently.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
