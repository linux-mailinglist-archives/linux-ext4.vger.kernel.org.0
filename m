Return-Path: <linux-ext4+bounces-4068-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254696DCB6
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6F6289DDD
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3393E1A01BA;
	Thu,  5 Sep 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MOeDHXQw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56E1A01A9
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548068; cv=none; b=bxkTm7JLzHBUyHb0zkh4V5QRlOq17fvgzjcowWZ2wwgWdCZ7ebQtPcovXhJaRdKxsBYDPHcdoHnsspIuzX7j0W001voC1zqoCiaHA3UYl/zDhhKj6IxmnW5ePyXsHPo7EM4nXUaamQmJdToUuvKXKoSTRxhUMdAiH/DnN9cf+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548068; c=relaxed/simple;
	bh=4Z9k+nZa8CSbLPSjXwgwUCdsfnCGfQfRgffPcO+MX+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2ow/dunmz55AVDABe9+CF2LOQMRAiWd8CfkgJlOKCq0wOK1j6lRYOAJSULLn2jFu7OAuALMCUsPuF7L08DD7/etdY5GPS8foW7ifovEOH728+U0Ew7vYSxRbYtAuPB0j4D3LyvUtycB/xzgCEFYh0UD+dlJxlSAOF2PbhPJSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MOeDHXQw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485ErsNs004663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548038; bh=jmjyksdm3GoMn6X+WThCrFA0srCIQpT9DSWxDt3GJcI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=MOeDHXQwSJkA/SFicK7IcIQut3A8y+LH1NLSoleSllcB80B8NH4GqcJu/0cMMUYIx
	 Ayv4wsdMknK+ZkrJvPb0VuN1Kofx5wAr0arMI08ZKrHUypNL69YVps022uxYFj440K
	 ZEiD553bULN0tCMBXq1GdtNT8fpC3M4NIkeFWsNkIxe68xeHAfFOudM7xoqlVmqCP6
	 BXi2p46jZlODw2TtMfOQdZ8XghOdw3zlFBa50BbgZBjxyNCQFFtrjzsf7GZiD1/LoS
	 tbvQ/GnRB2Gp+Pefq+MSoq+vrm5jCT4gtZcFHo/jldBtx1bcsLM1hCBMYrY0QA8wZQ
	 cefvgZczk9kbg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E231F15C1972; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 00/25] ext4: some bugfixes and cleanups for ext4 extents path
Date: Thu,  5 Sep 2024 10:53:43 -0400
Message-ID: <172554793832.1268668.18180660356908900484.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822023545.1994557-1-libaokun@huaweicloud.com>
References: <20240822023545.1994557-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 22 Aug 2024 10:35:20 +0800, libaokun@huaweicloud.com wrote:
> This patch series is a hardening of ext4 extents path related code.
> 
> This is the second version of this patch series. Thank you, Jan Kara and
> Ojaswin Mujoo, for the feedback in the previous version. The new version
> has no functional changes compared to the previous one, so I've kept the
> previous Reviewed-by, please let me know if you have any objections.
> 
> [...]

Applied, thanks!

[01/25] ext4: refactor ext4_ext_rm_idx() to index 'path'
        commit: edfa71dbe841075109e3e1da7d3925b45328ed25
[02/25] ext4: prevent partial update of the extents path
        commit: 3e8a584c82cc999b99ea17c31fc2da101201545f
[03/25] ext4: fix slab-use-after-free in ext4_split_extent_at()
        commit: c26ab35702f8cd0cdc78f96aa5856bfb77be798f
[04/25] ext4: avoid use-after-free in ext4_ext_show_leaf()
        commit: 4e2524ba2ca5f54bdbb9e5153bea00421ef653f5
[05/25] ext4: update orig_path in ext4_find_extent()
        commit: 5b4b2dcace35f618fe361a87bae6f0d13af31bc1
[06/25] ext4: aovid use-after-free in ext4_ext_insert_extent()
        commit: a164f3a432aae62ca23d03e6d926b122ee5b860d
[07/25] ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free
        commit: 5c0f4cc84d3a601c99bc5e6e6eb1cbda542cce95
[08/25] ext4: fix double brelse() the buffer of the extents path
        commit: dcaa6c31134c0f515600111c38ed7750003e1b9c
[09/25] ext4: add new ext4_ext_path_brelse() helper
        commit: 6c2b3246cd0b951338c54b10f8ca13c59a41c86a
[10/25] ext4: propagate errors from ext4_find_extent() in ext4_insert_range()
        commit: 369c944ed1d7c3fb7b35f24e4735761153afe7b3
[11/25] ext4: get rid of ppath in ext4_find_extent()
        commit: 0be4c0c2f17bd10ae16c852f02d51a6a7b318aca
[12/25] ext4: get rid of ppath in get_ext_path()
        commit: 6b854d552711aa33f59eda334e6d94a00d8825bb
[13/25] ext4: get rid of ppath in ext4_ext_create_new_leaf()
        commit: a000bc8678cc2bb10a5b80b4e991e77c7b4612fd
[14/25] ext4: get rid of ppath in ext4_ext_insert_extent()
        commit: f7d1331f16a869c76a5102caebb58e840e1d509c
[15/25] ext4: get rid of ppath in ext4_split_extent_at()
        commit: 1de82b1b60d4613753254bf3cbf622a4c02c945c
[16/25] ext4: get rid of ppath in ext4_force_split_extent_at()
        commit: f07be1c367369636d7d338d7994473d6eae283c5
[17/25] ext4: get rid of ppath in ext4_split_extent()
        commit: f74cde045617cc275c848c9692feac249ff7a3e7
[18/25] ext4: get rid of ppath in ext4_split_convert_extents()
        commit: 225057b1af381567ffa4eb813f4a28a5c38a25cf
[19/25] ext4: get rid of ppath in ext4_convert_unwritten_extents_endio()
        commit: 8d5ad7b08f9234bc92b9567cfe52e521df5f6626
[20/25] ext4: get rid of ppath in ext4_ext_convert_to_initialized()
        commit: 33c14b8bd8a9ef8b3dfde136b0ca779e68c2f576
[21/25] ext4: get rid of ppath in ext4_ext_handle_unwritten_extents()
        commit: 2ec2e1043473b3d4a3afbe6ad7c5a5b7a6fdf480
[22/25] ext4: get rid of ppath in convert_initialized_extent()
        commit: 4191eefef978d734fa8249bede3f9b02a85aa3c0
[23/25] ext4: refactor ext4_swap_extents() to reuse extents path
        commit: a2c613b8c4860d5e70010e7391fff727c5d96bab
[24/25] ext4: make some fast commit functions reuse extents path
        commit: 2352e3e461926b59f01c1e39fbb0494891cff997
[25/25] ext4: save unnecessary indentation in ext4_ext_create_new_leaf()
        commit: 5f48d4d9d8556ffa934537f0c000f9c3e108da66

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

