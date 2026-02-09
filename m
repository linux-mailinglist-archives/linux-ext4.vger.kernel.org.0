Return-Path: <linux-ext4+bounces-13628-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCD2Fj0qimm6HwAAu9opvQ
	(envelope-from <linux-ext4+bounces-13628-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 19:41:01 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40F113AA8
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 19:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E5F93036091
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Feb 2026 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5DC2DCC13;
	Mon,  9 Feb 2026 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mwdfvwIS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7BB220F2D
	for <linux-ext4@vger.kernel.org>; Mon,  9 Feb 2026 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662371; cv=none; b=ZBEBwkMpl1FXZIIbFK8UtB2lOEYkvsaTuEH5DkNSAOFMrHmcMQbQYOZD3ks4Phys/3jMjOJI9h/fVU1LPd+Re7nOD/mg4cBhMexgMTQHdIgxlr1fri5vjnVssF/oM4beAyrZ0nJkhvauGFQihnp0+PrjP4oB611lbpKsTQMRMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662371; c=relaxed/simple;
	bh=WtGpdoky7SahpBELH+IEAKoOWX4n7dY0t8ftVhaxuEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffpzbcSLsRD5OhUFKGKCsAnO/jFdEuMch7a574ESBdJ61RIRSyhUmW1fw1k85YjtwwERyZzoei6HeHv6e8Ccq9VsM/f4PTOPNpKq6PRk/Z/HqvArQmqdLzo+07j9L5bhVVIFDFYOHGPQaK+l/CMRoTBxhmBXWgngmXzB5KTEqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mwdfvwIS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-115-57.bstnma.fios.verizon.net [173.48.115.57])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 619IdNds005698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Feb 2026 13:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770662365; bh=J0gEiL+IYuF9LLNHpMJQP0M/wPCFBEGKbZO8Gr3/ccE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=mwdfvwISpXC7kR1IuKBIF7CpnL8jXMdrA23GkcVfV7ePXcLPeGTGZiCX2cEHNPuKU
	 yhci81bEDhwZaq2LU1pLUzntFg87XT1Mlu7kZyUj7uS6O9dElYLm9HZI6CwWSk70R7
	 yqDfD646Pnd+QIS+7UrA2O6AHSK0kgHjrD9Igeqiqs+Bzt8DyT+woEHRL60+xofu89
	 zrKa3XUn2MLFbXaFt2lSPnlNsR5Vjj3+wXjq3zXgyMqIolB/dsaOTuPz/ACbi8KL/t
	 rK3ivwdyyqwr6X3GgMN8bPNtATDnNBozeAaYLjGp6KvdqziCzhps1V6TQwHWqGZCUt
	 +Seno7NvZ8u/g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id C889B57D5563; Mon,  9 Feb 2026 13:38:22 -0500 (EST)
Date: Mon, 9 Feb 2026 13:38:22 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: 294772273 <zy931031@vip.qq.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>,
        "adilger.kernel" <adilger.kernel@dilger.ca>
Subject: Re: [QUESTION] ext4: Why does fsconfig allow repeated mounting?
Message-ID: <20260209183822.GA15302@macsyma.lan>
References: <tencent_2462A2D2BBD1792040E4BF74D8EE146E9D08@qq.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2462A2D2BBD1792040E4BF74D8EE146E9D08@qq.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-13628-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vip.qq.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[mit.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA40F113AA8
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:07:27AM +0800, 294772273 wrote:

> The mount interface will report an error for repeated mounting, but
> fsconfig seems to allow this. Why is that?

The mount interface does allow repeated mounting:

root@kvm-xfstests:~# mount /dev/vdc /vdc
[248226.221469] EXT4-fs (vdc): mounted filesystem 06dd464f-1c3a-4a2b-b3dd-e937c1e7
624f r/w with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# mount /dev/vdc /vdc
root@kvm-xfstests:~# grep vdc  /proc/mounts  
/dev/vdc /vdc ext4 rw,relatime 0 0
/dev/vdc /vdc ext4 rw,relatime 0 0

This is related to mounting the same block device in multiple places:

root@kvm-xfstests:~# mount /dev/vdc /mnt/b
root@kvm-xfstests:~# grep vdc /proc/mounts
/dev/vdc /mnt/a ext4 rw,relatime 0 0
/dev/vdc /mnt/b ext4 rw,relatime 0 0
root@kvm-xfstests:~#

... which in turn is related to using bind mounts:

root@kvm-xfstests:~# mount /dev/vdc /mnt/a
[248574.078106] EXT4-fs (vdc): mounted filesystem 06dd464f-1c3a-4a2b-b3dd-e937c1
e7624f r/w with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# mount --bind /mnt/a /mnt/b
root@kvm-xfstests:~# grep vdc /proc/mounts
/dev/vdc /mnt/a ext4 rw,relatime 0 0
/dev/vdc /mnt/b ext4 rw,relatime 0 0
root@kvm-xfstests:~#

In both of these cases, you have to unmount the file system all of the
mount points (and if applicable, in all namespaces) before the struct
super for the block device is really unmounted.

root@kvm-xfstests:~# umount /mnt/a
root@kvm-xfstests:~# umount /mnt/b
[248743.872394] EXT4-fs (vdc): unmounting filesystem 06dd464f-1c3a-4a2b-b3dd-e937c1e7624f.
root@kvm-xfstests:~# 

						- Ted

