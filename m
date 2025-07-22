Return-Path: <linux-ext4+bounces-9156-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFBEB0E37E
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5B91C83509
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78A5280A51;
	Tue, 22 Jul 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hEfrNtoB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FB27AC45;
	Tue, 22 Jul 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208893; cv=none; b=jmffIXM3+8wN/qMOXUaJ0ngHJ1hAqfqefw0GQyVjJ4hrQnCbQwHtnM6VEzhAd5HxvEdZwQAhkoK6izcX3xSnIyOP1UFkf1UTA7/RxMsdqN+qEL/dbkojPAejpyEtY4K6oQbOufOIFwmB0Fqef0IOJ4wVNbbxIzuDkpXxeNpa6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208893; c=relaxed/simple;
	bh=GJLEN+lCnN/TVYKqEOZIka4Ewdts5m7DcyKZncDxP6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfaNxA8s5a2EqeCcWJoJ7Mv28Nsl3WlMhhVRFVEIj4bCorg8gBQNBsMOkSd6AbSmN1LYuXmzotqBH1vQ9B7eCRG8L0eUASpIPNUxAjcq8XnzlnNAMygeHjgXeXhG8Lr/RTkT18PxBcShorIO/xu3wDrPjrPyuPAm/daTdrN7ZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hEfrNtoB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 14:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753208877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mi7Dy3DyQ/072Eng7iKuH2jusdHjQ9q25rYJBgy2hVk=;
	b=hEfrNtoBaGc71iw/XJ9gfELBNa/yjflx5Pwa2soNnrnPbyEOUz3ekulAwGvo1TJQVwp7Qo
	Fywl6T3WcP4z9Mlx4b/GeMaGpgLDEVNZ+N8/a3/JRXOs6Ih3539/LLhQns9jY3V2z7cFHR
	1mn3bC8Hi7DSDB/c+dJ5G4lRgcPFcQ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: anindya19@gmail.com
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] bcachefs: remove extraneous ; after statements
Message-ID: <c5inmf4l73sn7ckyp6zbvprchwqygrlucojh4fk5pmofmohsep@vorf7mtrnxqx>
References: <20250722182310.11931-1-anindya19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722182310.11931-1-anindya19@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 11:53:10PM +0530, anindya19@gmail.com wrote:
> From: Anindya Sundar Gayen <anindya19@gmail.com>
> 
> There are a couple of statements with two following semicolons, replace
> these with just one semicolon.
> 
> Signed-off-by: Anindya Sundar Gayen <anindya19@gmail.com>

Applied

