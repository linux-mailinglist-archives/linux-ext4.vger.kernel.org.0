Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350713EE662
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Aug 2021 07:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhHQFvH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Aug 2021 01:51:07 -0400
Received: from verein.lst.de ([213.95.11.211]:57167 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233928AbhHQFvG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Aug 2021 01:51:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB5316736F; Tue, 17 Aug 2021 07:50:31 +0200 (CEST)
Date:   Tue, 17 Aug 2021 07:50:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>, Alex Sierra <alex.sierra@amd.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, jgg@nvidia.com,
        jglisse@redhat.com, Roger Pau Monne <roger.pau@citrix.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v6 08/13] mm: call pgmap->ops->page_free for
 DEVICE_GENERIC pages
Message-ID: <20210817055031.GC4895@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-9-alex.sierra@amd.com> <20210815154047.GC32384@lst.de> <7a55366f-bd65-7ab9-be9e-3bfd3aea3ea1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a55366f-bd65-7ab9-be9e-3bfd3aea3ea1@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 16, 2021 at 03:00:49PM -0400, Felix Kuehling wrote:
> 
> Am 2021-08-15 um 11:40 a.m. schrieb Christoph Hellwig:
> > On Fri, Aug 13, 2021 at 01:31:45AM -0500, Alex Sierra wrote:
> >> Add MEMORY_DEVICE_GENERIC case to free_zone_device_page callback.
> >> Device generic type memory case is now able to free its pages properly.
> > How is this going to work for the two existing MEMORY_DEVICE_GENERIC
> > that now change behavior?  And which don't have a ->page_free callback
> > at all?
> 
> That's a good catch. Existing drivers shouldn't need a page_free
> callback if they didn't have one before. That means we need to add a
> NULL-pointer check in free_device_page.

Also the other state clearing (__ClearPageWaiters/mem_cgroup_uncharge/
->mapping = NULL).

In many ways this seems like you want to bring back the DEVICE_PUBLIC
pgmap type that was removed a while ago due to the lack of users
instead of overloading the generic type.
