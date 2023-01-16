Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1431066CE8C
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jan 2023 19:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjAPSPP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Jan 2023 13:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjAPSO2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Jan 2023 13:14:28 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38AB1C335
        for <linux-ext4@vger.kernel.org>; Mon, 16 Jan 2023 10:01:14 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id x5so1626912qti.3
        for <linux-ext4@vger.kernel.org>; Mon, 16 Jan 2023 10:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=hC8rifHiuHXCPgttcmOOf/xO+1ZeeDOeIZfW9Ym8Ory+CkzNJPkrfO/C3JXy2EE1LL
         2kTaAysayLbTpr+7RDLLrKq0FCECx/EKRPZa3mKY+K67nyLJZ8f7PA4gCRWG73mV4Yn4
         5cdNgXBpvhk8M9iRXw8+R8fW3tOu/c3Ashp10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=zUFcAzUBvWoo9TvrQcCA6zvFeeZGud0+Itk1WKBUclOYUCuRVJINkASUk6W+4p17zF
         s9W0ARW4lW80zgqLhYYzzzq943JToqeG/ZQxF/bMNMIb5xzqaufaopH+hf8JSt+SgIE7
         i+nSS83K68uO8gJO8idWDqmwfDQCu0KXl6qv6v+6XhRzah44LLBuHKPcUbu7AsNxIKPg
         Z4kum4r+TcK72p7ujZPiJQ9ymsyIababGpsDeS4KRaF5hJ9I5tD9rS06VutnHI7dex4T
         Yz2DrjNUp9OFyDcADp8Tm5v5SonGjddBkYavgWgWWPgzVh9XxCZg5Vlpi/PKnZlcHVoq
         UOxQ==
X-Gm-Message-State: AFqh2kqS/yfyugm4sZAbtj74XbfshYGvboDGxfTBaI8K4DlF69roNi4d
        DHCBqabEQl7+LjC5xwr6GFeYw0pUPm1ajUma
X-Google-Smtp-Source: AMrXdXt89U6MsDl55CMFvT2lp98p4iXPlayM3bOPkUVbT1OTQAKr1ojYLIZW4HCV7E91vsD1G0G21g==
X-Received: by 2002:a05:622a:5144:b0:3a5:ad81:8aff with SMTP id ew4-20020a05622a514400b003a5ad818affmr143486765qtb.55.1673892073841;
        Mon, 16 Jan 2023 10:01:13 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id q30-20020a37f71e000000b006ec62032d3dsm7056594qkj.30.2023.01.16.10.01.09
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:01:09 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id x5so1626668qti.3
        for <linux-ext4@vger.kernel.org>; Mon, 16 Jan 2023 10:01:09 -0800 (PST)
X-Received: by 2002:a05:622a:250f:b0:3b2:d164:a89b with SMTP id
 cm15-20020a05622a250f00b003b2d164a89bmr364175qtb.452.1673892068650; Mon, 16
 Jan 2023 10:01:08 -0800 (PST)
MIME-Version: 1.0
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jan 2023 10:00:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
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

[ Back from travel, so trying to make sense of this series.. ]

On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
>
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms. It's done on v6.2-rc2.

Ugh. I hate how this adds random patterns like

        if (timeout == MAX_SCHEDULE_TIMEOUT)
                sdt_might_sleep_strong(NULL);
        else
                sdt_might_sleep_strong_timeout(NULL);
   ...
        sdt_might_sleep_finish();

to various places, it seems so very odd and unmaintainable.

I also recall this giving a fair amount of false positives, are they all fixed?

Anyway, I'd really like the lockdep people to comment and be involved.
We did have a fairly recent case of "lockdep doesn't track page lock
dependencies because it fundamentally cannot" issue, so DEPT might fix
those kinds of missing dependency analysis. See

    https://lore.kernel.org/lkml/00000000000060d41f05f139aa44@google.com/

for some context to that one, but at teh same time I would *really*
want the lockdep people more involved and acking this work.

Maybe I missed the email where you reported on things DEPT has found
(and on the lack of false positives)?

               Linus
