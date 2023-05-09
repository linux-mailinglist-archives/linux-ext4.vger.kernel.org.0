Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34F96FCBC9
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjEIQxU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjEIQxH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 12:53:07 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81643581
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 09:52:18 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-61b79b9f45bso57514156d6.3
        for <linux-ext4@vger.kernel.org>; Tue, 09 May 2023 09:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651137; x=1686243137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NlCnOkM/MgxA+OhUODaj0DcPdY66ABvKJcAkS48+rQ=;
        b=dFimOhJxOisC9sApyThGPvR+2Db7MsSppaAWbsqkmUrTX5tVZo1FdLahc+Zm97mKaW
         DippBoOABJ4qpd/oLQ1FS7Eg+9QlKJvr5pqeHLEJmSueHYduXB0rK5CbvjSVaEoy+dGH
         OmFtInvxSC7Mb2TjhGi36xefB7AxtbL98EUgXQYXfvL6YDNHHL7guux3JY1SaGaxvPiA
         Bn69piaamnqAQYgl3qsEezfpCMRHf5cIfCdovkzKtAnXMh0onFFMtkjaaASy5dMKG+IG
         oc1kWQioFaopMAKMK4ubcLHKVZt1oiJIKAlrTLhUo9jnPB9MXloiwJlkQB0ksqSz9IDX
         oKvQ==
X-Gm-Message-State: AC+VfDzQEN4HBhXOwWhvET9luBkM9wQJZPjUsHqW7oSDWSUdIKk7qFmw
        c89+KRmrSocDuQcEDTCc9Yfa
X-Google-Smtp-Source: ACHHUZ6sqdNZ2jTWBpQoQUne2HxU2x6SkHvDsQePL/EB6aWKWGfiLRP7QOvsu0TXIL8IYmrE41X/oQ==
X-Received: by 2002:ad4:5ba2:0:b0:61b:6872:1459 with SMTP id 2-20020ad45ba2000000b0061b68721459mr18704881qvq.49.1683651137572;
        Tue, 09 May 2023 09:52:17 -0700 (PDT)
Received: from localhost ([217.138.208.150])
        by smtp.gmail.com with ESMTPSA id ew8-20020a05622a514800b003e635f80e72sm633574qtb.48.2023.05.09.09.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:52:17 -0700 (PDT)
Date:   Tue, 9 May 2023 12:52:16 -0400
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
Subject: Re: [PATCH v6 2/5] block: Introduce provisioning primitives
Message-ID: <ZFp6QDkSm296+Qm6@redhat.com>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-3-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-3-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 06 2023 at  2:29P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Introduce block request REQ_OP_PROVISION. The intent of this request
> is to request underlying storage to preallocate disk space for the given
> block range. Block devices that support this capability will export
> a provision limit within their request queues.
> 
> This patch also adds the capability to call fallocate() in mode 0
> on block devices, which will send REQ_OP_PROVISION to the block
> device for the specified range,
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
