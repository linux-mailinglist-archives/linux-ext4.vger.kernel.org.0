Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6B3ADEFA
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Jun 2021 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhFTORV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Jun 2021 10:17:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44873 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229593AbhFTORU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Jun 2021 10:17:20 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15KEEsxi001510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Jun 2021 10:14:55 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4EFFB15C3C9F; Sun, 20 Jun 2021 10:14:54 -0400 (EDT)
Date:   Sun, 20 Jun 2021 10:14:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v3 0/8] Support DEVICE_GENERIC memory in migrate_vma_*
Message-ID: <YM9NXrGlhdp0qb7S@mit.edu>
References: <20210617151705.15367-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617151705.15367-1-alex.sierra@amd.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 17, 2021 at 10:16:57AM -0500, Alex Sierra wrote:
> v1:
> AMD is building a system architecture for the Frontier supercomputer with a
> coherent interconnect between CPUs and GPUs. This hardware architecture allows
> the CPUs to coherently access GPU device memory. We have hardware in our labs
> and we are working with our partner HPE on the BIOS, firmware and software
> for delivery to the DOE.
> 
> The system BIOS advertises the GPU device memory (aka VRAM) as SPM
> (special purpose memory) in the UEFI system address map. The amdgpu driver looks
> it up with lookup_resource and registers it with devmap as MEMORY_DEVICE_GENERIC
> using devm_memremap_pages.
> 
> Now we're trying to migrate data to and from that memory using the migrate_vma_*
> helpers so we can support page-based migration in our unified memory allocations,
> while also supporting CPU access to those pages.
> 
> This patch series makes a few changes to make MEMORY_DEVICE_GENERIC pages behave
> correctly in the migrate_vma_* helpers. We are looking for feedback about this
> approach. If we're close, what's needed to make our patches acceptable upstream?
> If we're not close, any suggestions how else to achieve what we are trying to do
> (i.e. page migration and coherent CPU access to VRAM)?

Is there a way we can test the codepaths touched by this patchset?  It
doesn't have to be via a complete qemu simulation of the GPU device
memory, but some way of creating MEMORY_DEVICE_GENERIC subject to
migrate_vma_* helpers so we can test for regressions moving forward.

Thanks,

					- Ted
