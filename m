Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C6D3CB96E
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 17:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbhGPPKx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jul 2021 11:10:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57661 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240493AbhGPPKw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jul 2021 11:10:52 -0400
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16GF7fnw014809
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 11:07:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D6FEA4202F5; Fri, 16 Jul 2021 11:07:40 -0400 (EDT)
Date:   Fri, 16 Jul 2021 11:07:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v3 0/8] Support DEVICE_GENERIC memory in migrate_vma_*
Message-ID: <YPGgvNxfOCx/Sp0g@mit.edu>
References: <20210617151705.15367-1-alex.sierra@amd.com>
 <YM9NXrGlhdp0qb7S@mit.edu>
 <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 23, 2021 at 05:49:55PM -0400, Felix Kuehling wrote:
> 
> I can think of two ways to test the changes for MEMORY_DEVICE_GENERIC in
> this patch series in a way that is reproducible without special hardware and
> firmware:
> 
> For the reference counting changes we could use the dax driver with hmem and
> use efi_fake_mem on the kernel command line to create some DEVICE_GENERIC
> pages. I'm open to suggestions for good user mode tests to exercise dax
> functionality on this type of memory.

Sorry for the thread necromancy, but now that the merge window is
past....

Today I test ext4's dax support, without having any $$$ DAX hardware,
by using the kernel command line "memmap=4G!9G:memmap=9G!14G" which
reserves memory so that creates two pmem device and then I run
xfstests with DAX enabled using qemu or using a Google Compute Engine
VM, using TEST_DEV=/dev/pmem0 and SCRATCH_DEV=/dev/pmem1.

If you can give me a recipe for what kernel configs I should enable,
and what magic kernel command line arguments to use, then I'd be able
to test your patch set with ext4.

Cheers,

						- Ted
