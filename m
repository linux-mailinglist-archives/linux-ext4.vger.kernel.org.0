Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACB23F70A5
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 09:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhHYHrq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 03:47:46 -0400
Received: from verein.lst.de ([213.95.11.211]:55156 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238651AbhHYHrp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 25 Aug 2021 03:47:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C7676736F; Wed, 25 Aug 2021 09:46:58 +0200 (CEST)
Date:   Wed, 25 Aug 2021 09:46:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v1 09/14] mm: call pgmap->ops->page_free for
 DEVICE_PUBLIC pages
Message-ID: <20210825074657.GB29620@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com> <20210825034828.12927-10-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825034828.12927-10-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 24, 2021 at 10:48:23PM -0500, Alex Sierra wrote:
> Add MEMORY_DEVICE_PUBLIC case to free_zone_device_page callback.
> Device public type memory case is now able to free its pages properly.

This really should go into patch 4.  And it might make sense to introduce
free_device_private_page directly with the free_device_page name instead
of renaming it a little later.
