Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF13F7076
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhHYHgL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 03:36:11 -0400
Received: from verein.lst.de ([213.95.11.211]:55104 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234058AbhHYHgK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 25 Aug 2021 03:36:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A50267357; Wed, 25 Aug 2021 09:35:22 +0200 (CEST)
Date:   Wed, 25 Aug 2021 09:35:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v1 01/14] ext4/xfs: add page refcount helper
Message-ID: <20210825073522.GA29433@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com> <20210825034828.12927-2-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825034828.12927-2-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 24, 2021 at 10:48:15PM -0500, Alex Sierra wrote:
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> v3:
> [AS]: rename dax_layout_is_idle_page func to dax_page_unused
> 
> v4:
> [AS]: This ref count functionality was missing on fuse/dax.c.
> ---

Not sure all tooling can cope with the two --- separators.  Personally
I find these per-patch changelogs pretty annoying anyway, but others
have different opinions.
