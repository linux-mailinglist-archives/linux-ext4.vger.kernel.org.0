Return-Path: <linux-ext4+bounces-5838-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B29FAB99
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2024 09:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45C4161BB5
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2024 08:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A318E362;
	Mon, 23 Dec 2024 08:39:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AA1684AC;
	Mon, 23 Dec 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734943141; cv=none; b=Z2f9Jyk2ES4eD9Y4NJDzUXRbeWsaHXKmYDFSV0qMR64+JW9NLf4ZSP3mC2lQh0uY4C6JYJRVyt3ttkfyN8lGuZKCCztcsMHR+j5Ut9UTvfjYMJ1/wdaHuhWGgP+HjR8HmVLrIe3BsYsWCR/QCxjVLtm2mexRQxVQOk5DO7Wwkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734943141; c=relaxed/simple;
	bh=orRMIN3PPkGhdDCMVcTSi62J/Dwf8RE99UT0ce6X1sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMP16dVCAKTEaMEB3aMJOGCkejckPBUEYgJDKYv6C4ju0Mrb5AzoE+Rr570uRoQDG30+6Pv6adb788J8aE0dEvLfFcIcXX+kDXIZYUr6mY3LbilYgLgMSwQniE637zXZiuavlf0Hbc9qj1aSAV3KMGTWuFyHtKB1EUAonXa+IYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7FF4668BEB; Mon, 23 Dec 2024 09:38:47 +0100 (CET)
Date: Mon, 23 Dec 2024 09:38:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] ext-common: create a new test directory for ext*
 common tests
Message-ID: <20241223083846.GA19735@lst.de>
References: <20241210065900.1235379-1-hch@lst.de> <20241210065900.1235379-4-hch@lst.de> <20241218155947.ocbq6hjdzaud6ioj@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218155947.ocbq6hjdzaud6ioj@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 18, 2024 at 04:59:47PM +0100, Jan Kara wrote:
> So I went through all ext4 tests and I think:

Most of these simply fail due to unsupported features on anything
but ext4.

ext4/022 actually runs on ext2 and ext3 and fails
ext4/023 actually runs on ext2 and ext3 and fails

ext4/044 runs everywhere, but always forces an ext3 file system anyway
which is a bit odd.


