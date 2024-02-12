Return-Path: <linux-ext4+bounces-1194-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E7F850D84
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Feb 2024 07:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EB41F24281
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Feb 2024 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6FA7468;
	Mon, 12 Feb 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ3jHZ25"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92B620E3;
	Mon, 12 Feb 2024 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707718724; cv=none; b=blf3jA43fQp+fiKUqPWuBMhepngHXUddmzYGgvXl9kpWG8dMmq2QRIoDlRJ8kA9kpMPMY0mSlnuVw1Owu5oAvUgt4XrQ3FCdOn3XgZ1ikSxGQVIwA5W91R+Mkx1E7HRelP+7b8eoYLFZpBRTwa4wiY+wEoUguRz1Fnh2oqEk2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707718724; c=relaxed/simple;
	bh=Cgnj7UaWtNLg5yBDnc168wOt0+BMZugI7Zc2M/K+E20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFVvx3d4aDjiCGkd3ZfXm5MxiNXXo99p49Qv6UhPSrkXQMrvQqIdG0Bchnrhwlh6bgTkXfxP4NoBfKgMdxdAma8QuVNXWu9SkfnykJW1F11SsvWUsmRIE2g0qO/qPUwcNmcka9sUrbTw/AtayjhQOeRnYCdIUmLAfON7rkX4g/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ3jHZ25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467D5C433C7;
	Mon, 12 Feb 2024 06:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707718723;
	bh=Cgnj7UaWtNLg5yBDnc168wOt0+BMZugI7Zc2M/K+E20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQ3jHZ25h2StFtqtdvnFE4TH0WdwQ2GhK/+krlaeydbgTF6FVNpBrpnv37IUxeMoc
	 IfD6budWZjG9YQaRLrepIschPoBqLV+HdipTxydJLJohItYMAhS3zpy7Rgpx+he9j4
	 uVP0ojH/0/vPn94a7kDJcBZisFp7RHG982TLMEPtaVaHgOkaeTxESE2ytEJ0d8F26h
	 C4D5y64QeH0iuSSFpmaXM0QIOJuI/Z1ohp4OblTQcbtE4i+GgwofkNkfGxWOQrIHl8
	 HmUlN2Q0vqC2twsDewfhVe0XHW0sNfkDOnvaaCGYAHluY1kS/jIr+ghJ98EVU55ZlI
	 nBBJ9wSKtCgDg==
Date: Sun, 11 Feb 2024 22:18:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, willy@infradead.org, zokeefe@google.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v3 00/26] ext4: use iomap for regular file's buffered
 IO path and enable large foilo
Message-ID: <20240212061842.GB6180@frogsfrogsfrogs>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>

On Sat, Jan 27, 2024 at 09:57:59AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Hello,
> 
> This is the third version of RFC patch series that convert ext4 regular
> file's buffered IO path to iomap and enable large folio. It's rebased on
> 6.7 and Christoph's "map multiple blocks per ->map_blocks in iomap
> writeback" series [1]. I've fixed all issues found in the last about 3
> weeks of stress tests and fault injection tests in v2. I hope I've
> covered most of the corner cases, and any comments are welcome. :)
> 
> Changes since v2:
>  - Update patch 1-6 to v3 [2].
>  - iomap_zero and iomap_unshare don't need to update i_size and call
>    iomap_write_failed(), introduce a new helper iomap_write_end_simple()
>    to avoid doing that.
>  - Factor out ext4_[ext|ind]_map_blocks() parts from ext4_map_blocks(),
>    introduce a new helper ext4_iomap_map_one_extent() to allocate
>    delalloc blocks in writeback, which is always under i_data_sem in
>    write mode. This is done to prevent the writing back delalloc
>    extents become stale if it raced by truncate.
>  - Add a lock detection in mapping_clear_large_folios().
> Changes since v1:
>  - Introduce seq count for iomap buffered write and writeback to protect
>    races from extents changes, e.g. truncate, mwrite.
>  - Always allocate unwritten extents for new blocks, drop dioread_lock
>    mode, and make no distinctions between dioread_lock and
>    dioread_nolock.
>  - Don't add ditry data range to jinode, drop data=ordered mode, and
>    make no distinctions between data=ordered and data=writeback mode.
>  - Postpone updating i_disksize to endio.
>  - Allow splitting extents and use reserved space in endio.
>  - Instead of reimplement a new delayed mapping helper
>    ext4_iomap_da_map_blocks() for buffer write, try to reuse
>    ext4_da_map_blocks().
>  - Add support for disabling large folio on active inodes.
>  - Support online defragmentation, make file fall back to buffer_head
>    and disable large folio in ext4_move_extents().
>  - Move ext4_nonda_switch() in advance to prevent deadlock in mwrite.
>  - Add dirty_len and pos trace info to trace_iomap_writepage_map().
>  - Update patch 1-6 to v2.
> 
> This series only support ext4 with the default features and mount
> options, doesn't support inline_data, bigalloc, dax, fs_verity, fs_crypt
> and data=journal mode, ext4 would fall back to buffer_head path

Do you plan to add bigalloc or !extents support as a part 2 patchset?

An ext2 port to iomap has been (vaguely) in the works for a while,
though iirc willy never got the performance to match because iomap
didn't have a mechanism for the caller to tell it "run the IO now even
though you don't have a complete page, because the indirect block is the
next block after the 11th block".

--D

> automatically if you enabled these features/options. Although it has
> many limitations now, it can satisfy the requirements of common cases
> and bring a great performance benefit.
> 
> Patch 1-6: this is a preparation series, it changes ext4_map_blocks()
> and ext4_set_iomap() to recognize delayed only extents, I've send it out
> separately [2].
> 
> Patch 7-8: these are two minor iomap changes, the first one is don't
> update i_size and don't call iomap_write_failed() in zero_range, the
> second one is for debug in iomap writeback path that I've discussed whit
> Christoph [3].
> 
> Patch 9-15: this is another preparation series, including some changes
> for delayed extents. Firstly, it factor out buffer_head from
> ext4_da_map_blocks(), make it to support adding multi-blocks once a
> time. Then make unwritten to written extents conversion in endio use to
> reserved space, reduce the risk of potential data loss. Finally,
> introduce a sequence counter for extent status tree, which is useful
> for iomap buffer write and write back.
> 
> Patch 16-22: Implement buffered IO iomap path for read, write, mmap,
> zero range, truncate and writeback, replace current buffered_head path.
> Please look at the following patch for details.
> 
> Patch 23-26: Convert to iomap for regular file's buffered IO path
> besides inline_data, bigalloc, dax, fs_verity, fs_crypt, and
> data=journal mode, and enable large folio. It should be note that
> buffered iomap path hasn't support Online defrag yet, so we need fall
> back to buffer_head and disable large folio automatically if user call
> EXT4_IOC_MOVE_EXT.
> 
> About Tests:
>  - kvm-xfstests in auto mode, and about 3 weeks of stress tests and
>    fault injection tests.
>  - A performance tests below.
> 
>    Fio tests with psync on my machine with Intel Xeon Gold 6240 CPU
>    with 400GB system ram, 200GB ramdisk and 1TB nvme ssd disk.
> 
>    == buffer read ==
> 
>                   buffer head        iomap with large folio
>    type     bs    IOPS    BW(MiB/s)  IOPS    BW(MiB/s)
>    ----------------------------------------------------
>    hole     4K    565k    2206       811k    3167
>    hole     64K   45.1k   2820       78.1k   4879
>    hole     1M    2744    2744       4890    4891
>    ramdisk  4K    436k    1703       554k    2163
>    ramdisk  64K   29.6k   1848       44.0k   2747
>    ramdisk  1M    1994    1995       2809    2809
>    nvme     4K    306k    1196       324k    1267
>    nvme     64K   19.3k   1208       24.3k   1517
>    nvme     1M    1694    1694       2256    2256
> 
>    == buffer write ==
> 
>                                        buffer head    ext4_iomap    
>    type   Overwrite Sync Writeback bs  IOPS   BW      IOPS   BW
>    -------------------------------------------------------------
>    cache    N       N    N         4K   395k   1544   415k   1621
>    cache    N       N    N         64K  30.8k  1928   80.1k  5005
>    cache    N       N    N         1M   1963   1963   5641   5642
>    cache    Y       N    N         4K   423k   1652   443k   1730
>    cache    Y       N    N         64K  33.0k  2063   80.8k  5051
>    cache    Y       N    N         1M   2103   2103   5588   5589
>    ramdisk  N       N    Y         4K   362k   1416   307k   1198
>    ramdisk  N       N    Y         64K  22.4k  1399   64.8k  4050
>    ramdisk  N       N    Y         1M   1670   1670   4559   4560
>    ramdisk  N       Y    N         4K   9830   38.4   13.5k  52.8
>    ramdisk  N       Y    N         64K  5834   365    10.1k  629
>    ramdisk  N       Y    N         1M   1011   1011   2064   2064
>    ramdisk  Y       N    Y         4K   397k   1550   409k   1598
>    ramdisk  Y       N    Y         64K  29.2k  1827   73.6k  4597
>    ramdisk  Y       N    Y         1M   1837   1837   4985   4985
>    ramdisk  Y       Y    N         4K   173k   675    182k   710
>    ramdisk  Y       Y    N         64K  17.7k  1109   33.7k  2105
>    ramdisk  Y       Y    N         1M   1128   1129   1790   1791
>    nvme     N       N    Y         4K   298k   1164   290k   1134
>    nvme     N       N    Y         64K  21.5k  1343   57.4k  3590
>    nvme     N       N    Y         1M   1308   1308   3664   3664
>    nvme     N       Y    N         4K   10.7k  41.8   12.0k  46.9
>    nvme     N       Y    N         64K  5962   373    8598   537
>    nvme     N       Y    N         1M   676    677    1417   1418
>    nvme     Y       N    Y         4K   366k   1430   373k   1456
>    nvme     Y       N    Y         64K  26.7k  1670   56.8k  3547
>    nvme     Y       N    Y         1M   1745   1746   3586   3586
>    nvme     Y       Y    N         4K   59.0k  230    61.2k  239
>    nvme     Y       Y    N         64K  13.0k  813    21.0k  1311
>    nvme     Y       Y    N         1M   683    683    1368   1369
>  
> TODO
>  - Keep on doing stress tests and fixing.
>  - I will rebase and resend my another patch set "ext4: more accurate
>    metadata reservaion for delalloc mount option[4]" later, it's useful
>    for iomap conversion. After this series, I suppose we could totally
>    drop ext4_nonda_switch() and prevent the risk of data loss caused by
>    extents splitting.
>  - Support for more features and mount options in the future.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20231207072710.176093-1-hch@lst.de/
> [2] https://lore.kernel.org/linux-ext4/20240105033018.1665752-1-yi.zhang@huaweicloud.com/
> [3] https://lore.kernel.org/linux-fsdevel/20231207150311.GA18830@lst.de/
> [4] https://lore.kernel.org/linux-ext4/20230824092619.1327976-1-yi.zhang@huaweicloud.com/
> 
> Thanks,
> Yi.
> 
> ---
> v2: https://lore.kernel.org/linux-ext4/20240102123918.799062-1-yi.zhang@huaweicloud.com/
> v1: https://lore.kernel.org/linux-ext4/20231123125121.4064694-1-yi.zhang@huaweicloud.com/
> 
> Zhang Yi (26):
>   ext4: refactor ext4_da_map_blocks()
>   ext4: convert to exclusive lock while inserting delalloc extents
>   ext4: correct the hole length returned by ext4_map_blocks()
>   ext4: add a hole extent entry in cache after punch
>   ext4: make ext4_map_blocks() distinguish delalloc only extent
>   ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC map type
>   iomap: don't increase i_size if it's not a write operation
>   iomap: add pos and dirty_len into trace_iomap_writepage_map
>   ext4: allow inserting delalloc extents with multi-blocks
>   ext4: correct delalloc extent length
>   ext4: also mark extent as delalloc if it's been unwritten
>   ext4: factor out bh handles to ext4_da_get_block_prep()
>   ext4: use reserved metadata blocks when splitting extent in endio
>   ext4: factor out ext4_map_{create|query}_blocks()
>   ext4: introduce seq counter for extent entry
>   ext4: add a new iomap aops for regular file's buffered IO path
>   ext4: implement buffered read iomap path
>   ext4: implement buffered write iomap path
>   ext4: implement writeback iomap path
>   ext4: implement mmap iomap path
>   ext4: implement zero_range iomap path
>   ext4: writeback partial blocks before zero range
>   ext4: fall back to buffer_head path for defrag
>   ext4: partially enable iomap for regular file's buffered IO path
>   filemap: support disable large folios on active inode
>   ext4: enable large folio for regular file with iomap buffered IO path
> 
>  fs/ext4/ext4.h              |  14 +-
>  fs/ext4/ext4_jbd2.c         |   6 +
>  fs/ext4/ext4_jbd2.h         |   7 +
>  fs/ext4/extents.c           | 149 +++---
>  fs/ext4/extents_status.c    |  39 +-
>  fs/ext4/extents_status.h    |   4 +-
>  fs/ext4/file.c              |  19 +-
>  fs/ext4/ialloc.c            |   5 +
>  fs/ext4/inode.c             | 891 +++++++++++++++++++++++++++---------
>  fs/ext4/move_extent.c       |  35 ++
>  fs/ext4/page-io.c           | 107 +++++
>  fs/ext4/super.c             |   3 +
>  fs/iomap/buffered-io.c      |  30 +-
>  fs/iomap/trace.h            |  43 +-
>  include/linux/pagemap.h     |  14 +
>  include/trace/events/ext4.h |  31 +-
>  mm/readahead.c              |   6 +-
>  17 files changed, 1109 insertions(+), 294 deletions(-)
> 
> -- 
> 2.39.2
> 
> 

