Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3390963F1DD
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 14:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiLANke (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 08:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiLANkd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 08:40:33 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82752AD993
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 05:40:31 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y17so1676932plp.3
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 05:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd4I3U3vyvAmfdHB97AWeUp1zpoHlq/ShY+7yF5P66k=;
        b=mUPAZ7TWcutI4lXN6/6etOShKkgUC0PcNp861L++DCxGg4YYp1G+PxV+IfKa+z9qKu
         Jvt81ZUOJMqkIpZQODnYIzDMB6vpbSOoiAspG0fg8dId1brwqwiTVlp1M/OB7tpATqXU
         QorzRT8CcBqGNJ6M4cznhejHI17nf2kiZOTN3Cjbes5nVsuBiNOHHcMNDclaTJL9tqwc
         XYgpckCvYKlrtjp9gLgBEeyoS56HGyzPpun8YSYTZtrykQKlkQAPgyIlvOgcAMYgEFrq
         CySoPZjblFT9vWjCWY32x/M7jxWaLSuyLbkni9o7NN31OVodf0zAp68JbOCuJ2ndjb2W
         UgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd4I3U3vyvAmfdHB97AWeUp1zpoHlq/ShY+7yF5P66k=;
        b=4ikPaaDt6INrm7+3bd/UcHrPf2W51JP5R8PanwjoAXJ98psrdpj1/heKEbRhGoMiJC
         UykRSFynoRLt6I6bV3YC87u2BpXg8CGJx+KwBD1UjTTTWN+9c6fcRa3grkm/BGa+gPW9
         hvWIUB6zTH6KEoqXg0fRWIdbOA5GA6xQpirsgka/iaar+2vf7NQ8gF3ANZ55vmB8sMOf
         Ck/hHo238kWrmrhbKqE4M0YFo0ha8Pt0rjo96ksUaXtiP1bbehR4pqLJi6ywqxuGzKOq
         jeNTb4JYHHpZRDb3LPavN/IooosKWbUivGwioD1VpNQwODTbgurLDEOkGRBP58/KeZa9
         4LTw==
X-Gm-Message-State: ANoB5pmCHNz/jq6ge4ih02ZBVhpJOTHyKYnynztx6QXkDsHG+PpCdV16
        k/Q78cHLNKBy2ACvKPMIMNPxazNg84M=
X-Google-Smtp-Source: AA0mqf5LRrL5RU0k1bcvQTmCLsp3sRvD8FNZl/zoXSnulV8aozlR8hWFGJaGdx4TQhZORQPHoFHAWA==
X-Received: by 2002:a17:90a:f104:b0:218:bd1d:37ad with SMTP id cc4-20020a17090af10400b00218bd1d37admr52059420pjb.39.1669902031069;
        Thu, 01 Dec 2022 05:40:31 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b00189422a6b8bsm3675676plr.91.2022.12.01.05.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:40:30 -0800 (PST)
Date:   Thu, 1 Dec 2022 19:10:25 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/9] ext4: Drop pointless IO submission from
 ext4_bio_write_page()
Message-ID: <20221201134025.qagwnl4ezhes46jo@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-4-jack@suse.cz>
 <20221201070655.cugep2fdrtntp67y@riteshh-domain>
 <20221201103519.n32kes6llulr2mcx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201103519.n32kes6llulr2mcx@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/12/01 11:35AM, Jan Kara wrote:
> On Thu 01-12-22 12:36:55, Ritesh Harjani (IBM) wrote:
> > On 22/11/30 05:35PM, Jan Kara wrote:
> > > We submit outstanding IO in ext4_bio_write_page() if we find a buffer we
> > > are not going to write. This is however pointless because we already
> > > handle submission of previous IO in case we detect newly added buffer
> > > head is discontiguous. So just delete the pointless IO submission call.
> >
> > Agreed. io_submit_add_bh() is anyway called at the end for submitting buffers.
> > And io_submit_add_bh() also has the logic to:
> > 1. submit a discontiguous bio
> > 2. Also submit a bio if the bio gets full (submit_and_retry label).
> >
> > Hence calling ext4_io_submit() early is not required.
> >
> > I guess the same will also hold true for at this place.
> > https://elixir.bootlin.com/linux/v6.1-rc7/source/fs/ext4/page-io.c#L524
>
> So there the submission is needed because we are OOM and are going to wait
> for some memory to free. If we have some bio accumulated, it is pinning
> pages in writeback state and memory reclaim can be waiting on them. So if
> we don't submit, it is a deadlock possibility or at least asking for
> trouble.

Aah! right. I didn't see the ret == -ENOMEM compare there.

Thanks!
-ritesh
