Return-Path: <linux-ext4+bounces-740-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C25BF827D02
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E621F243E2
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B40259D;
	Tue,  9 Jan 2024 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="M+aqyL8e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAA6103
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rU3n010609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768811; bh=e6Bdj4eeS1KZbXCBUjpjqXTwySDhngDpbU49zk+wONw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=M+aqyL8eDqHzH2lS6RzE5vCUuacZS26gUJGqDIU4E/PJhAJW9WqVXlCBbkNSkUdFW
	 1rdV0Rp3nettncIwNZkVqi0GnIqNAnpiW+1hub096z3myKdJc/6KRqhIX0AoGH4JWV
	 Uxbvkzh+WbgzUfSYgBFCDJql2+emeLHdVn9IkBKkgYgp8FCnVzWCx1lj4UQzh4BZeZ
	 /GEHPT/TecZMdiou6+SGVR05w+1pYAbaya1rzghH7vXsQLKtT6LHYWiX4D5+4v4ONE
	 kWqOAHN+YyF9eJxLCQLfPPwzcxhss/lzo9AOOKitUheDNtuzDVpuX41H3nVTkXX2pW
	 YhwbFKRscTYJg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 239E915C030B; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Enable dioread_nolock as default for bs < ps case
Date: Mon,  8 Jan 2024 21:53:19 -0500
Message-ID: <170476879010.637731.8792821246041124123.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231101154717.531865-1-ojaswin@linux.ibm.com>
References: <20231101154717.531865-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 01 Nov 2023 21:17:17 +0530, Ojaswin Mujoo wrote:
> dioread_nolock was originally disabled as a default option for bs < ps
> scenarios due to a data corruption issue. Since then, we've had some
> fixes in this area which address such issues. Enable dioread_nolock by
> default and remove the experimental warning message for bs < ps path.
> 
> dioread for bs < ps has been tested on a 64k pagesize machine using:
> 
> [...]

Applied, thanks!

[1/1] ext4: Enable dioread_nolock as default for bs < ps case
      commit: e89fdcc425b6feea4dfb33877e9256757905d763

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

