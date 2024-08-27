Return-Path: <linux-ext4+bounces-3902-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B4960AEB
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDBD1F23BE7
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5EE1BF805;
	Tue, 27 Aug 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KycDx7JK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BC1BCA19
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762872; cv=none; b=HkwhbaVcVrOOGlGcmDThXqVjasVXyLRJrSqBhKE0d9vanHZZhEFdQR015SwWK0fYw0XCJEb7pM0LqWK4lpaSCpHKUsPHj/QgG9MfNivbmTDRPL4/Qo5laFjk8UH7jzd12QvhdfLVvYZsZk0Ou6Te2U66NziAfu89Lj5E9JzlseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762872; c=relaxed/simple;
	bh=BadwHJbBYKz8Pt8bxgpD8DrZ3nrlXucHaDMo5AlbvnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrzHRKFZ1jDxiAk5RLW/M02okwGpI1TRAOL1ZMsxeCFlaAguf9YWhPddtx3GyCn1Z04Nr8lEAGWiEXXnYJ59l9buTB5iFWmBi3KHU8MLUCptArWnZJr+Zcg9bwuDwCqLCxun9GVKFK5gf1difPcd30PB++9gpaj8+Qw+d9mmKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KycDx7JK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClfc1021510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762863; bh=ll1YDNM9uOBU+tYnb++FSoy7a1iraSTFkbmIXR16hZE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=KycDx7JKkjWSDoK7Qdsm4NwSC1Ou23ew+i9X7zv+9fjwx/7Um5H5FBlmfSJzUVuFq
	 wgAoe4bPzelEKufGMkmh4qXvRrQPIUkbAiDj01gQwP7hLZHe82dW87C4iBAM4oL7ab
	 MeaEDXoe3Mlk1QQeMwOr4zoS9UdxyYsUaNcRy0BsVQvPlFzBvqbptMssXVGczIvm4j
	 2a/uPuyzFEjh54d5TCheEo4oo28riwlSsGTwJSw38RR3yQt7YHk45QYnDMZDgZxvRo
	 a9MgyMdCtCA6s9pWOjWafzj6yQ17mws8ypuTv8TNQhVZLHS4olwPhdZ2qGBXeOW2oV
	 nCxE8t4KVIZ1Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BDA2915C19A9; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaxi Shen <shenxiaxi26@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, skhan@linuxfoundation.org,
        javier.carrasco.cruz@gmail.com, syzkaller-bugs@googlegroups.com,
        syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix timer use-after-free on failed mount
Date: Tue, 27 Aug 2024 08:47:29 -0400
Message-ID: <172476284017.635532.12571452606052946369.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715043336.98097-1-shenxiaxi26@gmail.com>
References: <20240715043336.98097-1-shenxiaxi26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 14 Jul 2024 21:33:36 -0700, Xiaxi Shen wrote:
> Syzbot has found an ODEBUG bug in ext4_fill_super
> 
> The del_timer_sync function cancels the s_err_report timer,
> which reminds about filesystem errors daily. We should
> guarantee the timer is no longer active before kfree(sbi).
> 
> When filesystem mounting fails, the flow goes to failed_mount3,
> where an error occurs when ext4_stop_mmpd is called, causing
> a read I/O failure. This triggers the ext4_handle_error function
> that ultimately re-arms the timer,
> leaving the s_err_report timer active before kfree(sbi) is called.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix timer use-after-free on failed mount
      commit: 0ce160c5bdb67081a62293028dc85758a8efb22a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

