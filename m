Return-Path: <linux-ext4+bounces-7289-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B78A8A59F
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Apr 2025 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB37E3BD09F
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Apr 2025 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B050235BF0;
	Tue, 15 Apr 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nAfrYpn+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3994221DB7;
	Tue, 15 Apr 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738189; cv=none; b=WuqSCsjUuJwGCymnF2FEuwTxSfP4ZN6xA8MKONn7hlPOxDoTXDUrwAlJ7JRqO+VL4YO64Xi4rGrffUFhHtHFG8JowpAfexnraN7YuWwGJT6VJGGGosDiQiFbI3/aHAlM9rWUL76FhMMKgsqLe0d1x1xd4nNatpOzjuYGtwwlFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738189; c=relaxed/simple;
	bh=S9XIVsAtv9ZvySpTXNmklIj3dCEZDBJtKPlbeZscMlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEVzjThar/GpO1rhhvx+0tHYIUTwsbAnearsPK7NpLMtqiZyzK0BPG0Zz2OEv/9uTNttcitPVzn64wrPFRn7Z5EI5DjJkOu3Brw+Y8RH2GwJXIJg8DEPKcQkVNaUDK/vbVPRzh9c+1ycV6N9QfukMRMWNqqghAX/eZiyWh14MAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nAfrYpn+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S9XIVsAtv9ZvySpTXNmklIj3dCEZDBJtKPlbeZscMlc=; b=nAfrYpn+EH35wsb4MLQ6p/PDDF
	zOFQG1WwkS0rI2Ik5a1xtmtHbS/8FmGMveZezvs5NdHB5IAOkO88E72Oxmz8DEE6GbnYhOyBlVnid
	UkUJBQP/CFn33zCQY+XfQh2gKCRYGh0biOZS8u+aKphLXctFwioKoZFtD2OQUMGabTKI5MBGcfd8D
	YNLO2kOwx4rGUw1sI+K/+L/NiHFVCzPretOedaFWvRwjg6OVkGb+SPTM1aiu5/Y1sNQ/ao+UG8hD9
	jmxZ7Tf9nYWWLFJ6MZV5l0CoaAWRq3kUZMYtpbaU1X5b8Whp594kAe7yWA7HyvL94CFhwdV2caSaL
	A1Q4xX1Q==;
Received: from 179-125-92-204-dinamico.pombonet.net.br ([179.125.92.204] helo=quatroqueijos)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u4k6M-00H20J-M8; Tue, 15 Apr 2025 19:29:39 +0200
Date: Tue, 15 Apr 2025 14:29:34 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: syzbot <syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in
 ext4_insert_dentry
Message-ID: <Z_6XfhN083ctkQHj@quatroqueijos>
References: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>

#syz fix: ext4: fix off-by-one error in do_split

