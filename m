Return-Path: <linux-ext4+bounces-13410-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FhnDilRemnk5AEAu9opvQ
	(envelope-from <linux-ext4+bounces-13410-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:10:49 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F0EA7896
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E576F30BB323
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD6E37105F;
	Wed, 28 Jan 2026 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Ou6Lk2pT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7436F437
	for <linux-ext4@vger.kernel.org>; Wed, 28 Jan 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623537; cv=none; b=eMunFmFlqvuQ/CFKpS1bukHO0IGny4z/ac2cTdHl2HQlBQAMav2vn0oJtXhm16spXzonblXOgIgZaNKgMJDZAJAE18R5+SXCAf4Ni/bRALccNHZAD67004yvEIhg6XBxyN2/94j2KJRxdNgocxUOkOpknJlDArvEZiOEaqPuzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623537; c=relaxed/simple;
	bh=i/tndf1EqorbEeQkQkZTsLIp5n8auM7VxbJQjxgHC+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7zcj75x/cBDKdjqVie3hxNkQ4p5zBYULlCLZLvhyhBkncPDP4kbL7EKjAXVlTK3LZ8npWLMB+iUY7264kkQ+akjtUTWBRcU7TUk8VyeTJgxLk0OkTCX1Awp9EAqqxPPJcvXpj+4Bh0UKou1CsC6f3MNDnUAmHjfB0jN2DeUG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Ou6Lk2pT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-123-50.bstnma.fios.verizon.net [173.48.123.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60SI5GNQ028634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 13:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1769623518; bh=WMPk7clOddB33GiQ7o8ddtxtguT6/yuBZkOPNrCW4XM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Ou6Lk2pTMDGX0BSYwp913qHdEjZv67tI1LmQRI9Z7ZIR5UT31GuvyHoWTOEVEWDDa
	 h73+QKNwqLsE7OfSSVtJKAlfEoV2/F71TYBfv6KyJKaN+j3GKeR3iehgxTThKUHvYh
	 1/1bjR/Uq2m5rDn9kslPov/Eg8xQpVHoerprWp++xBB2UAhoq0ziQ4nzF35CaOviRw
	 wwYYFFfqPNT95wI4m8h5AEspzZbtLU5u6BcOBNbLiK5Hq5GhQRkcUnj0Ycw37kaqco
	 oLzUnOW/YeWihx+xJjwxVu/717c6yijmjUaaOSK+GIMrlCnMbQYo+3yS9S3CNe3jYk
	 mZnJxtoGu1cNw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0BEA42E00DA; Wed, 28 Jan 2026 13:05:16 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Baokun Li <libaokun1@huawei.com>, Pedro Falcato <pfalcato@suse.de>,
        Zhang Yi <yi.zhang@huawei.com>
Subject: Re: [PATCH 1/2] ext4: always allocate blocks only from groups inode can use
Date: Wed, 28 Jan 2026 13:05:00 -0500
Message-ID: <176962347640.1138505.1021788434907927289.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114182836.14120-3-jack@suse.cz>
References: <20260114182333.7287-1-jack@suse.cz> <20260114182836.14120-3-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13410-lists,linux-ext4=lfdr.de];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+]
X-Rspamd-Queue-Id: 79F0EA7896
X-Rspamd-Action: no action


On Wed, 14 Jan 2026 19:28:18 +0100, Jan Kara wrote:
> For filesystems with more than 2^32 blocks inodes using indirect block
> based format cannot use blocks beyond the 32-bit limit.
> ext4_mb_scan_groups_linear() takes care to not select these unsupported
> groups for such inodes however other functions selecting groups for
> allocation don't. So far this is harmless because the other selection
> functions are used only with mb_optimize_scan and this is currently
> disabled for inodes with indirect blocks however in the following patch
> we want to enable mb_optimize_scan regardless of inode format.
> 
> [...]

Applied, thanks!

[1/2] ext4: always allocate blocks only from groups inode can use
      commit: 4865c768b563deff1b6a6384e74a62f143427b42
[2/2] ext4: use optimized mballoc scanning regardless of inode format
      commit: 3574c322b1d0eb32dbd76b469cb08f9a67641599

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

