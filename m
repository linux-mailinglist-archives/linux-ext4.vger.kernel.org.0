Return-Path: <linux-ext4+bounces-748-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4B827D10
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A3EB235F1
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF132942C;
	Tue,  9 Jan 2024 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PD6ihP9j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615629417
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rVX4010645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768823; bh=ekQyyoBxkCkVzJpxhdbWZpS5zVyTsKRLql3ChR79O8E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PD6ihP9jom8n0JFFVmVoSRWzZ2VdwbCqLXz9QHZ5navdKBVzhwFCPF3Oia/0tmXUp
	 6WqXVBxOSdtyo+dMiCaaYi/ywXnp1bmLkC6FAZYoYejb3ImQCZGeTrBdLFz4aG9O/j
	 Kc+kifcyHM+ycUw/0l8O7hi8Gb0HRQvnz7PMdBwUmR/GRQoDlYNmua+vpEFGecAJVD
	 sYWGjvKHy69/72qpaWX+kVUUMPm0hk7QZaRNus8uEUNWxbG27g7BcLb7d0Z9GyPuld
	 ioX/AbjfLW6Pi2cEey7HGAu/7Yc4SrE00r5dvjEEbbkePSn8BIeyISO3JQtb4SGam8
	 TnGrMQFcrTfkg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 27DFC15C030F; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        sjitindarsingh@smail.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs/ext4: Allow for the last group to be marked as trimmed
Date: Mon,  8 Jan 2024 21:53:21 -0500
Message-ID: <170476879009.637731.2909208687184523548.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213051635.37731-1-surajjs@amazon.com>
References: <20231213051635.37731-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Dec 2023 16:16:35 +1100, Suraj Jitindar Singh wrote:
> The ext4 filesystem tracks the trim status of blocks at the group level.
> When an entire group has been trimmed then it is marked as such and subsequent
> trim invocations with the same minimum trim size will not be attempted on that
> group unless it is marked as able to be trimmed again such as when a block is
> freed.
> 
> Currently the last group can't be marked as trimmed due to incorrect logic
> in ext4_last_grp_cluster(). ext4_last_grp_cluster() is supposed to return the
> zero based index of the last cluster in a group. This is then used by
> ext4_try_to_trim_range() to determine if the trim operation spans the entire
> group and as such if the trim status of the group should be recorded.
> 
> [...]

Applied, thanks!

[1/1] fs/ext4: Allow for the last group to be marked as trimmed
      commit: ddf2aa1bac7d9be3b8ba374c5bdb88da06e3e10f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

