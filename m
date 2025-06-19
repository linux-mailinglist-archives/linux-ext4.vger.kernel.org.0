Return-Path: <linux-ext4+bounces-8555-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7033AAE0E4F
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jun 2025 21:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E913169589
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jun 2025 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A811246795;
	Thu, 19 Jun 2025 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QXXkUgyT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BAE30E82B;
	Thu, 19 Jun 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363013; cv=none; b=EJQg+ADa+/FF6QA8/gpgytNzr2AErMZL2qJBVvDiTqvXQL6yyGxhB3OB9BGFNCtdgqeMEZGu/Fd88QEavD6pIZeHddgcPwd5r8l//DpTjVKwmN1W5iiZh6gkTFGM4GAToBlPXfa0sqaseIw0noVcirLy1Yc03OAPNw1lN1wUc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363013; c=relaxed/simple;
	bh=kc9yZUhhl+wZhmO8Wk+15fLRMuYCkRGwR4DU0HxHKsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Unyaz5NxTcaceptlrBLyNr3LjsaHWPB25DqDrWKnkYsbI5gfAfiFTruKQc2YwnnoSRh3miBe89SxZxRwutR0VozUSUaN9f/p2KzXzmX82icWWd18eah1rWEtnwr+W1rlyvHQq5pTJJULQHfN9js/3Eod0+BjFflB0kIKJVUptmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QXXkUgyT; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2AAD141AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1750363009; bh=pPgeY/Gg+qoV5kCFkGXINZQiuyl+REXzEHHp6WF7TWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QXXkUgyTjGJu60So5GSYDnuzq5dsTwR30iwZ3/dMW58f/FpgOnQ5aonZpIe3KPYh9
	 D5Pr/ftL57YI4cfcZq8bciunHkPSSklVM7D4bzjaOq26xcLHjDhgaHrF8xVq1NU3b9
	 aAJ40urkx3382Vmik7EJ2cABNC4Jxv3m+fiKgxOeAVsLf9wGEcaxz0HjBTgT9cHeBW
	 Icj+uQl3/7+24axbxNSlf3S9G5hjolAxv5vcFODhEEMgxZkqdV+gRLUWkPfO6GPNqy
	 VQtTG//Ih1pW+5pWGsFQtr+NO/N2MIAAYWf8ezJ6mr3Wt8BpQ22+1hUf61e60t/dss
	 iI9f9VPQ2t27w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2AAD141AD8;
	Thu, 19 Jun 2025 19:56:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux ext4 <linux-ext4@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, "Darrick J. Wong" <djwong@kernel.org>, "Ritesh
 Harjani (IBM)" <ritesh.list@gmail.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/4] Slurp (squash) ext4 subdocs
In-Reply-To: <20250618111544.22602-1-bagasdotme@gmail.com>
References: <20250618111544.22602-1-bagasdotme@gmail.com>
Date: Thu, 19 Jun 2025 13:56:48 -0600
Message-ID: <87bjqjh5dr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> When a doc is included by other doc via include:: directive, Sphinx will
> pick the included doc and parse it independently from the including doc
> regardless if it is listed in the docs toctree. This, however, can
> exposes duplicate label warning that refers the label to itself (bug?)
> when the label is placed before any section heading, since Sphinx
> encounters the label twice, both when parsing the included and the
> including docs.
>
> This could be solved by removing the problematic label. However, when it
> is heavily referenced by other doc (e.g. via :ref: directive), this can
> be a churn. Furthermore, the include:: usage pattern in kernel docs is
> to use it to included a common doc part that is shared by many docs
> (e.g. isonum.txt). ext4 docs, though, is the opposite: splitting docs
> into multiple reST files (subdocs) and including them in three master
> docs (overview.rst, globals.rst, and dynamic.rst)
>
> Let's slurp (squash) the subdocs instead. This will make the master docs
> larger of course (although not as big as KVM API docs), but one can use
> cross-reference labels without hitting aforementioned warning bug. Also,
> docs directory structure is tidier with only 4 files (master docs and
> about.rst). As a bonus, also reduce toctree depth as to not spill the
> whole hierarchy.

"slurp" is not exactly a technical term that will make sense to readers
of the changelogs.

But, more importantly... Might it be that the current file structure
reflects the way the authors wanted to manage the docs?  It seems to me
that just organizing the existing files into a proper toctree would be
rather less churny and yield useful results, no?

jon

