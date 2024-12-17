Return-Path: <linux-ext4+bounces-5716-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106449F55AB
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 19:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284A91691AB
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2AF1F706E;
	Tue, 17 Dec 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XaLbt1WB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB81448DC;
	Tue, 17 Dec 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458564; cv=none; b=KXs48pvPqF8jKYoHetGCzNMNdhkU6ZOHs+5069U9JHxFITdOVFoXyQ+R/lYCm57rT8II6+mGvFUh68jaq+kiqevlXGNqziFqvG3odnbwyG/Q3XeVfNaWl6MqQPqhdgmRp03bcUFo9lE9FJa1rakU1YPoNgIiIsPji4JoQ4IyK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458564; c=relaxed/simple;
	bh=rxdmUBOotCc97F/sywPxRvq/rC606PWTnDBPsk2dZqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuKs9KB1Rmaxw9Bbx0lFThFTLsXW2WFeHS+UmXiP8Mc6tDYS/caG1Pq1AMHynAx6gyDiLNZLajVyMTZ/yQ/SW5hfpEQAAUttqOyKM+KEWAB9J/5WZC/ORJdhoA0b++3GPxFGgnffKrEfnuJFSypotWG4rNB20TDVh6uZlByv9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XaLbt1WB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MGW37u9d8e7OVh/1zCm9OZP2qtE7ni2RcorG5BSsV8c=; b=XaLbt1WBItmHGn8P4d9pwxjJlr
	+8dc3SrtoyCsbtrKyEOv8Lcx00qMu1kFTdstkuOPn05/a3omQQLEz88BpljL01PbT7BG1R+ysvqw+
	Z3Cqq0fWGIrG3b4tYd+fVdlumT1ac6QY5ZFbG/XEUOkbrDbQsl/szIdqUSD0So0Ximh3WFtgOqC0y
	+ee6RyVmoBoh3Xr8VNLk+PXpC7t/DNCah+UAEXGwGwbxpySwkK9K2Ti319LGEmo1VLx8zTv6wZv8r
	PctyPLtqaBmPhUBhtDHPZCQ4Pd7OkoLbrHrKyIm2vdbviqB5v/BrockHE/Fyxi6QFgvYd5uF3/tfm
	lga/EMJg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNbty-00000008ZYA-3E1b;
	Tue, 17 Dec 2024 18:02:34 +0000
Date: Tue, 17 Dec 2024 18:02:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	dennis.lamerice@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] jbd2: remove unused transaction->t_private_list
Message-ID: <Z2G8ujYUUDGSpbGl@casper.infradead.org>
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
 <20241217120356.1399443-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217120356.1399443-3-shikemeng@huaweicloud.com>

On Tue, Dec 17, 2024 at 08:03:55PM +0800, Kemeng Shi wrote:
> +++ b/Documentation/filesystems/journalling.rst
> @@ -112,8 +112,6 @@ so that you can do some of your own management. You ask the journalling
>  layer for calling the callback by simply setting
>  ``journal->j_commit_callback`` function pointer and that function is
>  called after each transaction commit. You can also use
> -``transaction->t_private_list`` for attaching entries to a transaction
> -that need processing when the transaction commits.

I think this also needs:

-called after each transaction commit. You can also use
+called after each transaction commit.


