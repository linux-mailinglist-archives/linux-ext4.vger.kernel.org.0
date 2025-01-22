Return-Path: <linux-ext4+bounces-6215-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE26A1936A
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 15:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A5E1881D33
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB5F2139A6;
	Wed, 22 Jan 2025 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jrHCE2CA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911E12116FB
	for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555119; cv=none; b=qaezrTPjnqD7oH4mV+k4B08WZi3G5vTUJ0d4nAtZDake5bG3G0Lco86foisBWHZaqqT4KQA+MO44Z8peCM7RPzual+Zc4gE7OSvC5ZwylAvnmTQdB7XBz0Ju9ZCMk5sJ1aeKMCRUT7W+TRUNyR4hfmHmpA1jiRL0AMc/Wm8P4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555119; c=relaxed/simple;
	bh=DFrXRjKIj3f3mhPNILm4u9uZq33Aky+99DxS3xnzbB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWsekPK4ORHKt25JUBDzmKj+Sy3CTeuBov6L+321SSILtJfSI8f84DRB/Bdrwi0W3rEDV/+TJmZgAyAd94/9vskLluIIkFSuZyNKT4heKol1J68B38u/dN9rP5k5dFUpbleuCMumGm2HVLmVwOfhq1JSBngdWwTC6EZanam/0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jrHCE2CA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DFrXRjKIj3f3mhPNILm4u9uZq33Aky+99DxS3xnzbB4=; b=jrHCE2CAdRQBtTYWVCCb5ZX2N6
	hDA2rvwuk7gfTA+RpZkj/DAOBA2zYD3xkPwpUcNFAtd/JkjqIRrnBfbyGidyJ2rylC1HomFkINPi+
	Pt5xVw+YbumdNv7ie80cHPwYWzyjdOtaxvOWIBaxNBqX/SLhBfoIAENZsOJUoOyusuYntjrLa8MJO
	fCJ7kRLXR9eCjiCEyHs1pw2DemlbvrBGObIBXOEdbi9xmALGlPQtxnf+iVKo4LKzyAj4XAWYNnU9c
	MySLIIYZCyAzcYc2essBszwihjRKEtYXvL04JYQGeQccjutpprXXE549stWV5By7usQzda8M/RZPt
	alU7G4+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tabSV-0000000AO1e-3SjZ;
	Wed, 22 Jan 2025 14:11:55 +0000
Date: Wed, 22 Jan 2025 06:11:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
	Gerhard Wiesinger <lists@wiesinger.com>, linux-ext4@vger.kernel.org
Subject: Re: Transparent compression with ext4 - especially with zstd
Message-ID: <Z5D8q3QtpNiGSo22@infradead.org>
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
 <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
 <20250121193351.GA3820043@mit.edu>
 <b8663f69-cdaf-4c05-b99f-cd4105023264@wiesinger.com>
 <Z5CgQosGsbxbbEIL@infradead.org>
 <20250122131912.GA3844227@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122131912.GA3844227@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 22, 2025 at 08:19:12AM -0500, Theodore Ts'o wrote:
> ... but out of place writes means that every single fdatasync() called
> by the database now requires a file system level transaction commits.

Yes.

> So now every single fdatasync(2) results in the data blocks getting
> written out to a new location on disk (this is what out of place
> writes mean), followed by a CACHE FLUSH, followed by the metadata
> updates to point at the new location on the disk, first written to the
> file system tranaction log, followed by the fs commit block, followed
> by a *second* CACHE FLUSH command.

Or you put the compressed data in the log and have a single FUA
write.


