Return-Path: <linux-ext4+bounces-5541-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA829EB5AB
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 17:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF08016205A
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E231BBBC4;
	Tue, 10 Dec 2024 16:08:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3D23DEA7;
	Tue, 10 Dec 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846916; cv=none; b=civ3iP+Eld4NZFMvc7Vx/b6EuvwCKuARoZG+xQKx7JbYpweu6KcOZOJ7MOhHYkR8TIgJTbeFK5cxT64WZL0S5NCW7xGgU5hzp7v/0XymcFvLv40jbWVaAwZ0I9Nn174C++IQmAnu+004ZNezA7qBM8yLhfwt9eJWVWXiGVCqM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846916; c=relaxed/simple;
	bh=ctbo2LScvP3/nQmyLa7abuD6A9YmxwHyTWDFN7b8NKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUE64q78iwCjTTm5kxbhSQdfUriR4Xt1LoGlb2u3myRcI5MeyIYmdm8OGqBD8wbfIfVg7FXK6OkEr2PZ5hA3uQX4WWvZhewMPtmUkBvmxaL0hDphzbh4h4SC5Zy+unekHmQDoLxp5Mogb53yotsHtW0d3mks45P/6/uKtQwzjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6412768D12; Tue, 10 Dec 2024 17:08:28 +0100 (CET)
Date: Tue, 10 Dec 2024 17:08:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: remove _supported_fs
Message-ID: <20241210160827.GA26559@lst.de>
References: <20241210065900.1235379-1-hch@lst.de> <20241210130033.GA1839653@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210130033.GA1839653@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 10, 2024 at 08:00:33AM -0500, Theodore Ts'o wrote:
> Hmm, instead of doing this (would require hard-coding support for ext2
> and ext3 file systems needing to use ext-common), why not just have
> special-case code which causes ext2 and ext3 file systems to include
> the ext4 group, and then we'll have _exclude_fs declaractions as
> needed for ext2 and ext3?

That's what the current tree does and what I want to get away from.
I think the diffstat alone makes it pretty clear that moving away
form that is a benefit, and it's also a lot easier to understand than
that ext2 and ext3 magically run ext4 tests.

> After all, ext3 has been removed except for the very oldest LTS
> kernels (and I dount anyone is actually testing ext3 using xfstests
> these days),

The tests also cover using ext4 as the ext3 driver.

> So it might not be worth it to move a bunch of tests and creating a
> new (somewhat ugly) group, ext4-common, IMO.

І'll let Jan speak up, but the only thing cleaner would be to drop
the ext2/3 coverage, but І don't think the extra group is too bad,
and certainly much better than what we currently have.


