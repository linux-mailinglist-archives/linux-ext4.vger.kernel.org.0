Return-Path: <linux-ext4+bounces-3905-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD723960B2B
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2921F23A46
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22051C2DA1;
	Tue, 27 Aug 2024 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PtKdSb1V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15741BFE02
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762876; cv=none; b=SBXk4sb/U9HtOa1tYxhXwK3BtvRRfWskb4j/sDxoogXAOqOWP1vbuOpp1o2nV/HT9JRBqkAeiX1iUVY08f8u50A5pzL+b81mMCyHwDglhuNItagR3P1Mj0rlASaPz46jns+B7L4KROZuLCkTHNlJsXX7MDpWk+W10AasecxWqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762876; c=relaxed/simple;
	bh=mHELJVXs7TTiyGNr+hd7btM1rY0XHjZ76L4y7hh0Pq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pq3af7WY5+ZEuR+iYG2chzOzt5FUX7E3eKrzgwBBrP9MYpGcWoX/b6hTwTtERjL9yWJca0z2OjVTOh3K3wXrI+6ZkU96AauMHLBVIQmqyLFYeMgQpm26OpBzF2rAgj1UmHOob6eTd2hu/ugshL4t3zzNhsLHYw43vd5n/Chn/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PtKdSb1V; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClf3X021539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762864; bh=iu8i1ABiSX9Dkc12snhpqh3TYZ1/usHouJJFhVEfFkU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PtKdSb1VI6uL1uDk3XNoS/QoBiapTfuauO1Km5Q4dsAv5pYeEQaR6Jl0mowpid39L
	 BiAaD95FsRRCOgNY3/aMwTQBC2sE9TQX+UNKaI1dkUKnbO1yvNdIbjDF+53E2c+/8O
	 rl9fYyFXaGlBnNrqze78ManY+b1rOC/bkwof11rifk7DLfrtHvuLpZti43+shfC/9u
	 IcqJcpNDss2EH9Y/hlyNc88o358zLCr2aZwtMXwv0Uh/js6b1bcnZJ4tam3qxfVD5y
	 /K7M7ZB13auF1pAh7bPbMfZDQnTKMh+h1MT8pv06zQTnrJGzXA++HacmT8DqPtWQ9f
	 hN190CoSrQdVw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C51DF15C1CC9; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 1/4] ext4: Reduce stack usage in ext4_mpage_readpages()
Date: Tue, 27 Aug 2024 08:47:33 -0400
Message-ID: <172476284020.635532.6933318029535354689.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718223005.568869-1-willy@infradead.org>
References: <20240718223005.568869-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Jul 2024 23:29:59 +0100, Matthew Wilcox (Oracle) wrote:
> This function is very similar to do_mpage_readpage() and a similar
> approach to that taken in commit 12ac5a65cb56 will work.  As in
> do_mpage_readpage(), we only use this array for checking block contiguity
> and we can do that more efficiently with a little arithmetic.
> 
> 

Applied, thanks!

[1/4] ext4: Reduce stack usage in ext4_mpage_readpages()
      commit: e37c9e173bff50a2d57dfecdd694457c00ce5a8c
[2/4] ext4: Pipeline buffer reads in mext_page_mkuptodate()
      commit: 368a83cebbb949adbcc20877c35367178497d9cc
[3/4] ext4: Remove array of buffer_heads from mext_page_mkuptodate()
      commit: a40759fb16ae839f8c769174fde017564ea564ff
[4/4] ext4: Tidy the BH loop in mext_page_mkuptodate()
      commit: 3e3a693551c3e9b45575e94ca2d1d670a47b3fcc

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

