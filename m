Return-Path: <linux-ext4+bounces-11881-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C095C65EB9
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9883347389
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332D33C529;
	Mon, 17 Nov 2025 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pkN3z+qk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0E339B3B
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406857; cv=none; b=LGYSMrrisKsrZxwIYHB7KOu+ZfJ+hPGvJ8E9XCsfXbpYR6ORbcAvkW1psecJH14jF7LYzU/P0N0Xxvp741Mtt5SGM13UlMvLGxO0RDLNrtfMmVMuT5nDNEfI4x2qsjuRc7ujQ5VoWEw8ev4LZH7iUucAkNHEbVmD0a9kPpUEKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406857; c=relaxed/simple;
	bh=v6CiNgpE/O4tk5eg+/RonfEOR5bk+YpyM2UNwLyIZHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsvlR/ubTmpAR6eMa+V6CEe5zX1hUmYyyARxH+vXpVpsP/xs5b4j5SZkRG2b/qJF7Yc+zlovxe7lYM21YdKN9C9giy4qekAswXWT/Sw/YmBMwzrF0xXoRfrVNT1EMfcKKsXoI1Fv6dXW5ZplmtC9KQCl20xAaipDoFjigXajtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pkN3z+qk; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDoIe020576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406833; bh=0otr4AGhCLLWxZmU72cq6997fEtNY7jejFHPKEe8TD4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=pkN3z+qkb9Lzcr9lhfPYGuqlEALoES9P99cO9Avd3UZBHFRdGe2eSQ2j7JxlEm7Sj
	 qhSDbiXWa1oGMVOjpyBG3sXpEBE+f9hq52Uqn8eEQJQcaSyIi1kk2h5UIzR4+eRxLM
	 x1qYN0V7VEWbkbEkZ1LtcnN5AfKYHWhW8mU2HzXbW1h9lZ79gF8jOUU9pu/I1eKPWV
	 rM2COGH/ZMauhV8Q6Ks9+sbBWwOpki5bUzhAYEpBFc1doZqW9AQQlXM1WhNPpJPMQo
	 BiS22+BQ55NEgFCTgPJuCchNmTZl9O8zky2ftjGTLImpyRSWA9CRW6dRt4qGL77HGX
	 kAMW2U9kT8t5w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3A8352E00D7; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, Haibo Chen <haibo.chen@nxp.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] ext4: clear i_state_flags when alloc inode
Date: Mon, 17 Nov 2025 14:13:31 -0500
Message-ID: <176340680645.138575.13420977001024080703.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104-ext4-v1-1-73691a0800f9@nxp.com>
References: <20251104-ext4-v1-1-73691a0800f9@nxp.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Nov 2025 16:12:24 +0800, Haibo Chen wrote:
> i_state_flags used on 32-bit archs, need to clear this flag when
> alloc inode.
> Find this issue when umount ext4, sometimes track the inode as orphan
> accidently, cause ext4 mesg dump.
> 
> 

Applied, thanks!

[1/1] ext4: clear i_state_flags when alloc inode
      commit: 322a9e3c77253842617257af246cb5a0ac77851c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

