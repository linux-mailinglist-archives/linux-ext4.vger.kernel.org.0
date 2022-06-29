Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C3560D1D
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jun 2022 01:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiF2XYS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 19:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF2XYR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 19:24:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826CB23BF3;
        Wed, 29 Jun 2022 16:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D785B82466;
        Wed, 29 Jun 2022 23:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB1C34114;
        Wed, 29 Jun 2022 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656545053;
        bh=Dnxtg2+47dMB9fvk3mpZuwgNcKCi6p+et4oU9iDj/kY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yIUhyRd1UmOnjNmm25XNKViGfXOi0X4HOJ10GLIlf13tTMKTjOUKLDyQ4Z2DbDg0O
         cVQjech3q/YmOGPV9iO+PcS3fpGyfcUYsFfe1708PQjUEfslyL6ytDB/D+Pq4Yvxiq
         Yqsj0t71BtS8NGnMPbzTZ5t6X4C+LtXr/VhhiUbg=
Date:   Wed, 29 Jun 2022 16:24:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v7 01/14] mm: rename is_pinnable_pages to
 is_pinnable_longterm_pages
Message-Id: <20220629162412.d6aa0bf6244e487e4279fc31@linux-foundation.org>
In-Reply-To: <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
References: <20220629035426.20013-1-alex.sierra@amd.com>
        <20220629035426.20013-2-alex.sierra@amd.com>
        <f00f9c93-c115-d222-dc8c-11493ccd2567@redhat.com>
        <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 29 Jun 2022 18:08:40 -0400 Felix Kuehling <felix.kuehling@amd.com> wrote:

> >
> > I'd have called it "is_longterm_pinnable_page", but I am not a native
> > speaker, so no strong opinion :)
> 
> I think only the patch title has the name backwards. The code uses 
> is_longterm_pinnable_page.

Patch title was quite buggy ;) I made it "mm: rename is_pinnable_page()
to is_longterm_pinnable_page()" in my copy.


