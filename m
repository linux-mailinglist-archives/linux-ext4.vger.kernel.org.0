Return-Path: <linux-ext4+bounces-10446-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADE5BA5412
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A651C05F1E
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029CE29A30A;
	Fri, 26 Sep 2025 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QEflae0o"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C62848AD
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923294; cv=none; b=qQ4Gi8aPeU9oM8n0JI2/jpHr7SPI2nv+zMP3xm5XSYhWXdXo+lh7iq/YueePJW5XBZTNQv7w/Ns9SoZ8N25UJnI4bN2ZqQcZwsB1HJwsqve2FfFXDhfPZiJKZ9L0cX5+Ybl/UzRDfN5zPRcO1/0+EhdzD4lD2SrzSqLU1v7Ernw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923294; c=relaxed/simple;
	bh=K7oJuFyApwJg5aswo1o77Yr2LgTjp+suYLUVSfIfGVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pbupc3vx9Yhw6I1HdXHChpAhkqe5cxWLVpQo7s15J28D4nluWKHeksGUK7RDzZNPQGS/O34B8gOtEr6rxAxuHjglZBWAnnazp6Okorxqv2yp1UK//MruXxL3A6rRxFHwOPI9ulqPQuKS+LV4Jrh6fQZJJcDD2ZDUejR//aU/i1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QEflae0o; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLltFL014754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923277; bh=DYRYk0uRH/qdV93ryya0uoaACIjjbZpMy5Py8krWpNg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=QEflae0oOuqEni1Y5s5WYSYvfxDGeCmz+oU7WHx8X4HrlNKvAXhmbngSogaTF1aZw
	 Fw6rFaet3ZYPixEUWKIk8MZE+YUvF3R/3T9PfCfzRcHW5Q5lCafuyp0mmku/d8N82k
	 IbXS3gMsMt0L6PcS6349iIPJA663PRjAEugeJ0yz84J/y+qYj9OLFuULmQoRQhgIni
	 nhi0P+gLFa4w9shWERaHrw+qVbrB7B3FawOxXL+AfQQkpb5ndOWera/kHi5kj07UQK
	 f8skt0RmNhnux6msu/oTVXTwXv/7wx0CdEoOHkF6nae2AHJZKqSXkXk7IwhCo+n0xI
	 kY27dTVyfR6PA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EB2CB2E00E3; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Julian Sun <sunjunchao@bytedance.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz, harshadshirwadkar@gmail.com,
        ritesh.list@gmail.com
Subject: Re: [PATCH] ext4: Increase IO priority of fastcommit.
Date: Fri, 26 Sep 2025 17:47:44 -0400
Message-ID: <175892300642.128029.8985774143396523898.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827121812.1477634-1-sunjunchao@bytedance.com>
References: <20250827121812.1477634-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 27 Aug 2025 20:18:12 +0800, Julian Sun wrote:
> The following code paths may result in high latency or even task hangs:
>    1. fastcommit io is throttled by wbt.
>    2. jbd2_fc_wait_bufs() might wait for a long time while
> JBD2_FAST_COMMIT_ONGOING is set in journal->flags, and then
> jbd2_journal_commit_transaction() waits for the
> JBD2_FAST_COMMIT_ONGOING bit for a long time while holding the write
> lock of j_state_lock.
>    3. start_this_handle() waits for read lock of j_state_lock which
> results in high latency or task hang.
> 
> [...]

Applied, thanks!

[1/1] ext4: Increase IO priority of fastcommit.
      commit: 46e75c56dfeafb6756773b71cabe187a6886859a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

