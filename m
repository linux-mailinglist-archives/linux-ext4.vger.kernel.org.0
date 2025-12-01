Return-Path: <linux-ext4+bounces-12107-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1AC983AC
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B729341369
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC7233344A;
	Mon,  1 Dec 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="aZe4/mMD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA931CA68
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606314; cv=none; b=McpnoxFO1D175m/AZcwGY2sPxqAiFEM3IyRsYMdB9Epl9BfLPdRvUdi0ckwbeNgNzr4Bi0slqGfjRPZbQDDIMsqg9raraUPzPPgUQ4XFQF3me87A1046K8ZyTwyWy3cXrh7v3jLDkGSRYeRlRf8sns3mUpuy4SkmNzzvqB0sBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606314; c=relaxed/simple;
	bh=p2u9NAas6QKUTDy/nS+Iz2PPP/4piRiGsukuTIuufzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMCeOiwHGQk34tOZwgN/SQ9Kri4NTfJWxsrXkCrfhy2y4sGZ+i2suIniEgOYgtDgpH6iqXM7ItZytvWE1eBn/eXaNkt2XAEpOQdhF3XkHHj8p8X0KoVwuarLUFWJ/wDlT/VjYtKOIkCBfXnFYQpZf3EgM+igv36Z7IKjPmzKsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=aZe4/mMD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GNssc008160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764606238; bh=LUdYErnUgaQxiKQxs7/vJqTY4M8G2BTCyWqurAk5vmM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=aZe4/mMDBJMxLxtCbDi840JDbqHI9Ruusnd9B2a1965UzO3h/Lkj9LHG0znHtRiBc
	 4p/A08Uk0DL+Fc1unGHJi2jMI0IRcSLlCMCBGVIrTEgvKwxEUz63O8vQEjBAqkinNa
	 r3+Ud+3Bf3rMD8P0v+hk1nhzdCLLPnnQsHE0QRe3BjAHdmMz60bs+GwexvfFbnQ4Nt
	 PhTaD3D1Ikh2esrp291mCIime77dTxj3C/N7MHTKIMYVOJDH0xQcaTGMQHBq37aeQ4
	 o95w48HKejfUQIDNjKT9ZRfHL6MTL8WpZ9wVGzcChzg9J66/7CTDC3y9xwfylbeZ2q
	 tv9dKVu3iNBrA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 012482E00DC; Mon, 01 Dec 2025 11:23:54 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v4 00/24] ext4: enable block size larger than page size
Date: Mon,  1 Dec 2025 11:23:46 -0500
Message-ID: <176455640537.1349182.6031269946896525103.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121090654.631996-1-libaokun@huaweicloud.com>
References: <20251121090654.631996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 21 Nov 2025 17:06:30 +0800, libaokun@huaweicloud.com wrote:
> Changes since v3:
>  * Collect RVB from Jan Kara, Zhang Yi and Pankaj Raghav.
>     (Thank you for your review!)
>  * Patch 21: Fix lock imbalance in ext4_change_inode_journal_flag.
>     (Suggested by Dan Carpenter)
> 
> [v3]: https://lore.kernel.org/r/20251111142634.3301616-1-libaokun@huaweicloud.com
> 
> [...]

Applied, thanks!

[01/24] ext4: remove page offset calculation in ext4_block_zero_page_range()
        commit: 5835b1339e33549d9e7342fae56243b4fcd758c9
[02/24] ext4: remove page offset calculation in ext4_block_truncate_page()
        commit: b73f45a32420a8393e92fb2dec3b7d109e565127
[03/24] ext4: remove PAGE_SIZE checks for rec_len conversion
        commit: afa6d5a16bf2e354e183a4fcbcdb8578798e9942
[04/24] ext4: make ext4_punch_hole() support large block size
        commit: d37a7ddd3a384bd34f985273d6e776d3d50b0edd
[05/24] ext4: enable DIOREAD_NOLOCK by default for BS > PS as well
        commit: 58297412edf077870eedce2481db5755b4e98474
[06/24] ext4: introduce s_min_folio_order for future BS > PS support
        commit: 8611e608a8fa01e8b82c9008b4dac9f24531ae0f
[07/24] ext4: support large block size in ext4_calculate_overhead()
        commit: 6a28b5c9908d6e7ea13eae7a5872e8e081a397c4
[08/24] ext4: support large block size in ext4_readdir()
        commit: 609c5e0081b432caaa557ffcf1318aefe1187c4e
[09/24] ext4: add EXT4_LBLK_TO_B macro for logical block to bytes conversion
        commit: 125d1f6a5a77ed6a1af3eb0957240f54e4124af2
[10/24] ext4: add EXT4_LBLK_TO_PG and EXT4_PG_TO_LBLK for block/page conversion
        commit: 2a8de76b2b0f84333a2778db04ce51811c260d9d
[11/24] ext4: support large block size in ext4_mb_load_buddy_gfp()
        commit: 6117f1806a7328e8d316eeeac66b2ba4e4539ba5
[12/24] ext4: support large block size in ext4_mb_get_buddy_page_lock()
        commit: 3938fc29f89fff132929b2fea2fe00b0f43617ca
[13/24] ext4: support large block size in ext4_mb_init_cache()
        commit: 0ad55fa104a2aa5980c12f88546fab328d34644b
[14/24] ext4: prepare buddy cache inode for BS > PS with large folios
        commit: 31daa8261c54404513cf7ac81d1f79ff1cdbc36e
[15/24] ext4: rename 'page' references to 'folio' in multi-block allocator
        commit: 65c39954bb92b3f2ab5fb179225b8c8788c79afd
[16/24] ext4: support large block size in ext4_mpage_readpages()
        commit: a6d73242b8b5caa9f9a529eab49cc1e85ace9890
[17/24] ext4: support large block size in ext4_block_write_begin()
        commit: bff6235d623a022260b8af5559ced3534fb7fc2e
[18/24] ext4: support large block size in mpage_map_and_submit_buffers()
        commit: b967ab748765bf2cf9512efaa8aa987ab4482c7d
[19/24] ext4: support large block size in mpage_prepare_extent_to_map()
        commit: 8e50e23b769ace4885fc132e6fca2b4343c27fb1
[20/24] ext4: support large block size in __ext4_block_zero_page_range()
        commit: c00a6292d0616c304cb712d823370f1a82f899b2
[21/24] ext4: make data=journal support large block size
        commit: 58fd191f99f3791c6687e98041c89a6477d9f64d
[22/24] ext4: support verifying data from large folios with fs-verity
        commit: 1a3e9e8aa4f72440b00ef6171b4198f82822d679
[23/24] ext4: add checks for large folio incompatibilities when BS > PS
        commit: 709f0f1f1bf5ca62a000084e5446ca6b57c8678c
[24/24] ext4: enable block size larger than page size
        commit: cab8cbcb923a89cb583c9088fa50431eb2feded5

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

