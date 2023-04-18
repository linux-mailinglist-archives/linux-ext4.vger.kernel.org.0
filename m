Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBAE6E63AB
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Apr 2023 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjDRMm2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Apr 2023 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjDRMm1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Apr 2023 08:42:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603A31447C
        for <linux-ext4@vger.kernel.org>; Tue, 18 Apr 2023 05:42:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kt6so34649939ejb.0
        for <linux-ext4@vger.kernel.org>; Tue, 18 Apr 2023 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1681821735; x=1684413735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4zZaPJzshEnDWklD8XmiXWEZ2laXp6xq95Vi3BXmH3M=;
        b=Yh8+fClk+o4D4gN8FJFTMYOCEQykSAR2N3lXlhxFRH819DbCxelSwny3X6namwWRKU
         GxdHB/kxfY5kKPhXMtKtAtd/y/y32MzJB8S7woLN7Gss/q2DnFE02D3CbBe2PY+vXqyR
         0xkkpGaSKQIswmlxjMdxhpyCvsd/ciuJaVhWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681821735; x=1684413735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zZaPJzshEnDWklD8XmiXWEZ2laXp6xq95Vi3BXmH3M=;
        b=JMUQPyKtoN6RTIOc84aylQGViBISKke55Pd2laDx0jyuddYVkYwoIcw+xo8flZjbO0
         gzFuqSv4+6S9oc5UG63ndSwrnn1JVR4t5O+eP39bqdFv6yO7pQ6CKYB9Ic+oLVuY2Jwu
         iFRzDAG1K2tny9GP+NiTEgFgG97CEa6Q8ao9+3aQgixb20zmktKPlPOqBYpyl773EWae
         zy63k3sq3Df5vZWSIfEK1J08wavlRV9sjzxOqaiWJn8I0wkgzy0VFQML3oqGNB0ox68b
         KpcuYb6X9gctbMreZw5fq3YTow/RGYYM27UHLqxf0bSMLpKRFhzkEAo6tT95DCCeYj8h
         j+Rg==
X-Gm-Message-State: AAQBX9eLt8LFUD78htfx/3eNssD5xH08kSydscGPtHijBKpm3DgTwf8p
        CVzMEc7v4r0fCzrAxdjyD17L/K6Awl6ptp7VFkpZpCSY4kR2JgQ0W1cZOw==
X-Google-Smtp-Source: AKy350aIbPYzblpBDLhTaHf97THqFbwgAZLWaT7+qiwAtSmr5pAzCF+5AYXPjoVDIlMF1Xfcxyo5b02deZsR10nPfQ4=
X-Received: by 2002:a17:907:3f24:b0:94f:19b5:bafd with SMTP id
 hq36-20020a1709073f2400b0094f19b5bafdmr12536182ejc.42.1681821734894; Tue, 18
 Apr 2023 05:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230307172015.54911-2-axboe@kernel.dk> <20230412134057.381941-1-bschubert@ddn.com>
 <CAJfpegt_ZCVodOhQCzF9OqKnCr65mKax0Gu4OTN8M51zP+8TcA@mail.gmail.com>
 <ZDjggMCGautPUDpW@infradead.org> <20230414153612.GB360881@frogsfrogsfrogs> <cfeade24-81fc-ab73-1fd9-89f12a402486@kernel.dk>
In-Reply-To: <cfeade24-81fc-ab73-1fd9-89f12a402486@kernel.dk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Apr 2023 14:42:03 +0200
Message-ID: <CAJfpegvv-SPJRjWrR_+JY-H=xmYq0pnTfAtj-N8kG7AnQvWd=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add FMODE_DIO_PARALLEL_WRITE flag
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bernd Schubert <bschubert@ddn.com>, io-uring@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 15 Apr 2023 at 15:15, Jens Axboe <axboe@kernel.dk> wrote:

> Yep, that is pretty much it. If all writes to that inode are serialized
> by a lock on the fs side, then we'll get a lot of contention on that
> mutex. And since, originally, nothing supported async writes, everything
> would get punted to the io-wq workers. io_uring added per-inode hashing
> for this, so that any punt to io-wq of a write would get serialized.
>
> IOW, it's an efficiency thing, not a correctness thing.

We could still get a performance regression if the majority of writes
still trigger the exclusive locking.  The questions are:

 - how often does that happen in real life?
 - how bad the performance regression would be?

Without first attempting to answer those questions, I'd be reluctant
to add  FMODE_DIO_PARALLEL_WRITE to fuse.

Thanks,
Miklos
