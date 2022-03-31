Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710E84ED652
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Mar 2022 10:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiCaI7p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Mar 2022 04:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiCaI7o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Mar 2022 04:59:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83F1F1244;
        Thu, 31 Mar 2022 01:57:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D00D868B05; Thu, 31 Mar 2022 10:57:53 +0200 (CEST)
Date:   Thu, 31 Mar 2022 10:57:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Alex Sierra <alex.sierra@amd.com>,
        jgg@nvidia.com, Felix.Kuehling@amd.com, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, jglisse@redhat.com,
        apopple@nvidia.com, willy@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/3] mm: add vm_normal_lru_pages for LRU handled
 pages only
Message-ID: <20220331085753.GA22487@lst.de>
References: <20220330212537.12186-1-alex.sierra@amd.com> <20220330212537.12186-2-alex.sierra@amd.com> <20220331085341.GA22102@lst.de> <709b459a-3c71-49b1-7ac1-3144ae0fa89a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <709b459a-3c71-49b1-7ac1-3144ae0fa89a@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 31, 2022 at 10:55:13AM +0200, David Hildenbrand wrote:
> > Why can't this deal with ZONE_DEVICE pages?  It certainly has
> > nothing do with a LRU I think.  In fact being able to have
> > stats that count say the number of device pages here would
> > probably be useful at some point.
> > 
> > In general I find the vm_normal_lru_page vs vm_normal_page
> > API highly confusing.  An explicit check for zone device pages
> > in the dozen or so spots that care has a much better documentation
> > value, especially if accompanied by comments where it isn't entirely
> > obvious.
> 
> What's your thought on FOLL_LRU?

Also a bit confusing, but inbetween all these FOLL_ flags it doesn't
really matter any more.
