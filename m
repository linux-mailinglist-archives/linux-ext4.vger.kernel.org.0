Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C464353C686
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jun 2022 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiFCHoF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Jun 2022 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiFCHoD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Jun 2022 03:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E6DA5F5A
        for <linux-ext4@vger.kernel.org>; Fri,  3 Jun 2022 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654242241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3NFR17KqSiA1Cv/9OF/SD8mUQpa5Kr1/3JIDc75JsUk=;
        b=EvtZpfQqdRpxEl/+CXH/lUJelg0hjFBvUBkrGDxtuClucQFGjfB4w61plN9+BPMIr4XR6B
        NfS38JsxUTn15LcIUUKmzjzvs1i4n+3f1u7Q/azb0jGQ4V6r2YUqGUgeJvuxZAQCwWlbsZ
        Ue3mKas3EwpsFMoVQpYBkwT5hfPvXRM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-9PFhzEEDOCKeeBjlIguTAw-1; Fri, 03 Jun 2022 03:41:04 -0400
X-MC-Unique: 9PFhzEEDOCKeeBjlIguTAw-1
Received: by mail-qv1-f72.google.com with SMTP id i15-20020ad45c6f000000b0046462f670d2so4812664qvh.18
        for <linux-ext4@vger.kernel.org>; Fri, 03 Jun 2022 00:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NFR17KqSiA1Cv/9OF/SD8mUQpa5Kr1/3JIDc75JsUk=;
        b=VAZeogrYCnKUH+9lPBhPqieKcCvTLHvGBd/wWqeN8jP6A/4QSzudwUKZ2XAVSFRWPl
         4Nkisun6xaA4124skCbpBI9TO1TPtjRTA/z3I2rgvG7cvz2qbFU2+W3hDuiLF7DHB9sG
         5kVTyGbn8C4FZMk3R5kEYNbF5XbRdOZDauE/3J7uN9VMS2lfHyrPsEY0xS8NGy1BPkxp
         WEzVj9F5cfucLpCrTjHsCYa4+qztcHudrOJJthYESQW0xVp/dzBo6GH5kFOL3SQcSprF
         sGeXzicx33gLUHui831Qkglo1sF4xXBiz19b1WDSp0Rw1IrlSN8vVjxGwBFceBCPkl6Z
         sFbA==
X-Gm-Message-State: AOAM533FzSo8qW2AbXZHmlejrtZrhA/8fiSctml+IiPYe9Fm19A8NKf9
        9S0h7yZEhPqOiQ2QLGomyUT73ISdWQUY67NnyGNji4uLudn1HGwyZw5rxACQ7BCTChHrHtN0y0w
        o+QutS///idUPNgKdzz/sHA==
X-Received: by 2002:a37:2fc4:0:b0:6a6:494e:475d with SMTP id v187-20020a372fc4000000b006a6494e475dmr5934582qkh.102.1654242063290;
        Fri, 03 Jun 2022 00:41:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd+761mLalCzth1wMYYZ/8jeGqiIQL3PL5SrqyGa2xf7m+maJqg+W2BR4hynzRsE6pv5DcOw==
X-Received: by 2002:a37:2fc4:0:b0:6a6:494e:475d with SMTP id v187-20020a372fc4000000b006a6494e475dmr5934575qkh.102.1654242062972;
        Fri, 03 Jun 2022 00:41:02 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm4586450qtk.2.2022.06.03.00.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:41:02 -0700 (PDT)
Date:   Fri, 3 Jun 2022 15:40:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4/053: update the test_dummy_encryption tests
Message-ID: <20220603074057.5l63o3opgouczueb@zlang-mailbox>
References: <20220530173044.156375-1-ebiggers@kernel.org>
 <20220603053143.ud42tcsxrdkr3mj2@zlang-mailbox>
 <YpmgrJHnrMR8BcOG@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpmgrJHnrMR8BcOG@sol.localdomain>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 02, 2022 at 10:48:28PM -0700, Eric Biggers wrote:
> On Fri, Jun 03, 2022 at 01:31:43PM +0800, Zorro Lang wrote:
> > On Mon, May 30, 2022 at 10:30:44AM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Kernel commit 5f41fdaea63d ("ext4: only allow test_dummy_encryption when
> > > supported") tightened the requirements on when the test_dummy_encryption
> > > mount option is accepted.  Update ext4/053 accordingly.
> > > 
> > > Move the test cases to later in the file to group them with the other
> > > test cases that use do_mkfs to add custom mkfs options instead of using
> > > the "default" filesystem that the test creates at the beginning.
> > > 
> > > Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > > 
> > > v2: mention the commit ID now that it is merged, and add a Reviewed-by
> > 
> > Hi Eric,
> > 
> > If I don't remember wrong, it was a patchset with 2 patches. Now you only
> > send this patch out, do you hope to merge this one only, or merge both?
> > 
> > Thanks,
> > Zorro
> > 
> 
> Just this one for now.  The second patch would add a test for the bug fix
> https://lore.kernel.org/linux-ext4/20220526040412.173025-1-ebiggers@kernel.org,
> but that wasn't applied for 5.19 due to a cross-tree dependency.  I'll be
> resending that test patch later.  One step at a time...

Sure, thanks for clarify that :)

Thanks,
Zorro

> 
> - Eric
> 

