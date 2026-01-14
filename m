Return-Path: <linux-ext4+bounces-12805-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B84B6D1CF5E
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 08:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49AA63016AA1
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1537BE65;
	Wed, 14 Jan 2026 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL5y2HaL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5212379961
	for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376994; cv=none; b=r4VElSXbas4oQRN6IG9/z0FvyCRu47DaCO2qmkwHDhWFJxEMkk2eAwCi+usLtYUGpztFpxKtqlRT3YruNWzZw7Urr0d5rgsotMKxJkfXCLvQOkCT1iaSfMA9iTH1hI3AKlQcHsphUtso04noeG4P4NCYKAf3GXGWcUjO2ku/Bco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376994; c=relaxed/simple;
	bh=KnQzynCb2i8tFdXwQdOn1yXseME+gMzBZwB+PYmJeDo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WTDRxOSGNqr48asO8ShOMvAlJRuZH3raf0DwRLAfmWPROfNQVbRdnt1n1S2jF+eCA0pEE9CkfZIDT+lqQwKFKobatiBiEmzuBiRdX3yWhJh9FuaNN7UesRK3KbBmEWx+G5mWJFPfjLmizuoRBpqvRZKc0X0BQHxTn5KYFAWNHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL5y2HaL; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5efa6d5dbf5so1675487137.1
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 23:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376988; x=1768981788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KnQzynCb2i8tFdXwQdOn1yXseME+gMzBZwB+PYmJeDo=;
        b=KL5y2HaLF0HYQU59ph8Ovju0b9Lq2XdO42Z0WvuMwbVHlO9OsTaFnWCNVy+DAkd9bM
         LSIMP9AF6cH1TgBN8CRnxdbrZlcOzZpCYxbh2yJ70fl3hMfSDin3uPBxWaV+2eCl+0lh
         9komDVF2VslQStAreiXISQscvEoq+cnEUPh72K+MXZ97xifSIwL7vsfuxjQWby8Y8IgH
         LTS0m2UNErbBhRiO1/42DH5Cg0Xdx0blVOVEe7J8TxN8h8OY/nK7ViAFphetKyN1q3t3
         7kt7tuMxOHE04nMJppqGVnzrPMhi/RKDtij+1zo+Z4yCqk+M+Vy6A15J2lJEk6bNzNSH
         70Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376988; x=1768981788;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnQzynCb2i8tFdXwQdOn1yXseME+gMzBZwB+PYmJeDo=;
        b=V6TUq2TTX2XBigVUAlDcZtlySojEmmz2PYJYgsOzgNECT7cYKZ757gnhE1kMRiPn3G
         5YC2RRHuht1QNjXliHTuQ/waKyLr8/JUEuWu4ptW95cSkNVZyqh4DCjeUm61ZCYAi/Et
         j/OAXzDArq3VhRH0FfcH2RoL9ZmpImXGx/0C37grQRFQpUV1UdwV/aQNmj+T0nKC28AQ
         YJzIZeDHSiBhWedz09EdH/KRfD9eizNoI/ghvRiLAG6UVv1Y5mBcpdEeIxWoeatQgg3j
         bgZdtfh4EfpNUcKVZ07RF8xuPbRsW9WPUGDCQAZXCj2gLTRt1nzxJRSU1iRHGbPw8wIv
         1JKw==
X-Forwarded-Encrypted: i=1; AJvYcCVPpVhHn1PbLcjV02KHvpFbdc1CFMQFpawsPOw1JkFbFhV/Xs9OlueKYydXprTrFXLECH6TQmEFSe4K@vger.kernel.org
X-Gm-Message-State: AOJu0YzIm2ZmVWRYdduRahNX4Lv9aCX6SJskeLKWggVqnYnnfPRvVQM9
	Qgd6lEtf7/1Wle6QxMcjVNk7mZi0ONJySi9gXTH5J/bo0laN71wHyPuTl4n8ZFgNXUrra2Fk/Li
	IiL9nx9N7IqtbBZkUQ8uNuTGbaSyoiT8=
X-Gm-Gg: AY/fxX7hymd1JXngjxR+fVFxH4rfLdIo5YtuQJdWZ5aNL+gqF03jsnQTobzKAaZulmv
	oE/NXXF+Rsy/ZmjR2tzP3JyhmJOVxMEhspRgiVCuNl0mEFPJXgAyDkepUNo64Yz5NJqkkadBPRy
	CPhkJHGw3y2sgN9XF28BgQgJMiHnJ9I6ks9yHDv610Z9Onx/pDKlOQmVfAAKSgQyLFW6UZGWXqY
	YIUnuHub1Cu/Aln4kvwq7Uah7lvarlAVyB7gA1+pwsOnIE6R71uvzGXsTTiqbIx0+mJMHeDcBO0
	m2RYrxmf3Aog1hOuF1I5tV9QxqM=
X-Received: by 2002:a05:6102:b15:b0:5e5:66c6:d23e with SMTP id
 ada2fe7eead31-5f17f3f9ed3mr667895137.1.1768376988032; Tue, 13 Jan 2026
 23:49:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Wed, 14 Jan 2026 15:49:36 +0800
X-Gm-Features: AZwV_QhAXf30TY58BMelbYLuzqKb2_v0iufFI86oH9g2PHADsf2LpdHXzABzmbE
Message-ID: <CAOU40uAhBkaPaL3rFn1ukLOM-GOu1uggbgiHpgbeewHsbMZjGA@mail.gmail.com>
Subject: [BUG] kernel BUG in ext4_do_writepages
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a kernel BUG triggered in the ext4 writeback path,
reproducible with a syzkaller-generated workload on v6.18.0-rc7 and
v6.17.0.

The crash may caused by a violated internal assumption in
ext4_do_writepages() . During writeback, the code reaches a path that
assumes the inode is not using journaled data, but
ext4_should_journal_data(inode) evaluates to true, triggering a
BUG_ON() and crashing the kernel.

The BUG is triggered at:

: ext4_do_writepages()

specifically at the assertion:

BUG_ON(ext4_should_journal_data(inode));

From code inspection, ext4_do_writepages() contains earlier logic to
handle journaled-data inodes by disabling mapping (mpd->can_map = 0).
However, later in the function, the code unconditionally asserts that
journaled data must not be in effect. This suggests an internal state
inconsistency: either the inode metadata indicates journaled data
unexpectedly, or the writeback state (mpd) allows the control flow to
reach a path that is incompatible with journaled data inodes.

This can be reproduced on:

HEAD commit:

v6.18-rc7: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d

v6.17.0: e5f0a698b34ed76002dc5cff3804a61c80233a7a

report: https://pastebin.com/raw/t7sKi2aU

console output v6.18-rc7 :https://pastebin.com/raw/a88x4vQt

console output v6.17.0: https://pastebin.com/raw/s3cfkbmC

kernel config : https://pastebin.com/raw/1grwrT16

C reproducer :https://pastebin.com/raw/0nLHxWck

Let me know if you need more details or testing.

Best regards,

Xianying

