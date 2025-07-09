Return-Path: <linux-ext4+bounces-8904-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C89CAFEF2B
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 18:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E64917C209
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCF1221286;
	Wed,  9 Jul 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="jOVm9/b8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6F2236EB
	for <linux-ext4@vger.kernel.org>; Wed,  9 Jul 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079761; cv=none; b=R+0lkg0RyNibo/xi6nkbOn/7J03ZewZD+bQWWHg3OFCQgQiXco3aU2qVv8j7W3OFOCN0MioHjLjzxY6n/FXplllP0ap9S0V9ozKUtFfyLATF42WPngrNu1f66qyqBI4c0vjU7i0fEUuTH+zJpLHZjId1WlR7QiTAUZP7kD6MO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079761; c=relaxed/simple;
	bh=neSm+DA9Rm3hRLGNHaOZJCT/GifDO6n3DNx7t808w6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWykz6Y9pLVWJXfJLS7zIVspBixwBA8wycMr/tjzhCscF+hB69SLeXyf85tcyjOt6EH1foTzkaDT/PKwEV9Yd7gTgWtar3yOQkvFpppFyvN9WfgXKo792cE0nrE3z/39v1VK8Eb08wOyHSubKDFz/jcAKadEeEvtzzjgGzDl99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=jOVm9/b8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-49-45-64.bstnma.fios.verizon.net [108.49.45.64])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 569Gn1bw016489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Jul 2025 12:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752079743; bh=u3WxDOUMKnT55e7i3pnhI69PAg3R31+4a1AwDVnXRDA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=jOVm9/b8VJ08biSybgjFEWx6pa+6XjYIjFi4ecVLdRQgpm/BubyswjWVM07Kz6aba
	 MyH/voSJ36AsDWzz6+k5civxOZGjUB+a2U8lCtbQ5KNpKZp/ytVDNcmT94sMw71h8Y
	 jlDUzwCNuwQHWtnJfKVshqqdqN+wP05Dyk7BQb6iEbhpKJVXY7Famx7mozyfIUIOR1
	 fjXvZEzjjc+u9JEwl+pewlpDCxmeuPaqkJgEhXRher1dskiSHu8d/JOnZvCWP0/eQF
	 pqMqjSqNhBAr7FSbO482MEu7EXJ4W5HC0n8EjPq/bC77DvOLx1WQUlRqQ0mSOsnerA
	 UdWeVhd05XglQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 50FD12E00D5; Wed, 09 Jul 2025 12:49:01 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Samuel Smith <satlug@net153.net>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] e2scrub: reorder exit status check after calling lvremove
Date: Wed,  9 Jul 2025 12:48:55 -0400
Message-ID: <175207972881.202310.6505227584562745829.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250705033821.3695205-1-satlug@net153.net>
References: <20250705033821.3695205-1-satlug@net153.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 04 Jul 2025 22:38:21 -0500, Samuel Smith wrote:
> Checking for snapshot device existence resets the status code in $?.
> Reording the conditions will allow the retry loop to work properly.
> 
> 

Applied, thanks!

[1/1] e2scrub: reorder exit status check after calling lvremove
      commit: fb9b2e7c9cf90e2c4eabcf1cffbde443e8eeb360

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

