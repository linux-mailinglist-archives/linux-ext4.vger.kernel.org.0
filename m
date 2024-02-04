Return-Path: <linux-ext4+bounces-1093-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C832848B1C
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Feb 2024 05:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD945B243FD
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Feb 2024 04:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86E8BF9;
	Sun,  4 Feb 2024 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TfEqg8zS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22C8BF3
	for <linux-ext4@vger.kernel.org>; Sun,  4 Feb 2024 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707022696; cv=none; b=r8843UU0ntHq4vXv/3xjThp5ncOvnPg9WwTgAw4CyCuFOH6eLP6RJRBIf8Hi4IppPuG316mToZkZHISHrxefBsVV2CAogqsiSU5L45E/LBulpiskZCEsaYBQ0PA1/csI8vell62itW7ACHEyls5r2x1zLUFJrDIBPItfBiGrp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707022696; c=relaxed/simple;
	bh=MM3MOto1zlu39y1jV9m4Xjz7/BS0oEHqaTOfKjIdVa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYAK8oQWJb3zBFtO8tU0kK+J+YkKxAmcalIx5ORPVwqXsdYXdluTIIWw+bJTwKjTl/ic0SIr8qSzqais0JZt7nr24FpsfDwMxFCbnGg1ir+IEaZbNZIn1GLQ4O2oIR7a6YPGrEV1fzGr0zzcr9JzJd8w40r8QqZdXuc1sFzm7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TfEqg8zS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4144vfvf014319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 23:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707022666; bh=73nG5emiLho6o2L78eCep2kYVU6SzMamnnyIbcxLMfU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=TfEqg8zSj4I9fkNQNMMHLcRFuRDfOnWoajgs92AHROByuHvtqK4jzjLEXN0SCR4BT
	 /REqFRRKK/lHxUfr5g6VG5PFTMRt6D8Xt1g1y6tTUCzCPowMh82on2zw39AdExhT1T
	 51l/UFFq5xIsHwu92Jfk72gou94ChlUAGdxdNvrzNNn0u8d7TQQ63bYo3826Vst7+D
	 eKFNaYIySzuY3mPNo/1asVYdwI8zU+PHyBia4QdZyJr1TB8d32gc7hYNq5Uty+UveB
	 nhu35wIwYKj+waeEViLWHW0KgbtnMdnHG5hNbypfKKGuHo2eKUgwuDmnhQP7Yjbd8B
	 jrTrydYkkbmSw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A656E15C02FD; Sat,  3 Feb 2024 23:57:41 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 0/8] ext4: fix divide error in mb_update_avg_fragment_size()
Date: Sat,  3 Feb 2024 23:57:36 -0500
Message-ID: <170702219298.205725.12570295713288350540.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104142040.2835097-1-libaokun1@huawei.com>
References: <20240104142040.2835097-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 04 Jan 2024 22:20:32 +0800, Baokun Li wrote:
> V2->V3:
>   Replace patch 3's changelog with the one suggested by Jan Kara.
>   Refactor the code in patch 4 to make it more readable, as suggested by Jan Kara.
>   Patch 8 is adapted based on patch 4 after modification.
>   Add Reviewed-by tag.
> 
> V1->V2:
>   Fixed some things pointed out by Jan Kara.
>   Fixed more cases where blocks could be allocated from corrupted groups.
> 
> [...]

Applied, thanks!

[1/8] ext4: fix double-free of blocks due to wrong extents moved_len
      commit: 55583e899a53
[2/8] ext4: do not trim the group with corrupted block bitmap
      commit: 172202152a12
[3/8] ext4: regenerate buddy after block freeing failed if under fc replay
      commit: c9b528c35795
[4/8] ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()
      commit: 2331fd4a4986
[5/8] ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
      commit: 993bf0f4c393
[6/8] ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
      commit: 4530b3660d39
[7/8] ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
      commit: 832698373a25
[8/8] ext4: mark the group block bitmap as corrupted before reporting an error
      commit: c5f3a3821de4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

