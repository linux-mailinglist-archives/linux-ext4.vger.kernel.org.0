Return-Path: <linux-ext4+bounces-3257-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE3C930D33
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 06:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63EF7B20E05
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 04:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D043C183096;
	Mon, 15 Jul 2024 04:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DohJ5drz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114828FC
	for <linux-ext4@vger.kernel.org>; Mon, 15 Jul 2024 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721017717; cv=none; b=Fo4MxN1TeurTlgJxzvU+1KUSrUITy5G7YTxIRnIMeCWNswn/9+DgRbBVuPYpc8NlF8LeumfZTQ5nfA+MFGBUIDSOFjHZcdysiLsTfrL7THUrKZqzbdS4+14izLAHU1cQANmUdm8zjwKMikjErzLxDMX8+tUWhCdBZwrw+KgV08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721017717; c=relaxed/simple;
	bh=RBSx72or8ZjyW0t1RDNwbn3UIgNtPoYJO5knun5rgII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi1bVBtIUjAUrjmMBf3FYZEWUkF7ZvbZjKD2+i8bdCoCd5VaE1swT9HGsoqQsoQAf6i/+3Oy2qebWITFtCh1VTgJt1JM/0ldZkl4yjWM34qA886ZD3jrSVLbXowH9TCWkOtZ+jbZV2IF8zt5OzeNFKdo0APg8Dib1/Laq/xXeaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DohJ5drz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-108.bstnma.fios.verizon.net [173.48.102.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46F4S3ti023464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 00:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721017685; bh=gjLMGIRjiRJ0hh63/qYMVnFng9tQJrk+QqvCddh5BBQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DohJ5drzsSLeFLFsRJlHrrruPWvI3pcdk1gnkKDfwsJamocxnJn28D6Ljtn9AhT0s
	 5v91gNOro6JPh5qestHKfILpMMNLeYqO0aVABzfE/OW553ALhOzOp5C6QZrMlNcyU/
	 aZzv34VdFbdWAILr4zxiQdEdn/LqzNkhMFAkfh6Y2nMHPRUaUi/zaHi1z2mI3AomQr
	 D3gsKtGHxw0vey8hsHJ7ordFJiJLPgfexw7E+U7NJV605XFQTWxhpViOvvCCtnUqhv
	 H1TMs+GVSh/6hhBfy0mHghKMEfbVKttFuHYt3UjqkfNLNXcRELhFw1D8QZou7/fT2I
	 uGfHNYks5sFYA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2A7AA15C029B; Mon, 15 Jul 2024 00:28:03 -0400 (EDT)
Date: Mon, 15 Jul 2024 00:28:03 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [Bug report]: fstests g/388 crash on ext4, BUG: kernel NULL
 pointer dereference, address: 0000000000000000
Message-ID: <20240715042803.GM10452@mit.edu>
References: <20240714034624.qz3l7f52pi6m27yx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714034624.qz3l7f52pi6m27yx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Jul 14, 2024 at 11:46:24AM +0800, Zorro Lang wrote:
> 
> A weird kernel panic on ext4 happened when I tried to test a
> fstests patchset:
> https://lore.kernel.org/fstests/20240712093341.ftesijixy2yrjlxx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#med4b8d2fe14ef627519d84474b4cd1a25d386f75

I'm confused; this patch set:

Daniel Gomez (5):
      common/config: fix RECREATE_TEST_DEV initialization
      common/rc: add recreation support for tmpfs
      common/config: enable section parsing when recreation
      common/rc: read config section mount options for scratch devs
      common/rc: print test mount options

seems to be mostly about how xfstest config section handling
especially for tmpfs.  Is this realy the right patch set?  If so, I'm
guessing that the reproducer would be very specific to the xfstests
config.

My {kvm,gce}-xfstest setup doesn't use the config sections at
all, but instead uses shell script fragments, since it predates config
sections by three years --- and I need something that works well with
sharding separate configs to run on separate cloud VM's.

So I'm not sure I'm going to be able to reprduce this easily using my
test setup.  Can you translate the stack trace to source file names /
line numbers?  Maybe that will give me a hint what's going on:

> [35346.372867] Call Trace:
> [35346.375319]  <TASK>
> [35346.377426]  ? __die+0x20/0x70
> [35346.380493]  ? page_fault_oops+0x116/0x230
> [35346.384602]  ? __pfx_page_fault_oops+0x10/0x10
> [35346.389048]  ? _raw_spin_unlock+0x29/0x50
> [35346.393072]  ? rcu_is_watching+0x11/0xb0
> [35346.397006]  ? exc_page_fault+0x59/0xe0
> [35346.400854]  ? asm_exc_page_fault+0x22/0x30
> [35346.405049]  ? folio_mark_dirty+0x2a/0xf0
> [35346.409072]  __ext4_block_zero_page_range+0x50c/0x7b0 [ext4]
> [35346.414809]  ext4_truncate+0xcd3/0x1210 [ext4]

Getting line numbers for these two functions would be especially
helpful.

Thanks,

					- Ted

