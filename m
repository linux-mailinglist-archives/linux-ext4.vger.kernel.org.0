Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC9560D42
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jun 2022 01:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiF2Xbd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 19:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiF2Xbc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 19:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C873625C;
        Wed, 29 Jun 2022 16:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD11614D9;
        Wed, 29 Jun 2022 23:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD79C34114;
        Wed, 29 Jun 2022 23:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656545490;
        bh=EUtoD6mxDI6S48VU4JnwbI++d7sfQ0Ba+nGXTEVn3jI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ko/bDBvXxEcl48eumHeFgpRmNjd7wuaH7G0qP1t6sIobV5qNgwt9GvaQkmQ+8dLZe
         hKn2EQAupvKSihpNA1xULMkEVgDQpKd2GPIe2XSS8++/sO3ZQjzDOdGljxu/viVmyv
         Z6MSvOI4xrcShSRXxM7iYVplJ7VEnCGXQnVIYp5g=
Date:   Wed, 29 Jun 2022 16:31:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v7 03/14] mm: handling Non-LRU pages returned by
 vm_normal_pages
Message-Id: <20220629163128.7002f81b6346b2ed34d4d02a@linux-foundation.org>
In-Reply-To: <269e4c6e-d6ee-bace-9fab-a9dcb4268d5a@redhat.com>
References: <20220629035426.20013-1-alex.sierra@amd.com>
        <20220629035426.20013-4-alex.sierra@amd.com>
        <269e4c6e-d6ee-bace-9fab-a9dcb4268d5a@redhat.com>
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

On Wed, 29 Jun 2022 11:59:26 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 29.06.22 05:54, Alex Sierra wrote:
> > With DEVICE_COHERENT, we'll soon have vm_normal_pages() return
> > device-managed anonymous pages that are not LRU pages. Although they
> > behave like normal pages for purposes of mapping in CPU page, and for
> > COW. They do not support LRU lists, NUMA migration or THP.
> > 
> > Callers to follow_page that expect LRU pages, are also checked for
> > device zone pages due to DEVICE_COHERENT type.
> 
> Can we rephrase that to (because zeropage)
> 
> "Callers to follow_page() currently don't expect ZONE_DEVICE pages,
> however, with DEVICE_COHERENT we might now return ZONE_DEVICE. Check for
> ZONE_DEVICE pages in applicable users of follow_page() as well."

I made that change to my copy.

> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -624,6 +624,13 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> >  		if (is_zero_pfn(pfn))
> >  			return NULL;
> >  		if (pte_devmap(pte))
> > +/*
> > + * NOTE: New uers of ZONE_DEVICE will not set pte_devmap() and will have
> 
> s/uers/users/
> 
> > + * refcounts incremented on their struct pages when they are inserted into
> > + * PTEs, thus they are safe to return here. Legacy ZONE_DEVICE pages that set
> > + * pte_devmap() do not have refcounts. Example of legacy ZONE_DEVICE is
> > + * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
> > + */

And let's regularize that comment placement?

--- a/mm/memory.c~mm-handling-non-lru-pages-returned-by-vm_normal_pages-fix
+++ a/mm/memory.c
@@ -632,16 +632,16 @@ struct page *vm_normal_page(struct vm_ar
 			return NULL;
 		if (is_zero_pfn(pfn))
 			return NULL;
+		/*
+		 * NOTE: New users of ZONE_DEVICE will not set pte_devmap()
+		 * and will have refcounts incremented on their struct pages
+		 * when they are inserted into PTEs, thus they are safe to
+		 * return here. Legacy ZONE_DEVICE pages that set pte_devmap()
+		 * do not have refcounts. Example of legacy ZONE_DEVICE is
+		 * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
+		 */
 		if (pte_devmap(pte))
-/*
- * NOTE: New uers of ZONE_DEVICE will not set pte_devmap() and will have
- * refcounts incremented on their struct pages when they are inserted into
- * PTEs, thus they are safe to return here. Legacy ZONE_DEVICE pages that set
- * pte_devmap() do not have refcounts. Example of legacy ZONE_DEVICE is
- * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
- */
 			return NULL;
-
 		print_bad_pte(vma, addr, pte, NULL);
 		return NULL;
 	}
_

