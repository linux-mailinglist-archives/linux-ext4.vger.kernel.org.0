Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555CB68F224
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Feb 2023 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjBHPir (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Feb 2023 10:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjBHPiq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Feb 2023 10:38:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D0148584
        for <linux-ext4@vger.kernel.org>; Wed,  8 Feb 2023 07:38:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o18so17186483wrj.3
        for <linux-ext4@vger.kernel.org>; Wed, 08 Feb 2023 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ldS/9lgbAryUlzaEqo027FaU3ababbmuo6baFKv9sM=;
        b=GMKcvLbWgYYOV8D3gsJ1NLFPsx/+rb4QbvXLP5DPdEX/7OtnyJYn0eSEvrkIK19zWo
         BjCy3lR5nl3V/D+qx2u/4QrQu2ABYM65YPAlg3ZH+V2JzoEt7pgPNZH7lJ1yMN2zh5qx
         oiCs2/g3lnxsmmeEgvnZSDKkH0EEM32NJxdQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ldS/9lgbAryUlzaEqo027FaU3ababbmuo6baFKv9sM=;
        b=1h3m5aqivZTVVxWkTP3fdfohEdu8UXBQ/CUTNs4JK+H5IECP9/2Cq8bhpGRbFZFOur
         1c2n9rWU+QT2qRAnPofmDbVzLdw3j8Pgo8OZicLPa/36M0peMPQyPdwb8XscI47Y6zGi
         AnB4W9+M20x88ZvSpcPSli6GIIrETQYxjg4NnskjzZwwQQDKrzQutGwTqDGTvOcGSVH/
         XqTIe8nrOSNzsATlGPUZJwe9EPY79t9Q1A4TNtAfPNk/gPuc2smJCGL/ZOH1FB8GeB1i
         nn1LDZpCWjyVfRnhpGECc9Y2rJonYhUPetbzJAjcKCfkBucJQFJR9cFZkkVFeYlC96nk
         /1WQ==
X-Gm-Message-State: AO0yUKVga9k7eYZDhIWAac5rv/gYz1qNQyv+wEIdPHCeAm3v/A3MRrG+
        G8q3+CrJ9NRVvGimgXhvopYSCH1eALTOe1QO+fJW7g==
X-Google-Smtp-Source: AK7set9wOIIledAM+swzN7yqnjLB4V2d1LUzlu4L3HNgfYqhu48xDkzDgkwlr5dV8Rji93JA7JtvRg==
X-Received: by 2002:a05:6000:551:b0:2c4:5d8:8250 with SMTP id b17-20020a056000055100b002c405d88250mr1651965wrf.23.1675870723645;
        Wed, 08 Feb 2023 07:38:43 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b002bfb8f829eesm14756052wry.71.2023.02.08.07.38.42
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 07:38:42 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id l12so12119515edb.0
        for <linux-ext4@vger.kernel.org>; Wed, 08 Feb 2023 07:38:42 -0800 (PST)
X-Received: by 2002:a50:d0db:0:b0:4a2:6562:f664 with SMTP id
 g27-20020a50d0db000000b004a26562f664mr1769251edf.5.1675870722462; Wed, 08 Feb
 2023 07:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20230208062107.199831-1-ebiggers@kernel.org>
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Feb 2023 07:38:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=5AqsG_1Td_bOMpFE8odKhsT9Mb3s4Wp+qq_X1Z6gqQ@mail.gmail.com>
Message-ID: <CAHk-=wg=5AqsG_1Td_bOMpFE8odKhsT9Mb3s4Wp+qq_X1Z6gqQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add the test_dummy_encryption key on-demand
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 7, 2023 at 10:21 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> I was going back and forth between this solution and instead having ext4
> and f2fs call fscrypt_destroy_keyring() on ->fill_super failure.  (Or
> using Linus's suggestion of adding the test dummy key as the very last
> step of ->fill_super.)  It does seem ideal to add the key at mount time,
> but I ended up going with this solution instead because it reduces the
> number of things the individual filesystems have to handle.

Well, the diffstat certainly looks nice:

>  8 files changed, 34 insertions(+), 51 deletions(-)

with that

>  fs/super.c                  |  1 -

removing the offending line that made Dan's static detection tool so
unhappy, so this all looks lovely to me.

Thanks,
             Linus
