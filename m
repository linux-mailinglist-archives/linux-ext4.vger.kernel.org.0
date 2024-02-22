Return-Path: <linux-ext4+bounces-1362-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5D85FD23
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EE0283B15
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BA014F9E2;
	Thu, 22 Feb 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hOoYk0Iq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22614E2F5
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617293; cv=none; b=hgEPorkgLa7XZ/hfkYeDrq6bFS2m3dm7+N0QjhPnq2bULqy/5nT5OL5HP/IJLf2oFQ/P36LJdbovKwQmHxX5gBUwP0vF6kuGnhq+7RkgAja4AvRyj8igHmx/9ZGvcvdLdcdpA3nmZh1dvMA+Tj+docq0+1WcbdHFrcS/dIZNVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617293; c=relaxed/simple;
	bh=vh3ySbrlpw9hAwtgM3UcTxVpEpvYM1fkdRySX3Socwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhzfanuDh+MnIaJxFU7KaV2DGqDWe7VHKIw1ThpyMmQLeIPs9XjtIKA189nbCCQ8TmRGkEQyNjZQECj3X6NdPqKykhYKs8884TWD+Pu1nxAKb72dfz7r2iBMJzHNvtKrLRHwoTVi3gGPS/TMu+3CT7r4t1agJkRLySXRvUydnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hOoYk0Iq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFseCg030786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617282; bh=JXtydpAxqdnK/7VL2sFHyIioph6Yglnc57QLs6ufLCM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hOoYk0IqHjow9q8Mj5ThgNG6fI1GNoWv+8VHaj4A5SjyYuVVksw4yhwQ3H+u3HbtZ
	 nHtqcAK3nc2oaXQnxIQbQb3APu5UyhHrjUcw/EISCS7t0hXc8F2egQbh63eQGetm+V
	 ec3trUwpWCCEBym1chwmcl5vdChfTATFwxf2vXyq+VLWMBjO9+Tan+7z/q9pzPyumk
	 YouhVfc+xdK9T6qgYMkAkr5Bg8YKpfgKKKLdvrgIbQTyQydj3A5LMDZHfuNhEFWnoq
	 ZyhUt1LLPDRLIMoTlmzXzGLBkSq91w0v9DFTyf+4WYD982/XULAb0jo2iMrJsYRXFi
	 /LKVCl9o5t6bg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3434A15C0337; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Don't report EOPNOTSUPP errors from discard
Date: Thu, 22 Feb 2024 10:54:29 -0500
Message-ID: <170861726753.823885.4373903569687360726.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213101601.17463-1-jack@suse.cz>
References: <20240213101601.17463-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 13 Feb 2024 11:16:01 +0100, Jan Kara wrote:
> When ext4 is mounted without journal, with discard mount option, and on
> a device not supporting trim, we print error for each and every freed
> extent. This is not only useless but actively harmful. Instead ignore
> the EOPNOTSUPP error. Trim is only advisory anyway and when the
> filesystem has journal we silently ignore trim error as well.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: Don't report EOPNOTSUPP errors from discard
      commit: f3edd83e2e71dd393c0f485be103a4b35f9ef41a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

