Return-Path: <linux-ext4+bounces-1250-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF4B85689F
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Feb 2024 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98A71F23103
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Feb 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE6133982;
	Thu, 15 Feb 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="J64dugUe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463167CF03
	for <linux-ext4@vger.kernel.org>; Thu, 15 Feb 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012727; cv=none; b=UErDM3TdZtRB4CGyhVZR5brqrv7o8QZFLWYZxtNDwRo6ioKeE212SiSYRAefalCjp9AS3ZyoGD/Nk8fWm5YK+dQ5m6jRiYKDY2oj/hZlRMOMNVPEg9+Fbn3AMntwgVLUvvqTCzALPkQcAmLhYc6SL0sXcbufhKQgjewoZQzNmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012727; c=relaxed/simple;
	bh=eIsU37tYzInmaHRipq7y9TWJ/HG2GIdzgAvYwREqvvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q13lxbO5WsoxYxeYb/s5mJNGzqRFv6fB89UiQUd1nfWbBnPcq/pFq/MLxY+Z3mwnUcAxBeOAo8Eao2ygyzrGblL0qPeoJ9oEpUCG3OwIApBCnpaibhfQuRz5gSh1ygChtcrw7rP0SVN06do67yQJNOk2QbcgXupOupK13uRBD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=J64dugUe; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-68.bstnma.fios.verizon.net [173.48.116.68])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41FFwJ4d024827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708012702; bh=ziNCxk5Fw1xseh3Sg36UUTITDZiH/WcD0CrZmgDMZk8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=J64dugUeVimZIU7EgjMHLBa0xUOBfXzURaazQa5AZlEVhrxxdypWsYkNT4Mcg8N14
	 oXACta8kS5qNfNoB1tJV41AiC4JoGsPNFJ+Xkr4dKmJezHwrV0sVNLz4YVbFUw2nms
	 5Z6zrXpHsl0WLfLBCcUITb3sB43Fu+WIxD/ayzMnmZcs8gOfxfMxtpXvIn7GJcjvRR
	 k3ZJ6USmASk7MBU2unZE7/sqy8jsIniuZLtZpsWdXHG4urAidvCx+Rw+yDu/lLHVsD
	 Yqf8l2HbVPWdmeErbLKjM50MOyE3Rqx9VvhJAQyCxSGm9EJDFZndlTd+ZWpB7BGH0e
	 kGn6jZ9jDe1dQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AC38215C0336; Thu, 15 Feb 2024 10:58:19 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, jack@suse.cz, yangerkun <yangerkun@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        yangerkun@huaweicloud.com
Subject: Re: [PATCH v2 1/2] ext4: remove unused buddy_loaded in ext4_mb_seq_groups_show
Date: Thu, 15 Feb 2024 10:58:18 -0500
Message-ID: <170801269220.557465.8141847571506704045.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118042557.380058-1-yangerkun@huawei.com>
References: <20240118042557.380058-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Jan 2024 12:25:56 +0800, yangerkun wrote:
> We can just first call ext4_mb_unload_buddy, then copy information from
> ext4_group_info. So remove this unused value.
> 
> 

Applied, thanks!

[1/2] ext4: remove unused buddy_loaded in ext4_mb_seq_groups_show
      (no commit info)
[2/2] ext4: improve error msg for ext4_mb_seq_groups_show
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

