Return-Path: <linux-ext4+bounces-5161-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDD49C8C3E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 14:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B54D1F2159F
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C341317C8B;
	Thu, 14 Nov 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="M1HU41e+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9E1DFE8
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592562; cv=none; b=DNeNFyVOS9tR4rp7cFUSVEnrqzDhSaq/9ebj/rZP+/UHUGbF6oXeyhSYidbcZJnseMDfyaViFy75PPt9D4+WUF20UUBiw5ksDRr67+aT6sA/fEFq4C8wTbTz0tuenCYISC3yXIfSHbhirt/NTo539YyA1OU1nm1cnF5Q/8w+eps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592562; c=relaxed/simple;
	bh=yuDquuXsjNXmo28405PHgwtCrxv1d4FqnZ90vofmlq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+laGjMoR9pcHz44p3HtLSXeZR0ZIHdVF7DxpgH9SFNM2/2wv3Ghx4UQnlal9MkVedyNuY+WVcTw/NLYEZnBUKOolG269jh3baK2nreaxVtveg0D1Z7qiRSLAdker1ByY3wShoLqYQYnTmC0bL8AmfS2kdrlQ5JAtxJG7ouPu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=M1HU41e+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AEDrjZk001822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731592427; bh=uAk8OD2rEcYaqKZ0FoZJK0cOa7Jm8MVRYRxWQi8wPWQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=M1HU41e+JJucE/wyOn6kMtFu2VLBuUCJw9dHH5VaCmidqVzS3M8hqseZRtW0/RR0I
	 G2ZjV4TE66WlQK0agU5Ik9RvegJasCf5yg+OYalJ2j6N8lE44rto8YoNmcw0T7f/MV
	 pBaWDaUWpRkvb+DgEEHOciFeJZXTyiu5TONDXk5DAYVeZ0j6L6N6VLTJruVCmK3wJ4
	 IkoMhTzpthxSaqTQzX+JMQpgpG9RCky2doUMcdlR7Ooa5sw4FxSqCBlZzb2AszS/46
	 30siaBPl/h+XO7tGiktIV3E/YYuersgswqjHXShdNJs/sfgiX8Gcah01jgPDuCuU4w
	 m5d0INBgeFMxQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4C32515C1C63; Thu, 14 Nov 2024 08:53:43 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Use struct_size() to improve ext4_htree_store_dirent()
Date: Thu, 14 Nov 2024 08:53:38 -0500
Message-ID: <173159220757.521904.12869324237285628437.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105103353.11590-2-thorsten.blum@linux.dev>
References: <20241105103353.11590-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Nov 2024 11:33:54 +0100, Thorsten Blum wrote:
> Inline and use struct_size() to calculate the number of bytes to
> allocate for new_fn and remove the local variable len.
> 
> 

Applied, thanks!

[1/1] ext4: Use struct_size() to improve ext4_htree_store_dirent()
      commit: d5e9836e13a53ef36af702d87ab20d1a126b0fb8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

