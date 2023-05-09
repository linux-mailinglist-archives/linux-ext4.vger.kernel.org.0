Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673BB6FCBD1
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjEIQyC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjEIQx6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 12:53:58 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F9A5593
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 09:52:55 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-3ef302a642eso31351491cf.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 May 2023 09:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651175; x=1686243175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGP12yp4f/zdeMyz6FmQhXwVLGe13YEnm2DiLQWOfHc=;
        b=e5WGDVc3fxlLEhrS4bfqZYXip8xiDht+0NF0tZYXYXN1UV9rlCFzLo9za4fppKj96A
         /gjHj1YWUltpLZlNxgoGFGSnBVgcEZSCl4Asp329kbFDofChRPTCku1n8KIx2PfVALhm
         IpKlAncTijQbbTIoVl5VshU2M9KkTOTFGv2Xdl7JtXodk/E0zEu5R7+9ktyVdWxtwu08
         aUH6j3yhbarRziOw9JHwvIvNUxLb14Wula5yVT6gKFc5CFa36+1LbfI3TAQDTWMvaCpl
         iCsyJGesPMDKYmChGSnx6uSY+0weNbzNX8tvr7NxxXnSPngvweMFBQVhzTPHHZ0iNRh1
         ESTQ==
X-Gm-Message-State: AC+VfDyMfrP0AcpJKXXa325i2OwAtzP+6ilu5NiBBTXdTNtTZm84epUf
        PXwrJ9nsmssQHq0d8GgwtKkkGn/ksQIgygWcgQ==
X-Google-Smtp-Source: ACHHUZ60YxoIH2gyoAjnbydVA2DQU48zJWQIwW/0Dh9DydhZKu2onIPJxWL7YRFQz348oUBbEBXSUQ==
X-Received: by 2002:a05:622a:148a:b0:3f2:a8db:3d57 with SMTP id t10-20020a05622a148a00b003f2a8db3d57mr23188660qtx.3.1683651174740;
        Tue, 09 May 2023 09:52:54 -0700 (PDT)
Received: from localhost ([217.138.208.150])
        by smtp.gmail.com with ESMTPSA id o4-20020ac80244000000b003f38f55e71asm632547qtg.47.2023.05.09.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:52:54 -0700 (PDT)
Date:   Tue, 9 May 2023 12:52:53 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v6 3/5] dm: Add block provisioning support
Message-ID: <ZFp6ZSwzqk2CIKwu@redhat.com>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-4-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-4-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 06 2023 at  2:29P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Add block provisioning support for device-mapper targets.
> dm-crypt, dm-snap and dm-linear will, by default, passthrough
> REQ_OP_PROVISION requests to the underlying device, if
> supported.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
