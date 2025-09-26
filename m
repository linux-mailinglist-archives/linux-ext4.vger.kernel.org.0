Return-Path: <linux-ext4+bounces-10450-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0963BA5421
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D3B624B0D
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B712FF15B;
	Fri, 26 Sep 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LcsVVX2I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7528B4FD
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923309; cv=none; b=hZQ9+P431G2Ko0vCccdDDmXnI/bpNP/Ij+GCzYsGTao5Qymaf+6umJS/RmUt+MsL/JdWdHzTg2JqhFuF4VWEscO9mSDA563Vp4bPAspShLh1dJjSBpY4ibC5iJZWljocR+dqH4fGBmyHlG4K2srts7aNN7LSoS5ZgTWsoZ3D9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923309; c=relaxed/simple;
	bh=BnFE0JvdvCPh2emrsYkclOKwrvobWvMKY3x6HQKD8uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Awvo0zPWBwtOr5Pw3HHGILjkem09Y6srujNCcXgLETgx2HihYH3ghrVB+Bwc5boA+lC+GQhYBnO9F2B1iMB6Uj41UB9l1wm5m4Au/+AKJJCclggOM55vwfovGS8gJBCwpSR7hEfAdp/NnwlvKYpTcV1aTxcL2zIyD098jETaOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LcsVVX2I; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLltW1014734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923278; bh=rNxHeAQ3Ih20CrcoFXD60S/YyDevZ4VxueFiDj/xm9Q=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=LcsVVX2INv/kruTNiG4cV0C/atPQND7Jx+WY+ZYqSF6gcZm6p+5dx7dRDVOmQwoBG
	 n+eOd52H+tAcp1/q1X9MyxLbNfQoCQMtovyQeSc7Go3cpEhGmzsB65nzT1YnJCU909
	 0jGhDUdGvVXQn6pobjolVLednNT1zVzkCvp2yAMGNQRW8r1XlJf0GzGq8I3f4FAy56
	 2wY6a93H0uUN9nDAeIYct/LhsfpPi9CYuZkk45+PDSGT/0FsQ6AYezO52xFooCK1ug
	 8djPbdggXj7TTbIOw7Valp9OEi21Nf7pMPdt/K+4Gpv+ClSkjfcrKi2X7N21Bmaem4
	 RvZ3GiRPsQPRg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E2E952E00E0; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH] ext4: add ext4_sb_bread_nofail() helper function for ext4_free_branches()
Date: Fri, 26 Sep 2025 17:47:41 -0400
Message-ID: <175892300640.128029.15364886889531339470.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250821133857.80542-1-libaokun@huaweicloud.com>
References: <20250821133857.80542-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Aug 2025 21:38:57 +0800, libaokun@huaweicloud.com wrote:
> The implicit __GFP_NOFAIL flag in ext4_sb_bread() was removed in commit
> 8a83ac54940d ("ext4: call bdev_getblk() from sb_getblk_gfp()"), meaning
> the function can now fail under memory pressure.
> 
> Most callers of ext4_sb_bread() propagate the error to userspace and do not
> remount the filesystem read-only. However, ext4_free_branches() handles
> ext4_sb_bread() failure by remounting the filesystem read-only.
> 
> [...]

Applied, thanks!

[1/1] ext4: add ext4_sb_bread_nofail() helper function for ext4_free_branches()
      commit: d8b90e6387a74bcb1714c8d1e6a782ff709de9a9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

