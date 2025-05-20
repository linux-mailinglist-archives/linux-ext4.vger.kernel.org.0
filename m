Return-Path: <linux-ext4+bounces-8047-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8BABDD75
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 16:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D653B07A4
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA123F28B;
	Tue, 20 May 2025 14:40:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CFF248F6D
	for <linux-ext4@vger.kernel.org>; Tue, 20 May 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752032; cv=none; b=ACtbH00pNX3wYCvEW4CIBRo2uLuiT3MfI9xzY71PiyHnn4LjQJy+yNoXygBeRFv6oLkW3MoD2jdMy5tsD/0L2RkmTqvWZz0eXUYVRMjC7jlQsVF19VgC8Ub93EW/JWafG3EknCLxhKmW1XjGhcZldKS5fZ8w7y6Vg3u7uNrXIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752032; c=relaxed/simple;
	bh=2/ygtATYTRjG6YG0kpwqsnb0+Qlzc20a/9YKsPeyB2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQJjg+S4j0Hi6gJkjkAHmkgFImfTGlEU+QhW862IvT0NyXrbjRCg2/C3B2kVwg0yRR38NfVEo/2W48nxtI4PCESTyTi2gCqTegOaobXoqcyzgS2LayW0V+tZdY2qQqamjgFchFL3lbsUXwfh6WpSBEAED8SU1iT0RX4w7PsJp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEeOOS013129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B75D32E00E0; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: only dirty folios when data journaling regular files
Date: Tue, 20 May 2025 10:40:11 -0400
Message-ID: <174775151766.432196.5153867352854280731.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516173800.175577-1-bfoster@redhat.com>
References: <20250516173800.175577-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 May 2025 13:38:00 -0400, Brian Foster wrote:
> fstest generic/388 occasionally reproduces a crash that looks as
> follows:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> Call Trace:
>  <TASK>
>  ext4_block_zero_page_range+0x30c/0x380 [ext4]
>  ext4_truncate+0x436/0x440 [ext4]
>  ext4_process_orphan+0x5d/0x110 [ext4]
>  ext4_orphan_cleanup+0x124/0x4f0 [ext4]
>  ext4_fill_super+0x262d/0x3110 [ext4]
>  get_tree_bdev_flags+0x132/0x1d0
>  vfs_get_tree+0x26/0xd0
>  vfs_cmd_create+0x59/0xe0
>  __do_sys_fsconfig+0x4ed/0x6b0
>  do_syscall_64+0x82/0x170
>  ...
> 
> [...]

Applied, thanks!

[1/1] ext4: only dirty folios when data journaling regular files
      commit: e26268ff1dcae5662c1b96c35f18cfa6ab73d9de

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

