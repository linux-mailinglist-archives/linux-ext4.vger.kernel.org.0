Return-Path: <linux-ext4+bounces-10879-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA18BDC321
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 04:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDF4434C316
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 02:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F368830C349;
	Wed, 15 Oct 2025 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QhHHVTTC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9BF2F60CB
	for <linux-ext4@vger.kernel.org>; Wed, 15 Oct 2025 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496288; cv=none; b=RJH5JeY3b2/DI2mdubUScWadJnoUNSOlyHKQbKxWK9Gq8CjuGbrjy3jXTSobqr3RJMn5ZYcRR1DXg0c94Zv+BJEmectG5DURA6fB9co+iAMF13RHU+tq0yhgQJul3lSzkcNzLkH/7xe7Uqikhwsu5npNcjW3EY2b2NB9ouqqOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496288; c=relaxed/simple;
	bh=gs6Xxgdq5vKc/+FDa3BISnYoT4uHbfxCbX1jm2/R9k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gauFhvdEH4DgBJXlmehBRA0hStaRtPlgWahXtJ64phEsuHBcVEHU23q5jmt6jDG95GRLlieJ1dT1Z0yPCQAg6hG2z0BikSO4Kt+jovurHOdnGDaZmZICtUIX+iiiunozu7PjWHLGpMTJiijdOJiudRPC7vhW/z8yZEDgI3kqQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QhHHVTTC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59F2iJxd021706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 22:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760496261; bh=90VMANy8wywHNISJvnfEyPddEYG5BudxXWSnPN4cEHs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=QhHHVTTCxxB3UGSl3LhT1IRQjPejaeLz+utulbLeiA0JxO4OLpQWV/CP8CVnVt0BG
	 Jr+MFB6g2+V4FN7QhXnGnVLaoL9W9cBucjOu1pURjMg1pAgupqKTEL3blc/uxysWEH
	 FGtY/GwgtZBkvlt1mgoIVYOgniTp4MPR4/nXORzOvTRLKzeNL8twNrqvIzkVUmxyXW
	 T9t05pU/t4DnxgTZ763z891loAEVTDxxrNeesHZDecRloIYY4aYoNfE1/GkUX6j29V
	 x+NoBzVva20bFApZoPea7fBggNctUBQDOQTipnoHRIJ9+RvnIEL8xgQaewa0I4S8Cg
	 nE91NkH3aZEjw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 448F02E00DC; Tue, 14 Oct 2025 22:44:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zeno Endemann <zeno.endemann@mailbox.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] ext4, doc: fix and improve directory hash tree description
Date: Tue, 14 Oct 2025 22:44:15 -0400
Message-ID: <176049624800.779602.3824744552232012410.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925152435.22749-1-zeno.endemann@mailbox.org>
References: <20250925152435.22749-1-zeno.endemann@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Sep 2025 17:24:33 +0200, Zeno Endemann wrote:
> Some of the details about how directory hash trees work were confusing or
> outright wrong, this patch should fix those.
> 
> A note on dx_tail's dt_reserved member, as far as I can tell the kernel
> never sets this explicitly, so its content is apparently left-overs from
> what was there before (for the dx_root I've seen remnants of a
> ext4_dir_entry_tail struct from when the dir was not yet a hash dir).
> 
> [...]

Applied, thanks!

[1/1] ext4, doc: fix and improve directory hash tree description
      commit: 4b471b736ea1ce08113a12bd7dcdaea621b0f65f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

