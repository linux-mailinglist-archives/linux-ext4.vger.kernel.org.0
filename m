Return-Path: <linux-ext4+bounces-11791-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC9EC4FABB
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 21:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE297189ADDB
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCBA3A8D7A;
	Tue, 11 Nov 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="FLibgbGt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501527A917
	for <linux-ext4@vger.kernel.org>; Tue, 11 Nov 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891798; cv=none; b=gYQxt9p/DOAcmyJZxDL5Nuasc2rShiEEBxlXYt+UKrMFNF6dlDcQyeN90ff6pxEWQ8bh31okteuenXqdd7Bs7WoNOfjM1I9Phz/pgH6Q/MDXzNwaM2hefvmdY4t6IrTDxnMvpJSDFWx4zJYYI0c87WCzeMb2e+AnrtPXd8V856c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891798; c=relaxed/simple;
	bh=/BIqHtYI6MUFcfcNp5LvHoK7xOafRE8I3kdazk00vNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxL6XnapFvgK0jvXvOZfgDGWwGZNS7InusmjwG5TqMEF8zFYLIWrABCLGSv8TWUFTbjxfp4b2sXlVVWqvVlZvMe/oGI2JjX1T6TbWS2hv4VLfgMd+L3dezaBV5TcQ2lsl6mR/EKbl+SrYI6+Cp6vIKn6Te43JTcf4ITWZ86lytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=FLibgbGt; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ABK9oMN008980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 15:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762891791; bh=kV15s0gG90M8rpuRukzzQRdglv/UxT3lKSrGpvMLYnw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=FLibgbGtUp5P+T4MDh5fUW2BIgYlj8Y0rtu1A87YBkcGPmO91QbH1F5UmXbs4y2NE
	 iXTCzKwlLvoLalo7v1nm5KGPVDpg5luztnMvDZNuLxBeGb7C5ansmQwiodOdfH0Sho
	 6eqC7otjmKEK73To8zFK1DMUnQ8GqaPocbTvn3eijeUQT59vvPM6M6ercr6kBHU08Z
	 x6UerhNYxV4jOrEQQENB2VTgF4cN0bYV3Ld9tmTfg5/apKT2XPXQ7PQ6cWDPItZCEO
	 yX/1RSVen28Zhq9BoHec3pBRNUBTtX/+t2ZFOhIfewn6V34r9B3o5gFQ1PFt2m/3bw
	 8pACQ6jFxXuGw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 53EBC2E00DB; Tue, 11 Nov 2025 15:09:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 0/4] mke2fs: small doc and features
Date: Tue, 11 Nov 2025 15:09:47 -0500
Message-ID: <176289177750.1399954.17574653015978817576.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 10 Sep 2025 09:51:44 -0400, Ralph Siemsen wrote:
> Four independent fixes for mke2fs:
> 
> 1) document the hash_seed option
> 2) support multiple '-E' arguments
> 3) add extended option for setting root inode security context
> 4) minor indentation fix in man page
> 
> [...]

Applied, thanks!

[1/4] mke2fs: document the hash_seed option
      commit: 6096dffaaf22d483f246166f6287dc4742e4e54c
[2/4] mke2fs: support multiple '-E' options
      commit: 06f50e001b7df448df523231bba26f1ca488f456
[3/4] mke2fs: add root_selinux option for root inode label
      commit: 9fc251d0d687f987975ac7c8011c600065e87d94
[4/4] mke2fs: fix missing .TP in man page
      commit: 041412cf2351c6d275547d65df33eec1cf36df8d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

