Return-Path: <linux-ext4+bounces-11831-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96FC53E2D
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 19:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E69E834542C
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A65A3451CD;
	Wed, 12 Nov 2025 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYwMJrmD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FE285C98;
	Wed, 12 Nov 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971607; cv=none; b=V52ELbgxgqzlQXgoOATKAGFvyI6eXV1ZlmPMjwlT2LZ8vjmK1SxFg7UrsQmrp2Da9PmHx3vb1R+FZ0LCMNQXhx6NkTPcAvCQgZlxXkDRxNF4IgBpKZ6EXqZcrf6v2WDeebdmwR4cG2ZHee1DpXvr6XgcQ6tNXVkKVCGTal4tmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971607; c=relaxed/simple;
	bh=oWVtEyxa/USf6lDPU9HhuH0iewSOT4SAsW56JKxlpLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIG4sMhaSPaqyT3F8IbZ81ZrqVg6/TJ7PMzHxB6r+vnq/r2JNRk/aWnKBMO2ycDDdUnF1KMdXnofAeQdXVBVrQ3P7NKyzYYYzUYKfv1+PKsnIQE2dPu57iyqceXkBU5Hx1KtT/yAbZyxcIic99cbk64B0/bD6fozJ228T4Wq1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYwMJrmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED7AC4CEF8;
	Wed, 12 Nov 2025 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762971605;
	bh=oWVtEyxa/USf6lDPU9HhuH0iewSOT4SAsW56JKxlpLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYwMJrmDGELNaHahDcgS7sTeERxcyAE5K9xIaLmuhefK1+zcMIDw3+oGHedjmLP7U
	 g3ZHnBFWxXM2CYg3JiGscyTZhvSvqVAGvuDeXqbKua3GUvAmb8rS4Rlh6k75SzOZ3q
	 upoHFTqAleqzOp59Nw+XyzB4jDhGg6Hxks2w7tPhjMW+KAflWWsharq5WdDFCQlKJ2
	 G9y/XEsXzQY1JX2w+3XX1AL46OZsIQJ5KLOiosOJxsdVadmQHQ9Tc8G5L82loq8DhX
	 B00dI7AKI8XLoQbD93RWXHHq49ClCTLiKZF1EQQarCS10dxxV2fPdC33DTH5+6JjgJ
	 D45CJBHWsBc0Q==
Date: Wed, 12 Nov 2025 10:20:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/7] generic/019: skip test when there is no journal
Message-ID: <20251112182004.GG196366@frogsfrogsfrogs>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909079.605950.17890053232268440120.stgit@frogsfrogsfrogs>
 <aRMB0JlJvduJCxF_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMB0JlJvduJCxF_@infradead.org>

On Tue, Nov 11, 2025 at 01:28:48AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 10, 2025 at 10:27:04AM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > This test checks a filesystem's ability to recover from a noncritical
> > disk failure (e.g. journal replay) without becoming inconsistent.  This
> > isn't true for any filesystem that doesn't have a journal, so we should
> > skip the test on those platforms.
> 
> This is triggered by your fuse ext4 I guess?

Yep.

--D

> Either way, looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> > 
> ---end quoted text---
> 

