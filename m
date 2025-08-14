Return-Path: <linux-ext4+bounces-9373-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA7B26A29
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5347D60113B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E817215F5C;
	Thu, 14 Aug 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LpxlOKtA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2250212B31
	for <linux-ext4@vger.kernel.org>; Thu, 14 Aug 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182971; cv=none; b=Z9OZcClXpHyUNb5q8+dn3KVTKcQeFdV009+ZWZQkPHJbklwrTrXSgUVALswlrdlu8zQWl0mzlOsUnutOpBYkUK6ngB9ROLjbTVi20R4IxJkObeddKApYX3q72moTt3ycdbhyBzagCGFGfCIOjUAgWbGHaFh0dibo3cCovMiAOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182971; c=relaxed/simple;
	bh=Pv+qvk+qENYwS/wqHL54lUvYZJs0gFaNRKGlN3x1Orw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aARwC3or9djLmb9NqtKNY4Fa8yOnqXjkdGaGrs0krLmnwBT1Iue7BskVMkw4sfT/R6YxVRNW18ljQOZwAcHY3gOxjjNXpzjSN/kJBsgA4x0h4cAaIji4l0HJDO72qSAwP7vVLH3SBfHCEGo21zfm7/iMBcY0q1AgNr87eKoHpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LpxlOKtA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmm01028535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182931; bh=IrwzxmScLCN6Ynn/abtLDh71jAb5MfHzvpt8Jdq8B30=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=LpxlOKtAFcqVwVYqFldy5rE3aTfADd2shegYyc/nWshoPuZLihByIz0DppgYuqwuV
	 3Fz2He8P7N0bcpq85jZ381bj2xSlLFclY+sAOsY38piy2P5mdvS1Z7UsWvGErnWybP
	 REOkM/HtAHnQzRUZNW/30ODS/X1Eih6zd9RFvIJmTpyBsVoRXL8ztZMhbWOoYpMBJU
	 jGDOXTdYxVO2ESlSix+6gQ84LWStCpr/s5SRkhRza72sJ3PIPksRCorcRsNAax1H4l
	 x6Umqde/EFKxR4aFn5WEJ/WNtt2kDCVrHeuT13hbSjPmN24KN/fTKVEMO6d2Rd3bhC
	 opIT3IQqxFCdw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CB3F42E00DA; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 1/2] ext4: show the default enabled i_version option
Date: Thu, 14 Aug 2025 10:48:42 -0400
Message-ID: <175518289071.1126827.15036151174560578547.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250703073903.6952-1-libaokun@huaweicloud.com>
References: <20250703073903.6952-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 03 Jul 2025 15:39:02 +0800, libaokun@huaweicloud.com wrote:
> Display `i_version` in `/proc/fs/ext4/sdx/options`, even though it's
> default enabled. This aids users managing multi-version scenarios and
> simplifies debugging.
> 
> 

Applied, thanks!

[1/2] ext4: show the default enabled i_version option
      commit: 6a912e8aa2b2fba2519e93a2eac197d16f137c9a
[2/2] ext4: preserve SB_I_VERSION on remount
      commit: f2326fd14a224e4cccbab89e14c52279ff79b7ec

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

