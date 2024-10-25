Return-Path: <linux-ext4+bounces-4750-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A289AF885
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 05:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A27B21E05
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 03:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2718C90D;
	Fri, 25 Oct 2024 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dLh7ExGK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60018BB9A
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828449; cv=none; b=ttHxCGsR0/37C4z6b8cqviUcbUl5oyD7QqqVQxXGz+jZ2Qv+e2pq8meqyb5oAQtsnJG9O35yEzku623/AqHbDOSMx/qa2Iu9Yd95F6YoV9IzfqLavNdkWo2RvRtjhtvoy+BKTk8xZtonAHdfIHqDMHgxt6MWvh41u/yO4cgq5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828449; c=relaxed/simple;
	bh=t9hfU7huYKhKIzJk9o1rWPcxtgO93ly8Nhu4K+5XMck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2yjB6v945Uc1wItpGWNNSmFVgQGzVL1dv8uMEss7jAiFO67wXz3jUlUdAxwn8cRpSzQyND9EOkIYXsxeKGMfsrjVdmudC9Gil0NWakEs91eDfGTH+zkg3Z46Un0cvQORG3b2YeCnWgVFtnlLg2QMw+D9b+iLd1stJc0zAw3FB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dLh7ExGK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49P3rx7V027516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 23:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729828442; bh=PAv/e9yX4J8VfPowXcYwKZz/20EhaTUkCVOsjlTOm3E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dLh7ExGKgDi0f6pA0KnF9b9Q3zwIHhWNXpIt8GVe5hmVi8RkZF72pIsqhsYTCWPqp
	 6u+GsW1h13l6bWJ5gFRaJ43+JU5w2AAIPmMDlOBu8Bhi6NrGNQl8qb2n4vJJHX76dp
	 WnvVuWs0vcrylSqUTrEsR6rcSBUuwlVDQFjmp1Dql33ydU2fp++pt43UyYF1Msu71I
	 owIQb5GyEgcAqWxvMqiuCDxRNYZHajDhPgrdTlAN6EfHtZT7/gHb7StO4Ii+Y5Mq8w
	 kfD6pgWVLCD/aYKzeLBsG59JTmMB2wIoD087j6iEdNYQsa36LYY/OBG9aycBI/tUDe
	 mBxcQB8ZI7LQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AEE2B15C067A; Thu, 24 Oct 2024 23:53:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] resize2fs: Check number of group descriptors only if meta_bg is disabled
Date: Thu, 24 Oct 2024 23:53:51 -0400
Message-ID: <172982841322.4001088.12864574795422106135.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925171926.11354-1-jack@suse.cz>
References: <20240925171926.11354-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 25 Sep 2024 19:19:26 +0200, Jan Kara wrote:
> When meta_bg feature is enabled, the total number of group descriptors
> is not really limiting the filesystem size. So there's no reason to
> check it in that case. This allows resize2fs to resize filesystems past
> 256TB boundary similarly as the kernel can do it.
> 
> 

Applied, thanks!

[1/1] resize2fs: Check number of group descriptors only if meta_bg is disabled
      commit: ad56ccaae8b6d69350273c01ae2f72a66df245e0

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

