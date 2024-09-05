Return-Path: <linux-ext4+bounces-4066-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BDE96DCB3
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 16:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B561C21971
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A91A00FA;
	Thu,  5 Sep 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WgkyMrlI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB719FA9C
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548066; cv=none; b=uTZgJX64jRLTi9Yf2oVsj1rFC55M3Nt0r3uczoaBTK3iQ5WkR7KpT8DPTCD9/CYX7S8vYm9wdJVSOwVCJ8BUdOGfuKVPPNMSCXBdYyjI35EayMLQ5Gb6bOJIk8ROo51/Y+I5Y8JU0y7HIP9cZvvPDSdikRqbA34EyXnf3XAVbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548066; c=relaxed/simple;
	bh=Zs6fHYhHxtU3Mhv+52yP+Qf3schKL124pKVBoNo/XpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7/Ttz+cBdrH1loR58D3ZKD2sBgzwN/DPLbY4vzjMyU/094HRFD5PgO7qsQLY2pyQsKhbcbI7IFDA76BU3WqaaXDdOk+3j/uBQK6XTWrH491E82wtqCbR5Lb9Xr74OrJHrUsnZnsiictlzo+yUY+4BirjNqdb32awYIavxyVJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WgkyMrlI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485ErwXe004711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548041; bh=KJdygHWncU3g/fYHse0ueuNCiTIZ9PgXATycU/SQZYo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WgkyMrlIjOwRI97Tibi0702bshuBtEUNAGRhB9FVshHyuon/xPr7Oglq7SK6+s84a
	 +ESQvRsGui0p6d44PCKwimBmcvDncVggFTfdNzltUGLJXfnAXB2IVo0cYjdU8LQCNH
	 O9EYvH0pHVnG0sg6kmQozpHc8Tuepqc2MAemWBkD8O3FRtvT0MoVYNhQ8CTjgGXFYA
	 L3J9JBMsM6UqkjF06TMsCS1hMS6Lzky6i5sqP2JMxPjTbEbYvpql2rmyjFbFKp/Gtj
	 DSQt8PARaTCLQAuSlaLU6YIYOt7rkUt0N8whtmQoXsMg46jBXEhiA9gEfyzdJbpLwT
	 oRYEgaAC3prrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E760315C1A13; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, jack@suse.com, ebiggers@kernel.org,
        zhangshida <starzhangzsd@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Subject: Re: [PATCH v6 0/4] Fix an error caused by improperly dirtied buffer
Date: Thu,  5 Sep 2024 10:53:46 -0400
Message-ID: <172554793835.1268668.9241893620848455490.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830053739.3588573-1-zhangshida@kylinos.cn>
References: <20240830053739.3588573-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 30 Aug 2024 13:37:35 +0800, zhangshida wrote:
> On an old kernel version(4.19, ext3, data=journal, pagesize=64k),
> an assertion failure will occasionally be triggered by the line below:
> ---------
> jbd2_journal_commit_transaction
> {
> ...
> J_ASSERT_BH(bh, !buffer_dirty(bh));
> /*
> * The buffer on BJ_Forget list and not jbddirty means
> ...
> }
> ---------
> 
> [...]

Applied, thanks!

[1/4] ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers
      commit: 3910b513fcdf33030798755c722174ef4a827d2a
[2/4] ext4: hoist ext4_block_write_begin and replace the __block_write_begin
      commit: 6b730a405037501a260d6efd24782d2737e65d07
[3/4] ext4: fix a potential assertion failure due to improperly dirtied buffer
      commit: cb3de5fc876ee9ef2b830c9e6cdafac5c90903ef
[4/4] ext4: remove the special buffer dirty handling in do_journal_get_write_access
      commit: 183aa1d3baea18b199505455a0247b13de826e2f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

