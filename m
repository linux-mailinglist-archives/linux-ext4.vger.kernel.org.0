Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340BF3B26D3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 07:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFXFdM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Jun 2021 01:33:12 -0400
Received: from verein.lst.de ([213.95.11.211]:53053 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhFXFdM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Jun 2021 01:33:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 244BF68AFE; Thu, 24 Jun 2021 07:30:49 +0200 (CEST)
Date:   Thu, 24 Jun 2021 07:30:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Alex Sierra <alex.sierra@amd.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hch@lst.de, jgg@nvidia.com,
        jglisse@redhat.com
Subject: Re: [PATCH v3 0/8] Support DEVICE_GENERIC memory in migrate_vma_*
Message-ID: <20210624053048.GB25004@lst.de>
References: <20210617151705.15367-1-alex.sierra@amd.com> <YM9NXrGlhdp0qb7S@mit.edu> <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 23, 2021 at 05:49:55PM -0400, Felix Kuehling wrote:
> For the reference counting changes we could use the dax driver with hmem 
> and use efi_fake_mem on the kernel command line to create some 
> DEVICE_GENERIC pages. I'm open to suggestions for good user mode tests to 
> exercise dax functionality on this type of memory.
>
> For the migration helper changes we could modify or parametrize 
> lib/hmm_test.c to create DEVICE_GENERIC pages instead of DEVICE_PRIVATE. 
> Then run tools/testing/selftests/vm/hmm-tests.c.

We'll also need a real in-tree user of the enhanced DEVICE_GENERIC memory.
So while the refcounting cleanups early in the series are something I'd
really like to see upstream as soon as everything is sorted out, the
actual bits that can't only be used by your updated driver should wait
for that.
