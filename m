Return-Path: <linux-ext4+bounces-9817-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0CDB44660
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 21:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAB01CC3B65
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6EF2727F0;
	Thu,  4 Sep 2025 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="aDlZPmmn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6961271A94;
	Thu,  4 Sep 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014105; cv=none; b=P6l9ronS/1hmsLvnIzhQTDJQse2XyIgpZ78T2u6iIB8k8T7fjyiSBx+gEAj3yQ+LK3YHatw5xmwHAbg8tmG5G6xUhETOFExMJ6MlPJCPX1i5f2eqKtrawPvs1qXGxtrT4ZkxFSIGNcoydk9Y9uouDWp+veM9p1OhkBQqdOYAb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014105; c=relaxed/simple;
	bh=tdyvtOrC9bkkRx9FcafUu+t4Wzh4qIKgMhILEx5s41g=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jlFVwUoFiQ+4e6m6OpcJHkk+4zliXNYczuTi1qhkOQBQxvOnleB78Eylpk5tzs1L3nbl4SupCOBijmcijuNYwMNAguxsRMSkMNtUNaqm+CirXiigWXgEydeYgNV52x2HthNlC93B0nr+n8SSz1Vns3uMKlbjkiuBBsFHAqocA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=aDlZPmmn; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757014100; x=1757273300;
	bh=tdyvtOrC9bkkRx9FcafUu+t4Wzh4qIKgMhILEx5s41g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=aDlZPmmn9T8y+27YACId29KrcLLbiAQIRdYzvmORQ8JwiikWJQOJ5niG33+wp17oK
	 A4ICxFLyX4gqdpxSwp7GfjzmbmlJZ7m7iQI8u8syW2NqBjc3Mzpm4km09tLX7mlVrr
	 An/JMYap+o+UEodXbRpRVVyb0yn5Eq1kvPFbXt1xG1KDhsv0X1is1YXDB8fMjUBz56
	 43O6pro62RXon6Yt/OqOZHEI6CFkunjh+gzz31QJMpP0T0BflZDcd0xvMfyQXlQYsV
	 9VDZHAB/8nF0ofI02ZOJ+h6MNMY++vAunIT+vd+48A5RbYEsrzJCbkbV5DME0e3Br4
	 y0oRQyEK+c39w==
Date: Thu, 04 Sep 2025 19:28:15 +0000
To: syzbot+2ff67872645e5b5ebdd5@syzkaller.appspotmail.com
From: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Cc: adilger.kernel@dilger.ca, brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mjguzik@gmail.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ext4?] WARNING in __ext4_iget
Message-ID: <20250904192807.114909-1-nicolescu.roxana@protonmail.com>
Feedback-ID: 136600343:user:proton
X-Pm-Message-ID: 1ce9fea0631c7a56f4baa89f93f0b11dd729435a
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

#sys fix: ext4: verify fast symlink length


