Return-Path: <linux-ext4+bounces-2122-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2AB8A7A4E
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8541C21478
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 02:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419546A4;
	Wed, 17 Apr 2024 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="VNoW96Sx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B587184F
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319437; cv=none; b=E1dKjCiUXHO1aJSbjHJNKp5cInpDVj4qByFT+kTFw8eD9o2vErMGjLtHN247hs/LAugAlxpMSv8DW4menRLy31hEXF1V1OZLDJ/WY4ezg7V8V4HY31Q+/kmETI8T4bxc63yQxq3sexER4MDSWbsNPZWkGlPX9isVlLlcK/SOkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319437; c=relaxed/simple;
	bh=1XzjegvPAYAR/PeCCef+KBVLIhN1N8p1kZsqnJnrdEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZPqRcAEkkTyU+UtB8WVgfTK6ZWPSNhmLdMyyhQ4GkE85IjEfWKOXzyM7rkoAsWUOSdIrm/UcjeaprYAdqfjR7L3RzZjc5EqjOuLlHK2tVOAM1iVnoo4ipmd3aVOrsxLXpECC7+04vy2xa/e8hMoyGx1o8Fv+fx/x5ypYHFHlCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=VNoW96Sx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H23gpR013703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713319424; bh=W3lSvbwG0bHzMp6ogtXSABzTIiRXFz7a638i511ln6w=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=VNoW96SxdsmsD8LaTs3DthcDpPv0EMtM5DJpU04G8vgYWDzSCKXlJ5WYa4B/1JBJ+
	 MaWHnLTT8LXRL7Ql1CwLBvUNiJzkJA8F5T6DPRt7DbzgCZ+3r/fxfYGNoB5OthJDaf
	 t68lRdeJq+5FyRqbYwubqIdYsoDss4icV0tVzKjptn30rv5GyZpGzcqzq52nz8Kui2
	 7R56j1aeFYJ9QbWmsHmow5uoMQGmk5iL6OzF/xXM+F3eSwuyHRRvlm8Xm7jEBCR1oj
	 qm8yVFZGQy0iMs2uAWLUlRcYQe/DskpfNLbC1EgEq3ykwC9TULC4Um3PkXOoYwbFTy
	 FWHqD9N5EBJqQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B9C3C15C0CBA; Tue, 16 Apr 2024 22:03:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] misc: add 2038 timestamp support
Date: Tue, 16 Apr 2024 22:03:30 -0400
Message-ID: <171328638215.2734906.13266270872317257455.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230927054016.16645-1-adilger@dilger.ca>
References: <20230927054016.16645-1-adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 26 Sep 2023 23:40:16 -0600, Andreas Dilger wrote:
> The ext4 kernel code implemented support for s_mtime_hi,
> s_wtime_hi, and related timestamp fields to avoid timestamp
> overflow in 2038, but similar handling is not in e2fsprogs.
> 
> Add helper macros for the superblock _hi timestamp fields
> ext2fs_super_tstamp_get() and ext2fs_super_tstamp_set().
> 
> [...]

Applied, thanks!

[1/1] misc: add post-2038 timestamp support to e2fsprogs
      commit: ca8bc9240a00665dd4c96de350e610add8543a08

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

