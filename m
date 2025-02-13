Return-Path: <linux-ext4+bounces-6449-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E2A348D4
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 17:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF57188A029
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027291E766F;
	Thu, 13 Feb 2025 16:01:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3AA1D6DB4
	for <linux-ext4@vger.kernel.org>; Thu, 13 Feb 2025 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462496; cv=none; b=WmNJGuPvbSej5tIov+26/sW5FF/njtVlCF8NEzrWF40tLMoREOiFvcMfvFfRT7+mJ5RSAtRPbu1Iy9TL94oD/mk9GfI7wmEzoWEbE7u/i1dpKoVduTUrymMaS0C3CTH1H4ColqJvy+1g+4Pomi3zGVppwil3uV2bcq6ZaVsn5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462496; c=relaxed/simple;
	bh=1eClevuZK9UNXCwV+ofhAPq6vkWVR1HZed9etDJNXc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqM2ZjTie+phEtyLRb+3tKuZlO0bwgwc7WF7gO3gIToDAj3ZEGVQ0FpwxeVtOcBMdNTlFRc4tPSkHYk9YErtpTpxL/cR91mRkRNW6s/mvrSqqXoX+HuVweBQ7aqyMswLhAACiqjq6hYutFoMjhbX62oiEitbfiZh2eZQqXevYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51DG13gb005144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 11:01:04 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A67E415C0009; Thu, 13 Feb 2025 11:01:03 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Alexey Zhuravlev <azhuravlev@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>, Zhang Yi <yi.zhang@huawei.com>
Subject: Re: [PATCH v2] jbd2: Avoid long replay times due to high number or revoke blocks
Date: Thu, 13 Feb 2025 11:00:54 -0500
Message-ID: <173946232427.399068.17378583762136452438.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250121140925.17231-2-jack@suse.cz>
References: <20250121140925.17231-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 21 Jan 2025 15:09:26 +0100, Jan Kara wrote:
> Some users are reporting journal replay takes a long time when there is
> excessive number of revoke blocks in the journal. Reported times are
> like:
> 
> 1048576 records - 95 seconds
> 2097152 records - 580 seconds
> 
> [...]

Applied, thanks!

[1/1] jbd2: Avoid long replay times due to high number or revoke blocks
      commit: a399af4e3b1ab2c5d83292d4487c4d18de551659

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

