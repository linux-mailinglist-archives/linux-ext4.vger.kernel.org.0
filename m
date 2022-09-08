Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418B85B17D8
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIHI5J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIHI5I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:57:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1A9F755B
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:57:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so1699382pjf.2
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nr2GW601SYv8dfWffereN2I8CqPbJhvWU/A88alEbyw=;
        b=QoNolPm2DN7xIzLlnVK6nohLdPJBla9irP6P5ulhWpG1FdiuMXGGJ/PBMuG2KjQkDU
         gJMc5PpHl4GFzQhrnNH1+dAADp3yWZ3FTmrv+qPrT1i0VjAHUo1D4s8lwnNZa+RLhjPv
         n9QVvM3NgZ5jhtvcY+nrj/nvSYnHCRpQJqPoZ7R8JXiZHjUKjixXpl18n5AzhkUvx0cw
         swxetB6n3i/HDFMuYtgFNFs8IXYYO62d3vXEThSKk058q161/ZJYh6Ai1AoFKymO/V9R
         QD90COi6XpT6alCAiC9TECSvBrdTbAuShTi9KQZVoRdXgVmdbxpR8KamCRHUg3ADRY3+
         jGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nr2GW601SYv8dfWffereN2I8CqPbJhvWU/A88alEbyw=;
        b=VKV2DXfma5iTQBNSrFRnif3tjBJBRJIrDoq6+K2E2YEu0C0GtI2DiZxoxTKR7xopbZ
         nWVHHPncIcXcMFBo9/bZD2TzxC5REBU7ZjZijfixISbI9Nm/HPp6B2WFO8/qECN9qpwt
         kifdUZyvy9vToX7AEZVnF6BGsg869jwuZqZlh4+M9r2ogcQZCnC+i9V14c3b8MJMVixD
         51ojux+QY+l1YsMc1ktS+cu81gsXidvIYOCosNhpcokXJSOOZFccjo5KttMv2FVUUC86
         mes6RMO5Nl8Fi88QZiZ6PLDTH3Br+fn3Y2bx8hWN+oR7mHABai/LmJTpikIADTtcZp3G
         M8ew==
X-Gm-Message-State: ACgBeo10LrDTNue44OOprC7PtyDRnStRkww88MrylC8qwcfWfGvnkE0P
        FJnZVGBFRN74b1H7Vj4W6K4=
X-Google-Smtp-Source: AA6agR7gPO94FqHwRFiiTuyLcFxRUCP+fnajsWUw4e6A10OJQojniE+QoVZ4vGdQDIo+a/I2J/JJxg==
X-Received: by 2002:a17:90a:a90:b0:200:3e3e:71b3 with SMTP id 16-20020a17090a0a9000b002003e3e71b3mr3139658pjw.106.1662627427781;
        Thu, 08 Sep 2022 01:57:07 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b0017543086eb3sm14131418plg.274.2022.09.08.01.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:57:07 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:27:02 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 08/13] ext4: factor out ext4_init_metadata_csum()
Message-ID: <20220908085702.llt3b54ep4tpeizi@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-9-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-9-yanaijie@huawei.com>
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
> Factor out ext4_init_metadata_csum(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 83 +++++++++++++++++++++++++++----------------------
>  1 file changed, 46 insertions(+), 37 deletions(-)

Looks good to me. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
