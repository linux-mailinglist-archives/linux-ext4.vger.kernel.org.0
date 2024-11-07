Return-Path: <linux-ext4+bounces-4994-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E109C09CB
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 16:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E943AB252D2
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEDF215C6A;
	Thu,  7 Nov 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fbfog9Rf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BB2139C9
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992420; cv=none; b=cu8EGXA2WZ1A685y0c1EcMdhnmIwa3ntwDpOqebCFWdo49sJkJ8tPfpwl4CcCy/4hntEUtoMkVnUvsUnbm7Og8finjf1/Shac28iDFmJfKM0pbCqVhCD6It1h5rksX1165N3eZ1gCEQKi+OnyweaDID15s5QBiM6JQVkqc2q6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992420; c=relaxed/simple;
	bh=9qt4V0ccHc0UX37sY4hMOqtIZPABzA7z7I8clwPSfuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cbbe7tCqP4+OPVCtNddljTy9PJBNgJtnyuqIBMDHozrOuHsmu0u9o+0zfTYwAJln9hYzA4pvBO/vvH30pV4czDo0m2Xb3d/HiPMMU2v2oEgwfjFVDHTqUbFdEcus7noQHzTUDaSZ/C2i/kdOYRBAB2bFMqnOwu6FkzuCZ2MEwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fbfog9Rf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD8TZ003575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992391; bh=v/qVTHOljAISwUK06181QYvI3vNOJSHeGigUMv0sbmo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fbfog9RfIIO/dQ/H3xytlGn4O0MbdrQgs9Cux58Fr/9fRoE8XSQzic/6hvvcKHpYx
	 6eVEGdctC2Vzkpz5Ahu+u8JnrErvccXhcBUc/49WAyTeNDEL5zE1CbaT8Ii5fs9M7f
	 URbNjuSCEw7oMsZGMkrWM4kginjFGoxmjGdyqRGjMLAnjStUps0r8VsCK2KCmOBji/
	 Sgh32snTo/fzpku/XoMMxUyz98K3N2a31ndK8ykkh5a02nYlJpHsETWkbVX605QUcT
	 TPo26o4oo456ftNnxJ5AYHAmsBlAn4roBobnECkUbSMigJmQSkvF0Mq9+JClG8bxaj
	 L+DeQTn3mkh6A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4CDAB15C1A13; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v2 0/6] some cleanup and refactor for jbd2 journal recover
Date: Thu,  7 Nov 2024 10:13:00 -0500
Message-ID: <173099237655.321265.2925765114453172886.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930005942.626942-1-yebin@huaweicloud.com>
References: <20240930005942.626942-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 30 Sep 2024 08:59:36 +0800, Ye Bin wrote:
> Diff v2 vs v1:
> 1. Modify the indentation problem and remove unnecessary braces in PATCH[4];
> 2. Add PATCH[6] to remove the 'success' parameter from the jbd2_do_replay();
> 
> Ye Bin (6):
>   jbd2: remove redundant judgments for check v1 checksum
>   jbd2: unified release of buffer_head in do_one_pass()
>   jbd2: refactor JBD2_COMMIT_BLOCK process in do_one_pass()
>   jbd2: factor out jbd2_do_replay()
>   jbd2: remove useless 'block_error' variable
>   jbd2: remove the 'success' parameter from the jbd2_do_replay()
>     function
> 
> [...]

Applied, thanks!

[1/6] jbd2: remove redundant judgments for check v1 checksum
      commit: 1438c95d4541fb7283c13d3d65b95fd91010a903
[2/6] jbd2: unified release of buffer_head in do_one_pass()
      commit: ed6eb7b7fc53405e57c988b0ff60ae845470ca04
[3/6] jbd2: refactor JBD2_COMMIT_BLOCK process in do_one_pass()
      commit: 21e90d4ca19fd9353ff5e02182ae80ef926afc84
[4/6] jbd2: factor out jbd2_do_replay()
      commit: 0b85400756de5678f9e581eb7698c6e35f578a16
[5/6] jbd2: remove useless 'block_error' variable
      commit: 4b3703e8200e0d8dcf46411f148bbb1d22d59525
[6/6] jbd2: remove the 'success' parameter from the jbd2_do_replay() function
      commit: 1c77bb71e581d101df54df95c30407621d87ba68

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

