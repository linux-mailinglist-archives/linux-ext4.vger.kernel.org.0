Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469E4578BCD
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Jul 2022 22:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiGRUcl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Jul 2022 16:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiGRUck (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Jul 2022 16:32:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113C32ED4A;
        Mon, 18 Jul 2022 13:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A99E2B817A9;
        Mon, 18 Jul 2022 20:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1B2C341C0;
        Mon, 18 Jul 2022 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658176356;
        bh=tVhY1ahFLjj6vTGPep6MAG7OR+bCm6MQ/EAA9xTV0WI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0dw4cFB42gg7zj8HiQLc7D+Npd1QELSrzQuuDGx8jBrtkX5XSY6IdxrkIDJPU2Cda
         tAqDaeoI64/mIBlrH5Ua4Ub73MSKc4+PLVOj1xGe4Ppk7yJT8pAdAbIMDrWigRp2+7
         0rgoEva+ImYH2rnIxXKDMOVONVzb6MdwtWcG4A/A=
Date:   Mon, 18 Jul 2022 13:32:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v9 06/14] mm/gup: migrate device coherent pages when
 pinning instead of failing
Message-Id: <20220718133235.4fdbd6ec303219e5a3ba49cf@linux-foundation.org>
In-Reply-To: <225554c2-9174-555e-ddc0-df95c39211bc@redhat.com>
References: <20220715150521.18165-1-alex.sierra@amd.com>
        <20220715150521.18165-7-alex.sierra@amd.com>
        <225554c2-9174-555e-ddc0-df95c39211bc@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 18 Jul 2022 12:56:29 +0200 David Hildenbrand <david@redhat.com> wrote:

> >  		/*
> >  		 * Try to move out any movable page before pinning the range.
> >  		 */
> > @@ -1919,7 +1948,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
> >  				    folio_nr_pages(folio));
> >  	}
> >  
> > -	if (!list_empty(&movable_page_list) || isolation_error_count)
> > +	if (!list_empty(&movable_page_list) || isolation_error_count
> > +		|| coherent_pages)
> 
> The common style is to
> 
> a) add the || to the end of the previous line
> b) indent such the we have a nice-to-read alignment
> 
> if (!list_empty(&movable_page_list) || isolation_error_count ||
>     coherent_pages)
> 

I missed that.  This series is now in mm-stable so any fix will need to
be a standalone followup patch, please.

> Apart from that lgtm.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

And your reviewed-by's will be lost.  Stupid git.
