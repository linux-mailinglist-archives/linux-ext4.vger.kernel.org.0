Return-Path: <linux-ext4+bounces-261-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5CF800DA7
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 15:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971DC281BF2
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC493D999;
	Fri,  1 Dec 2023 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fOxxb2mK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD001715
	for <linux-ext4@vger.kernel.org>; Fri,  1 Dec 2023 06:47:34 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B1EkvpZ005615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Dec 2023 09:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701442020; bh=kArsuLagsSnYy/Wige3LZnikmXXjnr7ZjdM85XfWUMQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=fOxxb2mKE0KV987CyElNlxzOFvPu7JIxFgB6eAJd2sxQKtC6QZTFGVRHEcC65W/aq
	 4wURw7svKD0bD3Kq0Y7hDinQBAm2JoCPhlhoD8IplEo1eM1jJuRYdiHjvTY8JYNW9p
	 d7wxBe83et/K1i7I7lovT1D88M/Sdr4KXBx3/QrcsFkmbjXc+4CxOTLrOi3ozfjTpS
	 B6iGc2ha+/NVtlyQxt+6h0oSN2YtdJsV60iqERx56Ygyw8CZ6Jh5JBQoOJ/MMVj06X
	 Qhuarot+BqNf6APmPyMpI1XtEhlIe3f41psUBIqpN4UYN0zvbS3FSLKy4P9BE7prfU
	 IGUWFDtXlgW3w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5E5F515C0290; Fri,  1 Dec 2023 09:46:57 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org, djwong@kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        stable@kernel.org
Subject: Re: [PATCH] ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS
Date: Fri,  1 Dec 2023 09:46:55 -0500
Message-Id: <170144199127.633830.13561950566118838688.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231127063313.3734294-1-libaokun1@huawei.com>
References: <20231127063313.3734294-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 Nov 2023 14:33:13 +0800, Baokun Li wrote:
> For files with logical blocks close to EXT_MAX_BLOCKS, the file size
> predicted in ext4_mb_normalize_request() may exceed EXT_MAX_BLOCKS.
> This can cause some blocks to be preallocated that will not be used.
> And after [Fixes], the following issue may be triggered:
> 
> =========================================================
>  kernel BUG at fs/ext4/mballoc.c:4653!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  CPU: 1 PID: 2357 Comm: xfs_io 6.7.0-rc2-00195-g0f5cc96c367f
>  Hardware name: linux,dummy-virt (DT)
>  pc : ext4_mb_use_inode_pa+0x148/0x208
>  lr : ext4_mb_use_inode_pa+0x98/0x208
>  Call trace:
>   ext4_mb_use_inode_pa+0x148/0x208
>   ext4_mb_new_inode_pa+0x240/0x4a8
>   ext4_mb_use_best_found+0x1d4/0x208
>   ext4_mb_try_best_found+0xc8/0x110
>   ext4_mb_regular_allocator+0x11c/0xf48
>   ext4_mb_new_blocks+0x790/0xaa8
>   ext4_ext_map_blocks+0x7cc/0xd20
>   ext4_map_blocks+0x170/0x600
>   ext4_iomap_begin+0x1c0/0x348
> =========================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS
      commit: 2dcf5fde6dffb312a4bfb8ef940cea2d1f402e32

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

