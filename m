Return-Path: <linux-ext4+bounces-745-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1032827D0B
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E37428571C
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C833EA927;
	Tue,  9 Jan 2024 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AKUmK74G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067441E4B5
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rWoH010670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768813; bh=PBXPEjs8S6Xjv3on5qnL4AHB7lIpx2uSn0wufjcExMo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=AKUmK74GZxhlB3jH8sR8/3W88eLS6EkqBr7ee2A5h0p4AcqTZxcpr9mUXoO+kxIvj
	 hOxdpXph6dJgZ5jTX+oGBwPe4hoEOVQqeKyts08HaV1yJwCw/Tv9+4/8BR27BcI5R6
	 WABJ/wQEOZ6RsmH9x0Kt56EosIiwm8UEYcOHSYjXwg6UVnm+Q3wUJxsA41y5RB9JyF
	 SceqMh+/B59lE817imOWBK+IywhLRy7FWrzGml67C/sNaisCmOV1h2BoJ6Fe4UryLp
	 8tODtMG/jVMAaA+w5JFUkpsVz1U9+H1uPVf/gZ5LmwBlyIVcO0Mn2E0Ts9NNKiFrea
	 FamuBpLYWdlDQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2BA1E15C0314; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH v2] ext4: fix inconsistent between segment fstrim and full fstrim
Date: Mon,  8 Jan 2024 21:53:23 -0500
Message-ID: <170476879011.637731.15498657467622683553.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216010919.1995851-1-yebin10@huawei.com>
References: <20231216010919.1995851-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 16 Dec 2023 09:09:19 +0800, Ye Bin wrote:
> Suppose we issue two FITRIM ioctls for ranges [0,15] and [16,31] with
> mininum length of trimmed range set to 8 blocks. If we have say a range of
> blocks 10-22 free, this range will not be trimmed because it straddles the
> boundary of the two FITRIM ranges and neither part is big enough. This is a
> bit surprising to some users that call FITRIM on smaller ranges of blocks
> to limit impact on the system. Also XFS trims all free space extents that
> overlap with the specified range so we are inconsistent among filesystems.
> Let's change ext4_try_to_trim_range() to consider for trimming the whole
> free space extent that straddles the end of specified range, not just the
> part of it within the range.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix inconsistent between segment fstrim and full fstrim
      commit: 3d1aa1169c45aba9d589be1eb4b131f26f0a663c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

