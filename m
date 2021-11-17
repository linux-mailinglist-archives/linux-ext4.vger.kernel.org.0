Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEDA454433
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Nov 2021 10:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhKQJxn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Nov 2021 04:53:43 -0500
Received: from verein.lst.de ([213.95.11.211]:49737 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232917AbhKQJxn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 17 Nov 2021 04:53:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EABF68AFE; Wed, 17 Nov 2021 10:50:42 +0100 (CET)
Date:   Wed, 17 Nov 2021 10:50:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v1 1/9] mm: add zone device coherent type memory support
Message-ID: <20211117095041.GA9730@lst.de>
References: <20211115193026.27568-1-alex.sierra@amd.com> <20211115193026.27568-2-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115193026.27568-2-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 15, 2021 at 01:30:18PM -0600, Alex Sierra wrote:
> @@ -5695,8 +5695,8 @@ static int mem_cgroup_move_account(struct page *page,
>   *   2(MC_TARGET_SWAP): if the swap entry corresponding to this pte is a
>   *     target for charge migration. if @target is not NULL, the entry is stored
>   *     in target->ent.
> - *   3(MC_TARGET_DEVICE): like MC_TARGET_PAGE  but page is MEMORY_DEVICE_PRIVATE
> - *     (so ZONE_DEVICE page and thus not on the lru).
> + *   3(MC_TARGET_DEVICE): like MC_TARGET_PAGE  but page is MEMORY_DEVICE_COHERENT
> + *     or MEMORY_DEVICE_PRIVATE (so ZONE_DEVICE page and thus not on the lru).

Please avoid the overly long line.  But I don't think we we need to mention
the exact enum, but rather do something like:

 *   3(MC_TARGET_DEVICE): like MC_TARGET_PAGE  but page is device memory and
 *     thus not on the lru.

> +	switch (pgmap->type) {
> +	case MEMORY_DEVICE_PRIVATE:
> +	case MEMORY_DEVICE_COHERENT:
>  		/*
>  		 * TODO: Handle HMM pages which may need coordination
>  		 * with device-side memory.

This might be a good opportunity for doing a s/HMM/device/ here.
