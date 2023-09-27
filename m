Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0C37B029D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 13:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjI0LTa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 07:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjI0LT3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 07:19:29 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4309F3;
        Wed, 27 Sep 2023 04:19:28 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c4d625da40so4985805a34.1;
        Wed, 27 Sep 2023 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695813567; x=1696418367; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7NrmC5pcFzp/76ziw8W5fSNzwvgLppzIHB7W1pRJs0A=;
        b=ZIGUe8uZwAkEpydsBO+KnIXGnzxGvp+YYsFbm9t1R/wdjlSa/Sip7AdEiIRC4445vs
         EIa+LtA/V6bq2O/KyHLAwlGURYhrYRqo6/NHRPvLTYpoTcxCyv8Z0bW9fkdNMCMxEH3K
         KSmWQJq7qyOAeV/oHOqJlxt6Yi5Hr64CMHsJ6TO6tlH8KMsyy4nQLXxImXotsO5T5wqv
         cUxmVgL4Cruoc7jUgvU2YNG67169EZOXaqRxsTc3QctQGbNQdLKJORfA5CNMbi0edXYN
         CyXvRuyl1r9FBUJWO01jBbAYy11263IbOIuZ4vePj2Klb6Chec92DcaUlYG30cxh2Idg
         Xb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813567; x=1696418367;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NrmC5pcFzp/76ziw8W5fSNzwvgLppzIHB7W1pRJs0A=;
        b=flWnEy3tjh52GCvt+NOplxuVhcTGwNsoy2P9YTwyxP45ejrPckdkE4emp/Y6DHNenF
         pRLT1p0U1JIsaXx1b0/FWB2W00hWVthC9yVQI8at/A3JElGslwAVgjMWw3mnB/JPHie4
         k+TsOuBRIEfAKrbNlXJJ2InTFuz4G5bFxQHoFnt/bgEn+y3TNvqXLiKT03j6F1l0LyDf
         odUwTNRQOrDRCVMbgUXVihNCQMAnWX2rY/OlnXW4KK2VJe8yX0YVBTfDYad3THjSna/q
         BqLv8e+Pnvwg4rxh2f6bJCkNw+nKl/G8NlN9914gzl0WBUGepzEuBx0GrZPBN+NcNHw3
         hViw==
X-Gm-Message-State: AOJu0YwqjtXBAs4erJ9J5xlt5vcKZQnTd07i6N1B4EC04LrMwSYFXitD
        xuYc+YjPxEgmZ5wSH8Rb632n6Fej/KY=
X-Google-Smtp-Source: AGHT+IGB/qcWlekUd3z2tbAcAdfdVeXqay+2WInndnfjQ06GGrks/A/9+2VWoAayQ3/CNEIdNEZTgQ==
X-Received: by 2002:a9d:7f8c:0:b0:6b7:518a:1672 with SMTP id t12-20020a9d7f8c000000b006b7518a1672mr1679826otp.34.1695813567403;
        Wed, 27 Sep 2023 04:19:27 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id i13-20020aa78d8d000000b00689f8dc26c2sm11499968pfr.133.2023.09.27.04.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:19:26 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:49:23 +0530
Message-Id: <87fs2zg8xw.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/12] ext4: call ext4_mb_mark_context in ext4_group_add_blocks()
In-Reply-To: <20230919201532.310085-10-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Call ext4_mb_mark_context in ext4_group_add_blocks() to remove repeat code.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 82 ++++++-----------------------------------------
>  1 file changed, 10 insertions(+), 72 deletions(-)
>

Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
