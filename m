Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64FF5B7614
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Sep 2022 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiIMQFR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Sep 2022 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiIMQEu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Sep 2022 12:04:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B6985AC
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 08:01:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so11574982pgb.4
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=X3m3FjGRBCb423diCAWVdaBcPwgy09tN4cpw/6JEjJs=;
        b=S6drEZOZTg4NR8K8q1ClRd6f53fEXKUTQzjIRH3aaIoX9eKB8iOunUy3mRS7vk2irq
         71CmjcjBPGNF+UApQMZb9xPdLQM/3+lbI3cQuZXuMgnYlY1wEd1b2YOGrY94jklLAN37
         ER+pJyOG3uWi046qvE7uhtg2yFPdHWDKBnC/MMlJiw05Y+cNLHWVCftP81z74gVIono7
         lTVFxf/hUuwIEDm6Ym/WzeZAplguL4Y40eDN1mgS0V8H4Wah6m85+wUqhcEqNGq8RUwA
         +nZbksM32HI6qBGOqEn4H6AanzQ6lzAveKSSqzMssyPhqBu3hthLKlGoUFXEeyARoaax
         PA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=X3m3FjGRBCb423diCAWVdaBcPwgy09tN4cpw/6JEjJs=;
        b=H5zPT9ez+17xyxo4qk2nk4O0ibsQiiScrsW4KAGnYtkXeFXVQol4ZQ5ebS8mgl8AGR
         JZG6fJwDQ6exnO88vmF1+KQzu8oz/T2rudhUTtrK4uNy1IsDwqIcSuK9utYFnRYCpPzJ
         Zh2WLdeDeyJKEzksQYHMDs1CBB60wqaePGCpj3noXEhPiqFqwrsJgIHj176JY2W59Gb2
         sFEUcGr9JDbnmlUgTd4PrA8VP0MMVs8VjM8JLyYlchIZLQLMcdCu2CH47F+yA8wE6XYS
         g9lbhl2GtRiKKZcWL27wJK/uQs1KuBK8+g16Ho+SCmtqDQ96tX2O10Ld0VawslwG0r+3
         wj8A==
X-Gm-Message-State: ACgBeo0mW7yc2rU0RmuOuG4OKnOgzNRgs90a9LSY5vMzm6vcX2Dd4OTP
        QdcTFLUWGOlPXEXju+f0kDqXDAyPeog=
X-Google-Smtp-Source: AA6agR643QaWPlLZMbrI4iW5KE5Wh/lP96NmIqQHQt92EHgg1ETUBHS3MMtlBIvG5r/97qR1lOJX9Q==
X-Received: by 2002:a05:6a00:1943:b0:536:2bef:2f93 with SMTP id s3-20020a056a00194300b005362bef2f93mr32298514pfk.34.1663081195595;
        Tue, 13 Sep 2022 07:59:55 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id h184-20020a6283c1000000b0053e80515df8sm7901756pfe.202.2022.09.13.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:59:55 -0700 (PDT)
Date:   Tue, 13 Sep 2022 20:29:50 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     tytso@mit.edu, Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>
Subject: Re: [PATCH] ext2fs_open2: goto cleanup tag when
 image_header->magic_number != EXT2_ET_MAGIC_E2IMAGE
Message-ID: <20220913145950.t2fwkeihjgas55kj@riteshh-domain>
References: <703f5bf7-fd63-ad0a-fcbb-0b5affd31d53@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703f5bf7-fd63-ad0a-fcbb-0b5affd31d53@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/13 09:14PM, Zhiqiang Liu wrote:
> 
> In ext2fs_open2(), fs->image_header is assigned by calling io_channel_read_blk,
> successfully. If fs->image_header->magic_number is not equal to EXT2_ET_MAGIC_E2IMAGE,
> we should go to cleanup tag to free resouce and return errcode (EXT2_ET_MAGIC_E2IMAGE).
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  lib/ext2fs/openfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Looks good to me. Feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh
