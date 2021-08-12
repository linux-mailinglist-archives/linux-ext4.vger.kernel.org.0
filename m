Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67EA3E9EAB
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 08:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhHLGeq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 02:34:46 -0400
Received: from verein.lst.de ([213.95.11.211]:43060 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhHLGep (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Aug 2021 02:34:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF00D67373; Thu, 12 Aug 2021 08:34:17 +0200 (CEST)
Date:   Thu, 12 Aug 2021 08:34:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v5 00/13] Support DEVICE_GENERIC memory in migrate_vma_*
Message-ID: <20210812063417.GA26938@lst.de>
References: <20210812063100.31997-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812063100.31997-1-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Do you have a pointer to a git branch with this series and all dependencies
to ease testing?

On Thu, Aug 12, 2021 at 01:30:47AM -0500, Alex Sierra wrote:
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
> 
> This work is based on HMM and our SVM memory manager that was recently upstreamed
> to Dave Airlie's drm-next branch
> https://cgit.freedesktop.org/drm/drm/log/?h=drm-next
> On top of that we did some rework of our VRAM management for migrations to remove
> some incorrect assumptions, allow partially successful migrations and GPU memory
> mappings that mix pages in VRAM and system memory.
> https://lore.kernel.org/dri-devel/20210527205606.2660-6-Felix.Kuehling@amd.com/T/#r996356015e295780eb50453e7dbd5d0d68b47cbc
> 
> v2:
> This patch series version has merged "[RFC PATCH v3 0/2]
> mm: remove extra ZONE_DEVICE struct page refcount" patch series made by
> Ralph Campbell. It also applies at the top of these series, our changes
> to support device generic type in migration_vma helpers.
> This has been tested in systems with device memory that has coherent
> access by CPU.
> 
> Also addresses the following feedback made in v1:
> - Isolate in one patch kernel/resource.c modification, based
> on Christoph's feedback.
> - Add helpers check for generic and private type to avoid
> duplicated long lines.
> 
> v3:
> - Include cover letter from v1.
> - Rename dax_layout_is_idle_page func to dax_page_unused in patch
> ext4/xfs: add page refcount helper.
> 
> v4:
> - Add support for zone device generic type in lib/test_hmm and
> tool/testing/selftest/vm/hmm-tests.
> - Add missing page refcount helper to fuse/dax.c. This was included in
> one of Ralph Campbell's patches.
> 
> v5:
> - Cosmetic changes on patches 3, 5 and 13
> - Bug founded at test_hmm, remove devmem->pagemap.type = MEMORY_DEVICE_PRIVATE
> at dmirror_allocate_chunk that was forcing to configure pagemap.type to
> MEMORY_DEVICE_PRIVATE.
> - A bug was found while running one of the xfstest (generic/413) used to
> validate fs_dax device type. This was first introduced by patch: "mm: remove
> extra ZONE_DEVICE struct page refcount" whic is part of these patch series.
> The bug was showed as WARNING message at try_grab_page function call, due to
> a page refcounter equal to zero. Part of "mm: remove extra ZONE_DEVICE struct
> page refcount" changes, was to initialize page refcounter to zero. Therefore,
> a special condition was added to try_grab_page on this v5, were it checks for
> device zone pages too. It is included in the same patch.
> 
> This is how mm changes from these patch series have been validated:
> - hmm-tests were run using device private and device generic types. This last,
> just added in these patch series. efi_fake_mem was used to mimic SPM memory
> for device generic.
> - xfstests tool was used to validate fs-dax device type and page refcounter
> changes. DAX configuration was used along with emulated Persisten Memory set as
> memmap=4G!4G memmap=4G!9G. xfstests were run from ext4 and generic lists. Some
> of them, did not run due to limitations in configuration. Ex. test not
> supporting specific file system or DAX mode.
> Only three tests failed, generic/356/357 and ext4/049. However, these failures
> were consistent before and after applying these patch series.
> xfstest configuration:
> TEST_DEV=/dev/pmem0
> TEST_DIR=/mnt/ram0
> SCRATCH_DEV=/dev/pmem1
> SCRATCH_MNT=/mnt/ram1
> TEST_FS_MOUNT_OPTS="-o dax"
> EXT_MOUNT_OPTIONS="-o dax"
> MKFS_OPTIONS="-b4096"
> xfstest passed list:
> Ext4:
> 001,003,005,021,022,023,025,026,030,031,032,036,037,038,042,043,044,271,306
> Generic:
> 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,20,21,22,23,24,25,28,29,30,31,32,33,35,37,
> 50,52,53,58,60,61,62,63,64,67,69,70,71,75,76,78,79,80,82,84,86,87,88,91,92,94,
> 96,97,98,99,103,105,112,113,114,117,120,124,126,129,130,131,135,141,169,184,
> 198,207,210,211,212,213,214,215,221,223,225,228,236,237,240,244,245,246,247,
> 248,249,255,257,258,263,277,286,294,306,307,308,309,313,315,316,318,319,337,
> 346,360,361,371,375,377,379,380,383,384,385,386,389,391,392,393,394,400,401,
> 403,404,406,409,410,411,412,413,417,420,422,423,424,425,426,427,428
> 
> Patches 1-2 Rebased Ralph Campbell's ZONE_DEVICE page refcounting patches.
> 
> Patches 4-5 are for context to show how we are looking up the SPM 
> memory and registering it with devmap.
> 
> Patches 3,6-8 are the changes we are trying to upstream or rework to 
> make them acceptable upstream.
> 
> Patches 9-13 add ZONE_DEVICE Generic type support into the hmm test.
> 
> Alex Sierra (11):
>   kernel: resource: lookup_resource as exported symbol
>   drm/amdkfd: add SPM support for SVM
>   drm/amdkfd: generic type as sys mem on migration to ram
>   include/linux/mm.h: helpers to check zone device generic type
>   mm: add generic type support to migrate_vma helpers
>   mm: call pgmap->ops->page_free for DEVICE_GENERIC pages
>   lib: test_hmm add ioctl to get zone device type
>   lib: test_hmm add module param for zone device type
>   lib: add support for device generic type in test_hmm
>   tools: update hmm-test to support device generic type
>   tools: update test_hmm script to support SP config
> 
> Ralph Campbell (2):
>   ext4/xfs: add page refcount helper
>   mm: remove extra ZONE_DEVICE struct page refcount
> 
>  arch/powerpc/kvm/book3s_hv_uvmem.c       |   2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  22 ++-
>  drivers/gpu/drm/nouveau/nouveau_dmem.c   |   2 +-
>  fs/dax.c                                 |   8 +-
>  fs/ext4/inode.c                          |   5 +-
>  fs/fuse/dax.c                            |   4 +-
>  fs/xfs/xfs_file.c                        |   4 +-
>  include/linux/dax.h                      |  10 +
>  include/linux/memremap.h                 |   7 +-
>  include/linux/mm.h                       |  54 +-----
>  kernel/resource.c                        |   1 +
>  lib/test_hmm.c                           | 231 +++++++++++++++--------
>  lib/test_hmm_uapi.h                      |  16 ++
>  mm/internal.h                            |   8 +
>  mm/memremap.c                            |  69 ++-----
>  mm/migrate.c                             |  25 +--
>  mm/page_alloc.c                          |   3 +
>  mm/swap.c                                |  45 +----
>  tools/testing/selftests/vm/hmm-tests.c   | 142 ++++++++++++--
>  tools/testing/selftests/vm/test_hmm.sh   |  20 +-
>  20 files changed, 405 insertions(+), 273 deletions(-)
> 
> -- 
> 2.32.0
---end quoted text---
