Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15995B17F5
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIHJG0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiIHJGZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:06:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB1A024B
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:06:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm11so17142277plb.13
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/qxgNeQTTfDgcvL0EKTWk+U8QhzpgFCJdugMGsDjXlw=;
        b=npGwxfxW7UWy8M0ka7LNJzaUAdJQy/CiQ2h5bYRPxvXMoeEHAhWmwJr06BrBs7e6QY
         GsGSepgwOXlHmgd3E0DbL6mQrXwXyEkfCVtRr91+Kg1PSXsNmzTqvN7s+ljSWOxUPwNG
         j6DPJsTdO/V//G6hOcPqNRB175weSlz26oUcSMx2B0q7zjRm9FV+PifCenPzm1muY+AI
         PauXAX1TGHyzUURZwvFRbQd1HVnHRb7Sd8UkQ/W3z7F6S4elLGm/Px3JuA24MxihV87h
         FYqUI2LKEZA1N91GBmo1+QAv6BebKfcwYA1stCHfhumX5A8o5PRbImrEf1DieMa1UEhU
         2vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/qxgNeQTTfDgcvL0EKTWk+U8QhzpgFCJdugMGsDjXlw=;
        b=a3+bdJzIWgjLV9lJCkMliqrW1Ci8HBnfuyUdfpukvWbBdpCRd5SHGl7XHNu5KpTGKt
         0XJBWFKBsEpDfm8nIJOOKNCcOUTDja35Qzg6Gt0ES5MX+ETrnXr+rcUOLgnUPOieoK55
         kV2rqwmcymDxSPlNmOXQPemiqfsEYk/xiJ9pBnIlr51gFFkjlPU96bWLtXci6aXVJiPp
         hBL3azIuDz/tiKw7tcVdrrXWoiwJXTSHU/jXhzDAiARzRIXs/I8dg/Br0Wu6Y2Oe+plR
         gZe61ISX1u+1IjGktYs4dO0v8OhMozFg41P823/gQXEdjuphvZaeOfmZpMMxpQ1pU4BP
         9RSw==
X-Gm-Message-State: ACgBeo2iFE5XiYBSd4C+GxAxDehfrUmGP1p+sFedYDTql/ItsfksF3z5
        pxX/XEm9zdga4X1b8kWIgJY=
X-Google-Smtp-Source: AA6agR7UbnuTH+ekxwk1VjRI5zTESOFZGa43jX9k6kTgAPsIxh4/9E0oL+x6mYseK/oLQjlvgt/2PA==
X-Received: by 2002:a17:90b:3a8e:b0:200:5585:4099 with SMTP id om14-20020a17090b3a8e00b0020055854099mr3256662pjb.70.1662627983942;
        Thu, 08 Sep 2022 02:06:23 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id w20-20020a656954000000b0043093ec77ddsm12007325pgq.29.2022.09.08.02.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:06:23 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:36:18 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 13/13] ext4: factor out ext4_journal_data_mode_check()
Message-ID: <20220908090618.k2q5ocifngd5kz4j@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-14-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-14-yanaijie@huawei.com>
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
> Factor out ext4_journal_data_mode_check(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara<jack@suse.cz>
> ---
>  fs/ext4/super.c | 60 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)

Looks good to me. Thanks overall for the nice refactoring.
Function __ext4_fill_super() indeed looks a lot better now :)

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

