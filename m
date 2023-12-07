Return-Path: <linux-ext4+bounces-343-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E7808CE3
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 17:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C45A1C2099A
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F3846523;
	Thu,  7 Dec 2023 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="C/E+BasL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F884
	for <linux-ext4@vger.kernel.org>; Thu,  7 Dec 2023 08:06:36 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-130-174.bstnma.fios.verizon.net [173.48.130.174])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B7G5w3W030811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Dec 2023 11:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701965161; bh=33N47EVtbuEH9kAqIlVobaCM1hniyihNKITFG6dEdTM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=C/E+BasLvAaJJd3KeWexWSx/5aGK3YASvNws/RzV40V7zkKz+ReNTy3i0RZlaYZ1c
	 X2rlLVamjBGRzkK5W4mc9gvB75WK8s1sNDcKUF5HGlbrJl2FaFR6pfwEnUcebceiWO
	 RhDewE4DcUzKcZ8xLnFNPXwAZRDo3D09PspIUQOio/kSamToskFXaS+vogmjbHZwKM
	 5puQ2CM1CPfDr4yl0ugBDIEplm3FNKfcsy8PGoPvdpuZpb9qvZ0zUg1UOzFRID2J9G
	 O5V+2fJb/fxGjvNuh4YYj3eQyBlGt0wZd11vFv2qBGXh76cpJ7rXEuJVSy1ztEFRm7
	 a2gj7cA7kqoYQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5EA3215C057E; Thu,  7 Dec 2023 11:05:58 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 0/2] e2fsprogs: avoid error information loss during journal replay
Date: Thu,  7 Dec 2023 11:05:56 -0500
Message-Id: <170196512709.16594.6947509474130465416.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230217100922.588961-1-libaokun1@huawei.com>
References: <20230217100922.588961-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 17 Feb 2023 18:09:20 +0800, Baokun Li wrote:
> Baokun Li (2):
>   e2fsck: save EXT2_ERROR_FS flag during journal replay
>   tune2fs/fuse2fs/debugfs: save error information during journal replay
> 
> debugfs/journal.c | 17 ++++++++++++++++-
>  e2fsck/journal.c  |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> [...]

Applied, thanks!

[1/2] e2fsck: save EXT2_ERROR_FS flag during journal replay
      commit: 6ab579ee3c6c8c2d76aebcc9e8430a797c9963ff
[2/2] tune2fs/fuse2fs/debugfs: save error information during journal replay
      commit: d5296ff0c665c1f957252ee18f824ad666a34b78

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

