Return-Path: <linux-ext4+bounces-2562-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939048C8909
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2024 17:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65D928188E
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2024 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB86996A;
	Fri, 17 May 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gi+I/uwM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256564CE1
	for <linux-ext4@vger.kernel.org>; Fri, 17 May 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958664; cv=none; b=e70JwQ7Zt1XUsA4s2J6B0XP6D8xUO/q7m4vH6cAk95nT/jjDyqEEv0SZE0qE7mZOm3fuhh9Ccixd/TjL5JzHgiznvwluz2MkufAW0YY49V8JM6ijKMzGCM0MtUDqrrQbiS6T70pKbA73HHt6gcYdfJYBc0THXKtF9zeqjJnuGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958664; c=relaxed/simple;
	bh=0U3sf8Hc8uG0pt5j1TXMHSmEl5W5zQP3g9W1tgxp3YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnG1jwYnm3KWf1l8yWQ1hwaf6t58RM7u4b4X1CTOrmgKqzgIKFgm5qbdBYOFXi/+KphKAEn7nD9b1eogEdZStwi4qiHkG2fwFSLr7frxreb+/5wnSPFX9acgIs/k9Lf6MVsMbOkXzMBptQRZNIj45psDiaOwSCZ53/qIlIsxjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gi+I/uwM; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44HFAfIg005865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 11:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715958645; bh=53gt3U+FPEO+PUBC7Ra4RhW5FF25V+xJNdlek+/C4FM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gi+I/uwMs8AWOIZoVgSpzp1LTjUsBsgcufR8K4dcGGobk03DWYCSMIAX2XXIMSuUG
	 IMrBAkasJnfWWkcczcF6xvzajb6fj/yiJ3pvmgQl96LxNnrcKasqkILq8Tm2dmxpfg
	 wrJ0M28N0WKdPhUL4sKblaLS2as1zpWW6aIxJxX2U4TRdp1HUbKkMQXYp1ym18pdI4
	 u0OH9N1LyyWIOvzAlJzH0NqLH5LpF4UJ7Pc30JoHemfw0Umsexai0kzBgOADkLdKEY
	 Pusxqpf6O8Npax2VByBowDCN7YmLDseO0R3jr5+JILbaXlrSlb1vekr8NnhO4sNYj8
	 JxChXbyt5Zp+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 20A1F15C00DC; Fri, 17 May 2024 11:10:41 -0400 (EDT)
Date: Fri, 17 May 2024 11:10:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Howells <dhowells@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: Don't reduce symlink i_mode by umask if no ACL
 support
Message-ID: <20240517151041.GB10730@mit.edu>
References: <1586868.1715341641@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586868.1715341641@warthog.procyon.org.uk>

On Fri, May 10, 2024 at 12:47:21PM +0100, David Howells wrote:
>     
> If CONFIG_EXT4_FS_POSIX_ACL=n then the fallback version of ext4_init_acl()
> will mask off the umask bits from the new inode's i_mode.  This should not
> be done if the inode is a symlink.  If CONFIG_EXT4_FS_POSIX_ACL=y, then we
> go through posix_acl_create() instead which does the right thing with
> symlinks.
> 
> However, this is actually unnecessary now as vfs_prepare_mode() has already
> done this where appropriate, so fix this by making the fallback version of
> ext4_init_acl() do nothing.

Thanks for this patch; however, as I had mentioned in the discussion
of the v1 version the patch, this change is already in the ext4 tree
and linux-next in commit c77194965dd0 ('Revert "ext4: apply umask if
ACL support is disabled"').

						- Ted

