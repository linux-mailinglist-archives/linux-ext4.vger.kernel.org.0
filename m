Return-Path: <linux-ext4+bounces-11792-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A29C4FABE
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 21:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749FC189AE9A
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 20:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC2A3A8D7E;
	Tue, 11 Nov 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="qDKCpUGs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1333A8D6F
	for <linux-ext4@vger.kernel.org>; Tue, 11 Nov 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891798; cv=none; b=FFoIX1tdgUu62Vxcy/3EKQjvD9acbmogghFSmGA64BHvFm/sB91pI4tENmaOLHqjPig5CqOFtfRkAJsbKLjZCJJbyG6VFLFE6ixGC0XN6g2ik1krqyX+MzjQz1W6tUCarc/HY4s/utYXXLiVuTbpx+dOcIdFDXilRmMQ/mn0yo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891798; c=relaxed/simple;
	bh=F3SVG2uA7aoJlfkCA83swXLrS9hBeOEmLMRm37fMzSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcFSxJZ8Lj18CT4i2djqrtNVwYvIkCSDFUQ989oq5nXAjrFJyxIRuUcsFKGq4I6oapk+Mupzuybhgn6lhV65qMGwaSSvqA3FfbtGXKXyda8dRb5CANIjkSnnEcIqlCJIoCJcfOnV3krDgt28LfRCYLG/Bwjjq+4TKNeyRkWuxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=qDKCpUGs; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ABK9oPr008979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 15:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762891791; bh=zROlQ+EDxDqXyJFTxvusMIrhzaHfPzjmJr9Z+YB5fWM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=qDKCpUGsvCPfFMlgsnb5SOGu3mIKN45oW77panpe7rQ2LeBIQwxkMWKUPTfSA1rCC
	 QwVQFefseHsYRvjK9CMCDEvgmu08URnBkygrn4kt3qAe8p3j6cm3hO0y+c8Lkob8ky
	 XYjahf98j6OFNDKbU/U6pXwEhxJd25+W1j7awIUuMX7HDWh0LT/pv6Pl3nRWckaYRc
	 c4w++1S4hmDm33ntgcpKaNYpNC/FSzE91ckrBQXMdtYtTxJvPinbNO1ASZr2O2x7jM
	 Az20xg9iCgY8BmZfPO7XfZN8b+XJQMtUgGZeNT8Ru4rpAGmrF1L2p4b0tQ0ZyxXGZ4
	 Zt6FSDxt2Wu7A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4E8242E00D9; Tue, 11 Nov 2025 15:09:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] doc: fix mke2fs.8 Extended Options formatting
Date: Tue, 11 Nov 2025 15:09:45 -0500
Message-ID: <176289177750.1399954.13097499722987782620.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920225030.29470-1-adilger@dilger.ca>
References: <20250920225030.29470-1-adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 20 Sep 2025 16:50:30 -0600, Andreas Dilger wrote:
> The two consecutive .TP macros cause bad formatting for the
> remaining options.  Remove one.
> 
> 

Applied, thanks!

[1/1] doc: fix mke2fs.8 Extended Options formatting
      commit: 337cae6eecedceb6d407183508676b662117409f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

