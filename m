Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E0E777778
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 13:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjHJLsv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 07:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjHJLsu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 07:48:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383091
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 04:48:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe58faa5cfso1182874e87.3
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691668128; x=1692272928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMY8frrca41Vekt3XIPmeD0Lb8cpCjOB+63wKDM1sk4=;
        b=yuwvwEWssHdcYJQa4HinMo7yhgk3OtI280P/MzEtYaRX9hELEOoyJj8zQkrN4PmSLh
         SiEQIrwGM/cUlp2BHZSAff/8BWu9i4UFfIB8kBea+Dh1GTsSjEDPfBqYnx0GuGt2vkEV
         EArkKUnhnOluC1F60TzIyeWi6c9+c/zn36PI0ssVaGzdF14uCbLlwbWTvXujWlTU08VV
         ysLSmSNteK+l0yFq49mlkqhJ6Lng0BvLL7FuXdrxdTqpIIHNTjvoaeVSf71o2dtrJYPm
         1yyCxDmKK67mKgLYh1yhueSJ1aRgkgHANLuK1l/uCEUoUz2JKsGohgb6L51CVCYN5hX1
         EdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691668128; x=1692272928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMY8frrca41Vekt3XIPmeD0Lb8cpCjOB+63wKDM1sk4=;
        b=bgbdTQrslBofbWm9m0g/qu0yK7S+OQ/uw3jatEsAK5ysC2AZjHEqkgDUf4xijULUj1
         03fV7uy7QjIq0+xB62/G7zRRgAoZnYPPFjWleLpX9rkKwgHBdHZgeqSZesiNX1J6oCpt
         6v2e9Er1/mj8elfowrtCjkOGALGJ7q3pI14+U12zOSbzYBdZMnO31AVpuZoDTAQOkiVY
         TJTwOvJgWrvFlCY8vpx6pp6JW3VcTZfXUw2gL/Pj0TY/Ln9wVf0u9fp4zT+lGYIa1r4d
         oHHY58RSQz807MO680nc00wQryFc0s/BgUo5fun9sS5kt3rWFXtXgwcaC3HCsl9gJ9Dl
         i5zA==
X-Gm-Message-State: AOJu0YxqrxWEGZRoVt5h7uk1xsx1QiJrlfb7LhbddL9pQj/rIAi6nVie
        kPSredCRYO0tv+z11OJho7YBL1/LZ2FmTretdOU=
X-Google-Smtp-Source: AGHT+IFf5Nd4Kj6BQvvHettFkx3xvQttVGAmyrssbzvT521pULBTk2T/lpVoMMhKttJVREyUAOoXbw==
X-Received: by 2002:a05:6512:2141:b0:4fa:6d62:9219 with SMTP id s1-20020a056512214100b004fa6d629219mr1370006lfr.62.1691668128183;
        Thu, 10 Aug 2023 04:48:48 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1925342wma.7.2023.08.10.04.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:48:47 -0700 (PDT)
Date:   Thu, 10 Aug 2023 14:48:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: convert symlink external data block mapping
 to bdev
Message-ID: <0ff22f40-3eee-44ed-970d-8ee6af7979e4@kadam.mountain>
References: <797feb23-f8c8-4ce7-b25c-b4f591be1387@moroto.mountain>
 <7f69ac7e-bfad-ec37-f48b-0633583838d5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f69ac7e-bfad-ec37-f48b-0633583838d5@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 10, 2023 at 07:25:02PM +0800, Zhang Yi wrote:
> On 2023/8/10 18:31, Dan Carpenter wrote:
> > Hello Zhang Yi,
> > 
> > The patch 6493792d3299: "ext4: convert symlink external data block
> > mapping to bdev" from Apr 24, 2022 (linux-next), leads to the
> > following Smatch static checker warning:
> > 
> > 	fs/ext4/namei.c:3353 ext4_init_symlink_block()
> > 	error: potential NULL/IS_ERR bug 'bh'
> > 
> > fs/ext4/namei.c
> >     3337 static int ext4_init_symlink_block(handle_t *handle, struct inode *inode,
> >     3338                                    struct fscrypt_str *disk_link)
> >     3339 {
> >     3340         struct buffer_head *bh;
> >     3341         char *kaddr;
> >     3342         int err = 0;
> >     3343 
> >     3344         bh = ext4_bread(handle, inode, 0, EXT4_GET_BLOCKS_CREATE);
> >     3345         if (IS_ERR(bh))
> >     3346                 return PTR_ERR(bh);
> > 
> >>From reading the code, it looks like ext4_bread() can return both error
> > pointers and NULL.  (Second return statement).
> 
> Hello, Dan,
> 
> After checking the code, we have passed in EXT4_GET_BLOCKS_CREATE to
> ext4_bread(), the return value must be an error code or a valid
> buffer_head, it's impossible to return NULL. So I think the warning
> is a false positive.
> 

Yep.  You're right.  Thanks for taking a look at this.

Eventually, I will get around to tracking bits set across function
boundaries and that should silence this warning.

regards,
dan carpenter

