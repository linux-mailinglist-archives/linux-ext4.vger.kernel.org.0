Return-Path: <linux-ext4+bounces-4752-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3194A9AF886
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 05:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA384282F51
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 03:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE31F18C013;
	Fri, 25 Oct 2024 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="f4ZVV2e6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E218BC1D
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 03:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828453; cv=none; b=cK5adRRNCRS/n8zyZQfaoTirX3tk+/H2Ezs0VzDk0DiFclY4o4meSDXEo1sIcjmZqaPvgxynP28P6uWMfRTlGOyvaDYqr0zIpoiTjcN6GjijDkJsrsQyUDCYtVS+KtLqm/DETY99F2IZB/z596d9eksoJMm7yVVRYxVK5QWqABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828453; c=relaxed/simple;
	bh=a0DuitTwtLj+PInWUjXLa9rVJ5uKypT88sz8HdwO544=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8/g5tEskG0sjZPvoiHXfdlEUrbPhU+AU5xHtnfuJlgUUWEeL6c2PPhT43z6ZCbpfyzRLBzPpynNNdL015QAQkSolj3EOZ2uwwG373x3XkhYiDS9SBOqL41W0OWAFvCoYLb7TM7BMoMnESc0enjwB9do4Ll8mCxUC/kqAFl3HMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=f4ZVV2e6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49P3rvkD027477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 23:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729828439; bh=iP+5rADPMnGXlyZn18VjwoqUhshixdgQXE4HIDXxE3k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=f4ZVV2e6hqoznMrNHEUErPHfYPGoZv3KecIdENczwXnJiojiqaLPDZCxcE0I36CeG
	 EyPqQZ8PM+tlzksd8WU+ud+ZkX3LWU1EaCV/1Z8l/kKdv4hUFm8XdurfQQ4vDFKQbW
	 Lu+hnEnuNyTDqR/mZkJ6XDD9ggAec5bwFxg0U0xFRk1+GSoQoVzChLg3fROLVDuMVB
	 mtZ4+m/GlK8W28r8ps2eafnX4NHw+ORQHjXLgxLJZCNgM6A9WWxvMRHu4d4l55NrWP
	 FMpz+dWgMUMp7O9uHqs2VCNpcmjeTlpIfs4zVpOuc/bHaSxn3zUXzNEPyySJ2tJmyC
	 a7ZguBBWem1JA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A86FC15C05EA; Thu, 24 Oct 2024 23:53:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org,
        =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] Fix implicit my_llseek declaration error when targeting musl libc
Date: Thu, 24 Oct 2024 23:53:48 -0400
Message-ID: <172982841321.4001088.9112131230075843056.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240602120721.387561-1-henrik@lxm.se>
References: <20240602120721.387561-1-henrik@lxm.se>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 02 Jun 2024 14:07:21 +0200, Henrik Lindström wrote:
> 


Applied, thanks!

[1/1] Fix implicit my_llseek declaration error when targeting musl libc
      commit: 2bb33e3b0c490b2798dab9ef25459b399075c1ec

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

