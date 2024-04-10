Return-Path: <linux-ext4+bounces-1938-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F889EDBB
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Apr 2024 10:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BD91F21A45
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Apr 2024 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC1A154C0F;
	Wed, 10 Apr 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CKPJgLKU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F2154BFF
	for <linux-ext4@vger.kernel.org>; Wed, 10 Apr 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738201; cv=none; b=YjPB09ByaPQv8/KOnNbqTpB1E90pipnqqCjTmhDe6a8GAoD61m74RnlJ1N8QftL1AHvKYXfQsD7mlc9xB2vRiIL5obYTsosACCmnH1++mF6xotqgoMgl7b8Y4HGXqIeDcwPtRNwoe2MkKE92CiXHJHxBPLe6WbhegHiCQWIRuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738201; c=relaxed/simple;
	bh=QdvJRYaCxb2oe+NVB6ePydDfNz+e1cwK5ickVVXPU98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AeF1qvyDBYBzP3/VXokuJs5IN7ZCon5a7fbCKXbil5HSDtS9ec9d9nCBk51+/0Gk63qV1QKUkLDmqKCafZdJrevbC/E/5x76qlH3UtLoTHf7eXK5RYla0clfsl9qVmpH9QXymh/cLyoarpEXxrPVorXkxBeZP1XzJJ8jwTCiIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CKPJgLKU; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712738196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CVhH7oCfqIEkL1gu8mqGf3SToX40Lwl3RcKtDsE118=;
	b=CKPJgLKUUTjKE/LpKWSxBUIDYBlHMhRIvYGIGmn4JDvpGXQ5xCUtXyBlXt3wteFykAdXAM
	jIbKqlOoI+dA7LBc/tk6x6a56VHBLdQKPzQxF8oD58OCJFCNux1WD+thexmHVOK3B911FJ
	6PXZK/P0jtHBUeN7gAGUvujtoI3cEKk=
From: Luis Henriques <luis.henriques@linux.dev>
To: "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>,  Wang Jianjian
 <wangjianjian0@foxmail.com>,  Ext4 Developers List
 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: Add correct group descriptors and reserved
 GDT blocks to system zone
In-Reply-To: <01581bdd-bbab-48e7-bffb-6d3e50f39398@huawei.com> (wangjianjian's
	message of "Sun, 7 Apr 2024 18:13:20 +0800")
References: <tencent_D744D1450CC169AEA77FCF0A64719909ED05@qq.com>
	<20230817170557.GA3435781@mit.edu> <87ttkl6u13.fsf@brahms.olymp>
	<01581bdd-bbab-48e7-bffb-6d3e50f39398@huawei.com>
Date: Wed, 10 Apr 2024 09:36:33 +0100
Message-ID: <87seztwr5a.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Sun 07 Apr 2024 06:13:20 PM +08, wangjianjian (C) wrote;

> Hi,
> Let me test it and fix it if it fails.

Thank you for looking into this.  I'll also see if I can find out more
details on this.

Cheers,
-- 
Luis

