Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9465B56F3
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiILJJW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Sep 2022 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiILJJV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Sep 2022 05:09:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387602AC5D;
        Mon, 12 Sep 2022 02:09:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so7560269pjl.0;
        Mon, 12 Sep 2022 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vu4RMx56gRMDRRk5LhB0fizvQmnThnr0+bRkp4/VSUM=;
        b=VlsHskWKM4R6mhCzGNwlF+XlzycI1rkR6prx4pw98ZWxHMjhmHvfAheLCvz7sh5yro
         UIaH3hJCeTtdhFBSp7kK2Seahz8O8zfcwF5NHoDyYE3Quflq9cycBnS/UsSKhreY1+1y
         eCXmO8dM/UIx+Ll9fXFRvAD2XrMWdqGzTgPhhTLq45K2UzdwNEwKYVM5TVbZv+V3e4uV
         qXrJADA4gFyaRwod6SuOA/NPWQ5G/wD7Aajclm05YIekqQelhxcbYlSfj4nODOWL7INt
         nup2nP+ft+bdlpyLVn2S87+V2XSh3iHxz0SQXFXhA5S/xOCwpn3fs02FVo2eBqBenAPj
         nY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vu4RMx56gRMDRRk5LhB0fizvQmnThnr0+bRkp4/VSUM=;
        b=tx8lb+3R8zuTBx66IIuFx4Ddem2QtUN2afJFBuS9iD8GQlX8PzjwtQLwLpFsujTgLB
         u2z2D5LG5mWyZzX87jDcZy72WJT7yvaTc7PLwFJMVfGTx3+q1r77TO19J0aUQJ9tG4Cm
         E/jvd29UeO3vC6xWQ+EqFP+SsEP0teBWyPPTYoHiM69Ip5VFBJ7gbQRRVrZs4IS5yLCo
         v7V/f52M7VkBnnNpfix0mVpkFalrvftjvxRt10dNrdGKjsyVFHe1euL7HWPiMB0jEzYo
         CwV4jN9U5Lmr1FDaG2Ny1uZ4QHVBNAzvGw26L4YweS+MN74XegD5HDB1cvz0Q/Bhxtt/
         DHJg==
X-Gm-Message-State: ACgBeo1L6+d7OvJmbt4/a9ADxnQw4uPoUpTCOOZQkNhmCLsEbMav48VA
        vlxIFa8sViP0l3eQty6WW5I=
X-Google-Smtp-Source: AA6agR6x+gDeeIfiywKYL0/46XYu0CgLHLCzWTx0gUJIHfCzSB46G1BlONQWK0Uq8KrOv9LzAbkCjA==
X-Received: by 2002:a17:902:8f8a:b0:170:8df4:eebd with SMTP id z10-20020a1709028f8a00b001708df4eebdmr26124314plo.116.1662973751686;
        Mon, 12 Sep 2022 02:09:11 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id i6-20020a628706000000b00537d60286c9sm4846212pfe.113.2022.09.12.02.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 02:09:11 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:39:05 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove ext4_inline_data_fiemap() declaration
Message-ID: <20220912090905.h4u6dl5vo5bnxlug@riteshh-domain>
References: <20220909065307.1155201-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909065307.1155201-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/09 02:53PM, Gaosheng Cui wrote:
> ext4_inline_data_fiemap() has been removed since
> commit d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework"),
> so remove it.

Yes, indeed. Thanks for spotting it.

> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  fs/ext4/ext4.h | 3 ---
>  1 file changed, 3 deletions(-)

Feel free to add 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
