Return-Path: <linux-ext4+bounces-9369-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F647B26A37
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 16:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC6EA2455E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04D1FDE39;
	Thu, 14 Aug 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="L1lmhq+l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8921F584C
	for <linux-ext4@vger.kernel.org>; Thu, 14 Aug 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182943; cv=none; b=nulkReT1bPxL4rIlBg4GcpZ+oDvZyYv5nUiJ8VhRko7EjuuvDUMFPzsO6e68dcXdS7u/w9pE5ITNyQsKhws30Gqb+KsXLACZkZ6hWbTsvR8JIwNxG1cyfdDvHCYvxtgztR2eCbpxv0/HQe1N3bdSdtMNrBrm0oYJOQoaZz8BU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182943; c=relaxed/simple;
	bh=kSlcqIJoOANJBfzkmyHSCWHO6XFN7YbzygD6ENc4IIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYYi+rX4GCxY3dLBPilm+8gVcByUUbgS6aK08pOlWQYyncMu4GE6P/etJAVmLlCdgvc21O311BM5WVWv858tpuG5SudPH81cmjhSGJcaqQeSil+XsKhIrLn40WWXbFIABMs0iIIuNQMLE7tQ/9KCPN6Pf/WHjsiuMcDbhYEMkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=L1lmhq+l; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmmmk028537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182931; bh=786dVTp11of+4dMcouenJR0MhFa4XQVxMtSn4KcrrPw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=L1lmhq+lK/c6Igx5AV6ariviBTOnZbyDVRz2XyWlpn+1x66FBV9XiA+NFoa2ljyOC
	 h5E/X2qBUvPMRmTS+wXiqJu/icXw4zTjHzyAy2kRJSvpA9Nw6TPApIKrVpFz/5x5zm
	 eVaFWonriozHELKIgEWS4A0dYTwuEKhWPyeYpbTSzqBr0n7fMglvAVHMdv6j+Z49zW
	 wdhKxCfBIhxIS/9/6uOYmcLMMHW4PW51asDHZ+iJVZZUw4BdYhc2FVrFOE/QIAH8Md
	 1HrllWaLCzdVI37NwNxtRNgqxfqluK2CFUJ4PanQUUPtuAngQ86OO1L/F6poGW79TL
	 BS+wiRwRntQdw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C87AD2E00D9; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] ext4: Using kmalloc_array() for array space allocation
Date: Thu, 14 Aug 2025 10:48:41 -0400
Message-ID: <175518289077.1126827.7808789762375496098.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811125816.570142-1-liaoyuanhong@vivo.com>
References: <20250811125816.570142-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Aug 2025 20:58:16 +0800, Liao Yuanhong wrote:
> Replace kmalloc(size * sizeof) with kmalloc_array() for safer memory
> allocation and overflow prevention.
> 
> 

Applied, thanks!

[1/1] ext4: Using kmalloc_array() for array space allocation
      commit: 76dba1fe277f6befd6ef650e1946f626c547387a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

