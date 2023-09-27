Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173E27B0129
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 11:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjI0J6n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjI0J6m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 05:58:42 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A191A7;
        Wed, 27 Sep 2023 02:58:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c4bf619b57so5293875a34.1;
        Wed, 27 Sep 2023 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695808719; x=1696413519; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3hPVi5a4oOzuPKosm3U0zhfS96+9QHisSYbM2I9FqZU=;
        b=nA6p4KXjIDpL6M/ke3LTf7wLwrXVYrsOMWT4W787KGHcsJ16dBvNXxSK9dMwJinms5
         LRqWej37w8DLzsqlPTAoRSBoyHjpSbAyVDe6u0wkoyrJ8zPa5pSpqJpOrllM/xK5cR5k
         bPhm3NrH8I5xjvCijaBV3cuCJ4GpymI5iaiZiIymsgN0oLDkmNlQTjr0sye39Atz+dZC
         Zi3hsTHHz9xXJR8rcGsWJ1GkKAGmdmQK7SwgwuyD81mbMmEMf2ioV/z8N5N+NTwvt6gW
         j+nvCLsztb/FQBAvBb05zhE74c4SMis7lYKwREQyHrp3usF8ZRPwXNAkd4xxCH1C2T8b
         a8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695808719; x=1696413519;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hPVi5a4oOzuPKosm3U0zhfS96+9QHisSYbM2I9FqZU=;
        b=KU6QtYHMeQOMRN4IChWW0skQFzsmNgW0DLFnuM2F13BCL4J4vABvJtxhkc0UAia+J6
         4yEgti1NctwhhwQZvdi0F/4AglDiWtMwRKS9VlcWAsWfeX8g3KPQ36GNqZ7itkOgDhpZ
         R4E3Q+fmdUqNTxxiohofNvkZg8J3zowsoUFVZ8Yj8/Pu9mQbH8UVT9J0HXPoPJbaKxbN
         O0GeRXbFFdhRFELPFs8hbDPBPnTg3xVw1m722U0pfyZhpr58dQD4cxBJ4pN+AaIV0oGn
         2kDufGPbfd3RFkiTodSnroItgxqSAUmaw1HSVJal8sEdqhvx9LNmOGrQB6EkSOA+yanS
         ueHQ==
X-Gm-Message-State: AOJu0YzVsi3RKHBUGhzphxAwziBqC5u6kUnFp1yV+L/asOf8A4diYe4m
        DQEnIyLa6ZvclRNIX7fIyhBomCSNSQk=
X-Google-Smtp-Source: AGHT+IGH7RCJJOQp1ERidIU9DFRTE1anMUQoFX2bQG6o/4lQXQIqj9SKcdF5xLSoba4UeYuC1yAAsA==
X-Received: by 2002:a9d:734b:0:b0:6c4:e80d:5d8d with SMTP id l11-20020a9d734b000000b006c4e80d5d8dmr1649986otk.32.1695808718929;
        Wed, 27 Sep 2023 02:58:38 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id t14-20020a056a0021ce00b0068bc461b68fsm11134465pfj.204.2023.09.27.02.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:58:38 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:28:34 +0530
Message-Id: <87r0mkey45.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/12] ext4: call ext4_mb_mark_context in ext4_mb_mark_diskspace_used
In-Reply-To: <20230919201532.310085-6-shikemeng@huaweicloud.com>
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

> call ext4_mb_mark_context in ext4_mb_mark_diskspace_used to:
> 1. remove repeat code to normally update bitmap and group descriptor
> on disk.
> 2. call ext4_mb_mark_context instead of only setting bits in block bitmap
> to fix the bitmap. Function ext4_mb_mark_context will also update
> checksum of bitmap and other counter along with the bit change to keep
> the cosistent with bit change or block bitmap will be marked corrupted as
> checksum of bitmap is in inconsistent state.
>

Rewording point 2 to... 
Now that we have a common API for marking blocks inuse/free in block
bitmap, use that instead of open coding it in function
ext4_mb_mark_diskspace_used(). The current code was not updating
checksum and other counters. ext4_mb_mark_context() should fix these
consistency problems.


Also I now see why you have used "int" (ext4_grpblk_t) for len in
ext4_mb_mark_context(). The reason is because this is "cluster len" which
is defined as ext4_grpblk_t in "struct ext4_free_extent"

I think by default we anyway have 8192 blocks per block group. So it
should be ok for now. I anyway think the usage of blocks and cluster (&
their data type) is confusing at different places which needs an auditing/cleanup.

This patch looks good to me. Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
