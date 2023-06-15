Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6871D7320C3
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjFOUPw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 16:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFOUPv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 16:15:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463BF212B;
        Thu, 15 Jun 2023 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6qVMM2snJT/z1+3q7iOllvvHpkI+bKo+0q0jsxvpBjg=; b=Q2dCQ3JGnKDklQMM57TVbFGdFB
        iDGe7FLLBCsANC19XWYQ2qW/dNzVqxNq5XPk92wix9OFK5mgAnfgy1+fWIFnkISpM/gOGTi+prEl1
        ceyIQ+XAblDZIvGCF+1NRxMwN36PI6oUI5ZhF761FfZRKc2aWY7XW2BARpsgWMsRGQX8ACRgD9Va8
        BNuZmSrnUVV4YqLAfYEGOhUTVSK/AgQzzblIWTISlsNkQTNYBgzoFtmNM3iShP16ZzhFXbGeQbViW
        uDoO6tR2eXpmKWfU9e0r/PR7TbvfT8gd/swGNbUHGJko93EmkO7jpEhdB8hZNvUHwYKXLo0vQo0+t
        IXJ7iVPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9tNO-0082yB-UE; Thu, 15 Jun 2023 20:15:26 +0000
Date:   Thu, 15 Jun 2023 21:15:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        david@redhat.com, Felix.Kuehling@amd.com, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hch@lst.de, jglisse@redhat.com,
        apopple@nvidia.com, akpm@linux-foundation.org
Subject: Re: [PATCH v9 02/14] mm: move page zone helpers from mm.h to mmzone.h
Message-ID: <ZItxXny9kRDq/ryf@casper.infradead.org>
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-3-alex.sierra@amd.com>
 <ZItneGX+sqg7WApF@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZItneGX+sqg7WApF@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 15, 2023 at 03:33:12PM -0400, Peter Xu wrote:
> My question is whether page_zonenum() is ready for taking all kinds of tail
> pages?
> 
> Zone device tail pages all look fine, per memmap_init_zone_device().  The
> question was other kinds of usual compound pages, like either thp or
> hugetlb.  IIUC page->flags can be uninitialized for those tail pages.

I don't think that's true.  It's my understanding that page->flags is
initialised for all pages in memmap at boot / hotplug / delayed-init
time.  So you can check things like zone, node, etc on literally any
page.  Contrariwise, those flags are not available in tail pages for
use by the entity that has allocated a compound page / large folio.

Also, I don't believe zone device pages support compound allocation.
I think they're always allocated as order-0.

