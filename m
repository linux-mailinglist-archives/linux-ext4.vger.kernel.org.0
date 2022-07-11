Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCEB5704D4
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jul 2022 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGKOAY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jul 2022 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKOAX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Jul 2022 10:00:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21149627E;
        Mon, 11 Jul 2022 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rcQF7iugd2cu8An1gTYADBIF1lWVn+jc8HlNL1UeLoM=; b=gVStaT9Kg0MMbppoH83xjPscGs
        IFbnv81Y2Qux27iyh2Ytl5RYRUv/rrc/FF853SfUcRswpEscsP7xj4ckdRrrmFlKVPdCkfjDFWPJV
        a6BE4mHwC98MjNV7ILSxNmudVQYo/YACzEjfygVSi9TN8tlCjTOLQQUWznoWY739TfIIQPlyYa2mY
        OsowUrkakCcxofte6qfDxJ43ipH5CUD9JiHbZadiUR5ps47qHAgjlAHSPevIEYvLqBZsGOC2JKq8i
        KFOLAViCUYEoLKdytMRp4fnJce4T+X2CknDxNQzRotjz/y2NXtCO92RF15eLW0OoWR33g46bZ3vax
        fHzP8VIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAtxM-0060dO-5n; Mon, 11 Jul 2022 14:00:12 +0000
Date:   Mon, 11 Jul 2022 15:00:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v8 07/15] mm/gup: migrate device coherent pages when
 pinning instead of failing
Message-ID: <Ysws7LOirtQ07JG/@casper.infradead.org>
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-8-alex.sierra@amd.com>
 <2c4dd559-4fa9-f874-934f-d6b674543d0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4dd559-4fa9-f874-934f-d6b674543d0f@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 11, 2022 at 03:35:42PM +0200, David Hildenbrand wrote:
> > +		/*
> > +		 * Device coherent pages are managed by a driver and should not
> > +		 * be pinned indefinitely as it prevents the driver moving the
> > +		 * page. So when trying to pin with FOLL_LONGTERM instead try
> > +		 * to migrate the page out of device memory.
> > +		 */
> > +		if (folio_is_device_coherent(folio)) {
> > +			WARN_ON_ONCE(PageCompound(&folio->page));
> 
> Maybe that belongs into migrate_device_page()?

... and should be simply WARN_ON_ONCE(folio_test_large(folio)).
No need to go converting it back into a page in order to test things
that can't possibly be true.
