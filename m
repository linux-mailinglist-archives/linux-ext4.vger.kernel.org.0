Return-Path: <linux-ext4+bounces-4993-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC1F9C09C9
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6F01C233D0
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2381921501F;
	Thu,  7 Nov 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="jDlmkL+X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE282144CD
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992417; cv=none; b=YeNKrJzBJEx3kyYHbMbN5EotS5gvw4xQbImPvGmCHp1mnX5MgZS7u3VBSr24TDsh4YHRrwnOzja/zSDCiHQAcfQCqfVXOKuD7iyOhzlRBWCJd3qvm4ZTc0I5AwEuC3gMCOhLQU/8izxaMKAR7SO8fjX/0It08fKRZEsrtbvdq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992417; c=relaxed/simple;
	bh=Jg4ytGyJPzSVZSYZ9ovDHmtORUtX/YMb6ZDk/+LF32I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSSIynu2jbJMVShi94qal76MaFsJ5eiykAj2y8glaJjQKBJzfZ9cnuemkoiUmviKRN1JU7L5PcWzC/IhEEfqTz601sMzk1d7tpGYD8TMI7jKxSuSHAGXyxbm4LMhUYnOOPnPs24gojSRKe0bPERh8FmdhGzWiinr+80S1346qKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=jDlmkL+X; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD8eD003610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992391; bh=OJPO9o9xC73sRxGQ6mMJoXJYxmQ9I3Ul/+DGELgcONY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=jDlmkL+XldCHJtmpERypOduQeHdg5Kd+/Pbam2kDC6LDtfT/VyhOtbOn4F18YU8D9
	 fv8nH3KvNsk+to57Euszvefapt/Wu6O6ZbRwpdKyXd93Mxn+w0yB+Y7n/Cr/bOdY/z
	 C2MzymqW0HhiHhQk41XRhTytav7iltQgxsbvkP5PvHgFaaCpG0YQAGCHUHYfiUSxBR
	 a91YmzMAnSaL06BpQZL4vhFlgwG229SwOerNRDV9GmOLhIgeV9rDvY6vooWgtKsK+O
	 w/ZkbK3Y/lQycboPu+34OI7KDtmAJZEqmcNOrap6MRVeE1b3Qq9CgWRDtpaBgR/lAl
	 /gHbN0m6xrBxw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 52F1115C1E39; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
        steve.kang@unisoc.com, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
Date: Thu,  7 Nov 2024 10:13:03 -0500
Message-ID: <173099237652.321265.9092728480077110829.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904075300.1148836-1-zhaoyang.huang@unisoc.com>
References: <20240904075300.1148836-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 04 Sep 2024 15:53:00 +0800, zhaoyang.huang wrote:
> cma_alloc() keep failed in our system which thanks to a jh->bh->b_page
> can not be migrated out of CMA area[1] as the jh has one cp_transaction
> pending on it because of j_free > j_max_transaction_buffers[2][3][4][5][6].
> We temporarily solve this by launching jbd2_log_do_checkpoint forcefully
> somewhere. Since journal is common mechanism to all JFSs and
> cp_transaction has a little fewer opportunity to be launched, the
> cma_alloc() could be affected under the same scenario. This patch
> would like to have buffer_head of ext4 not use CMA pages when doing
> sb_getblk.
> 
> [...]

Applied, thanks!

[1/1] fs: ext4: Don't use CMA for buffer_head
      commit: ef60f4aab81d2ce5984135e6af1abcce56a425d7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

