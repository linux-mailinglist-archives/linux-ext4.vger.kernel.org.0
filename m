Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38423F2626
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 06:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhHTE5N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 00:57:13 -0400
Received: from verein.lst.de ([213.95.11.211]:39696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233544AbhHTE5H (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Aug 2021 00:57:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AD1156736F; Fri, 20 Aug 2021 06:56:27 +0200 (CEST)
Date:   Fri, 20 Aug 2021 06:56:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hch@lst.de, jgg@nvidia.com,
        jglisse@redhat.com
Subject: Re: [PATCH v6 02/13] mm: remove extra ZONE_DEVICE struct page
 refcount
Message-ID: <20210820045627.GA27083@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-3-alex.sierra@amd.com> <7b821150-af18-f786-e419-ec245b8cfb1e@nvidia.com> <393e9815-838d-5fe6-d6ab-bfe7b543fef6@amd.com> <e155ed59-8c3c-4046-e731-f082ee4b10bb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e155ed59-8c3c-4046-e731-f082ee4b10bb@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 18, 2021 at 12:28:30PM -0700, Ralph Campbell wrote:
> Did you test on a system without CONFIG_ARCH_HAS_PTE_SPECIAL defined?
> In that case, mmap() of a DAX device will call insert_page() which calls
> get_page() which would trigger VM_BUG_ON_PAGE().

__vm_insert_mixed still ends up calling insert_pfn for the
!CASE_ARCH_HAS_PTE_SPECIAL if pfn_t_devmap() is true, which it should
be for DAX.  (and as said in my other mail, I suspect we should disallow
that case anyway, as no one can test it in practice).
