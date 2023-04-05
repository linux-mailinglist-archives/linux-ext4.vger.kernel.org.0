Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A486D79DA
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 12:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbjDEKhk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjDEKhj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 06:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4FC5276
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680691010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hFqrvNZsn86teCYjqs2wVJUMFZmHeavzTexdU+dVHw=;
        b=ccCG7nTXb1/1ej0Laf9Vh/R/4XTtROvhrW+TT0tyvb2ogDWHgnGy0ajOCN438/wTyqWxBu
        td/a7bL5Be0awf1Ss8AS/soY/mxmyh4zdByrGPNKgdjKJMFMAuyeLgxv8zHNtVbWUUmDbS
        XwidgRsjWrMlFl+5JhH5TTwzuY+Noko=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-w9Y4t13YNaiVhWKORIcKFg-1; Wed, 05 Apr 2023 06:36:48 -0400
X-MC-Unique: w9Y4t13YNaiVhWKORIcKFg-1
Received: by mail-qt1-f200.google.com with SMTP id p22-20020a05622a00d600b003e38f7f800bso23846018qtw.9
        for <linux-ext4@vger.kernel.org>; Wed, 05 Apr 2023 03:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hFqrvNZsn86teCYjqs2wVJUMFZmHeavzTexdU+dVHw=;
        b=a5neuyYOuKGjikzyIzSBxkEibWWlHz2lgUe5qnBlzbyPUI5Cwombf3A6/Bi69PbON/
         Y52UwQNV2lliNMsREtkacD5hyomSPzaoets+AJc+DJmDBK7flp7UVoYl+I5yMRPlOR0e
         msuH5KZm8bs8RCKQr0GPfpIr1CcmXTxYZeQicigmGDQ63jRDwegigaAHnP6KQqNBZ3Q0
         203kca0ZgwO4cX2I9cbj0+eYcrGAxDZw8Ek2vKICy5lWN/dZrfptMeuzJ6eN6Bd8oJdN
         PQ6yUOMN0gAy7mysnaY51eqrcDByQ9nOkYg6fTi7PwDdZt96sqZArBDSRNuU/qjZiQr5
         vDMw==
X-Gm-Message-State: AAQBX9eseb5zAIX9Qa2T7Zg3tAlsuiQSEz2fOX0bhCRroMsNIoxnXI8O
        RK6Jtf76k/NRJAlWX/suW9usNZZwPaidFZ6Pm4Vpr4h0SoT74PBh/xXsfh0tjpEIA/caBqu+Jx+
        6O2z1g9xFqFuEOLWbaEyq
X-Received: by 2002:a05:622a:181c:b0:3da:aa9b:105a with SMTP id t28-20020a05622a181c00b003daaa9b105amr4016628qtc.17.1680691008082;
        Wed, 05 Apr 2023 03:36:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yray4mqL/DA63FufP2W8G+Q2vCv/dEYqnAM/OkHjKwnv430c/AiUDk3FXiS3P6h8ilen17Eg==
X-Received: by 2002:a05:622a:181c:b0:3da:aa9b:105a with SMTP id t28-20020a05622a181c00b003daaa9b105amr4016592qtc.17.1680691007736;
        Wed, 05 Apr 2023 03:36:47 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i2-20020ac84882000000b003d5aae2182dsm3911845qtq.29.2023.04.05.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:36:47 -0700 (PDT)
Date:   Wed, 5 Apr 2023 12:36:42 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 05/23] fsverity: make fsverity_verify_folio() accept
 folio's offset and size
Message-ID: <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-6-aalbersh@redhat.com>
 <ZCxCnC2lM9N9qtCc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCxCnC2lM9N9qtCc@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Christoph,

On Tue, Apr 04, 2023 at 08:30:36AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 04, 2023 at 04:53:01PM +0200, Andrey Albershteyn wrote:
> > Not the whole folio always need to be verified by fs-verity (e.g.
> > with 1k blocks). Use passed folio's offset and size.
> 
> Why can't those callers just call fsverity_verify_blocks directly?
> 

They can. Calling _verify_folio with explicit offset; size appeared
more clear to me. But I'm ok with dropping this patch to have full
folio verify function.

-- 
- Andrey

