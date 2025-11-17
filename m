Return-Path: <linux-ext4+bounces-11877-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B874C65E80
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1899C28BCA
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6548B3370E1;
	Mon, 17 Nov 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EfGbkzgY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6132C317
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406851; cv=none; b=s3Sxaj74y4DWFsRIXUAdoFQ8BdL/690n71esoYPHz1aKY3+clJ/dZuY3fIbBlMYpbF4anQ66QANieQQeOjqJwDAmx+CD+zCkGPSwXBRIUIitWV5t44meudPwlcsoLhEASbKGYpI9NhMmXC609icgJLludEcF6YztPW5c7VSUTGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406851; c=relaxed/simple;
	bh=hOMKgDIZX3avtLzKNyoQVfmby/IhYdvh8+dXSMxKJXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M06waNj9RdhwOeJGckVAdxR0fFWA7QXZyrr60LWmRt688Sgf/4l8o4oaJncnpRKxuFJD01mD7g0v5s3w+AKC21AU6r2uOB7ZOr5Z4Xixhv2ECeQysxUHw2QPvwlyvuBCW9Nh+lYBL0OlGQqdDrhEDCKCazJ9358YpYEohUNv9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EfGbkzgY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDoZi020575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406834; bh=MBfn8g5r6jdKjirEE2DP7ErZrTYQ36dSRqE9rhdy3Cg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=EfGbkzgYft7Xe1B6S5ynaZWwixNnfKRcYSY8XEbDBabibu5lbx5wyyOCfUGGozsF6
	 yX+1HUWNs3+aq5TeIcdppOwQLDZkyZoUgyRAsKBLvgVLscK6CiInxBTt5QMOoLwfND
	 Y9ssocryE056BP3XV7LRexgvFlH1QGQqJ83Kz4J1pFNQrPNlqYT0bjMMB/cPEl71uF
	 T8NQYsLemkdu/WVoziK486hbh6KmP1zXcojHnvsI/AeuaA4v67+emY+5X6Ng9vLY97
	 1VSBtgYQbBsIFmlE8fzb/e1mKocJrNJtqOrY+XhWQtVFp58+nZxwLEkkUAOlCXVp/S
	 sgTfFeOmMG/xA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 385892E00D9; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.com, Byungchul Park <byungchul@sk.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, kernel_team@skhynix.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/jbd2: use a weaker annotation in journal handling
Date: Mon, 17 Nov 2025 14:13:30 -0500
Message-ID: <176340680642.138575.1743360049600398198.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024073940.1063-1-byungchul@sk.com>
References: <20251024073940.1063-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 24 Oct 2025 16:39:40 +0900, Byungchul Park wrote:
> jbd2 journal handling code doesn't want jbd2_might_wait_for_commit()
> to be placed between start_this_handle() and stop_this_handle().  So it
> marks the region with rwsem_acquire_read() and rwsem_release().
> 
> However, the annotation is too strong for that purpose.  We don't have
> to use more than try lock annotation for that.
> 
> [...]

Applied, thanks!

[1/1] fs/jbd2: use a weaker annotation in journal handling
      commit: 40a71b53d5a6d4ea17e4d54b99b2ac03a7f5e783

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

