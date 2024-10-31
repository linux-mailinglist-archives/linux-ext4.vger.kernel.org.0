Return-Path: <linux-ext4+bounces-4861-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3D29B7CEF
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 15:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151291F22822
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281BA199FAE;
	Thu, 31 Oct 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="V66udETz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96628175BF
	for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385234; cv=none; b=KFgFCZWmFoGdU0R0IMdGg/F4BVos0/Ze+qA9DVYuSTNRDGsGIZMRti1t5R0HPFlb+2lDgDWuSEWGzIfu1aBNyL1whjkI+FT+AR89asJkCrLdOBrodX6986dO/euH+I52PDQ7o9+/7TbWntyndc9ymCPULwy5t3K6XzALHWQ2QNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385234; c=relaxed/simple;
	bh=MigPIh+tmqjgh1CbKzMF++S0mmW+6BjtZfxx9LrvPq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awkDThFDAma6TTEY1a9hSzWbkPfTZtjqEpHh78lCXOur11YvleujKyt1wImmYBVJf1EkQT4Kv6/T6f2EeoNn/SUHpWCBADLOJUJAEKBQloXqIBYpfCbOR7yn0ODcMiDkO44UA853J0X+9GySWQpy/MSlBt9BmYhcSjKuET27DI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=V66udETz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49VEXinU026369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730385226; bh=TQZDZvTRw7X061r+7wczEkyyl+ueCNSZ6fnl/xh6084=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=V66udETzYoC2IJ3bTX9E38F6Ct2b0nkGS9vJmT7WolWaAK1dmioE1odHz/jOc+PzX
	 x8StdkZ60ly9y+TYeuZUO4n8id9KnVzRBqGhhkaX5rSSYw5lqgbe8fhOc3n4FJCwoI
	 3JEEv0Yu+iDZ3eAZNWlVk7ZRNmGqBQLfvPBRgHhv8UtSfSYN+nfO9GsTnp0Xh6rxFv
	 3KcJSFX+xk2pAlQug8+hwK7SrJsoHXcC1PaWRiknJYp1Yfqgp7puUrmg/wWSzxK6T1
	 jTHJLVrHyZNgmC0hWcYD6k2kIeLcRRFLdJWDj3uRJxns9DeTu1G7fRnC+t6vVN1U5E
	 /qrSh5R8Wl5Xw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7B94A15C05C4; Thu, 31 Oct 2024 10:33:44 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] ext4: Avoid remount errors with 'abort' mount option
Date: Thu, 31 Oct 2024 10:33:38 -0400
Message-ID: <173038521047.99135.4656059820024985118.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004221556.19222-1-jack@suse.cz>
References: <20241004221556.19222-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 05 Oct 2024 00:15:56 +0200, Jan Kara wrote:
> When we remount filesystem with 'abort' mount option while changing
> other mount options as well (as is LTP test doing), we can return error
> from the system call after commit d3476f3dad4a ("ext4: don't set
> SB_RDONLY after filesystem errors") because the application of mount
> option changes detects shutdown filesystem and refuses to do anything.
> The behavior of application of other mount options in presence of
> 'abort' mount option is currently rather arbitary as some mount option
> changes are handled before 'abort' and some after it.
> 
> [...]

Applied, thanks!

[1/1] ext4: Avoid remount errors with 'abort' mount option
      commit: 76486b104168ae59703190566e372badf433314b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

