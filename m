Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605F05B1751
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiIHIkZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIHIkX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:40:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2AA9E8B6
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:40:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so1660972pjf.2
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FiXynoETQouJYiGZmJtuL0Xc5fwlYoF5EW0bBbAUcfI=;
        b=d9Qf1Dv2UombjwXWK1YEoMeJUc9JxfG+v2WIhlrL99MzVt1r/UzqrAsNF1jz3h8IWR
         a/+4bZQYYL/tQX4H6ZRSGGhIqTF5zE3kN07H8MO+uwpfZeNjgm4diEg4mR96kGs1HHfl
         NdoWuHu38+EAEp5UjW/6Hhgq5HrdWrwD/bRAE7tvb8uzpt5KEzZy6YVj1MieAm9wgUt9
         NfoSQ7KBzdm0g3EUjRpMCLx/Sq11J2VXmm3NIu2KCGC2JcckZ+vNpAB5E5Jy+ymMTBkz
         HzDICs7luenCn9Ygjn84SsMgQ1oJZVmXpniOAC5o4G/7trAjXDL0sG8g1kmxxGoa29kA
         nulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FiXynoETQouJYiGZmJtuL0Xc5fwlYoF5EW0bBbAUcfI=;
        b=IzmC0EUzAYWyKqbc2rIX2/KkKRpc1YIgPN2M4MrksbVUGvya9Kd7LdCFTaxCPTD6tv
         pMc6lQ1qkGt7FpobHtxcKTwEa/S1kqUjhuvR1VH1pGjlye/KZydJLQ1rIg4ETGHjdM6r
         gT1dUzfciUe1xx1YMn/AUyXCD0tzcfTIwAmr0Tf56l1lOz1NGwEZBMWVuW7QhNe7b3WD
         2AHdHbhS7VnNmsHTeWZmyt8xfvfzzDnBAPBpMfap44roqNYwo3j/ibnom+vezeZLwrs3
         21CdAloDqrOp33dZWdo09sptG+R2zSiQ5LjiUQVO6lNXKV7cLtPCwbGSpAV9VEM7Mop7
         Milw==
X-Gm-Message-State: ACgBeo0vOoDqjWCtckkXjYDpI9TJEhzmtJ3TIQS/GMB/aNQQbEdeUvZB
        sgoigEDRYAgZ2721Jwg9moTVOU2ueNw=
X-Google-Smtp-Source: AA6agR5MFam+wPoZTGK9OzypnPgFmBQ3Ditr14yijxcUyFM3PeziBq5kQ2NnQXKcGkhDnJU6vTZuhg==
X-Received: by 2002:a17:902:db0a:b0:176:d40e:4b62 with SMTP id m10-20020a170902db0a00b00176d40e4b62mr7919887plx.46.1662626421338;
        Thu, 08 Sep 2022 01:40:21 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79691000000b0053e80515df8sm3135520pfk.202.2022.09.08.01.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:40:20 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:10:15 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 02/13] ext4: remove cantfind_ext4 error handler
Message-ID: <20220908084015.pwc3rwidmd7jvm3c@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-3-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-3-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/03 11:01AM, Jason Yan wrote:
> The 'cantfind_ext4' error handler is just a error msg print and then
> goto failed_mount. This two level goto makes the code complex and not
> easy to read. The only benefit is that is saves a little bit code.
> However some branches can merge and some branches dot not even need it.
> So do some refactor and remove it.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)

Looks good to me. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
