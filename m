Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BBB4D51C6
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Mar 2022 20:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiCJT0m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Mar 2022 14:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbiCJT0m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Mar 2022 14:26:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED813FAFD;
        Thu, 10 Mar 2022 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vKB1pv4NC1deGVtskVNXZeo270YsQHcGnw/bzvNqjhU=; b=t+fQekjDylXM5FpL11K6LbsM4U
        nCEpfSkGhWw+V7I6WlvE7/IKQW5xJVT9Wix1QBVDoLZKIC730H7It/GEFSYO86SbZidTfQ79c02Zf
        W+mH+tEYafK0ctXsSkLrVq0r2S59sK/FeZ+fPRX3t/TtOUFhhJK9horVAqmehDltTEjopvGPg59EN
        43GCJwf2Lvvd0Iue2CdHswQmns5peN3XHOKy6GedHLH2DxWLw/ZyWHtmeAk1+Tb+/NHRgfzmuQBFS
        aInAU+8T8FpK0w+KCHXOvIvfcTpYVkRjUfq0dKRkQD+Oeoj5Z3K41RKFV58IlLSgabV8Bklj3fIFt
        Ec0MfEWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSOPi-000rME-NN; Thu, 10 Mar 2022 19:25:30 +0000
Date:   Thu, 10 Mar 2022 19:25:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     jgg@nvidia.com, david@redhat.com, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v1 1/3] mm: split vm_normal_pages for LRU and non-LRU
 handling
Message-ID: <YipQqqpTz8hZAbLZ@casper.infradead.org>
References: <20220310172633.9151-1-alex.sierra@amd.com>
 <20220310172633.9151-2-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310172633.9151-2-alex.sierra@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 10, 2022 at 11:26:31AM -0600, Alex Sierra wrote:
> @@ -606,7 +606,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   * PFNMAP mappings in order to support COWable mappings.
>   *
>   */
> -struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> +struct page *vm_normal_any_page(struct vm_area_struct *vma, unsigned long addr,
>  			    pte_t pte)
>  {
>  	unsigned long pfn = pte_pfn(pte);
> @@ -620,8 +620,6 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			return NULL;
>  		if (is_zero_pfn(pfn))
>  			return NULL;
> -		if (pte_devmap(pte))
> -			return NULL;
>  
>  		print_bad_pte(vma, addr, pte, NULL);
>  		return NULL;

... what?

Haven't you just made it so that a devmap page always prints a bad PTE
message, and then returns NULL anyway?

Surely this should be:

		if (pte_devmap(pte))
-			return NULL;
+			return pfn_to_page(pfn);

or maybe

+			goto check_pfn;

But I don't know about that highest_memmap_pfn check.

> @@ -661,6 +659,22 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  	return pfn_to_page(pfn);
>  }
>  
> +/*
> + * vm_normal_lru_page -- This function gets the "struct page" associated
> + * with a pte only for page cache and anon page. These pages are LRU handled.
> + */
> +struct page *vm_normal_lru_page(struct vm_area_struct *vma, unsigned long addr,
> +			    pte_t pte)

It seems a shame to add a new function without proper kernel-doc.

