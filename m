Return-Path: <linux-ext4+bounces-1370-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8C85FD3D
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 16:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B64B2872A
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9311509A8;
	Thu, 22 Feb 2024 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PxY2RfhA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4D14E2EE
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617320; cv=none; b=NOzznFeIgiFYIp4TQcRZWO4ed5TJHVTrWrlID0iBo9NyqCbaeN92qcEs6Rya9a30Dii+I/VkP5Kkl2y95xcCqfBNJSMjp9y4dr/iN6cHHkfaiwbvYRijIQMoCyeiHR/LfwPuanPWuSjZp8Yp+zk7h97X7wrR9Lb8Fm5cdgCRLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617320; c=relaxed/simple;
	bh=/sAuWoxygbHnz3bPYEk5pc98OZZN/efFuyFbLWL+ycI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpA9mgbSSB4omzBc22Sp3PUayyrzZfAf0j6kDqXBV2tQNNEVTZFrsW8YMciaRoivFGvF9DCxBGj8w3zivROyrkqpQbGZ2L/fEigXpcIIADALztQaIZ4+NV/GLRnzPjI1oF/VMNcvzPXou3YZ1oVj3PIfBZ8z0Dd6xnbu5cABnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PxY2RfhA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFseXX030787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617283; bh=Tw39zUJjdOXe0uc8tGlhBxpYxPbuviy9TTm3QaYl5P4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PxY2RfhAxGuhzUwdu0P3DJ6S97aV0dSUEXsmJ7GlKiVF21cUmtEwPyWvz2y4hnDiG
	 bvOh4O2+YQbraST+paOtrw4GDht926QQ04i/OgeT/7vHJmluJdsbtCoX/9A9Z90r68
	 yMTcQHjRL1QIOktmobcK3rClwOy7DSgH+tuxthOmmwmvg9+jdWdj1AZegYAXSXSIO9
	 SGGTdo1+4kOOQqwnpb3FLCa2HOE9T/7excuepn4mBEs7EKLkDNCqsyMuY1Y5awNqmy
	 PU+PJhS4Xfuu+l+qFD89in/j+aPydLrT3K4cRCFdI65MEZC1cUvl+8V4RIXzTO3H9R
	 wJzKafkwl/ayQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3887415C1414; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
        stable@kernel.org
Subject: Re: [PATCH v2] ext4: correct best extent lstart adjustment logic
Date: Thu, 22 Feb 2024 10:54:31 -0500
Message-ID: <170861726753.823885.11358303915766853695.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201141845.1879253-1-libaokun1@huawei.com>
References: <20240201141845.1879253-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 Feb 2024 22:18:45 +0800, Baokun Li wrote:
> When yangerkun review commit 93cdf49f6eca ("ext4: Fix best extent lstart
> adjustment logic in ext4_mb_new_inode_pa()"), it was found that the best
> extent did not completely cover the original request after adjusting the
> best extent lstart in ext4_mb_new_inode_pa() as follows:
> 
>   original request: 2/10(8)
>   normalized request: 0/64(64)
>   best extent: 0/9(9)
> 
> [...]

Applied, thanks!

[1/1] ext4: correct best extent lstart adjustment logic
      commit: 4fbf8bc733d14bceb16dda46a3f5e19c6a9621c5

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

