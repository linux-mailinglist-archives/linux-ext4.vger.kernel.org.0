Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC7C4A7409
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 15:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345213AbiBBO57 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 09:57:59 -0500
Received: from verein.lst.de ([213.95.11.211]:34501 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343675AbiBBO56 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 2 Feb 2022 09:57:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 49B1A68B05; Wed,  2 Feb 2022 15:57:52 +0100 (CET)
Date:   Wed, 2 Feb 2022 15:57:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v4 00/10] Add MEMORY_DEVICE_COHERENT for coherent
 device memory mapping
Message-ID: <20220202145750.GA25170@lst.de>
References: <20220127030949.19396-1-alex.sierra@amd.com> <20220127143258.8da663659948ad1e6f0c0ea8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127143258.8da663659948ad1e6f0c0ea8@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 27, 2022 at 02:32:58PM -0800, Andrew Morton wrote:
> On Wed, 26 Jan 2022 21:09:39 -0600 Alex Sierra <alex.sierra@amd.com> wrote:
> 
> > This patch series introduces MEMORY_DEVICE_COHERENT, a type of memory
> > owned by a device that can be mapped into CPU page tables like
> > MEMORY_DEVICE_GENERIC and can also be migrated like
> > MEMORY_DEVICE_PRIVATE.
> 
> Some more reviewer input appears to be desirable here.
> 
> I was going to tentatively add it to -mm and -next, but problems. 
> 5.17-rc1's mm/migrate.c:migrate_vma_check_page() is rather different
> from the tree you patched.  Please redo, refresh and resend?

I really hate adding more types with the weird one off page refcount.
We need to clean that mess up first.
