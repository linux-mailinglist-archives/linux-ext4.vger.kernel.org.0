Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D9F6D7EA4
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbjDEOHD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 10:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbjDEOGp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 10:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8208B6191
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680703335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=net1/YQpLyeedtAUAtKmhMoSFz+7An5MzKe0V2cpLas=;
        b=dAv/8RSPRm0XAmckLG3K6jMkavO5t0G37YB10aL5ARzMOk++y/ZO7RoPjapV7lNNbnXft6
        wdnu+nYubVrlAogVGaWwwTxbuo+iPHNPrh8HUiV4P3QNO6Bge+QaMss8//JuWM0ZPfsSfZ
        JpbVb1fDH8IbVbgnn2rjU3XsGkRUIa0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-MKw-rjIOMZSQU_AE-dYY9w-1; Wed, 05 Apr 2023 10:02:12 -0400
X-MC-Unique: MKw-rjIOMZSQU_AE-dYY9w-1
Received: by mail-pj1-f69.google.com with SMTP id b8-20020a17090a488800b0023d1bf65c7eso9632380pjh.3
        for <linux-ext4@vger.kernel.org>; Wed, 05 Apr 2023 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=net1/YQpLyeedtAUAtKmhMoSFz+7An5MzKe0V2cpLas=;
        b=PuNOeWYdP+2OPVCLHBqDFExqSWm0reGr8PjOWq7aI7hMgmCaGhVbDEpFGqX9BaP5Be
         Fb/Yjq5dVQomugqkEmPBUeXNmsQtpKa6tagpE0x2B8KzFyNuBjRF9YWQ99NgfHCsq1wp
         iFEEvr3Ynx84lTXFjPotaJ+0vQJIq6nUaTNwWCvYV17yGJ07Ds8+z1cI/KrfluJGZOjV
         tq3G4XZ7g/PBBK8GZEVv3AdokmcpOgGrQvpA3Ir+gfb74av2ZipcOZXz5gakbLPoVYuc
         VWHD2uulpM1yYaqU3E7DDeYDqbTARRxnVwI5wsQGUvubgLQoDDUuzlONoG/OEBpTtXl3
         un/Q==
X-Gm-Message-State: AAQBX9d1QYLyb2Vklf/n4Y1dr/S5YzMiI7XORdmJcz61GJ+DYaLLmexp
        xk80gTKvXqLUGAEb4tNTPoNPIElX2HH6y+0ZoE8YHr2o+5GQzHbqw6DPHyHTOrqeDzgI5UFBkTv
        j5PiLhxYMHKwDiC/IzYUCCA==
X-Received: by 2002:a17:903:283:b0:1a1:cd69:d301 with SMTP id j3-20020a170903028300b001a1cd69d301mr6292228plr.68.1680703330929;
        Wed, 05 Apr 2023 07:02:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z3hrO2tDczikPPadND/siCWP3StMDF6ZwRfuQDU1LtW+SuQXatmasFWBRAsAV4qHbVdUEpFA==
X-Received: by 2002:a17:903:283:b0:1a1:cd69:d301 with SMTP id j3-20020a170903028300b001a1cd69d301mr6292202plr.68.1680703330583;
        Wed, 05 Apr 2023 07:02:10 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b24-20020a630c18000000b005023496e339sm9037285pgl.63.2023.04.05.07.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:02:10 -0700 (PDT)
Date:   Wed, 5 Apr 2023 22:02:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        brauner@kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, djwong@kernel.org, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, anand.jain@oracle.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        fdmanana@suse.com, jack@suse.com, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] fstests/MAINTAINERS: add supported mailing list
Message-ID: <20230405140202.bdp3lzgross2cjbt@zlang-mailbox>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
 <20230404221653.GC1893@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404221653.GC1893@sol.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 04, 2023 at 03:16:53PM -0700, Eric Biggers wrote:
> Hi Zorro,
> 
> On Wed, Apr 05, 2023 at 01:14:09AM +0800, Zorro Lang wrote:
> > +FSVERITY
> > +L:	fsverity@lists.linux.dev
> > +S:	Supported
> > +F:	common/verity
> > +
> > +FSCRYPT
> > +L:      linux-fscrypt@vger.kernel.org
> > +S:	Supported
> > +F:	common/encrypt
> 
> Most of the encrypt and verity tests are in tests/generic/ and are in the
> 'encrypt' or 'verity' test groups.
> 
> These file patterns only pick up the common files, not the actual tests.
> 
> Have you considered adding a way to specify maintainers for a test group?
> Something like:
> 
>     G:      encrypt
> 
> and
> 
>     G:      verity

Good idea! Let's check if this patchset is acceptable by most of you,
then I'll think about how to add this feature later.

Thanks,
Zorro

> 
> - Eric
> 

