Return-Path: <linux-ext4+bounces-2126-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8D8A7A53
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9652832F7
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 02:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6BF747F;
	Wed, 17 Apr 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Nwx2ArPl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42A7462
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319442; cv=none; b=kJh8X/KF8YI9oBT9BmGWpxrwHsB0sIp2gTnrXdcV6MlQYpZtTXdKPPzCpTJNqC7l8ncBLlonB3K1vfc8EdKgqlbxmw6KPnkS8DTjXuTH2r5hHCpBbdLvtYmwHXzbmOZflmzkLJE15A6fLJaULkRcs1QA8RSe3QyYSzjZcC+tMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319442; c=relaxed/simple;
	bh=uRd75FEq1pTGdRTDmQVbZZxK0bZWIiDbup3ElJO56QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfwnS/Y7JgMh2gpPbWuewivpH9ZCHOot3lvLqbkFnnXwyppmydEFq8/LBVJI5AzRpREQZdi/UF+04fPRvgn/KWYymTpVqWySOITqZC/HQ12j6kvQ7LKjom23YNpevYIVmHIGQD0496RigeMjjy9L/eKAtkoJ73xtT+3Y8Rr3+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Nwx2ArPl; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H23iYE013745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713319426; bh=L49Eo9W5k9TbLnAw0/AT7KaaWGS5FmLkmQNk/zE57KI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Nwx2ArPlns+Zy1AQ+iyd3hWTGDA7nNv3FIXPoNKqFYAWaQMATixmYb4AMU2RGq9dD
	 ah0Lf5kqSvnCvkNr1uzEFBoXmANLHYV4HxAmeV+MfWEXerW/rRPleNgLAQUAgcjxPY
	 zQ/qWpjkj/vHwtHlHJqfWLDkgGlhIgcfZTVPSaU4uKlwsEmtWa3m2SXCSYmaz7lcQ8
	 J02txSHmrRkXT7cFQpkNoHnOOPHxKFV03LbUs2JC9pi/7Ii8PX8O14jPqJhBHYdJXG
	 9uRCpN+5NJEmcyrPgZQELCqbsGaGB7yFGeRnuv7DRc1mhqe076MAUAb/ilrjh2USbO
	 jxotJMjB6QSXg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C809015C0CE3; Tue, 16 Apr 2024 22:03:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Sam James <sam@gentoo.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Mike Gilbert <floppym@gentoo.org>
Subject: Re: [PATCH e2fsprogs 1/2] configure.ac: call AC_SYS_LARGEFILE before checking the size of off_t
Date: Tue, 16 Apr 2024 22:03:36 -0400
Message-ID: <171328638215.2734906.7560773250028586700.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231107233323.2013334-1-sam@gentoo.org>
References: <20231107233323.2013334-1-sam@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 07 Nov 2023 23:33:21 +0000, Sam James wrote:
> 


Applied, thanks!

[1/2] configure.ac: call AC_SYS_LARGEFILE before checking the size of off_t
      commit: fed000ae01749e938d7c4e612fb9a6659127096c
[2/2] lib/ext2fs: llseek: simplify linux section
      commit: 24181bb25e52fdecadbc7e434834e6ece85ff932

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

