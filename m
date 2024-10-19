Return-Path: <linux-ext4+bounces-4641-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F14C19A4ABC
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Oct 2024 02:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB2FB21A15
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Oct 2024 00:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F6198A29;
	Sat, 19 Oct 2024 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="apg7Ikew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZKOC7rV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E220E31C
	for <linux-ext4@vger.kernel.org>; Sat, 19 Oct 2024 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729298789; cv=none; b=Rx3ubRuJ0kRCOAT7pRQU8/dMRjb6k/9A3fpOSH+AHYuL3xNRRzj2rmGH9IYXr+vWvDSLA6Buo8I3kBhLi0J4DHR9TUF0YvYjWcHGHEGshTdXOpaReGwPpwPSAmArFYDFokhl728iPVH6PDztf3QbsIFKDt3/WFGGQXClN/s1WEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729298789; c=relaxed/simple;
	bh=Y7/Ot4aUDu3gRRB0AAOb5GRik/qViyjkTSTeFhjrSRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlML9wLZwVen8EUCOMhQygmmUZqhNOEN4m0Umt3a27J0iFqNuK7XhyHIBwcUgwOermcWCU9YuW63Ejrx+eGTH6T55ZWHtKWS4w/mUUvFBkr6J41AXh0V5bnXh2tWuxPkstmoPpeaxpBSLlIq4SQjmM57M5F/j3nuykc2jUAZ9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=apg7Ikew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZKOC7rV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5022911401A1;
	Fri, 18 Oct 2024 20:46:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 18 Oct 2024 20:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729298786;
	 x=1729385186; bh=uGKvnCVDcfeH3aCYilwKqjf3jo4mtbIhcuEA5qo56BE=; b=
	apg7IkewnWJrNIhzagFnOzwobkP+sIhMbLHJYl2sVwhTjlC26+WowEl0U4pvW8a6
	jYoNo+h1/kuwfE7Yiq86bfof17HXKqDG2NNmp2zIOIBYOQm2sBQcYnmqUEfRJ6aA
	z/styY7VZ3ahVs4kOGMyhyZ7lfUxpTqYcAlgepQmTEe4aW44du5VB7W4SWaq3VUX
	aSSeyd1R3Wkt+pJQyKaypTaW3Cm2aCnbdwz7EhA+xmNcD0Ye6zWpafhk4Y7Us9CW
	/QHOGhVqccJZsvQI7J2ipMlp+V6OCA/gwBRG1ya/PC/wsN/WkQKto8csaMshHC9K
	FCSUTk1NQYC+rUqbSRQlew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729298786; x=
	1729385186; bh=uGKvnCVDcfeH3aCYilwKqjf3jo4mtbIhcuEA5qo56BE=; b=B
	ZKOC7rVmQ9ujtwY6ErPOl7kocodoDYL6sLk5AtXB1x1yVhw8ABq/E9vaKyTOvghV
	O/viIcKG7iCurBGS7WTE4/IXryhOw9qvPPvOzp6q9iYt0p6FtVJwoKPUgHDd9xlq
	Ll57nPS9A0YFEWkIG+1yjdllRMbNRVYuPhkF/LNweaXXEsVsuzgxwbjGQUgqkxaO
	IaIT9/Aqgh3UdxjyJ7aIq7NT/uKC2fWj4LntPuh63vw0pi3kK6Z+WWsVgVQQBjAv
	87azP++l6NdjWLCvq77mHyJzkeqJ/tD+YX6o4eaSBCjG5diSkI8cdSXytm56h2Ou
	OMHb7sLQh+Nk8lx8XY/1w==
X-ME-Sender: <xms:YQETZ-DNvneSDbVTGVo3qMSswxO0EfqQ8EEU7ZIDut3goqJq0TpWOA>
    <xme:YQETZ4gEq7tc4aiPXT-mQQWZx5fedLVkI-PetMF9no0K6m0i1imFyzB8yxWnQPSeP
    YHnBQootlWepaWPlAg>
X-ME-Received: <xmr:YQETZxl2o6J0LpnBMLz7coX7BllJmhsbgKL4UiikrjNfiVmsDOVFO26PMflu-10cd-_FPEO3bwldWA4gXlJDqGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpeettdejueehteegjeejteduteejlefggeeg
    gfelieegteeghfffgeejjeeuveelheenucffohhmrghinheprhgvughhrghtrdgtohhmpd
    hsuhhsvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhope
    egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhishdrhhgvnhhrihhquhgv
    sheslhhinhhugidruggvvhdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtg
    hpthhtoheprgguihhlghgvrhesughilhhgvghrrdgtrgdprhgtphhtthhopehlihhnuhig
    qdgvgihtgeesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YQETZ8wqo-0tzrMkQok8xYvfYqkXcQhx6qBFJKjDaUPPRYx4oCsg9g>
    <xmx:YQETZzRFQF9mAHNfYNMJlHiw4nroIXTQsnkkSL57LJHOLL0Lqo729g>
    <xmx:YQETZ3bLYLFxG3T6BfSERrPuS77lTOZU3gkj84GWbG7c0MQHQfDo1g>
    <xmx:YQETZ8Q2aNTUQKOqWlbVQVtUgxD2W6TPtMblpSGNNURa8RImm2zMtg>
    <xmx:YgETZxNauBYfR2P4Wca-7ithqDMC7CZUkQLH_TdRT9WjIRe-yPq--l5Y>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 20:46:25 -0400 (EDT)
Message-ID: <62c41f80-4bfc-488e-ba8f-8e1d5fc472a9@sandeen.net>
Date: Fri, 18 Oct 2024 19:46:24 -0500
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] e2fsck: make sure orphan files are cleaned-up
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org
References: <20240611142704.14307-1-luis.henriques@linux.dev>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240611142704.14307-1-luis.henriques@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/24 9:27 AM, Luis Henriques (SUSE) wrote:
> Hi!
> 
> I'm sending a fix to e2fsck that forces the filesystem checks to happen
> when the orphan file is present in the filesystem.  This patch resulted from
> a bug reported in openSUSE Tumbleweed[1] where e2fsck doesn't clean-up this
> file and later the filesystem  fails to be mounted read-only (because it
> still requires recovery).

Looks like Fedora is hitting this bug now:

https://bugzilla.redhat.com/show_bug.cgi?id=2318710

(unclear why fedora upgrade is leaving an unclean root fs on reboot, but
that's a separate issue.)

With this patch in place, bare e2fsck asks for confirmation, not sure if that's
expected. But with "yes" answers, the filesystem is cleaned properly and
mounts just fine.

Also - shouldn't we go ahead and deal with the orphan inode file even on a
readonly mount, as long as the bdev itself is not readonly?

ext4_mark_recovery_complete():

        if (sb_rdonly(sb) && (ext4_has_feature_journal_needs_recovery(sb) ||
            ext4_has_feature_orphan_present(sb))) {
                if (!ext4_orphan_file_empty(sb)) {
                        ext4_error(sb, "Orphan file not empty on read-only fs.");
                        err = -EFSCORRUPTED;
                        goto out;
                }
                ext4_clear_feature_journal_needs_recovery(sb);
                ext4_clear_feature_orphan_present(sb);
                ext4_commit_super(sb);
        }

# losetup /dev/loop0 2318710-e2image.raw   ## from above bz attachment
# e2fsck /dev/loop0 (without this patch)
...
# mount -o ro /dev/loop0 mnt
mount: /root/e2fsprogs/mnt: fsconfig system call failed: Structure needs cleaning.
       dmesg(1) may have more information after failed mount system call.
# dmesg | tail -n 2
[ 3083.343622] EXT4-fs error (device loop0): ext4_mark_recovery_complete:6229: comm mount: Orphan file not empty on read-only fs.
[ 3083.345339] EXT4-fs (loop0): mount failed
# mount -o rw /dev/loop0 mnt
# echo $?
0

-Eric


> I'm also sending a new test to validate this scenario.
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1226043
> 
> Luis Henriques (SUSE) (2):
>   e2fsck: don'k skip checks if the orphan file is present in the
>     filesystem
>   tests: new test to check that the orphan file is cleaned up
> 
>  e2fsck/unix.c                      |   4 ++++
>  tests/f_clear_orphan_file/expect.1 |  35 +++++++++++++++++++++++++++++
>  tests/f_clear_orphan_file/expect.2 |   7 ++++++
>  tests/f_clear_orphan_file/image.gz | Bin 0 -> 12449 bytes
>  tests/f_clear_orphan_file/name     |   1 +
>  tests/f_clear_orphan_file/script   |   2 ++
>  6 files changed, 49 insertions(+)
>  create mode 100644 tests/f_clear_orphan_file/expect.1
>  create mode 100644 tests/f_clear_orphan_file/expect.2
>  create mode 100644 tests/f_clear_orphan_file/image.gz
>  create mode 100644 tests/f_clear_orphan_file/name
>  create mode 100644 tests/f_clear_orphan_file/script
> 
> 


