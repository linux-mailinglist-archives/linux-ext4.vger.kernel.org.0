Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8DA7B0284
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 13:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjI0LO2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjI0LO1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 07:14:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A85FF3;
        Wed, 27 Sep 2023 04:14:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c47309a8ccso88941535ad.1;
        Wed, 27 Sep 2023 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695813265; x=1696418065; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MTO5YKzNZHo5vmVl48tEQLfQbpC8a1F4p23QGGnmvtw=;
        b=H6imsNiHW5QsM7E7sh1Isl/LAcgWVPerN1aKZdnDfOuKmVSy+gxyb+6fVIf6teNLg6
         hP9a1CRHzb3N5BPZiFgZbb2nLj3OX+mp6tftNUQ9x9Hs2ldXHrRyT9GMAck0rKgC9Eea
         GvEgRSvuwbjtqmkmyQbX1DxUQBisVwkDj5yQ+0Tkw8b6pHnWfLrgEW+PdtU/EMr2SuF8
         nWVPNsgnD4Mr1/LyBpP0TYZrmT2GXYq5nhjCalWKwiL6BAdLoPAqtCnSuqCfFDHe2P3A
         edbYbC6maPmgWuRhgh4MHEVZlSABgXvjEjNqBeCFBorTs8Ow6Rwfo8AYhVlPwB2MALUv
         ZvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813265; x=1696418065;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTO5YKzNZHo5vmVl48tEQLfQbpC8a1F4p23QGGnmvtw=;
        b=ZFygn0uw2xeeq5o6kS5HNwgz7cjdapv26Ma9/A780UPj0CYro7WvfqqDYzSeYjYwJS
         WCpAfWF5XIWGfVh1FqnS8hM4kFD3nd1cF8hUuoJCCs+uM5/yb/XFTwDKaG3w/FknuXxA
         /QYrBLHyUQ6P6G32SkPAjPRqn/b99PGazZanIn0xVOQgerYuHdGs9x5dDoDwvjaMVqMF
         9qGKDl8SGIdEeESIn6Qy3HQZVhiit6nQrLON/FEZrnelypCsimaePjamDLxmV3zGEqmW
         UuoRKTHJnR2ej+4/ji5ZXTKKqvZsc/G2J1CtSMh/M+W/kJBOgZst69yj1SbSpiqlXgUO
         YFGw==
X-Gm-Message-State: AOJu0YwHR7Uu3VDRSAWbyowwEGc82YiWHNGfhmuqS5DsKtTmT2/QtjGl
        VHNU7fl5h6kie2PSnNrsqRPuzuWfjLw=
X-Google-Smtp-Source: AGHT+IHXZRJr105D5E8ZdC2TY/8Wpv7fNdWYNfpLG7kveBOyZl96AI5Y5sd2rNRL4a6ycIMv7BjeJg==
X-Received: by 2002:a17:903:244d:b0:1bc:3908:14d with SMTP id l13-20020a170903244d00b001bc3908014dmr9847214pls.2.1695813264907;
        Wed, 27 Sep 2023 04:14:24 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id jk21-20020a170903331500b001b9be3b94d3sm7547060plb.140.2023.09.27.04.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:14:24 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:44:20 +0530
Message-Id: <87lecrg96b.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/12] ext4: call ext4_mb_mark_context in ext4_mb_clear_bb
In-Reply-To: <20230919201532.310085-8-shikemeng@huaweicloud.com>
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

> Call ext4_mb_mark_context in ext4_mb_clear_bb to remove repeat code.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 69 +++++++----------------------------------------
>  1 file changed, 10 insertions(+), 59 deletions(-)

Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
