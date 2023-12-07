Return-Path: <linux-ext4+bounces-340-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA85808CE0
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 17:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CE7282260
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B744652B;
	Thu,  7 Dec 2023 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AYLu+gPM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8111010E4
	for <linux-ext4@vger.kernel.org>; Thu,  7 Dec 2023 08:06:03 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-130-174.bstnma.fios.verizon.net [173.48.130.174])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B7G5wkT030814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Dec 2023 11:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701965159; bh=CVq2uV47ziYnjt3OnDnL6W3WsTTGK6Nf34BjwmutwQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=AYLu+gPM+OCeidlRwUYStBgvCpuB73N2u1MDyiJ5ZmpTVVkOlKdnz8Abw5DnoCLRY
	 HIDOUVI4rC1tQ4c8Hqv1S/P3bd3JRuIzXBBlU1mjtWlTxW1nYC6ZAznafIi0c1njGp
	 /16kbH6h92W1eR9ys4U7Ux+t3OPtdRFM6IJPDZTcyg02ENhYyMXzkF/K6fSGxtFD6t
	 dt74paBl1A1A+lI60p2gdXrk00C46iJsA6Oe1OqaVb+ihN7Sc6fiQ6ESKn61oMMgz0
	 zlr7zjcnC9aqqvVrPLACFrkmZPJAUtOQ3gM84zDBIUv/cALu6ycm7wU0Gex8G37R5b
	 cJv4aHvUbsPTw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5B55C15C057C; Thu,  7 Dec 2023 11:05:58 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RESEND] build: split version and release in configure
Date: Thu,  7 Dec 2023 11:05:54 -0500
Message-Id: <170196512708.16594.6748716596824111898.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1683694677-9366-1-git-send-email-adilger@dilger.ca>
References: <1683694677-9366-1-git-send-email-adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 09 May 2023 22:57:57 -0600, Andreas Dilger wrote:
> Update configure.ac to separate Version from Release if there is
> a '-' in version.h::E2FSPROGS_VERSION (e.g. "1.46.6-rc1").
> Otherwise, the '-' in the version can make RPM building unhappy.
> 
> Simplify the generation of E2FSPROGS_VERESION, E2FSPROGS_DATE and
> E2FSPROGS_DAY to avoid multiple grep/awk/sed/tr stages.
> 
> [...]

Applied, thanks!

[1/1] build: split version and release in configure
      commit: 1ac0061609c69cc9fe01bd116915632c2bc7c497

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

