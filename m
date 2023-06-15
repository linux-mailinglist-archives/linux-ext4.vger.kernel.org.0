Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F13732117
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 22:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjFOUtp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 16:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFOUto (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 16:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A7199
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686862145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKMjMj3FplZLOT+91I/4pBUGTAnLqLsMd/PZxjoHeJI=;
        b=VY/RFTEH78npZ2CTBhF5QX5iCnMcei+jL8WXQQqyKKEyoDBcDVBUqSXm6Qtt6BcdnS0WJR
        kiXaSaQxKJOX6Ft/YrHFF6U9uKpCjmDP/WzrLexJijqkFdKoanwh90RmgPsqqrJ5qbLl3H
        Qotg2eKDcq/F0k7Enkev0BB/7FoQXaE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-3VlVldJ7Nh6QunpWmnK9ng-1; Thu, 15 Jun 2023 16:49:01 -0400
X-MC-Unique: 3VlVldJ7Nh6QunpWmnK9ng-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62849c5e9f0so128246d6.1
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 13:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686862141; x=1689454141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKMjMj3FplZLOT+91I/4pBUGTAnLqLsMd/PZxjoHeJI=;
        b=ISqYp+QwiNGBTrr8OGu2JrFco6aMvSqukeo8zWfdtwP8UI80S8KBo2R6nwFwffeqGm
         TciOEyyccy0+IZFe0hpPvLbmiC7zNHg43RVd6y9wRkaZtFinmGExmtC7Eu5kO73nwu1Y
         z+N3bqssq7YRPgkGq2lvWg3BwbfLF7/vpieOPhY9iP3ZZKoaPX1q5LnQXlftqPnzZW7i
         UdK31vcH/kZhvi66rUweU8pr3YHkInFZLRRiz3s3G2rMpkoWwqq9hk+SE7e3KlMpXunE
         LRRReSuxS91+/Yk7Gt3JEtPDN3tf+vlcWjX1nEDKR8mKtEd4Nz9Jlawrxg8dcmBG+hCd
         ZH6A==
X-Gm-Message-State: AC+VfDweqPll1pef1YLeIyBUMdInxrQMB8zTurtJAohPCYxX2X84qKvg
        LCI5OjA6V3VTQJXjI5318/6x5jLrQWaoA4lrmI/1LG19zXz0T8xo9BE8rE9huoozQ5CRqUDUJPh
        Me2uECRc3rKoORyCSnXttvw==
X-Received: by 2002:a05:6214:411c:b0:62d:f62b:907 with SMTP id kc28-20020a056214411c00b0062df62b0907mr205907qvb.0.1686862140897;
        Thu, 15 Jun 2023 13:49:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67Q0T7UNcg441S5K48ufQ95OaInqX07S7iw3hjgHEcSdnXpq3izlYE7fKD1k9BhKtWSVJMmA==
X-Received: by 2002:a05:6214:411c:b0:62d:f62b:907 with SMTP id kc28-20020a056214411c00b0062df62b0907mr205893qvb.0.1686862140601;
        Thu, 15 Jun 2023 13:49:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id d24-20020a05620a159800b0074a6c29df4dsm1117082qkk.119.2023.06.15.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 13:48:59 -0700 (PDT)
Date:   Thu, 15 Jun 2023 16:48:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        david@redhat.com, Felix.Kuehling@amd.com, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hch@lst.de, jglisse@redhat.com,
        apopple@nvidia.com, akpm@linux-foundation.org
Subject: Re: [PATCH v9 02/14] mm: move page zone helpers from mm.h to mmzone.h
Message-ID: <ZIt5Oho3enLFs+sv@x1n>
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-3-alex.sierra@amd.com>
 <ZItneGX+sqg7WApF@x1n>
 <ZItxXny9kRDq/ryf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZItxXny9kRDq/ryf@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 15, 2023 at 09:15:26PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 15, 2023 at 03:33:12PM -0400, Peter Xu wrote:
> > My question is whether page_zonenum() is ready for taking all kinds of tail
> > pages?
> > 
> > Zone device tail pages all look fine, per memmap_init_zone_device().  The
> > question was other kinds of usual compound pages, like either thp or
> > hugetlb.  IIUC page->flags can be uninitialized for those tail pages.
> 
> I don't think that's true.  It's my understanding that page->flags is
> initialised for all pages in memmap at boot / hotplug / delayed-init
> time.  So you can check things like zone, node, etc on literally any
> page.  Contrariwise, those flags are not available in tail pages for
> use by the entity that has allocated a compound page / large folio.

Oh so the zone mask is special.  Fair enough.

> 
> Also, I don't believe zone device pages support compound allocation.
> I think they're always allocated as order-0.

Totally not familiar with zone device pages, but memmap_init_zone_device()
has pfns_per_compound which can be >1.  From there, memmap_init_compound()
does go ahead and setup pages as compound ones.

Thanks!

-- 
Peter Xu

