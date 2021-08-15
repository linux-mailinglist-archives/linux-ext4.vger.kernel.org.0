Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037FE3EC837
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Aug 2021 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhHOJBe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Aug 2021 05:01:34 -0400
Received: from verein.lst.de ([213.95.11.211]:51372 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhHOJBe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Aug 2021 05:01:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 686D56736F; Sun, 15 Aug 2021 11:01:01 +0200 (CEST)
Date:   Sun, 15 Aug 2021 11:01:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v6 01/13] ext4/xfs: add page refcount helper
Message-ID: <20210815090100.GA25067@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-2-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813063150.2938-2-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 13, 2021 at 01:31:38AM -0500, Alex Sierra wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> There are several places where ZONE_DEVICE struct pages assume a reference
> count == 1 means the page is idle and free. Instead of open coding this,
> add a helper function to hide this detail.
> 
> v3:
> [AS]: rename dax_layout_is_idle_page func to dax_page_unused
> 
> v4:
> [AS]: This ref count functionality was missing on fuse/dax.c.

These per-patch changelog goes under the "---", otherwise they totally
mess up the logs when commited to git.  Same for the other patches in
this series.

But the changes itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
