Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949DC757183
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jul 2023 03:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGRB5Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jul 2023 21:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGRB5X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jul 2023 21:57:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9706E6C;
        Mon, 17 Jul 2023 18:57:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b89d47ffb6so29112075ad.2;
        Mon, 17 Jul 2023 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689645442; x=1692237442;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zpwYvBryKekjodYDIsqD2F2J1FH8FhSMhj0KMFUDpts=;
        b=PyC5itYPYjFB8EUfq/sZ8PT9+t0hU4PHacCGlqauyl/VWXiFOMEgNtExFuGt/s04SQ
         uW9fBR15QWzE5Ib5xcf9D7Pej7xuslfpVWT10KmmNwtnK9f7LbXoXSfBLLs5NnHwYUo+
         8ub7C0ZkfkGF2SU2lyke1UwOxbAGU7PM9vj3TQYrjzB0POW4LPSNh5eFKTFsxFCSi5yH
         bL+PKTQsNUK3f38N+oBc7gNZU3fx0moALggKAqvEu0R5z7v5scuvBW8XBK6vmqvU0ygd
         14erZcpwJ4k23QQbN3QED1AYGKsARnFGQ+HQxDs46nOz7weQKipxurhI7+R7FvgsTrWz
         OGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689645442; x=1692237442;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpwYvBryKekjodYDIsqD2F2J1FH8FhSMhj0KMFUDpts=;
        b=EC+23SZrkeIdjBf2kikDMzwpoNIR01CzNUv/+bFXOXSaGOfQ+FYCwmy9vBx3XgN59U
         H6aeDeFuH2jeOoGUoVHlcGEJK7IJaZwN1/byxdBazamkkbI2jaacMeK08JXbl7brMXy1
         V0UhuEhd2CKsVCB7Uq+vFLQn6Pgrd0b0AlYaVoVdbZwgso0dGc1Y+Ddiut03PJVzpWaJ
         XKEefXQ+CoptrtUxyryABE/DmF9z7dm1rF84i5KkRS6dzKCjHMe/9ELjb2PreziKoHkB
         IpH/zUhxIzajz/+JyAFvjE7B92adYgBqEJ+r0atk7nkphDfHIZ4I63cWxFQ+axNKMC/N
         AfCA==
X-Gm-Message-State: ABy/qLZKSV0wHxEDynEl7/oG0QtsoFdDwHWsHZSRRlaXye9X6ODxa9vz
        /3J7+H+0CUBIUqOKK6xbsyRrG46tJQ0=
X-Google-Smtp-Source: APBJJlFgGWmuKWn5GFBhQDlQxlq4jLT9kF22MJBnNKr2ToSHiTCslUYnwdKsvmsmZBsYB3+p4ihjLA==
X-Received: by 2002:a17:903:244c:b0:1ba:ff36:e0d8 with SMTP id l12-20020a170903244c00b001baff36e0d8mr13122916pls.61.1689645442038;
        Mon, 17 Jul 2023 18:57:22 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001b882880550sm487420plb.282.2023.07.17.18.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 18:57:21 -0700 (PDT)
Date:   Tue, 18 Jul 2023 07:27:16 +0530
Message-Id: <87h6q2nfr7.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: next: kernel BUG at fs/ext4/mballoc.c:4369!
In-Reply-To: <20230717213424.GB3842864@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Mon, Jul 17, 2023 at 08:04:54PM +0530, Ritesh Harjani wrote:
>> 
>> These can basically trigger in extremely low memory space and only when
>> such ranges exist in the PA rbtree. Hence, I guess it is a little hard
>> to tigger race.
>
> Ritesh, thanks for looking into this!
>
> Naresh, how easy is it for you to trigger the BUG when using LTP?  I
> did two xfstests runs using "gce-xfstests -c ext2/default -g auto",
> one on the ext4 dev branch, and one on linux-next 20230717, and I
> wasn't able to trigger the BUG.
>
> If you can trivially trigger it using LTP (perhaps with a low memory
> configuration in your test setup?), that would be useful to know.

Hi Ted,

Sorry for wrong choice of words. By low memory space I meant low disk
space i.e. ENOSPC test (fs_fill). I reproduced it like this - 

root@ubuntu:/opt/ltp# while [ 1 ]; do ./runltp -s fs_fill; sleep 1; done

For me it took around ~1-2 hours for it to reproduce when I tried again.
I am hoping if we run generic/269 (fsstress ENOSPC) in a while loop like
this maybe it can hit this bug. But I didn't give it a shot.

-ritesh
