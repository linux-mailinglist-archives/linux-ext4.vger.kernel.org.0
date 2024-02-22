Return-Path: <linux-ext4+bounces-1367-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA1485FD2C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710E2288421
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10EB1534E5;
	Thu, 22 Feb 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GdflzDcm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF01509A2
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617299; cv=none; b=FZqy5WZhHuwS4Ci7aKdipXzZGQwekqh19gyPgeIweCo9quzriQnzLNSnGRAoGsk4VH9te7mmKE0c37lhD1mebleXmn4/MBeJHQ34ls89pOqq0NKKWlevJ5k/xlLUjimcQmqvZO8tM6Jl3kRsO8LWGsQeTQTUG8AjVMOPkloIzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617299; c=relaxed/simple;
	bh=PnGGD+pWCV95jZ6yeUKOt7CKn6Qva1qmwYV1aXNCv1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJmY4ZmA0A2Q1QJbwlUd8BS5/TUL6g7/oLpBZ34Tjvrk52tgjNGO1V0162IhU6TKMGNJERzShETVZ7eVgpOpf0quxJRY9RKwejcQpxEB3jLsPiak7ZpLZVeDpQEVdj/Lf+6TAJJKR7Kqsg05lGTZffSwrPbhgdqoQwChqEdlHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GdflzDcm; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFseg4030788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617282; bh=C/YFDNBRkYuaikGOFxg/FhnZW5EUxFBJ12Fm4X+ibBw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=GdflzDcmzVbJf2ljL3WupIZiHWqoG/MnjoPa7O57hP+gH6U2QH0saBNV5WUt6gmy2
	 +0ScZq6A4ot0TMUTX1XwbB28x0N4LlzkbVZZ5/T0RE/TvsYRqNJilmPYxmp4wrjcKN
	 uwlXCVz1XN9QA3PzSnepnrlHqwNyXe8mULLmT9jfMKfE/47jeRDj8+b/Lc9VGZL2W8
	 V8ePPs9ADaHMXogs7hiccWOlmgK7T9/rbx3E+pL2HkKIymuzpnlQVulXUlXnl12GUr
	 V02IQf7MKEnVd3s6zZJ7mc/jx370DWg01+3/ooDP1x7dwGppQ6JiyndArnICdNFVeN
	 /3R44Dm7S3THQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3639615C13EA; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Zhang Yi <yi.zhang@huawei.com>
Subject: Re: [PATCH v2] ext4: Verify s_clusters_per_group even without bigalloc
Date: Thu, 22 Feb 2024 10:54:30 -0500
Message-ID: <170861726754.823885.15911575133715045976.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219171033.22882-1-jack@suse.cz>
References: <20240219171033.22882-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Feb 2024 18:10:33 +0100, Jan Kara wrote:
> Currently we ignore s_clusters_per_group field in the on-disk superblock
> if bigalloc feature is not enabled. However e2fsprogs don't even open
> the filesystem if s_clusters_per_group is invalid. This results in an
> odd state where kernel happily works with the filesystem while even
> e2fsck refuses to touch it. Verify that s_clusters_per_group is valid
> even if bigalloc feature is not enabled to make things consistent. Due
> to current e2fsprogs behavior it is unlikely there are filesystems out
> in the wild (except for intentionally fuzzed ones) with invalid
> s_clusters_per_group counts.
> 
> [...]

Applied, thanks!

[1/1] ext4: Verify s_clusters_per_group even without bigalloc
      commit: 1f85b452e07c370448fb4eb4472cd55fc6bf115c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

