Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6B57B160C
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjI1Ibn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 04:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1Ibm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 04:31:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538FCAC;
        Thu, 28 Sep 2023 01:31:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c434c33ec0so97338205ad.3;
        Thu, 28 Sep 2023 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695889900; x=1696494700; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hs9I162pyAs03yza7EqNHteh8cmylaF4F7X2pBMkODM=;
        b=mKxAYlqsHudVTRaKPcHre7wcTjMZdusL0nhtmIjCrLE+B2x+TZQca/7csVvBO3NDFB
         cR2Mqc/tbt3FVc5uwytGs6r9X3E0DzOlIlfoHGEw0QkDPtqZxK9BRxNwVC6NsLWQ+mnT
         ppPgRWkXQkgkePdJK7Qgvg7UeFxXfBsrt9BS9EXVKGNokZXN1OaYTv6tXXLC/5keI0sP
         /m5PcDQodkkwQkHXKy2yV33c5bzu1b0ttWvADS9QLVUb7UPVOHLd6YXWEvfYVtjPfBoG
         e4Jr6uMV4h5OthLj8DiADquJGKm3u/ERXg4yeKESjNwmQ76/0Ny1yXnWyW0N3GkNB6mS
         XdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695889900; x=1696494700;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hs9I162pyAs03yza7EqNHteh8cmylaF4F7X2pBMkODM=;
        b=wbbqXwaRIhzYku91zaZ4ED6ry41epr79wjE2taojgHpstF8iUS2YQ8X9nt53FAzpv0
         8LsdG8RbjugSXqlhYYeV/kQue4MOvimq9fYMMGtFU/iyyKs+oyNmIOHSMEUlf5KdJQsh
         TcLmKsJydydNAFlOdacMWhpBR9Fq94I6Cmelol1gm9z4gXH3RAcw2RTJblO/rUKBCL+T
         8emLgXA2zD+tE8IfcrTmVAqgJFSWMUo1ZopZm17xmCQJa1kdwEK4b6zJy5TN9HiDlPQh
         T479brzNbaFQHLU8R3wQhPpFS/LkUWatfGI3f/kafePBxa49x1ylVzbtoN/jZzA+8bHZ
         NJNw==
X-Gm-Message-State: AOJu0Yz+OL4BceEGYN0ZlsfNUJA8s+ORyh4amU/C5d1X2vXoG12Rkz/l
        4RB4swcqETUD2dIkYYY4prl0WsKPyHU=
X-Google-Smtp-Source: AGHT+IFB6Zscj8NM61u77Y1cqKTTwVtopK/tVwO+4+NWRHGRVuvgJGhDI6HmQGloinDtHv2lZZLPlA==
X-Received: by 2002:a17:902:ea8d:b0:1c6:19da:b2a5 with SMTP id x13-20020a170902ea8d00b001c619dab2a5mr481087plb.32.1695889900154;
        Thu, 28 Sep 2023 01:31:40 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id jb22-20020a170903259600b001b81a97860asm14505674plb.27.2023.09.28.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:31:39 -0700 (PDT)
Date:   Thu, 28 Sep 2023 14:01:34 +0530
Message-Id: <87msx6r95l.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/12] ext4: make state in ext4_mb_mark_bb to be bool
In-Reply-To: <20230928160407.142069-2-shikemeng@huaweicloud.com>
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

> As state could only be either 0 or 1, just make it bool.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/ext4.h        | 2 +-
>  fs/ext4/extents.c     | 4 ++--
>  fs/ext4/fast_commit.c | 8 ++++----
>  fs/ext4/mballoc.c     | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)

Looks good to me. Thanks for the patch. 

Feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
